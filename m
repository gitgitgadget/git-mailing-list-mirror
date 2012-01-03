From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix hang in git fetch if pointed at a 0 length bundle
Date: Tue, 03 Jan 2012 12:11:24 -0800
Message-ID: <7vboqktukz.fsf@alter.siamese.dyndns.org>
References: <20120103011352.GA13825@localhost>
 <CACsJy8B5B2bx7WK7ViziseuWCPaMgcc-avwtsw2DybRme8Vgfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Harring <ferringb@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:11:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAhs-0004If-2I
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab2ACUL1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 15:11:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934Ab2ACUL0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2012 15:11:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CB7F62C6;
	Tue,  3 Jan 2012 15:11:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jGNRjcJ37xhX
	8QO27cEnNpzw65g=; b=F+pOj/49PgC2cg4Ee1Jd/7RSBXvg0aBAL6GvHw1nctsF
	PMZIXA8QqkIvVQz8Ilb2ioCcw+9JNjzxQfzK02OAQxwPEpSxMdOzEtCezdytMUrh
	bFg43RjH6pr4KvVi1je+eKhxsPEl/HcEPZXHfsxApg6P3P7tAZP8jbWiVrKApwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jjlzt0
	iQcH1KLq8M1sTFJ/QW3LQ1ttiDbli4NaX07VQc6/zJ4xOTIWqPR1mAHSvk4iB/Pk
	k+rzw/ZkIaMt0O9O5ZGC0tN7xGR6+5cIQR5BSyjz33wnPD1BQk7dX2fV3yc99W/q
	+Hrkd/JhfSfT56m13jxQ9D3aW56jTCkBFe35Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 435C362C5;
	Tue,  3 Jan 2012 15:11:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDF8A62C4; Tue,  3 Jan 2012
 15:11:25 -0500 (EST)
In-Reply-To: <CACsJy8B5B2bx7WK7ViziseuWCPaMgcc-avwtsw2DybRme8Vgfg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 3 Jan 2012 19:07:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D37100E-3647-11E1-B517-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187889>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, Jan 3, 2012 at 8:13 AM, Brian Harring <ferringb@gmail.com> wr=
ote:
>> @@ -31,7 +31,7 @@ static int strbuf_readline_fd(struct strbuf *sb, i=
nt fd)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (1) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char ch;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t len =3D=
 xread(fd, &ch, 1);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len <=3D 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -1;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addch(=
sb, ch);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ch =3D=3D=
 '\n')
>
> I think it should return 0 when len =3D=3D 0 because strictly speakin=
g eof
> is not a fault.

Even if you do not strictly speak, end of file is a perfectly normal th=
ing
to see, no?  IOW wouldn't the original patch actively _break_ callers t=
hat
read the whole file from the file descriptor to the end?

> FWIW I went through all xread call sites. All seem to handle return
> value <=3D 0 correctly.

Thanks.
