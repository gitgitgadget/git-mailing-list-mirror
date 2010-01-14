From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] Improve Git performance on big trees
Date: Thu, 14 Jan 2010 22:02:19 +0700
Message-ID: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 16:10:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVRLN-0002a7-H0
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 16:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757160Ab0ANPJn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 10:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757156Ab0ANPJl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 10:09:41 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:51577 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757151Ab0ANPJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 10:09:38 -0500
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2010 10:09:38 EST
Received: by pxi12 with SMTP id 12so124357pxi.33
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=/3V928S82+uZgI/ry1aXEZ0D6R4XWw00UzNBD92gQ4I=;
        b=RTQltNZvYqIALKygU4Wst4sh+ANeNI+wZquoxRA6jjV4p5WV01BBiV4eKsQJIGGI1w
         N11lzMfDN0Mb7m5h36nZ95qlGTBuIhyQTHaTh5chyzveHnN89bAbTsK+or/jC+fXpdRy
         CP+0OwfnNDStXpkX3p+4vYKbctQjWkiHpTWNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=w3ZbModKgYNc2klfQxXmboSaPyWHQBZwCNi6HoF46M/BAFM8qofZwTUBWx25pg17uQ
         HhXJ10C1j4TJF9fGbHe1FFkDqyh4BiAFTEvxfQTs+OQfS3PfvdQ562qm2naEkTaBzyHo
         Rfql/XV0XsADA6NxJhrzBD8qOR3CABSoxzlRI=
Received: by 10.114.30.1 with SMTP id d1mr632722wad.75.1263481390856;
        Thu, 14 Jan 2010 07:03:10 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.107])
        by mx.google.com with ESMTPS id 21sm635749pzk.11.2010.01.14.07.03.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 07:03:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 14 Jan 2010 22:02:23 +0700
X-Mailer: git-send-email 1.6.6.181.g5ee6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137000>

The discussion about using Git on Gentoo comes up again [1] and it
looks like we can improve Git a bit if user only works on some
subdirectories. In such cases, Git still does whole-tree check, which
takes quite some time. "git status" takes 3 seconds on my machine, but
I suspect lstat() is not the only culprit, "git diff --exit-code" is
about 1 sec.

These patches makes "git rm <path>" and "git status <path>" a bit
faster. Almost 1 sec for "git rm foo" still seems too long though,
probably due to writing a 9MB index.

[1] http://article.gmane.org/gmane.linux.gentoo.devel/64522

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  rm: only refresh entries that we may touch
  status: only touch path we may need to check

 builtin-commit.c |    2 +-
 builtin-rm.c     |    2 +-
 wt-status.c      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
