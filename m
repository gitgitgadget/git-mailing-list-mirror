From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v3 4/8] Case insensitivity support for .gitignore via core.ignorecase
Date: Sun,  3 Oct 2010 09:56:42 +0000
Message-ID: <1286099806-25774-5-git-send-email-avarab@gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 11:58:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2LKd-0005Kx-RR
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 11:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab0JCJ53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 05:57:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45079 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab0JCJ50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 05:57:26 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so4121914wyb.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xLzeJOE0RwlMRrAzPTozNwQLr93Luqt2WnXVWqLWqyU=;
        b=nMgooAWxhKMPgAMNLxSuJIZINDgUgAL2dPdUpAQY38pEY1gRmggbNsl8FcNDmIbtY2
         hxE3PWcoEkSbWg/2NwcQbS0+cCWf7cRdPPQtTRIe7q4EoPw//691RycsnrrtwZhNzzcc
         vCtE4pNHEOAonXSqbVMg6msXMlMCu2p32h5Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bd9ZihdlavOhVt7KvLlFILZmF908mrYhw32cktt3b2KEJETnvNjp5Da6ljYUUcPtq2
         9744aeH5oTAK7Gza7Y7J5hP6iw6aPMeLgn03PdL0a9fY3oR+UhkiOpq2Vdpa2K7EuUUK
         xKErDrCyUvyYe76tBA/3pTkQSUsDxqiLVaak8=
Received: by 10.227.147.6 with SMTP id j6mr5107956wbv.57.1286099846137;
        Sun, 03 Oct 2010 02:57:26 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id h29sm2968435wbc.9.2010.10.03.02.57.24
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 02:57:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <4CA847D5.4000903@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157853>

From: Joshua Jensen <jjensen@workspacewhiz.com>

This is especially beneficial when using Windows and Perforce and the
git-p4 bridge. Internally, Perforce preserves a given file's full path
including its case at the time it was added to the Perforce repository.
When syncing a file down via Perforce, missing directories are created,
if necessary, using the case as stored with the filename. Unfortunately,
two files in the same directory can have differing cases for their
respective paths, such as /diRa/file1.c and /DirA/file2.c. Depending on
sync order, DirA/ may get created instead of diRa/.

It is possible to handle directory names in a case insensitive manner
without this patch, but it is highly inconvenient, requiring each
character to be specified like so: [Bb][Uu][Ii][Ll][Dd]. With this patch, the
gitignore exclusions honor the core.ignorecase=true configuration
setting and make the process less error prone. The above is specified
like so: Build

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 3432d58..02c2a82 100644
--- a/dir.c
+++ b/dir.c
@@ -390,14 +390,14 @@ int excluded_from_list(const char *pathname,
 			if (x->flags & EXC_FLAG_NODIR) {
 				/* match basename */
 				if (x->flags & EXC_FLAG_NOWILDCARD) {
-					if (!strcmp(exclude, basename))
+					if (!strcmp_icase(exclude, basename))
 						return to_exclude;
 				} else if (x->flags & EXC_FLAG_ENDSWITH) {
 					if (x->patternlen - 1 <= pathlen &&
-					    !strcmp(exclude + 1, pathname + pathlen - x->patternlen + 1))
+					    !strcmp_icase(exclude + 1, pathname + pathlen - x->patternlen + 1))
 						return to_exclude;
 				} else {
-					if (fnmatch(exclude, basename, 0) == 0)
+					if (fnmatch_icase(exclude, basename, 0) == 0)
 						return to_exclude;
 				}
 			}
@@ -412,14 +412,14 @@ int excluded_from_list(const char *pathname,
 
 				if (pathlen < baselen ||
 				    (baselen && pathname[baselen-1] != '/') ||
-				    strncmp(pathname, x->base, baselen))
+				    strncmp_icase(pathname, x->base, baselen))
 				    continue;
 
 				if (x->flags & EXC_FLAG_NOWILDCARD) {
-					if (!strcmp(exclude, pathname + baselen))
+					if (!strcmp_icase(exclude, pathname + baselen))
 						return to_exclude;
 				} else {
-					if (fnmatch(exclude, pathname+baselen,
+					if (fnmatch_icase(exclude, pathname+baselen,
 						    FNM_PATHNAME) == 0)
 					    return to_exclude;
 				}
-- 
1.7.3.159.g610493
