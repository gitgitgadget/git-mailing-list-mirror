From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 3/6] commit: --fixup option for use with rebase
 --autosquash
Date: Wed, 27 Oct 2010 15:35:50 -0700
Message-ID: <7vpquvb6wp.fsf@alter.siamese.dyndns.org>
References: <1287689637-95301-1-git-send-email-patnotz@gmail.com>
 <1287689637-95301-4-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 00:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBEbN-0005Ub-Sb
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 00:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379Ab0J0Wf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 18:35:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab0J0Wf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 18:35:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D8E0A113D;
	Wed, 27 Oct 2010 18:35:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=TmtW2HeXPgqk4/MfVtcx2wlq9CM=; b=g72AKDPajIwyha4dn+dSqs/
	N5wUis1KQ7n7/Wi++ALzPt0Z7yaO3GBy2JJyRbd+Y8UJraXqyGc834NfR9YoOASb
	a6Esx0f6wxZ1oupj9qpmZ/lm87B2I1iA6kwZwOt6cLL3Bxouk6eq/InwDoz6EQH/
	XvD1D51tskd7aoL2RdeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=SoX2Sug9Waesx81+nafZJTNyZk+zy5Rt82U65awN7iMYwJpgH
	Ahjrz1Z/ggKK4oikyw1m1M4GLNbpr/vLCAUDGWLgvZ9RRpNKD008EKuqvZ4my+ma
	M9RfXtnMOTzA/ShSwa62ADGNTr1ujdtw6TTKEunvXimVn19r1ZE4gkNYfU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B57D3113B;
	Wed, 27 Oct 2010 18:35:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 174E61139; Wed, 27 Oct
 2010 18:35:51 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F648198-E21A-11DF-9AE4-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160131>

"Pat Notz" <patnotz@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 5fa24f5..c82108c 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -586,6 +588,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
>  		hook_arg1 = "commit";
>  		hook_arg2 = use_message;
> +	} else if (fixup_message) {
> +		struct pretty_print_context ctx = {0};
> +		struct commit *commit;
> +		const char *out_enc;
> +		commit = lookup_commit_reference_by_name(fixup_message);
> +		out_enc = get_commit_output_encoding();
> +		format_commit_message(commit, "fixup! %s\n\n",
> +				      &sb, &ctx, out_enc);

As your lookup_commit_reference_by_name() expects the caller to check for
errors, you should do something similar to what you do in your
"use_message" codepath in your [PATCH 1/6].

	if (use_message) {
		const char *out_enc;
		struct commit *commit;
 
		commit = lookup_commit_reference_by_name(use_message);
		if (!commit)
			die("could not lookup commit %s", use_message);
		out_enc = get_commit_output_encoding();
		use_message_buffer = logmsg_reencode(commit, out_enc);
