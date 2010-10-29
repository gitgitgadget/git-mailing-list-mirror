From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 35/42] rev-parse: prints --git-dir relative to user's cwd
Date: Fri, 29 Oct 2010 13:48:47 +0700
Message-ID: <1288334934-17216-36-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:53:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiqV-0007Wc-FZ
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933469Ab0J2Gxn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:53:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab0J2Gxl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:53:41 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hYo5Gftig/iiq9l+0qPqZGhK1/MjjnfFeKa1fHDf3CM=;
        b=DmGglo76BbbjPRHK2d+rr5Sndvcw1OALrYM+UqsgT1BarxbSJNVkiAcQgc8zLYiD1F
         Q82O906xUJJsBIzf/EcO/qNpKUflxJ7aEj3LlA+BjRaLMEAW0RmcJQZE27wtRVGXMWZz
         RJgQyoV5Fr9ArHryc3HgXuQWwyu5YfuR9dZXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eyBtqKBS03x3CqM1toLsTyhqKLggyDSQEoxc+YZuaEnDAf7f/yfQaZ5/it/ZlA0q8F
         KCXnocw2jros+CT6L549IUu2S3Ta2JC9JHcdYs8B2aHEViiMnCls+guWRfAyl8gwaMhr
         czAl0+fJJEtOm8fkcHWtrqOZ3ZQQK7egGXc0Y=
Received: by 10.142.202.3 with SMTP id z3mr1052982wff.275.1288335221307;
        Thu, 28 Oct 2010 23:53:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id y42sm1024745wfd.22.2010.10.28.23.53.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:53:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:53:40 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160303>

git-rev-parse.txt does not say much about this. But I'm sure
git-sh-setup.sh wants "git rev-parse --git-dir" be relative to user's
cwd.

git_dir variable in environment.c on the other hand is relative to
git's cwd, not user's cwd. Convert the relative path (actualy by making=
 it
absolute path) before printing out.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rev-parse.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..65c287b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -647,7 +647,11 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 				static char cwd[PATH_MAX];
 				int len;
 				if (gitdir) {
-					puts(gitdir);
+					if (is_absolute_path(gitdir) || !prefix) {
+						puts(gitdir);
+						continue;
+					}
+					puts(make_absolute_path(gitdir));
 					continue;
 				}
 				if (!prefix) {
--=20
1.7.0.2.445.gcbdb3
