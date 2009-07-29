From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] grep: skip files outside sparse checkout area
Date: Wed, 29 Jul 2009 16:49:11 +1000
Message-ID: <1248850154-5469-3-git-send-email-pclouds@gmail.com>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
 <1248850154-5469-2-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 08:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW2yx-0003qW-Q5
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 08:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbZG2Gtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 02:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZG2Gtd
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 02:49:33 -0400
Received: from mail-px0-f184.google.com ([209.85.216.184]:40415 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbZG2Gtc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 02:49:32 -0400
Received: by mail-px0-f184.google.com with SMTP id 14so404542pxi.33
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 23:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=qANEfJoklJptNaIZt5OGpTD2iS0rloeCY5ONRt1Kqew=;
        b=l3sWGmxUqwQIXHywnlSyDUSEKVjJIggM/JWxRF8mWkMJhPonIpMl3ku6n2Mdz3QuMw
         bADUETmgnqi0ws8cu0WS9X6e1x7zx8dr+XnzmgbEZsnEPcE3bKmtV7PKx8jjuHAIKX8f
         qUbu4n3yXzoq1gpKaoNZVzyzRzV9E38SIs6bo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AADxRNOuJXz/LgEmPiE2ip60dqak21OdMsT0kFni9cRDSPj8/jB70AKE9feir72TbA
         m2S8LqV6pU0HGKizeN0Ty0LGNRvkZWl5mb+9/3cux7ZXGO8Onrak3dlpVZeT2wkgpiXg
         +4xXh4mXNSqhYULfETSI+pn49XUIhoUoVYfq8=
Received: by 10.114.103.15 with SMTP id a15mr13427687wac.184.1248850173391;
        Tue, 28 Jul 2009 23:49:33 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id m30sm856869wag.34.2009.07.28.23.49.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 23:49:32 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 29 Jul 2009 16:49:27 +1000
X-Mailer: git-send-email 1.6.3.2.448.gdf8b6
In-Reply-To: <1248850154-5469-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124311>

---
 Documentation/git-grep.txt |    4 +++-
 builtin-grep.c             |    7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 8c70020..8d9cba7 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -27,7 +27,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Look for specified patterns in the working tree files, blobs
-registered in the index file, or given tree objects.
+registered in the index file, or given tree objects. By default
+it will search in the working tree files. When in sparse checkout
+mode, it only searches checked-out files.
 
 
 OPTIONS
diff --git a/builtin-grep.c b/builtin-grep.c
index ad0e0a5..55078cb 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -455,6 +455,8 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 			continue;
 		if (!pathspec_matches(paths, ce->name, opt->max_depth))
 			continue;
+		if (ce->ce_flags & CE_VALID)
+			continue;
 		name = ce->name;
 		if (name[0] == '-') {
 			int len = ce_namelen(ce);
@@ -522,8 +524,11 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached,
 				continue;
 			hit |= grep_sha1(opt, ce->sha1, ce->name, 0);
 		}
-		else
+		else {
+			if (ce->ce_flags & CE_VALID)
+				continue;
 			hit |= grep_file(opt, ce->name);
+		}
 		if (ce_stage(ce)) {
 			do {
 				nr++;
-- 
1.6.3.2.448.gdf8b6
