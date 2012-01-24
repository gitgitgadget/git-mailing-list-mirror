From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 06/10] clone: delay cloning until after remote HEAD checking
Date: Tue, 24 Jan 2012 14:01:59 +0700
Message-ID: <CACsJy8C_Lzgk-W3D9ArTh4xQBgFcy41UQzTHfghYKrGg7WxHMg@mail.gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326189427-20800-7-git-send-email-pclouds@gmail.com> <7v62g26jm3.fsf@alter.siamese.dyndns.org>
 <7vzkde546x.fsf@alter.siamese.dyndns.org> <7vvco253xx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 08:02:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpaOq-0007bo-EI
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 08:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab2AXHCc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 02:02:32 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48815 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab2AXHCb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2012 02:02:31 -0500
Received: by bkas6 with SMTP id s6so3172527bka.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 23:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=clEWwhBbKVae+iGI3FpsQHEQcWmyjfG47SnjWYpF4iY=;
        b=CuDF02m1taXYqXLP3jBj4I9fJZQbqsEpCha017tFpCBpJO7mddQMetHPgAtETNiZvK
         uCLnRiIFxCGLKS/BXKv/VbXLdiCkmbIwdf2Rxc0D4IV6umjFT0bzvOZZVMR3Od6p/esx
         gpTW0bGBF9RxmW1AgcayPSF92gs8PlwCiQmjs=
Received: by 10.204.10.65 with SMTP id o1mr4366775bko.19.1327388550135; Mon,
 23 Jan 2012 23:02:30 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Mon, 23 Jan 2012 23:01:59 -0800 (PST)
In-Reply-To: <7vvco253xx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189040>

2012/1/24 Junio C Hamano <gitster@pobox.com>:
> Recently, 6f48d39 (clone: delay cloning until after remote HEAD check=
ing,
> 2012-01-16) tried to record if a remote helper needs to be called aft=
er
> parsing the remote when transport_get() is called, by overwriting the
> field meant to store the configured remote helper name in the remote
> structure.
>
> This is OK when a remote represents a single remote repository, but f=
ails
> miserably when pushing to locations with multiple URLs, like this:
>
> =C2=A0 =C2=A0$ cat .git/config
> =C2=A0 =C2=A0[remote "origin"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D https://code.google.com/p/git-html=
docs/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D github.com:gitster/git-htmldocs.gi=
t
> =C2=A0 =C2=A0 =C2=A0 =C2=A0push =3D refs/heads/master:refs/heads/mast=
er

My bad. remote.*.vcs (or remote->foreign_vcs) is designed to override
remote helper detection based on url. Once you have pushed over https,
the following urls will be over https too. Luckily no other places
perform an operation over multiple urls like push so we're safe with
your bandage.

We should have another way to detect whether remote helper being used
(comparing some function pointers like transport->connect or
transport->disconnect may help). But I need to think a bit about
delaying cloning for http(s) too even though remote helper is used.
--=20
Duy
