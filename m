From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] pathspec: add tree_recursive_diff parameter
Date: Mon, 20 Sep 2010 09:29:57 +1000
Message-ID: <1284939000-16907-3-git-send-email-pclouds@gmail.com>
References: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 01:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTLC-0001WE-7Z
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab0ISXaY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:30:24 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56730 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab0ISXaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:30:22 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1009603pzk.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=VqtzzWi7kVYGc7S/Q0N6mEZvXwtjop+nh5cinYHOQOk=;
        b=ZNeuA96z+zkBmaKR1IYLeVVLPNcKXJJbiaHiC9LrEKmKTkdwurs90X/fqMB8a+TU91
         X0u1hAppuKIH6dYy+z/YTlMzIWKpiWTs/imlXn2cUHGd21U9RyKjsAFzJrpALhqfCH0x
         sM/6GzIRIKJDSe4U+FGZh5PVwWw82i1mT2mv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dNJdBjIDv3ctzwdqw++Br0ayAPi5YApsMmEN56YQWKoxeEsvqiNoipT628whe++U4s
         YsFzgnpu+LIyMcYoFYpOGwA0z/3RVDAFyjiIajIucz2e7Od6pI5XngjUxIhBCI13nEvw
         RQfHQ2PpjIjfkW9Qnj0P9TkMr++igtiPcACF0=
Received: by 10.142.117.21 with SMTP id p21mr134303wfc.86.1284939022105;
        Sun, 19 Sep 2010 16:30:22 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id v3sm6708655wfv.11.2010.09.19.16.30.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:30:21 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:30:16 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156535>

When wildcard match is implemented, a full path is needed to do final
match. What type of diff_tree is performed determines how to treat
directories:

 - If it's recursive diff, directories are just an intermediate step.
   All path must end with a file name. Thus, directories will be
   unconditionally matched.

 - If it's non-recursive, directories are treated like files and is
   matched against pathspect as full path.

Strictly speaking, this should be a new parameter to
tree_entry_interesting(). But I don't feel like chaning
tree_entry_interesting() too often.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |    1 +
 tree-diff.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 7a3e0a0..dc54d16 100644
--- a/cache.h
+++ b/cache.h
@@ -496,6 +496,7 @@ struct pathspec {
 	const char **raw;
 	int nr;
 	int has_wildcard:1;
+	int tree_recursive_diff:1;
 	struct pathspec_item {
 		int len;
 		int has_wildcard:1;
diff --git a/tree-diff.c b/tree-diff.c
index 50d7e6d..7e58f54 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -170,6 +170,7 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2, const char *base, stru
 {
 	int baselen =3D strlen(base);
=20
+	opt->pathspec.tree_recursive_diff =3D DIFF_OPT_TST(opt, RECURSIVE);
 	for (;;) {
 		if (DIFF_OPT_TST(opt, QUICK) &&
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
--=20
1.7.1.rc1.70.g788ca
