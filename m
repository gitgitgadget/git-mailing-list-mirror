From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v3 7/8] Support case folding for git add when core.ignorecase=true
Date: Sun,  3 Oct 2010 09:56:45 +0000
Message-ID: <1286099806-25774-8-git-send-email-avarab@gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 11:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2LKf-0005Kx-Gt
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 11:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab0JCJ5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 05:57:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45079 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab0JCJ5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 05:57:33 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so4121914wyb.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dUJ+lPwrwCni+oEE8d61amVj7aij9IgMkzek2VOZg34=;
        b=CPpwYcYdGjcJnra83Y/SnsiuYXIOfMr4NeS9qi44hg7U3YpkefsTJSII8CtNJ08KTc
         8nVvFQJkOX5oDpe795vdoYlEazdVxWfNqbBAhf0PDkOYVxNJGiJgraOUKItGozH6Z6qO
         QQHnc8k/Vq/3+x/HRVrmo/COuh7n9bXojo5qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=o5ma1alyDRaAHyq/Lfu8p0BSeq3F3PUp4SIVqJFr92aoVNvusrRpsU1rQtOpi3Jo2F
         EXAL8WwKdMdTZStYhf4IyPYx0wJ47f6G9836rJ3zxBJPyyyAqbcYu0QrexVf2ex2QScB
         VXym3kfBL3h918rDvt14VupavsoNoUpLyh1EY=
Received: by 10.227.146.65 with SMTP id g1mr6807329wbv.55.1286099853178;
        Sun, 03 Oct 2010 02:57:33 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id h29sm2968435wbc.9.2010.10.03.02.57.31
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 02:57:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <4CA847D5.4000903@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157857>

From: Joshua Jensen <jjensen@workspacewhiz.com>

When MyDir/ABC/filea.txt is added to Git, the disk directory MyDir/ABC/
is renamed to mydir/aBc/, and then mydir/aBc/fileb.txt is added, the
index will contain MyDir/ABC/filea.txt and mydir/aBc/fileb.txt. Although
the earlier portions of this patch series account for those differences
in case, this patch makes the pathing consistent by folding the case of
newly added files against the first file added with that path.

In read-cache.c's add_to_index(), the index_name_exists() support used
for git status's case insensitive directory lookups is used to find the
proper directory case according to what the user already checked in.
That is, MyDir/ABC/'s case is used to alter the stored path for
fileb.txt to MyDir/ABC/fileb.txt (instead of mydir/aBc/fileb.txt).

This is especially important when cloning a repository to a case
sensitive file system. MyDir/ABC/ and mydir/aBc/ exist in the same
directory on a Windows machine, but on Linux, the files exist in two
separate directories. The update to add_to_index(), in effect, treats a
Windows file system as case sensitive by making path case consistent.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1f42473..379862c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -608,6 +608,29 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		ce->ce_mode = ce_mode_from_stat(ent, st_mode);
 	}
 
+	/* When core.ignorecase=true, determine if a directory of the same name but differing
+	 * case already exists within the Git repository.  If it does, ensure the directory
+	 * case of the file being added to the repository matches (is folded into) the existing
+	 * entry's directory case.
+	 */
+	if (ignore_case) {
+		const char *startPtr = ce->name;
+		const char *ptr = startPtr;
+		while (*ptr) {
+			while (*ptr && *ptr != '/')
+				++ptr;
+			if (*ptr == '/') {
+				struct cache_entry *foundce;
+				++ptr;
+				foundce = index_name_exists(&the_index, ce->name, ptr - ce->name, ignore_case);
+				if (foundce) {
+					memcpy((void*)startPtr, foundce->name + (startPtr - ce->name), ptr - startPtr);
+					startPtr = ptr;
+				}
+			}
+		}
+	}
+
 	alias = index_name_exists(istate, ce->name, ce_namelen(ce), ignore_case);
 	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce_option)) {
 		/* Nothing changed, really */
-- 
1.7.3.159.g610493
