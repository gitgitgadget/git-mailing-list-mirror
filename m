From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] config_set_multivar(): disallow newlines in keys
Date: Sat, 20 Jan 2007 02:25:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200224180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com> <200701191310.32417.jnareb@gmail.com>
 <Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701192344.11972.jnareb@gmail.com> <7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 02:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84zF-0002wF-Re
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbXATBZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbXATBZj
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:25:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:40483 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965108AbXATBZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:25:38 -0500
Received: (qmail invoked by alias); 20 Jan 2007 01:25:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 20 Jan 2007 02:25:37 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37243>


This will no longer work:

$ git repo-config 'key.with
newline' some-value

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
	On Fri, 19 Jan 2007, Junio C Hamano wrote:
	
	> I think the current repo-config handles sane cases alright, but
	> it is still fragile in error cases.  For example:
	> 
	> 	$ git repo-config 'foo.bar=bzz
	>           baz.boo' foobar
	> 
	> does not currently barf, but results in a corrupted config file.

	Now it barfs.

 config.c               |    5 +++++
 t/t1300-repo-config.sh |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index b6082f5..c08c668 100644
--- a/config.c
+++ b/config.c
@@ -661,6 +661,11 @@ int git_config_set_multivar(const char* key, const char* value,
 				goto out_free;
 			}
 			c = tolower(c);
+		} else if (c == '\n') {
+			fprintf(stderr, "invalid key (newline): %s\n", key);
+			free(store.key);
+			ret = 1;
+			goto out_free;
 		}
 		store.key[i] = c;
 	}
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 60acdd3..eb7455b 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -418,5 +418,11 @@ EOF
 
 test_expect_success 'quoting' 'cmp .git/config expect'
 
+test_expect_failure 'key with newline' 'git repo-config key.with\\\
+newline 123'
+
+test_expect_success 'value with newline' 'git repo-config key.sub value.with\\\
+newline'
+
 test_done
 
-- 
1.5.0.rc1.g5a400-dirty
