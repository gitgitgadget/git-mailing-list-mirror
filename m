From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/5] merge/pull: verify GPG signatures of commits
 being merged
Date: Fri, 29 Mar 2013 20:38:06 -0700
Message-ID: <7vvc89k15t.fsf@alter.siamese.dyndns.org>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org>
 <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de>
 <51562E6A.6020007@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sat Mar 30 04:38:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULmco-0005nF-KJ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 04:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757646Ab3C3DiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 23:38:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757593Ab3C3DiK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Mar 2013 23:38:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E824AF6BB;
	Sat, 30 Mar 2013 03:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=XlsVZYQiMuzyD6hRbrTH9YOl7
	3o=; b=thn4IEW6ErpP+X5dGS4/E5OkUcvRZIPAHrjYrPjHLkE60qvRD2Q2YaQh0
	DP+4XQ0cbSM0rfXtlU5aV7uq6VGz6cook0lSl/frZVvwTe8CrU0DaAn0MWv0c52R
	5VwnN/qdZ/fe+uzDBBc3J7RT0H9eAbWKeJCElfQcfHjbxwdEgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=sxF62DxHUO2IUArBcXJ
	00NpEakT37jHHKQ0wrcgwX6v1kCtwLsf3Gk5ETU+yNwdr8S+4uNRxj/NQ4/W4g1U
	XTt6Ly8gvqWVF1KyuAuMw803HyPxspJ1DqcOshxcIdvohxCKkIs3nVo7FShiZ4Op
	TMgRqioyvplE2XEbpzjw8EcM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0D58F6BA;
	Sat, 30 Mar 2013 03:38:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59832F6B7; Sat, 30 Mar 2013
 03:38:09 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DA8E9FE-98EB-11E2-A27E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219551>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> +	OPT_BOOLEAN(0, "verify-signatures", &verify_signatures,
> +		N_("Verify that the named commit has a valid GPG signature")),

Please use OPT_BOOL() in new code.  Verifying existing OPT_BOOLEAN()
can safely converted to OPT_BOOL() and doing so would be a separate
matter and should not be part of this series.

> @@ -1233,6 +1235,35 @@ int cmd_merge(int argc, const char **argv, con=
st char *prefix)
>  		usage_with_options(builtin_merge_usage,
>  			builtin_merge_options);
> =20
> +	if (verify_signatures) {
> +		/* Verify the commit signatures */

This boolean variable is named clearly enough that you do not need
this comment.

> +		for (p =3D remoteheads; p; p =3D p->next) {
> +			struct commit *commit =3D p->item;
> +			char hex[41];
> +			struct signature_check signature_check;
> +			memset(&signature_check, 0, sizeof(signature_check));
> +
> +			check_commit_signature(commit, &signature_check);
> +
> +			strcpy(hex, find_unique_abbrev(commit->object.sha1, DEFAULT_ABBRE=
V));
> +			switch(signature_check.check_result){
> +				case 'G':
> +					if (verbosity >=3D 0)
> +						printf(_("Commit %s has a good GPG signature by %s (key finger=
print %s)\n"), hex, signature_check.signer, signature_check.key);
> +					break;
> +				case 'B':
> +					die(_("Commit %s has a bad GPG signature allegedly by %s (key f=
ingerprint %s)."), hex, signature_check.signer, signature_check.key);
> +				default: /* 'N' */
> +					die(_("Commit %s does not have a good GPG signature. In fact, c=
ommit %s does not have a GPG signature at all."), hex, hex);
> +			}

Style.

        switch (expr) {
	case 'G':
		do_something_for_G();
		break;
		...
	}

Also avoid overlong lines, both in the source, but pay extra
attention to what we show the user.  For example:

    "Commit %s has a bad GPG signature allegedly by %s (key fingerprint=
 %s)."

The first %s will expand to 40 places, the other two are likely to
be around 20-30 places.

    "Commit %s does not have a good GPG signature. In fact, commit %s d=
oes not have a GPG signature at all."

Drop everything from the beginning up to "In fact, ", perhaps:

    "Commit '%s' does not have any GPG signature."

is sufficient?  You may also want to consider

	die(_("Commit '%.*s...' does not have any GPG signature."),
	    8, hex);
