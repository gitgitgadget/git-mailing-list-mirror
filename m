From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] gc: reject if another gc is running, unless --force
 is given
Date: Sat, 3 Aug 2013 17:01:13 +0700
Message-ID: <20130803100113.GA8239@lanh>
References: <1375503605-32480-1-git-send-email-pclouds@gmail.com>
 <1375510890-4728-1-git-send-email-pclouds@gmail.com>
 <51FCD20E.8070406@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 03 12:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Ydh-00052j-2k
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 12:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab3HCKAl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 06:00:41 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:54603 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3HCKAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 06:00:40 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so1518324pab.31
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y5qBcjPfDBnuWtmsQJFggJy3RzHaxz2lOg83iWGGU6o=;
        b=r+N3GcjTaP6mso+GuH/hiJ/5ppH9/04lTkM+r8cIUCAAu1DJXkOxvK+1GxteqoBRh5
         GLEWdpFGxifo7CqoSUOLimL8OZwWs0NIVPnPcBW7ZtxNFSBW+VqaYb1rYKqpcM6zXD8P
         HjEYb6IhfZVBX7FhxJXh8nNoF3Ok2Bdf6CDw0sEtJ6PfB2FFHb7euEAAvmNFjD0b15A8
         Rqqg9H0Byd2ZfOd7UVXNs2p8s7DVQNHyZU1yuyLoxDpezlW2haABB4bc9+nT96aU3Gow
         inr4X9y5d4IkUS0bOJJ5wc8AeCy6t91AT1QlwHKQYrEhF0fBENnmaOk8GF3fERqv4Qts
         IbuQ==
X-Received: by 10.68.93.227 with SMTP id cx3mr12202172pbb.146.1375524040082;
        Sat, 03 Aug 2013 03:00:40 -0700 (PDT)
Received: from lanh ([115.73.207.46])
        by mx.google.com with ESMTPSA id fk4sm13660747pab.23.2013.08.03.03.00.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 03:00:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 03 Aug 2013 17:01:13 +0700
Content-Disposition: inline
In-Reply-To: <51FCD20E.8070406@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231573>

On Sat, Aug 03, 2013 at 11:49:02AM +0200, Johannes Sixt wrote:
> Am 03.08.2013 08:21, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
> >  I changed mingw.h to add a stub uname() because I don't think MinG=
W
> >  port has that function, but that's totally untested.
>=20
> Thanks, but we don't have kill(pid, 0), either :-(

Yeah, I should have checked. Will this work?

-- 8< --
diff --git a/compat/mingw.c b/compat/mingw.c
index bb92c43..14d92df 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1086,6 +1086,12 @@ int mingw_kill(pid_t pid, int sig)
 		errno =3D err_win_to_posix(GetLastError());
 		CloseHandle(h);
 		return -1;
+	} else if (pid > 0 && sig =3D=3D 0) {
+		HANDLE h =3D OpenProcess(PROCESS_TERMINATE, FALSE, pid);
+		if (h) {
+			CloseHandle(h);
+			return 0;
+		}
 	}
=20
 	errno =3D EINVAL;
-- 8< --
