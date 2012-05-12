From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/4] notes: preserve object type given by "add -C"
Date: Sat, 12 May 2012 12:20:00 +0700
Message-ID: <CACsJy8Avusvu9LJeg1L=OZ9=qW+FaqbNWfA_rrZJUY_3WqfhOg@mail.gmail.com>
References: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
 <1336699506-28388-2-git-send-email-pclouds@gmail.com> <7vzk9eju4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 12 07:21:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST4lV-0007kt-6V
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 07:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab2ELFUc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 01:20:32 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63674 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2ELFUb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 01:20:31 -0400
Received: by wgbdr13 with SMTP id dr13so3066101wgb.1
        for <git@vger.kernel.org>; Fri, 11 May 2012 22:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=T5Ltk/C1omQwHypYinnREq472Eriwu/BgZ5UwQMMATU=;
        b=mvB/P7+yIXqgd7UAPkBbvSYDGHOJxGaBWR/P3KX83xEO+5Rad1XX/baHiSW51ZqggZ
         wcmEtW8uYvnrGExD7bEtW9tvbnkpSJGwGB+Qygz5DVQ0RuyuWDfiAe5SGEYsDhV8A5KA
         Pktkpdq3vrYoHQ/Ofmd/G3ydsMfXzSkJw2ty0TqbZfcNPBLu0KIiy8UzQE88FbovBEtr
         1yC0DA+Z7ccDPtBl8c7pdDOrqOHbRcFClWIxxt+UH2TRlseOZiCT1cpj524dgfUzfoQU
         OBxxgodbKvC6sX0Anvcjcf7GUXoVVeC0JiE+bB3x/3CcRLi9Yt/UlS+swytz9lWh3J7M
         bFUw==
Received: by 10.180.105.198 with SMTP id go6mr1656370wib.19.1336800030419;
 Fri, 11 May 2012 22:20:30 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Fri, 11 May 2012 22:20:00 -0700 (PDT)
In-Reply-To: <7vzk9eju4m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197711>

On Sat, May 12, 2012 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> _Automatically_ converting a non-blob object to a blob is
>> wrong. Either this way, or reject non-blob objects upfront.
>
> But wouldn't it be even _more_ wrong to stuff a non-blob object at th=
e
> leaf level of the notes tree?

If people deliberately want to do that and notes subsystem knows not
to mess with non-blob objects, I think it's ok. Though if users want
to add some text, but put non-blob by mistake, then it's wrong to
accept it.

> It is not automatically "converting"; as far as the notes subsystem i=
s
> concerned, the data you throw at it to be associated with an object t=
he
> note annotates has always been uninterpreted stream of bytes. =C2=A0I=
f an
> application wants to store the raw representation of a commit object
> including the log message and its header, it has every right to expec=
t
> that it can use "git cat-file commit $argument_to_the_C_option" as th=
e
> source of that uninterpreted stream of bytes, doesn't it?

Some part of git-notes expects this stream of bytes to be textual,
human readable. In that case, "git notes add -C commit/tag"'s stuffing
a blob with the given commit/tag content to notes tree may make sense.
Personally I'd rather stuff the commit/tag object instead so no new
blobs are created. The end result is the same: read_sha1_file() always
return correct text, so does "git notes show".

The difference after this series is "notes add -C commit; notes append
-m foo" now results in an error message while it case goes smoothly
without the series. Perhaps we can be more flexible here on appending
and allow to append non-tree objects to non-tree objects, resulting in
a blob note.
--=20
Duy
