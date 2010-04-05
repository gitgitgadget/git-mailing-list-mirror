From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/43] rev-parse --git-dir: print relative gitdir correctly
Date: Mon,  5 Apr 2010 20:41:09 +0200
Message-ID: <1270492888-26589-25-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH6-0000ps-3w
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab0DESnA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:00 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab0DESmw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:52 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8eTAL9ZbtYbsrO0oBuSWHo4R8s4nGwqQuhndK/zeBvc=;
        b=vHvSxuY0ZObE47uADCt/Grh8sr93zccgRVH8VVTQ5McbfJKaV+DBq7Syt3Mtfh5TMO
         Ii6FrSIYEL9+qOK1tOOh4XpFAJz6IQG6RL3Z3hOmB8WvHg98jZzZj1+11U6YNqtQmkVY
         UFM9pjJATZZABb9HbXdhhIsO1L0v6RRkp0U04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RFZjgMQCxoZsS/8azXiQtgnpKupsEFSwYmrgQm3hzNvANqy0M4ZEaXGXpFPtC8ry+L
         pPmQh5PfNXSIc1/GrUjDwZzQ4BLokw2LLwcIPZg7CdFSU31OZDBjnF3JFsQ3Rtpxubk0
         8mXDIO6H0JoYuzNvX2R0DZh905BFK3nFEFFBo=
Received: by 10.223.99.78 with SMTP id t14mr5927956fan.85.1270492971799;
        Mon, 05 Apr 2010 11:42:51 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id b17sm611907fka.13.2010.04.05.11.42.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:50 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:48 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144028>

When git_dir is relative, it is relative to Git's current working
directory, which is worktree top directory. "git rev-parse --git-dir"
is expected to output relative to user's current working directory.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rev-parse.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8fbf9d0..8819e8a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -646,6 +646,14 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 				static char cwd[PATH_MAX];
 				int len;
 				if (gitdir) {
+					if (prefix && !is_absolute_path(gitdir)) {
+						int len;
+						if (!getcwd(cwd, PATH_MAX))
+							die_errno("unable to get current working directory");
+						len =3D strlen(cwd);
+						printf("%s%s%s\n", cwd, len && cwd[len-1] !=3D '/' ? "/" : "", g=
itdir);
+						continue;
+					}
 					puts(gitdir);
 					continue;
 				}
--=20
1.7.0.rc1.541.g2da82.dirty
