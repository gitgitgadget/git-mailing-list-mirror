From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] hold_index_file_for_update should not unlink failed to open .lock files atexit
Date: Wed, 5 Oct 2005 16:58:11 +0200
Message-ID: <81b0412b0510050758v26b88f4o5f15e3ff01e9cd87@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13398_22211458.1128524291463"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Oct 05 17:00:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENAit-0007Z1-FJ
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 16:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbVJEO6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 10:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVJEO6O
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 10:58:14 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:7447 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965193AbVJEO6N (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 10:58:13 -0400
Received: by nproxy.gmail.com with SMTP id n15so76443nfc
        for <git@vger.kernel.org>; Wed, 05 Oct 2005 07:58:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=WdhQTJAEGjMEJ68ulVB2GD29wmeK04yybZMC+O4Gfoy9/MVPDS/7ZfikDsZEwpUDy43xQRZ8bVZUOD3jtiWpq+0jHw0v5pS324wFURi0L9c7NKB9jZe/0MWzB0JrUzmAVuM02ZGaXneBSrBlrcWrfUxqK5Q4zdx/WoqvfqJNVvc=
Received: by 10.48.108.1 with SMTP id g1mr51282nfc;
        Wed, 05 Oct 2005 07:58:11 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Wed, 5 Oct 2005 07:58:11 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9710>

------=_Part_13398_22211458.1128524291463
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I noticed that index.lock is one time removed by git-update-index
and the other time not (I am still trying to make the rename behave on
my cygwin installation). The atexit callback removes .lock file uncoditiona=
lly,
whether it was opened by the current process or not.

I fixed this with the attached (sorry, it's windows+firefox+gmail) patch.

The patch sets up atexit only if the file was opened successfully.

------=_Part_13398_22211458.1128524291463
Content-Type: application/xxxxx; name=hold_index_file_for_update.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hold_index_file_for_update.patch"


Set up atexit only if the .lock-file was opened successfully.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

diff --git a/index.c b/index.c
--- a/index.c
+++ b/index.c
@@ -22,14 +22,16 @@ static void remove_lock_file_on_signal(i
 
 int hold_index_file_for_update(struct cache_file *cf, const char *path)
 {
+	int fd;
 	sprintf(cf->lockfile, "%s.lock", path);
-	cf->next = cache_file_list;
-	cache_file_list = cf;
-	if (!cf->next) {
+	fd = open(cf->lockfile, O_RDWR | O_CREAT | O_EXCL, 0666);
+	if (fd >=0 && !cf->next) {
+		cf->next = cache_file_list;
+		cache_file_list = cf;
 		signal(SIGINT, remove_lock_file_on_signal);
 		atexit(remove_lock_file);
 	}
-	return open(cf->lockfile, O_RDWR | O_CREAT | O_EXCL, 0666);
+	return fd;
 }
 
 int commit_index_file(struct cache_file *cf)

------=_Part_13398_22211458.1128524291463--
