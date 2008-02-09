From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: [PATCH] remote.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 18:38:19 -0600
Message-ID: <5d46db230802081638u415871e4i6fc67a98d5ccf0b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNdk6-0008Pf-Ab
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 01:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785AbYBIAiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 19:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755852AbYBIAiV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 19:38:21 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:63180 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785AbYBIAiU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 19:38:20 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3846313wra.23
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 16:38:19 -0800 (PST)
Received: by 10.151.11.17 with SMTP id o17mr5583583ybi.120.1202517499449;
        Fri, 08 Feb 2008 16:38:19 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Fri, 8 Feb 2008 16:38:19 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 2d0b0276ab9c53ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73177>

Note:Moved multiple checks for null to one place at the top of the function.
Comment in this section conflicted with Junio's request to remove this
behavior.

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 remote.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/remote.c b/remote.c
index 0e00680..27cdaa7 100644
--- a/remote.c
+++ b/remote.c
@@ -217,13 +217,13 @@ static int handle_config(const char *key, const
char *value)
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
+	if (!value)
+		return 0;
 	if (!prefixcmp(key, "branch.")) {
 		name = key + 7;
 		subkey = strrchr(name, '.');
 		if (!subkey)
 			return 0;
-		if (!value)
-			return 0;
 		branch = make_branch(name, subkey - name);
 		if (!strcmp(subkey, ".remote")) {
 			branch->remote_name = xstrdup(value);
@@ -244,21 +244,6 @@ static int handle_config(const char *key, const
char *value)
 		return 0;
 	}
 	remote = make_remote(name, subkey - name);
-	if (!value) {
-		/* if we ever have a boolean variable, e.g. "remote.*.disabled"
-		 * [remote "frotz"]
-		 *      disabled
-		 * is a valid way to set it to true; we get NULL in value so
-		 * we need to handle it here.
-		 *
-		 * if (!strcmp(subkey, ".disabled")) {
-		 *      val = git_config_bool(key, value);
-		 *      return 0;
-		 * } else
-		 *
-		 */
-		return 0; /* ignore unknown booleans */
-	}
 	if (!strcmp(subkey, ".url")) {
 		add_url(remote, xstrdup(value));
 	} else if (!strcmp(subkey, ".push")) {
-- 
1.5.4.36.g9af61
