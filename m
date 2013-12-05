From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 04/28] clone: prevent --reference to a shallow repository
Date: Thu,  5 Dec 2013 20:02:31 +0700
Message-ID: <1386248575-10206-5-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYVx-0001Ra-7I
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab3LEM6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:58:41 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56548 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126Ab3LEM6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:58:40 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so25978098pbc.33
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W673SwEG7acKm27+y6zZGuz006nZ2n0gS9toiL0vkVQ=;
        b=rCxsOjD0GrxAlD5gWDUm3+5IPbqzPrFA9Pd+eercB3e2phP7Aaw++S8HpsG29uSnPZ
         l02lO21NRqyjG/0CW79aZQ4zMcdqKpVN0nK5sz8P6oZdBT7PKRrcUEGxz0t0eIZPGZ8t
         2RaPUBU8f6tdmHJdLssEoASY9ihrzJdNOPhrNuDGAdmsl7bw+F0G7rbVDIy5pl5zpg3t
         cNOUeUDXW2/3e9Z97hYzybySiKSIRdUZHaYHTtSlGVMC96f6O21GvS2fP538+ooJIblk
         IuJLFGnheDy3EO8VOy1R6Yjvb2/ih50FDl3lVedkomM0bvnBoZOBsVaHtUvJZSkEbjF2
         +wAg==
X-Received: by 10.66.178.143 with SMTP id cy15mr89463467pac.105.1386248320443;
        Thu, 05 Dec 2013 04:58:40 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id ha10sm144607540pbd.17.2013.12.05.04.58.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:58:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:03:24 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238860>

If we borrow objects from another repository, we should also pay
attention to their $GIT_DIR/shallow (and even info/grafts). But
current alternates code does not.

Reject alternate repos that are shallow because we do not do it
right. In future the alternate code may be updated to check
$GIT_DIR/shallow properly so that this restriction could be lifted.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 874e0fd..900f564 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -252,6 +252,12 @@ static int add_one_reference(struct string_list_it=
em *item, void *cb_data)
 		die(_("reference repository '%s' is not a local repository."),
 		    item->string);
=20
+	if (!access(mkpath("%s/shallow", ref_git), F_OK))
+		die(_("reference repository '%s' is shallow"), item->string);
+
+	if (!access(mkpath("%s/info/grafts", ref_git), F_OK))
+		die(_("reference repository '%s' is grafted"), item->string);
+
 	strbuf_addf(&alternate, "%s/objects", ref_git);
 	add_to_alternates_file(alternate.buf);
 	strbuf_release(&alternate);
--=20
1.8.5.1.25.g8667982
