From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 03/12] commit --amend: invoke post-rewrite hook
Date: Sat, 20 Feb 2010 19:12:29 -0800
Message-ID: <7vd3zz46zm.fsf@alter.siamese.dyndns.org>
References: <cover.1266703765.git.trast@student.ethz.ch>
 <99b0d5c4ecb129fd663e50fbb46f41ff9f824c34.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:56:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2FT-0004un-SJ
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972Ab0BUDMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:12:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155Ab0BUDMm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:12:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 657FA9BC2C;
	Sat, 20 Feb 2010 22:12:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MPCodF6zuO9+cHKRFFuaYQsrt78=; b=cwLAtg
	Xc1cPDCDU8c9GtjHlWCAZG0xaWBWGm49d+nD/2/b2e07egN3nn9gNUJ6VUGwG+Yv
	J9jwQuTEA3B6Z59b9hkwYDU64mNdmPG9lrA70aoMG1PhU3z5uuCFsF3ml8Yy7RTa
	7OyScVEcd4UTLIOXCSt5KPpVFyli9meCPoGAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xCBWBPGHtdI9jDWlSDUTjXedlWduibZA
	CJ6VQJIMffgfAGZ/z9B8rNAlCOBbSzDfsO38NOxvbN2WbOPdy1AG9NeEIbNFpGal
	BHg3S8cJg+5as+XZVqFWsVWcWoD6MJlN2sc5KNujgJ/2EO4MtHQqOD4i7JEuYd5c
	jDk9lbR+AKs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01B4B9BC2A;
	Sat, 20 Feb 2010 22:12:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7DCF9BC24; Sat, 20 Feb
 2010 22:12:31 -0500 (EST)
In-Reply-To: <99b0d5c4ecb129fd663e50fbb46f41ff9f824c34.1266703765.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat\, 20 Feb 2010 23\:16\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F6D94C66-1E96-11DF-ADA8-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140587>

Thomas Rast <trast@student.ethz.ch> writes:

> +static const char post_rewrite_hook[] = "hooks/post-rewrite";
> +
> +static int run_rewrite_hook(const unsigned char *oldsha1,
> +			    const unsigned char *newsha1)
> +{
> +...
> +}
> +
>  int cmd_commit(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> @@ -1303,6 +1339,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  
>  	rerere(0);
>  	run_hook(get_index_file(), "post-commit", NULL);
> +	if (amend && !no_post_rewrite) {
> +		struct commit *commit;
> +		commit = lookup_commit(head_sha1);
> +		if (!commit || parse_commit(commit))
> +			die("HEAD commit disappeared right under my eyes?");
> +		run_rewrite_hook(commit->object.sha1, commit_sha1);

Why aren't you passing head_sha1 to run_rewrite_hook() in the first place,
and instead run lookup_commit() only to get its object.sha1?

This is merely a "post" hook, so failure to run it should not cause the
main program to fail.  By not looking it up you do not even have to check
and call die().  Let the dying be done in the hook instead ;-).
