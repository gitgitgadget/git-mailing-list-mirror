From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 14:17:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605081416140.29236@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <Pine.LNX.4.64.0605071718440.3718@g5.osdl.org>
 <Pine.LNX.4.63.0605080303410.13588@wbgn013.biozentrum.uni-wuerzburg.de>
 <1147051300.17371.32.camel@dv> <Pine.LNX.4.63.0605080327490.13794@wbgn013.biozentrum.uni-wuerzburg.de>
 <1147053329.17371.52.camel@dv> <7vody8howu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 14:17:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd4gB-0007dN-89
	for gcvg-git@gmane.org; Mon, 08 May 2006 14:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWEHMRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 08:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWEHMRV
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 08:17:21 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47020 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932084AbWEHMRV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 08:17:21 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id C3D532295;
	Mon,  8 May 2006 14:17:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id B7D032256;
	Mon,  8 May 2006 14:17:19 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 95BE3B8F;
	Mon,  8 May 2006 14:17:19 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vody8howu.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19764>

Hi,

On Mon, 8 May 2006, Junio C Hamano wrote:

> 	repo-config --get branchdata.description '\(.*\) for netdev$'

POSIX regexps do not want the backslashes...

Something like this?

---
[PATCH] repo-config: allow one group in value regexp

The regular expression for the value can now contain one group. In case
there is one, the output will be just that group, not the whole value.
Now you can say

        git-repo-config --get branch.defaultremote '(.*) for junio'

and for a config like this:

        [branch]
                defaultRemote = sushi for junio

the output will be "sushi".

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 repo-config.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/repo-config.c b/repo-config.c
index 63eda1b..9ac4c51 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -26,31 +26,41 @@ static int show_all_config(const char *k
 static int show_config(const char* key_, const char* value_)
 {
 	char value[256];
-	const char *vptr = value;
+	const char *vptr = value_;
 	int dup_error = 0;
 
 	if (value_ == NULL)
-		value_ = "";
+		vptr = value_ = "";
 
 	if (!use_key_regexp && strcmp(key_, key))
 		return 0;
 	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
 		return 0;
-	if (regexp != NULL &&
-			 (do_not_match ^
-			  regexec(regexp, value_, 0, NULL, 0)))
-		return 0;
+	if (regexp != NULL) {
+		regmatch_t matches[2];
+		int len;
+
+		if (do_not_match ^ regexec(regexp, value_, 2, matches, 0))
+			return 0;
+		len = matches[1].rm_eo - matches[1].rm_so;
+		if (!do_not_match && len > 0) {
+			if (len > 255)
+				len = 255;
+			strncpy(value, value_ + matches[1].rm_so, len);
+			value[len] = 0;
+			vptr = value;
+		}
+	}
 
 	if (show_keys)
 		printf("%s ", key_);
 	if (seen && !do_all)
 		dup_error = 1;
-	if (type == T_INT)
+	if (type == T_INT) {
 		sprintf(value, "%d", git_config_int(key_, value_));
-	else if (type == T_BOOL)
+		vptr = value;
+	} else if (type == T_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
-	else
-		vptr = value_;
 	seen++;
 	if (dup_error) {
 		error("More than one value for the key %s: %s",
-- 
1.3.1.g297e8-dirty
