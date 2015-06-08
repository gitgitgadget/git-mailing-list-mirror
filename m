From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: cope with scissors lines in commit message
Date: Mon, 08 Jun 2015 08:36:34 -0700
Message-ID: <xmqqoakqciv1.fsf@gitster.dls.corp.google.com>
References: <1433727639-5927-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:36:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1z6Q-0005Xf-6c
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbFHPgi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 11:36:38 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34861 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbFHPgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:36:36 -0400
Received: by iesa3 with SMTP id a3so100710556ies.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=sh2GvUqCb4lq9SCxbE4K5RJRNbz4akFEBRwm/ybkqKM=;
        b=Tw7TcqmjigkwWlN1wp725iTeZv4k7V0RZLut78dddhBcswv3azgT9R22XEQsVcvj8O
         Q+SDpsTSD4U7lKwCZbDmmEy0UG1rEuftnsUpxxlwmsTJbS0HejEFbAVym+pDWgKiTNC+
         AoWDJPs1XTVL0o1fqtQ+rUZfoT3FerYwGWEwb3v4aAAnb8msrleMHkMWSDavJq/L+3pB
         GwLzrQIBUq0X1qs/csGRv5XZtzZB1otjb4x2qzlqeKmIsOpD+3YXu7pdz/JL7b8Iqtj5
         dr165xrUjeora2JOiNbvmQXlKMjuRv/VDM4NylGlwurSlqgG8WQv9YLqnWJuUiQSTE9c
         duRA==
X-Received: by 10.50.80.19 with SMTP id n19mr14152632igx.30.1433777796377;
        Mon, 08 Jun 2015 08:36:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d91a:edb1:b738:fb03])
        by mx.google.com with ESMTPSA id g1sm1939992iog.4.2015.06.08.08.36.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 08:36:35 -0700 (PDT)
In-Reply-To: <1433727639-5927-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 8 Jun 2015 03:40:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271052>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> The diff and submodule shortlog appended to the commit message templa=
te
> by 'git commit --verbose' are not stripped when the commit message
> contains an indented scissors line.
>
> When cleaning up a commit message with 'git commit --verbose' or
> '--cleanup=3Dscissors' the code is careful and triggers only on a pur=
e
> scissors line, i.e. a line containing nothing but a comment character=
, a
> space, and the scissors cut.  This is good, because people can embed
> scissor lines in the commit message while using 'git commit --verbose=
',
> and the text they write after their indented scissors line doesn't ge=
t
> deleted.
>
> While doing so, however, the cleanup function only looks at the first
> line matching the scissors pattern and if it doesn't start at the
> beginning of the line, then the function just returns without perform=
ing
> any cleanup.  This is bad, because a "real" scissors line added by 'g=
it
> commit --verbose' might follow, and in that case the diff and submodu=
le
> shortlog get included in the commit message.

Yikes; this is not just "bad" but simply "wrong".  Thanks for
noticing.

>  void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
>  {
> -	const char *p;
> +	const char *p =3D buf->buf;
>  	struct strbuf pattern =3D STRBUF_INIT;
> =20
>  	strbuf_addf(&pattern, "%c %s", comment_line_char, cut_line);
> -	p =3D strstr(buf->buf, pattern.buf);
> -	if (p && (p =3D=3D buf->buf || p[-1] =3D=3D '\n'))
> -		strbuf_setlen(buf, p - buf->buf);
> +	while ((p =3D strstr(p, pattern.buf))) {
> +		if (p =3D=3D buf->buf || p[-1] =3D=3D '\n') {
> +			strbuf_setlen(buf, p - buf->buf);
> +			break;
> +		}
> +		p++;
> +	}

I however wonder if we should make strstr() do more work for us.

	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
	if (starts_with(buf->buf, pattern.buf + 1))
		strbuf_setlen(buf, 0);
	else if ((p =3D strstr(buf->buf, pattern.buf)) !=3D NULL)
        	strbuf_setlen(buf, p - buf->buf + 1);
	strbuf_release(&pattern);

perhaps?
