From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 2/2] trailer: add examples to the documentation
Date: Sun, 27 Apr 2014 22:12:37 +0200
Message-ID: <20140427201238.16880.7144.chriscool@tuxfamily.org>
References: <20140427200327.16880.53255.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:13:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeVS8-0006SR-Hb
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 22:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbaD0UN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 16:13:29 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:64714 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbaD0UN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 16:13:28 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 9FE754B;
	Sun, 27 Apr 2014 22:13:21 +0200 (CEST)
X-git-sha1: 79fc6d4e25b3c886488853fc2dc9f3afb0a22c51 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140427200327.16880.53255.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247226>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-interpret-trailers.txt | 98 +++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 450ec54..42c2f71 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -134,9 +134,105 @@ If the command contains the `$ARG` string, this string will be
 replaced with the <value> part of an existing trailer with the same
 <token>, if any, before the command is launched.
 
+EXAMPLES
+--------
+
+* Configure a 'sign' trailer with a 'Signed-off-by: ' key, and then
+  add two of these trailers to a message:
++
+------------
+$ git config trailer.sign.key "Signed-off-by: "
+$ cat msg.txt
+subject
+
+message
+$ cat msg.txt | git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>'
+subject
+
+message
+
+Signed-off-by: Alice <alice@example.com>
+Signed-off-by: Bob <bob@example.com>
+------------
+
+* Extract the last commit as a patch, and add a 'Cc' and a
+  'Reviewed-by' trailer to it:
++
+------------
+$ git format-patch -1
+0001-foo.patch
+$ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-bar.patch
+------------
+
+* Configure a 'sign' trailer with a command to automatically add a
+  'Signed-off-by: ' with the author information only if there is no
+  'Signed-off-by: ' already, and show how it works:
++
+------------
+$ git config trailer.sign.key "Signed-off-by: "
+$ git config trailer.sign.ifmissing add
+$ git config trailer.sign.ifexists doNothing
+$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
+$ git interpret-trailers <<EOF
+> EOF
+
+Signed-off-by: Bob <bob@example.com>
+$ git interpret-trailers <<EOF
+> Signed-off-by: Alice <alice@example.com>
+> EOF
+
+Signed-off-by: Alice <alice@example.com>
+------------
+
+* Configure a 'fix' trailer with a command to show the subject of a
+  commit that is fixed, and show how it works:
++
+------------
+$ git config trailer.fix.key "Fixes #"
+$ git config trailer.fix.ifExists "overwrite"
+$ git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
+$ git interpret-trailers <<EOF
+> subject
+> 
+> message
+> 
+> fix: HEAD~2
+> EOF
+subject
+
+message
+
+Fixes #fe3187489d69c4 (subject of fixed commit)
+------------
+
+* Configure a commit template with some trailers with empty values,
+  then configure a commit-msg hook that uses git interpret-trailers to
+  remove trailers with empty values and to add a 'git-version'
+  trailer:
++
+------------
+$ cat >commit_template.txt <<EOF
+> ***subject***
+> 
+> ***message***
+> 
+> Fixes: 
+> Cc: 
+> Reviewed-by: 
+> Signed-off-by: 
+> EOF
+$ git config commit.template commit_template.txt
+$ cat >.git/hooks/commit-msg <<EOF
+#!/bin/sh
+git interpret-trailers --trim-empty --trailer "git-version: \$(git describe)" "\$1" > "\$1.new"
+mv "\$1.new" "\$1"
+EOF
+$ chmod +x .git/hooks/commit-msg
+------------
+
 SEE ALSO
 --------
-linkgit:git-commit[1]
+linkgit:git-commit[1], linkgit:git-format-patch[1], linkgit:git-config[1]
 
 GIT
 ---
-- 
1.9.rc0.17.g651113e
