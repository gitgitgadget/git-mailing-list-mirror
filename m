From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] add post-fetch hook
Date: Tue, 27 Dec 2011 22:27:15 +0100
Message-ID: <4EFA3833.80409@kdbg.org>
References: <20111224234212.GA21533@gnu.kitenet.net> <7v4nwpbaxq.fsf@alter.siamese.dyndns.org> <20111225035059.GA29852@gnu.kitenet.net> <7vsjk99exw.fsf@alter.siamese.dyndns.org> <20111226023154.GA3243@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Dec 27 22:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfeYO-0004iB-9f
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 22:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab1L0V1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 16:27:20 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:20740 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751308Ab1L0V1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 16:27:19 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DA0792C4005;
	Tue, 27 Dec 2011 22:28:03 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7014319F5FA;
	Tue, 27 Dec 2011 22:27:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <20111226023154.GA3243@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187731>

Am 26.12.2011 03:31, schrieb Joey Hess:
> +int feed_post_fetch_hook (int in, int out, void *data)
> +{
> +	struct ref *ref;
> +	struct strbuf buf = STRBUF_INIT;

Is there a particular reason that you accumulate everything in a buffer?

If I read the loop below correctly, you should be able to run it using
only the functions sha1_to_hex(), strlen() and write_in_full(). This
would avoid any problems with concurrent calls to xmalloc().

> +	int ret;
> +
> +	for (ref = post_fetch_hook_refs; ref; ref = ref->next) {
> +		strbuf_addstr(&buf, sha1_to_hex(ref->old_sha1));

sha1_to_hex() works with a static buffer. Are you certain that it is not
called concurrently in the main thread?

> +		strbuf_addch(&buf, ' ');
> +		strbuf_addstr(&buf, ref->merge ? "merge" : "not-for-merge");
> +		strbuf_addch(&buf, ' ');
> +		if (ref->name)
> +			strbuf_addstr(&buf, ref->name);
> +		strbuf_addch(&buf, ' ');
> +		if (ref->peer_ref && ref->peer_ref->name)
> +			strbuf_addstr(&buf, ref->peer_ref->name);
> +		strbuf_addch(&buf, '\n');
> +	}

-- Hannes
