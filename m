From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 36/47] rev-parse: prints --git-dir relative to user's cwd
Date: Fri, 26 Nov 2010 22:32:32 +0700
Message-ID: <1290785563-15339-37-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:47:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0WW-0008AL-24
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab0KZPri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:47:38 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:62216 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab0KZPri (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:47:38 -0500
Received: by pzk26 with SMTP id 26so457989pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=kqVhjpbgXoGN1KtcmnURkOHssD1ioCh3RS1y9s8eKUY=;
        b=DTwfPgd0qovjjsJeiCx7NPinMk6set3JhR6bMDnqxuBZklbT3qDmRBRxXnn2rDYg5b
         N2AHiJsT6eSymFPK7oXK/vN7o0E9OqktRx2oJ/upMdzOIaOLTc/WFXLVEtPcI1at8Uxg
         NIXUwuf9p4gJPLp1GYdsGrjt5V4TbynSQkbGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=j4UNN6O5SIhKtiQSZjlTtdJ4qc9jnKWFABtLcrBmlWkmgEShAslNBQE+9YXlRjXoj5
         HAaO7pTb8Np6WIpdGJnfPzS7cu7jAtGjzQXvm9gXFrFvv6Eq0JWeYywZS8ZggfXoNsS7
         nVkYYoPd+kg8VKBeVj8SZOgsz5WZkHq7z8LzI=
Received: by 10.142.179.5 with SMTP id b5mr2531491wff.225.1290786457674;
        Fri, 26 Nov 2010 07:47:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id b11sm2684629wff.21.2010.11.26.07.47.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:47:36 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:46:25 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162249>

git_dir variable in environment.c is relative to git's cwd, not user's
cwd. Convert the relative path (actualy by making it absolute path)
before printing out.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.3.2.316.gda8b3
