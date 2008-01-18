From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with NO_MMAP
Date: Thu, 17 Jan 2008 22:10:43 -0800
Message-ID: <7vtzlbirz0.fsf@gitster.siamese.dyndns.org>
References: <20080118035700.GA3458@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 07:11:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFkS6-00022G-H1
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 07:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbYARGK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 01:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYARGK7
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 01:10:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbYARGK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 01:10:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E8C7781B;
	Fri, 18 Jan 2008 01:10:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1BF97818;
	Fri, 18 Jan 2008 01:10:50 -0500 (EST)
In-Reply-To: <20080118035700.GA3458@spearce.org> (Shawn O. Pearce's message of
	"Thu, 17 Jan 2008 22:57:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70966>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> +extern void close_pack_windows(struct packed_git *, int);

Nobody seems to pass anything but true in retain_fd parameter.
Is it worth it?

> +void close_pack_windows(struct packed_git *p, int retain_fd)
> +{
> +	struct pack_window *tail_var = NULL, *n = p->windows;
> +	struct pack_window **tail = &tail_var;
> +	while (n) {
> +		struct pack_window *w = p->windows;
> +
> +		if (w->inuse_cnt) {
> +			*tail = w;
> +			tail = &w->next;
> +			continue;
> +		}
> +
> +		munmap(w->base, w->len);
> +		pack_mapped -= w->len;
> +		pack_open_windows--;
> +		n = w->next;
> +		free(w);
> +	}
> +
> +	p->windows = tail_var;
> +	if (p->windows)
> +		warning("pack windows still in-use during close attempt");
> +	else if (!retain_fd && p->pack_fd != -1) {
> +		close(p->pack_fd);
> +		p->pack_fd = -1;
> +	}
> +}

I am not sure about this inuse_cnt business.

The only caller we know that needs this function is fast-import
that wants to drop all windows into a pack while keeping the
file descriptor and it should not have an in-use windows.

It is unclear what semantics is the right one for callers that
do want to retain some windows but still want to call this
function.  If somebody is in the middle of chasing a delta chain
and still calls this function, *why* is the call being made, and
what is the right behaviour if not all the windows can be closed
because of these open windows?

What about the case the value passed in ratain_fd is 0, which
presumably means the caller is asking us to close the file
descriptor?  If we close the packfile, later accesses through
the unclosed windows will obviously barf and I understand that
is why you are ignoring retain_fd in that case, but maybe for
the caller it was of higher priority that the packfile to get
closed than the remaining windows to be still usable.  Or maybe
the caller wants to be notified of such an error, in which case
it probably is not enough to just call warning().

IOW, I think the patch is trying to be too flexible without
having a clear definition of what that flexibility is trying to
achieve.

Maybe we would need more flexible version later, but I am not
convinced if the semantics the above patch implements is the
right one.

So I'd prefer something much simpler like this one instead...

void close_pack_windows(struct packed_git *p)
{
	while (p->windows) {
		struct pack_window *w = p->windows;

		if (w->inuse_cnt)
			die("pack '%s' still has outstanding windows",
				p->pack_name)
		munmap(w->base, w->len);
		pack_mapped -= w->len;
		pack_open_windows--;
		p->windows = w->next;
		free(w);
	}
}
