From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7] ls-files: Add eol diagnostics
Date: Tue, 22 Dec 2015 15:35:31 -0800
Message-ID: <xmqq37uucb0c.fsf@gitster.mtv.corp.google.com>
References: <B82763FE-0B35-4474-9956-B4B52DF6602C@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 23 00:35:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBWSw-0000xj-6T
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 00:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933553AbbLVXfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Dec 2015 18:35:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932205AbbLVXfd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 18:35:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7EA136D97;
	Tue, 22 Dec 2015 18:35:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Hpj+InccLGn6
	GcBQC/Nf2ijseqQ=; b=jHlxRZA9AbBLnlV8hzmJMeD/NldG5jzgEt+TgL3nEn1d
	0wN6R6jfBkQ77IAcN/yg96+KmWhDD1PiMQNm76xDbGGxCR1ZD1lr7nHuWcJdNIjN
	3odcYHshwqoVv0YZZfDGkLlkdeM6aB+Irw1Rcs9QFVza1YOp5TvGg2l1aMWY4H4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qy6eSz
	cPXqkbPXeG6+bd9Ho5fEwbPNWwkeemjlR5HiMx16dk4HLojXkTGM6VSAaVeyTCr3
	EG13ztXRcbDonvldhAc5L0zCQwOvNLnm3umsTIGdiBApECowMk9iexec4ouvqif7
	OAUfxPUHw7QiaugL6uAXXu1KycMfefGy0e3L0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DEDFC36D96;
	Tue, 22 Dec 2015 18:35:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5EF2436D95;
	Tue, 22 Dec 2015 18:35:32 -0500 (EST)
In-Reply-To: <B82763FE-0B35-4474-9956-B4B52DF6602C@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 22 Dec 2015 12:45:33
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B149D63A-A904-11E5-ADEB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282916>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> When working in a cross-platform environment, a user wants to
> check if text files are stored normalized in the repository and if
> .gitattributes are set appropriately.
>
> Make it possible to let Git show the line endings in the index and
> in the working tree and the effective text/eol attributes.
>
> The end of line ("eolinfo") are shown like this:
> "binary"       binary file
> "text-no-eol"  text file without any EOL
> "text-lf"      text file with LF
> "text-crlf"    text file with CRLF
> "text-crlf-lf" text file with mixed line endings.
>
> The effective text/eol attribute is one of these:
> "", "-text", "text", "text=3Dauto", "eol=3Dlf", "eol=3Dcrlf"
>
> git ls-files --eol gives an output like this:
>
> i/text-no-eol   w/text-no-eol   attr/text=3Dauto t/t5100/empty
> i/binary        w/binary        attr/-text     t/test-binary-2.png
> i/text-lf       w/text-lf       attr/eol=3Dlf    t/t5100/rfc2047-info=
-0007
> i/text-lf       w/text-crlf     attr/eol=3Dcrlf  doit.bat
> i/text-crlf-lf  w/text-crlf-lf  attr/          locale/XX.po
>
> Note that the output is meant to be human-readable and may change.

Wait, what? =20

I've been assuming that these output being designed was to be read
by machine, because this new feature is implemented as a part of the
command "ls-files", which is plumbing whose output is meant for
script consumption.

> +--eol::
> +	Show line endings ("eolinfo") and the text/eol attributes ("texteol=
attr") of files.
> +	"eolinfo" is the file content identification used by Git when
> +	the "text" attribute is "auto", or core.autocrlf !=3D false.
> +
> +	"eolinfo" is either "" (when the the info is not available"), or on=
e of "binary",
> +	"text-no-eol", "text-lf", "text-crlf" or "text-crlf-lf".
> +	The "texteolattr" can be "", "-text", "text", "text=3Dauto", "eol=3D=
lf", "eol=3Dcrlf".
> +
> +	Both the content in the index ("i/") and the content in the working=
 tree ("w/")
> +	are shown for regular files, followed by the "texteolattr ("attr/")=
=2E
> +

Does this format well, or would the second and third paragraph be
format in a funny way?
