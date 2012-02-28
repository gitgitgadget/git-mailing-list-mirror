From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 03/10] column: add columnar layout
Date: Tue, 28 Feb 2012 10:22:54 -0800
Message-ID: <7vy5rmzukh.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 19:23:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2RhW-00037M-65
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 19:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab2B1SW5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 13:22:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913Ab2B1SW5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 13:22:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAB987244;
	Tue, 28 Feb 2012 13:22:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2zdkV5EVHIJY
	0Gt4s74FjaZNqJg=; b=GTN61tS3RIW9GFcS6x5iGJtNnLFfjmLHHEuCmMhRkb8z
	oy4Hf/yiyGOtO28O6o28viue0Mqn1XPuprsxcv0abFmh72ingUYgHT+AU99AxljQ
	+VTew5ugEs5izyWduE8IEIoWI8w2/68LclpgWbZHh4AuJ7r8ZcL+vt523K7dI+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BiSJN6
	pn4VJ0KePKpX9kVGSH3OZpm3JgbjtLAK9GUlk0BwmgKaUrcZgYa8E81z8i4QOzPO
	j2PYJV2Ehng5axJmVXFAgJqgeOHgRM416J+RYsnz/ll2XO8S5wf9sNHuwDQmXZIN
	rYeixc71Puhi2jevHF1JQqMf5dLN1Q0EBs1vw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0E287243;
	Tue, 28 Feb 2012 13:22:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 381947242; Tue, 28 Feb 2012
 13:22:56 -0500 (EST)
In-Reply-To: <1330430331-19945-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 28 Feb
 2012 18:58:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C50CF3E-6239-11E1-909B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191755>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> COL_MODE_COLUMN and COL_MODE_ROW fill column by column (or row by row
> respectively), given the terminal width and how many space between
> columns.
>
> Strings are supposed to be in UTF-8. If strings contain ANSI escape
> strings, COL_ANSI must be specified for correct length calculation.

Hrm, is it too heavyweight to autodetect and relieve the caller from th=
e
burden of passing COL_ANSI?

Perhaps if you update utf8_strwidth() so that it takes <ptr, len> input
not NUL terminated string, you can do item_length like this, no?

	cp =3D s;
	width =3D 0;
	while (1) {
		ep =3D strstr(cp, "\033[");
		if (!ep) {
			width +=3D utf8_strwidth(cp);
                        break;
		}
                utf8_strwidth_counted(cp, ep - cp);
		... scan ep to skip the "\033[...;X"
		cp =3D ep;
	}
