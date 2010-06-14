From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] textconv: support for blame
Date: Mon, 14 Jun 2010 13:40:21 -0700
Message-ID: <7vfx0p9wlm.fsf@alter.siamese.dyndns.org>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 14 22:40:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOGSX-0003S9-E2
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 22:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab0FNUkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 16:40:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab0FNUkf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 16:40:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74A26BC959;
	Mon, 14 Jun 2010 16:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ohb2QT5ALSRf
	QAWmrpJCPq7JVdk=; b=qVY6QmB1vK7oHx28Kbah8cvhYBv9uq1ldtuaeVFAqSqf
	Q4iqboCq79tgOF9V/zsrbVwSAJ/c2Mf/ekVfmkP2LxtCQ3+3da4wTRFcGXtQJBS3
	Mu6VX2eLAdZ9vfjfWrR5yXmHlkudZeEF/qe0Fnc+Ewd0rWb3tJ93d6Q++JRhVUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Y8s+LO
	FWVWCjN+efybK171gx9KC/F4DIhwu0rmUuptiTY4yaf+kBdz0kE63hMS4/tcQ57t
	DevfYDx/Go4hZYWnTKSYLAeGGNwbevUsCRIfGDfiunXl4jzkCAvlkDaIjvg2IHfC
	FMZygbldfizOul/Dx3uhWsE+ID0rKn3wBCdWg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 156ADBC958;
	Mon, 14 Jun 2010 16:40:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29D4EBC957; Mon, 14 Jun
 2010 16:40:24 -0400 (EDT)
In-Reply-To: <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
 (Axel Bonnet's message of "Mon\,  7 Jun 2010 17\:23\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 119B244A-77F5-11DF-AEB3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149136>

Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:

> @@ -86,16 +87,49 @@ struct origin {
> ...
> +static void fill_origin_blob(struct diff_options *opt,
> +			     struct origin *o, mmfile_t *file)
>  {
>  	if (!o->file.ptr) {
>  		enum object_type type;
>  		num_read_blob++;
> -		file->ptr =3D read_sha1_file(o->blob_sha1, &type,
> -					   (unsigned long *)(&(file->size)));
> +
> +		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
> +		    textconv_object(o->path, o->blob_sha1, &file->ptr,
> +				    (size_t *) &file->size))

This cast is not correct, as there is no guarantee that your size_t and
typeof(mmfile_t.size) are compatible.  Depending on the gcc version, yo=
u
would get "dereferencing type-punned pointer will break strict-aliasing
rules" error.

The same issue exists in Cl=C3=A9ment's patch to builtin/cat-file.c.
