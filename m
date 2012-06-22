From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Editing the root commit
Date: Fri, 22 Jun 2012 14:35:33 -0700
Message-ID: <7vobobm3mi.fsf@alter.siamese.dyndns.org>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com> <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
 <20120620193922.GB3192@arachsys.com>
 <20120620194824.GA32228@sigill.intra.peff.net>
 <20120622205026.GI32205@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 23:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiBW0-0005uT-7l
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 23:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab2FVVfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 17:35:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48141 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756015Ab2FVVff (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 17:35:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 323678AB4;
	Fri, 22 Jun 2012 17:35:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LJumq2qlMDsXYN4GYree97QDV1M=; b=TcH9zu
	d07SlUkroTerLTJkhifodnBpOAVzh2uiLgH6jbltSHiXMV5ECEa8h1Yr8X1kdw1t
	gNTT1mYRMcK/c32pSGV8vBgl4rJNwSHSioPE1dTJa+TcqHPJZhW6DHnF0NXIk/M+
	cjlz4YwhijnzpCcn/FqrGol5L8nom50FU/RuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QyZBxVO/SBDbm9CFuBLQ/rT2Vw/7mfey
	3ZxNZlzsIYh64JzX/U9NoPMfbl5llhWoc9adpBGm34vFDBy8IyoqauEFXuf+xsuK
	g/mK6+fuiMKho2jt7RVXAIs+QyD21xV4P0tAHAr3iqEj2KP4nFpNsoRlEkq1DCw+
	ZJ8kcThw2ks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28EF18AB3;
	Fri, 22 Jun 2012 17:35:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB6658AB2; Fri, 22 Jun 2012
 17:35:34 -0400 (EDT)
In-Reply-To: <20120622205026.GI32205@arachsys.com> (Chris Webb's message of
 "Fri, 22 Jun 2012 21:50:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3334D8FE-BCB2-11E1-B300-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200474>

Chris Webb <chris@arachsys.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I think the only thing you can do is make a fake sentinel commit (with
>> an empty tree) to put in HEAD, and then remove the sentinel immediately
>> after the first commit is put in place (making sure not to include it in
>> the first commit's parent list). Yuck.
>
> If I do this:
>
> diff --git a/path.c b/path.c
> index 6f2aa69..1b3b6f3 100644
> --- a/path.c
> +++ b/path.c
> @@ -169,8 +169,9 @@ int validate_headref(const char *path)
>  	int fd;
>  	ssize_t len;
>  
> +	/* Allow HEAD to be entirely missing for detached orphan state */
>  	if (lstat(path, &st) < 0)
> -		return -1;
> +		return errno == ENOENT ? 0 : -1;
>  
>  	/* Make sure it is a "refs/.." symlink */
>  	if (S_ISLNK(st.st_mode)) {
>
>
> to thwart the sanity check, I can do 'rm $GIT_DIR/HEAD' to put my HEAD into a
> state where it is both detached and unborn, i.e. so that my next commit will
> result in a detached HEAD pointing at a root commit.

No thanks.  It will be too big a change to the fundamental invariant
for what a git directory is (and isn't).  It is simply unacceptable
to suddenly start treating a random directory that does not even
have HEAD as a git directory.

It would be a lot more palatable approach to teach "rebase -i" defer
its "detaching HEAD to the onto commit" step before starting to read
the insn sheet.  Would such a change be too involved for it to be
worth supporting "rebase --root -i"?
