From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] Allow for MERGE_MODE to specify more then one
 mode
Date: Tue, 27 Nov 2012 18:17:28 -0800
Message-ID: <7v7gp6jwsn.fsf@alter.siamese.dyndns.org>
References: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
 <1354057217-65886-3-git-send-email-draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:17:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXDf-0002xI-77
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab2K1CRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:17:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab2K1CRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:17:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36837AA2B;
	Tue, 27 Nov 2012 21:17:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LzIi9AYDNomgjVyE2orAHOXsohE=; b=rnJXyn
	jceiCPvuJUZSpW2jr99hulLruMrtgqTnRfxivL2tjMukBh0kffy7Dx0ydPpgRkQ+
	090YGwEX+3AoWhDAr2VuJYmK7KEeBR6ETd7vY2W4ZQHVgoPSKpUJa2bfE9/Cb1Iw
	QIgNBxYbwC5d15Tq4z7JiAI4Y4OvCU8t8QhT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nCjDRupP5M7EmcKPXLMTuYdDYzSjDcXZ
	QwDnV0YXKI6dVy+sdbzUP2gjB7ZTB4Rdg19qy0zRZ3uDjOo/egrip+uNRcpDAmpa
	uMbfyyEMmjv1kDZFScUhyJb4ZbUJW6sVCs7gUiaVkjG+CJ5rFrpOoi+m8jHvBoNa
	OqlzBRxBoTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22D79AA2A;
	Tue, 27 Nov 2012 21:17:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79BA1AA28; Tue, 27 Nov 2012
 21:17:30 -0500 (EST)
In-Reply-To: <1354057217-65886-3-git-send-email-draenog@pld-linux.org>
 (Kacper Kornet's message of "Wed, 28 Nov 2012 00:00:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C312BA60-3901-11E2-AA12-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210671>

Kacper Kornet <draenog@pld-linux.org> writes:

> Presently only one merge mode exists: non-fast-forward. But in future
> the second one (transpose-parents) will be added, so the need to read
> all lines of MERGE_MODE.
>
> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> ---
>  builtin/commit.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 273332f..ee0e884 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1427,7 +1427,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	unsigned char sha1[20];
>  	struct ref_lock *ref_lock;
>  	struct commit_list *parents = NULL, **pptr = &parents;
> -	struct stat statbuf;
>  	int allow_fast_forward = 1;
>  	struct commit *current_head = NULL;
>  	struct commit_extra_header *extra = NULL;
> @@ -1481,11 +1480,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  
>  		if (!reflog_msg)
>  			reflog_msg = "commit (merge)";
> -		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
> -			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
> -				die_errno(_("could not read MERGE_MODE"));
> -			if (!strcmp(sb.buf, "no-ff"))
> -				allow_fast_forward = 0;
> +		if((fp = fopen(git_path("MERGE_MODE"), "r"))) {

Style: s/if((fp/if ((fp/;

> +			while (strbuf_getline(&m, fp, '\n') != EOF) {
> +				if (!strcmp(m.buf, "no-ff"))
> +					allow_fast_forward = 0;
> +			}
> +			fclose(fp);

This needs a bit more careful planning for interacting with other
people's programs, I suspect.

Your updated builtin/merge.c may write an extra LF after no-ff to
make this parser to grok it, but it is entirely plausible that
people have their own Porcelain that writes "no-ff" without LF
(because that is what we read from this file, and I suspect the
current code would ignore "no-ff\n").

At least strbuf_getline() would give us "no-ff" when either "no-ff"
or "no-ff\n" terminates the file, so updated code would be able to
grok what other people would write, but if other people want to read
MERGE_MODE we write, at least we shouldn't break them when we only
write no-ff in it (once you start writing "reverse-parents" in the
file, they will be broken anyway, as they do not currently expect
such token in this file).

I am starting to wonder if this is worth it, though...
