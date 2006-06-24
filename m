From: Junio C Hamano <junkio@cox.net>
Subject: On boolean configuration variables...
Date: Sat, 24 Jun 2006 05:28:02 -0700
Message-ID: <7vy7vmviul.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 24 14:28:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu7FN-0002IG-KA
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 14:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050AbWFXM2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 08:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933085AbWFXM2E
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 08:28:04 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31410 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S933050AbWFXM2D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 08:28:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624122803.CLQW12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 08:28:03 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22511>

Boolean configuration variables in $GIT_DIR/config are a bit
strange.

	[bool]
        	var1
                var2 =
                var3 = true
                var4 = yes
                var5 = 1
                var6 = 2
                var7 = false
                var8 = no
                var9 = 0

var1, var3, var5, and var6 are "true"; var2, var7 and var9 are
"false".  var4 and var8 are syntax errors.

Currently "git repo-config --bool --get bool.var1" returns
"false", which is fixed by the attached patch, but I am
wondering if it is a good idea to allow "yes" and "no" as well.

-- >8 --
[PATCH] repo-config: fix printing of bool

When a bool variable appears without any value, it means true.
However, replacing the NULL value with an empty string, an earlier
commit f067a13745fbeae1aa357876348a00e5edd0a629 broke show-config.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 repo-config.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/repo-config.c b/repo-config.c
index ab8f1af..743f02b 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -29,16 +29,13 @@ static int show_config(const char* key_,
 	const char *vptr = value;
 	int dup_error = 0;
 
-	if (value_ == NULL)
-		value_ = "";
-
 	if (!use_key_regexp && strcmp(key_, key))
 		return 0;
 	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
 		return 0;
 	if (regexp != NULL &&
 			 (do_not_match ^
-			  regexec(regexp, value_, 0, NULL, 0)))
+			  regexec(regexp, (value_?value_:""), 0, NULL, 0)))
 		return 0;
 
 	if (show_keys)
@@ -46,11 +43,11 @@ static int show_config(const char* key_,
 	if (seen && !do_all)
 		dup_error = 1;
 	if (type == T_INT)
-		sprintf(value, "%d", git_config_int(key_, value_));
+		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
 	else if (type == T_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
 	else
-		vptr = value_;
+		vptr = value_?value_:"";
 	seen++;
 	if (dup_error) {
 		error("More than one value for the key %s: %s",
-- 
1.4.1.rc1.ga77b7
