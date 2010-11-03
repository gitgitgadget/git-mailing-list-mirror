From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv2 1/2] submodule: preserve all arguments exactly when recursing
Date: Tue,  2 Nov 2010 22:05:39 -0700
Message-ID: <1288760740-10075-1-git-send-email-kevin@sb.org>
References: <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 06:05:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDVXo-0001IH-ID
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714Ab0KCFFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 01:05:51 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49191 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab0KCFFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 01:05:50 -0400
Received: by pvb32 with SMTP id 32so75944pvb.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 22:05:49 -0700 (PDT)
Received: by 10.142.224.14 with SMTP id w14mr6795889wfg.206.1288760749721;
        Tue, 02 Nov 2010 22:05:49 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id q13sm12558580wfc.17.2010.11.02.22.05.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 22:05:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.200.g479de
In-Reply-To: <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160577>

When performing a recursive status or update, any argments with whitespace
would be split along that whitespace when passed to the recursive invocation
of the update or status command.

This is caused by the special handling that sh provides to the $@ variable.
Status and update stored "$@" into a separate variable, and passed that
variable to the recursive invocation. Unfortunately, the special handling
afforded to $@ isn't given to this new variable, and word-breaking occurs
along whitespace boundaries.

We can use $(git rev-parse --sq-quote "$@") to produce a string containing
a quoted version of all given args, suitable for passing to eval. We then
recurse using something like `eval cmd_status "$orig_args"` instead of the
former `cmd_status $orig_args`. This preserves all arguments exactly as
given to the initial invocation of the command.

Helped-By: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Kevin Ballard <kevin@sb.org>
---
This patch ditches the quote_words function and uses
`git rev-parse --sq-quote "$@"` instead, as suggested by Jonathan Nieder.
 git-submodule.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9ebbab7..543554b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -374,7 +374,7 @@ cmd_init()
 cmd_update()
 {
 	# parse $args after "submodule ... update".
-	orig_args="$@"
+	orig_args="$(git rev-parse --sq-quote "$@")"
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -500,7 +500,7 @@ cmd_update()
 
 		if test -n "$recursive"
 		then
-			(clear_local_git_env; cd "$path" && cmd_update $orig_args) ||
+			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_args") ||
 			die "Failed to recurse into submodule path '$path'"
 		fi
 	done
@@ -733,7 +733,7 @@ cmd_summary() {
 cmd_status()
 {
 	# parse $args after "submodule ... status".
-	orig_args="$@"
+	orig_args="$(git rev-parse --sq-quote "$@")"
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -790,7 +790,7 @@ cmd_status()
 				prefix="$displaypath/"
 				clear_local_git_env
 				cd "$path" &&
-				cmd_status $orig_args
+				eval cmd_status "$orig_args"
 			) ||
 			die "Failed to recurse into submodule path '$path'"
 		fi
-- 
1.7.3.2.200.g479de
