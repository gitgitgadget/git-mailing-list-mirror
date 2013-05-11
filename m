From: Andrey Borzenkov <arvidjaar@gmail.com>
Subject: Re: Cannot push anything via export transport helper after push
 fails.
Date: Sat, 11 May 2013 22:48:37 +0400
Message-ID: <20130511224837.39a1c551@opensuse.site>
References: <20130511162936.0354e5d7@opensuse.site>
	<CAMP44s1YhQR0o-0CLc2PG-EJTZdN4tha-4BVEUy-K_Av81D=GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 20:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbEqj-0001Nj-6I
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 20:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab3EKSsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 14:48:41 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:58257 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab3EKSsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 14:48:40 -0400
Received: by mail-la0-f45.google.com with SMTP id fp12so4927129lab.4
        for <git@vger.kernel.org>; Sat, 11 May 2013 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=R5aQnuT5kdLyEDtGpiEJef1kJsC1RoIUjEkSX3jpggE=;
        b=OoYFZF3w1pai7uv7z/vbhox11VbJzBZwm1AJFnFXKl62BIjJZo2zvzMdqmE/Eq1Xh3
         4Nsin38SfRDkyrVzEBwjka6M76kBmWnhSMDE1igePBzsXkzwR7YJ9ItrSfhdwi5QZLFd
         7Sjc89thQnw/hZpZjqwWmLD2fd+VzC8swYVN9j80zKU61b4UslKJ7b/FHG22nDMuoflA
         3hVnlezNqQaOCCvBawXNgWPGks4rB0aJkwrOVuKjSIj4VeEvMR3IyxjVW9q+PomaBCW7
         PLy8hrsTdvmTybJn2XBR1W7Ii0iYdpOu4RAEyoXa5TedgZhrtbSvBHEt2/zIJEsi6PL5
         whMQ==
X-Received: by 10.112.125.164 with SMTP id mr4mr9882800lbb.116.1368298119278;
        Sat, 11 May 2013 11:48:39 -0700 (PDT)
Received: from opensuse.site ([94.29.72.160])
        by mx.google.com with ESMTPSA id c9sm2268934lba.16.2013.05.11.11.48.38
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 11:48:38 -0700 (PDT)
In-Reply-To: <CAMP44s1YhQR0o-0CLc2PG-EJTZdN4tha-4BVEUy-K_Av81D=GQ@mail.gmail.com>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.14; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223999>

=F7 Sat, 11 May 2013 08:57:14 -0500
=46elipe Contreras <felipe.contreras@gmail.com> =D0=C9=DB=C5=D4:

> >
> > The problem seems to be that git fast-export updates marks
> > unconditionally, whether export actually applied or not. So next ti=
me
> > it assumes everything is already exported and does nothing.
> >
> > Is it expected behavior?
>=20
> Indeed, this is the way it currently works, and it's not easy to fix.
> We would need some way to make fast-export wait until we know the exi=
t
> status of the remote helper, and then tell it when it failed, so the
> marks are not updated.
>=20

One possibility would be to omit *export-marks and manage GIT marks in
remote helper as well. Helper would then update synchronously both GIT
and BZR marks if no errors were detected. Or even better, it could
update just those commits that had been successful.

> However, the way remote-bzr/hg work is that the commits are still
> there anyway. So if you merge the next time you push those commits ar=
e
> already converted, so it's not a problem if fast-export is not
> exporting them again.
>=20

As I understand bzr commit ID is stable. What happens if we try to
commit the same ID second time?

> So even though it's not ideal, it should work.
>=20

I'm more concerned about transport errors. Any network glitch during
push renders you repository unusable (at least, without much efforts).

> The problem is when the remote-helper crashes and the marks of
> fast-export and the remote-helper are out of sync, and then the user
> is really screwed.
>=20

This case would benefit from moving processing of GIT marks into remote
helper as well.
