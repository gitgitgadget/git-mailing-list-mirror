From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/5] Move commit GPG signature verification to
 commit.c
Date: Fri, 29 Mar 2013 20:37:38 -0700
Message-ID: <7v38vdlfr1.fsf@alter.siamese.dyndns.org>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org>
 <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de>
 <51562E4E.7070605@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sat Mar 30 04:38:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULmcM-0004SF-Bq
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 04:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757884Ab3C3Dhm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 23:37:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757673Ab3C3Dhl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Mar 2013 23:37:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3537F699;
	Sat, 30 Mar 2013 03:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=KbpwuV/X3sXo1BE2+32EsSJ+m
	VE=; b=Yypl3BxWJ+EdDYCNfPKSOgJcNYmpQdnVDGJLG9IV+PLx1SwcYSi1YNqdV
	AMok+lXTX7zbNskqv798Otl8gH4Ak9wTAtU/gh8NAeZEQcZkTFGHaXJMRapVx9bK
	dWYJLcV8q8B3QrMlR+KzOIL8hwnKSmiA6GTkgOpnyjhY6ASv4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=cAcsD7XF8k6IcOm2lgH
	ZMZVtHuzkGSzn4REW6lbzdVjPj12a2+QPzWr0iV//Us23pNdgxaK/XfquBdbZgHN
	FIPDBd1CCk6AzLwtFuzL1V4W83lnotXRIt0zKjtPiZUB+SeeGP2/OJlvImbOnJ7g
	egkRrBAKPLkXN0a5Dr871nO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAE5AF698;
	Sat, 30 Mar 2013 03:37:40 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5038BF697; Sat, 30 Mar 2013
 03:37:40 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C5A3AB8-98EB-11E2-9F1E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219550>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> @@ -230,4 +231,12 @@ extern void print_commit_list(struct commit_list=
 *list,
>  			      const char *format_cur,
>  			      const char *format_last);
> =20
> +/*
> + * Check the signature of the given commit. The result of the check =
is stored in
> + * sig->check_result, 'G' for a good signature, 'B' for a bad signat=
ure and 'N'
> + * for no signature at all.
> + * This may allocate memory for sig->gpg_output, sig->gpg_status, si=
g->signer and sig->key.
> + */

How wide is your terminal?  These lines are a tad wider than our
standard.  We tend to keep function decls in *.h files on a single
long line (primarily to help people who grep them without using
CTAGS/ETAGS), but everywhere else we try to keep most of our lines
comfortably fit on 80-column terminals.

> +extern void check_commit_signature(const struct commit* commit, stru=
ct signature_check *sigc);
> +
>  #endif /* COMMIT_H */
> diff --git a/gpg-interface.h b/gpg-interface.h
> index cf99021..44f70aa 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -1,6 +1,14 @@
>  #ifndef GPG_INTERFACE_H
>  #define GPG_INTERFACE_H
> =20
> +struct signature_check {
> +	char *gpg_output;
> +	char *gpg_status;
> +	char check_result; /* 0 (not checked), N (checked but no further re=
sult), G (good) or B (bad) */

Listing the possible values is a good idea, but not on a single
line.

Also now the structure screams with its name that it is about
checking, I do not see a reason for its field to repeat "check".
Calling it "result" (or "result_code") would avoid stuttering when
you use them, e.g.

	struct signature_check signature_check;

	switch (signature_check.check_result) {
        ...

would be less nice than

        switch (signature_check.result) {
	...

no?
