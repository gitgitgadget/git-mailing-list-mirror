From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/4] textconv: support for blame
Date: Thu, 03 Jun 2010 23:00:38 -0700
Message-ID: <7veign5oc9.fsf@alter.siamese.dyndns.org>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-4-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 04 08:00:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKPxf-00058D-EC
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 08:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966Ab0FDGAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 02:00:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0FDGAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 02:00:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D677B9203;
	Fri,  4 Jun 2010 02:00:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=MRmgGl+9/Ty7bSTZMQ2pd+mN2b0=; b=WB24LzZfvwTjejfVLS8s0tb
	8GHO9jiHc6sNGq7DwqOEM82rTu1rYdNNZxz/i5SJoCIr6iZTDuLUiHw5E50QuWKh
	I/0LIJbaetPfcrArK71bX5cqsTS05b8IF0pRIsVPnIB0Y6U8D/UBDTEiSsulM54x
	WIlfNFqG41xN6U8b8rzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KsJHnFGttzTxXsyGh88PzIfmKeOHs6uXryR2MvAKp4GHfLcC7
	MOKQFxRMtBNvQL20D2vBAzDP8ndKYj0hyo+blb+AdKW1dHbBwyFEyFmQtHXXEjMv
	2HG3j/JNllZVrC9VPUEdCB7iVi+a7tDgiwJ2pErOI5bMrMowiI+I8+9Phs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 180A5B9200;
	Fri,  4 Jun 2010 02:00:45 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 029A0B91FF; Fri,  4 Jun
 2010 02:00:39 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83C46CD4-6F9E-11DF-9BAD-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148379>

Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:

> @@ -2033,10 +2072,13 @@ static struct commit *fake_working_tree_commit(struct diff_options opt,
>  			read_from = path;
>  		}
>  		mode = canon_mode(st.st_mode);
> +
>  		switch (st.st_mode & S_IFMT) {
>  		case S_IFREG:
> -			if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
> -				die_errno("cannot open or read '%s'", read_from);
> +			if (!DIFF_OPT_TST(&opt, ALLOW_TEXTCONV) ||
> +			    !textconv_object(read_from, null_sha1, mode, &buf))
> +				if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
> +					die_errno("cannot open or read '%s'", read_from);

This is just a style thing but it would probably be easier to read if you
structured it like:

	if (! we are allowed to use textconv ||
	    do textconv and we did get the converted data in the buffer)
		; /* happy */
	else if (! successfully read the blob into buffer)
		die;

By the way, can't textconv_object() ever fail?  I see the function has its
own die() but it looks a bit funny to see one branch of an "if" statement
calls a function that lets the caller decide to die while the function
called by the other branch unconditionally dies on failure at the API
design level.

An alternative would be to encapsulate the whole of the above logic in one
helper function perhaps.

> @@ -2249,8 +2291,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	int cmd_is_annotate = !strcmp(argv[0], "annotate");
>  
>  	git_config(git_blame_config, NULL);
> +	git_config(git_diff_ui_config, NULL);

What configuration are we pulling into the system with this call?  Would
they ever affect the internal diff machinery in a negative way?  I am
especially wondering about "diff.renames" here.

>  	init_revisions(&revs, NULL);
>  	revs.date_mode = blame_date_mode;
> +	DIFF_OPT_SET(&revs.diffopt, ALLOW_TEXTCONV);

As an RFC patch, I would have preferred if we didn't have this line to
force --textconv on by default, but instead you merely allowed the
mechanism to be used by giving the option explicitly from the command
line.

Other than these points, the series looked quite sane to me.
