From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Fixes shortstat number of files
Date: Tue, 27 Nov 2012 11:14:49 -0800
Message-ID: <7vhaoan9hy.fsf@alter.siamese.dyndns.org>
References: <1353533210-29684-1-git-send-email-apelisse@gmail.com>
 <7vhaodxctq.fsf@alter.siamese.dyndns.org>
 <CALWbr2z+9fJGg34q7zp3knZVWgaTwtvzFBvFHRSmXfH+hc-jNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 20:15:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdQch-00039V-Vb
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 20:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab2K0TOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 14:14:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab2K0TOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 14:14:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDAEF9FC3;
	Tue, 27 Nov 2012 14:14:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QOSs1IjxPLDS/MmmQVhCEZMRFJg=; b=LcjyJz
	vGM95SzarRzdqm11zkW/bdmD4xs46PH9/0Ss/f1LxC8SbYfAh4vF+plYjKMf7fq5
	yEhlMnHYM2IrShcNB0ySiMizQff2MkGQoQDjkMWfIYRbp8aBGWRZizIGln6lRvI2
	/GTq47hFuRql/qXsi1W4P4IPvQLARMfvOMK20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OhfMZKh9TGdhPjMH1Vd7WkKTEl/hjDd5
	khAXsWPv4fZAXsuVVh22wp2ASWZakbIUoIx1V+nmAvjVd2QroOaL7zCrYvVPm6Qt
	a6A5sA88C4KtZuiDSvI+UbIf8keqCKgBqAQR//Aby1RfbR9amXNGrw/fQoSppezL
	orVCTEZet5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE54E9FC2;
	Tue, 27 Nov 2012 14:14:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CF549FBC; Tue, 27 Nov 2012
 14:14:50 -0500 (EST)
In-Reply-To: <CALWbr2z+9fJGg34q7zp3knZVWgaTwtvzFBvFHRSmXfH+hc-jNw@mail.gmail.com> (Antoine
 Pelisse's message of "Mon, 26 Nov 2012 10:10:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7AA69BA-38C6-11E2-98E1-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210586>

Antoine Pelisse <apelisse@gmail.com> writes:

> Indeed stat seems to be broken on master by commit 74faaa16 from Linus Torvalds
>
> There are three separated issues here:
>  - unmerged files are marked as "interesting" in stat and probably
> shouldn't, with some patch like this:
>
>         data->is_interesting = p->status != 0;
>
>         if (!one || !two) {
>                 data->is_unmerged = 1;
> +               data->is_interesting = 0;
>                 return;
>         }
>
> By the way, I don't get the point of this code then:
>
>         else if (data->files[i]->is_unmerged) {
>             fprintf(options->file, "%s", line_prefix);
>             show_name(options->file, prefix, name, len);
>             fprintf(options->file, " Unmerged\n");
>             continue;
>         }
>
> and
>
>         if (file->is_unmerged) {
>             /* "Unmerged" is 8 characters */
>             bin_width = bin_width < 8 ? 8 : bin_width;
>             continue;
>         }
>
> Are we ever supposed to print that ? I feel like it could be removed.

Yes, we have been showing two entries in --stat output:

 file | Unmerged
 file | 4 ++++

and that is not going to change.

There are a few problems in diff.c around --stat area, partially
caused by Linus's patch (like s/is_rename/is_interesting/ change
started ignoring unmerged entries in the diff queue and made the
existing loop not go into the codepath we see above), and largely
caused by the earlier change that introduced when --stat-count was
added (the second loop that decrements total_files does so only for
the paths within the "count" horizon determined by the first loop;
total_files must be adjusted for _all_ uninteresting and unchanged
filepairs and exclude unmerged entries).

Also the initialization of data->is_interesting is wrong.  These
days, p->status is never zero.

I'll send out a fix later today.
