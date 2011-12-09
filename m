From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/9] revert: tolerate extra spaces, tabs in insn sheet
Date: Sat, 10 Dec 2011 01:28:21 +0530
Message-ID: <CALkWK0kCZ7r2-_jF2st3h8MUF_kCgaLvrNZc0uxBxdpiK-7bLg@mail.gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-4-git-send-email-artagnon@gmail.com> <20111209194003.GE20913@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:58:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6an-0008OC-9f
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab1LIT6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 14:58:45 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38363 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab1LIT6o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 14:58:44 -0500
Received: by wgbdr13 with SMTP id dr13so6275624wgb.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=X6hDbKYkWtU8yvA1X09hJOW40jKCbfbtt6obAGb/WTg=;
        b=sFLFhg3AXEmmyAIKQmesDPfVL0WKsSf1hkdRGHgMwGvHW7o4fYdkNiV4C7svG+5fve
         tOCsEu6FxJ+Tnre0wqG2bhhYpS9P48Ia6WJWmtONbVEKQCbUStf96xzlBgkKOQAGtiCo
         n6B3Hxu+bVvvmqPcNRrG3V48T6/d3oK8whxUE=
Received: by 10.216.136.223 with SMTP id w73mr392515wei.112.1323460723309;
 Fri, 09 Dec 2011 11:58:43 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Fri, 9 Dec 2011 11:58:21 -0800 (PST)
In-Reply-To: <20111209194003.GE20913@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186677>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> +++ b/builtin/revert.c
>> @@ -727,7 +727,11 @@ static struct commit *parse_insn_line(char *bol=
, char *eol, struct replay_opts *
>> =C2=A0 =C2=A0 =C2=A0 } else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>>
>> + =C2=A0 =C2=A0 /* Eat up extra spaces/ tabs before object name */
>> + =C2=A0 =C2=A0 while (*bol =3D=3D ' ' || *bol =3D=3D '\t')
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bol +=3D 1;
>> - =C2=A0 =C2=A0 end_of_object_name =3D bol + strcspn(bol, " \n");
>
> Why not use strspn? =C2=A0What happens if I use a tab immediately
> after the pick/revert keyword?

:facepalm: Fixed.  Inter-diff:

diff --git a/builtin/revert.c b/builtin/revert.c
index b976562..be0686d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -716,20 +716,22 @@ static struct commit *parse_insn_line(
 	unsigned char commit_sha1[20];
 	enum replay_action action;
 	char *end_of_object_name;
-	int saved, status;
+	int saved, status, padding;

-	if (!prefixcmp(bol, "pick ")) {
+	if (!prefixcmp(bol, "pick")) {
 		action =3D CHERRY_PICK;
-		bol +=3D strlen("pick ");
-	} else if (!prefixcmp(bol, "revert ")) {
+		bol +=3D strlen("pick");
+	} else if (!prefixcmp(bol, "revert")) {
 		action =3D REVERT;
-		bol +=3D strlen("revert ");
+		bol +=3D strlen("revert");
 	} else
 		return NULL;

 	/* Eat up extra spaces/ tabs before object name */
-	while (*bol =3D=3D ' ' || *bol =3D=3D '\t')
-		bol +=3D 1;
+	padding =3D strspn(bol, " \t");
+	if (!padding)
+		return NULL;
+	bol +=3D padding;

 	end_of_object_name =3D bol + strcspn(bol, " \t\n");
 	saved =3D *end_of_object_name;
--

Thanks.

-- Ram
