From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH/selftest] hash-object: don't rely on order of --stdin, -w
	arguments
Date: Wed, 13 Feb 2008 22:49:41 +0000
Message-ID: <20080213224941.18121.qmail@c0fdbb95c1b5f1.315fe32.mid.smarden.org>
References: <20080213190338.7393.qmail@d70c5cbe18d4bd.315fe32.mid.smarden.org> <7v7ih8pre6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 23:50:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPQQS-0005Sh-Hp
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 23:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbYBMWtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 17:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757431AbYBMWtZ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 17:49:25 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:53038 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750896AbYBMWtY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 17:49:24 -0500
Received: (qmail 18122 invoked by uid 1000); 13 Feb 2008 22:49:41 -0000
Content-Disposition: inline
In-Reply-To: <7v7ih8pre6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73825>

Fix 'git hash-object --stdin -w' to actually write the object, just as
'git hash-object -w --stdin' does.

Reported by Josh Triplett through
 http://bugs.debian.org/464432

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 hash-object.c          |    8 +++++---
 t/t5303-hash-object.sh |   19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)
 create mode 100755 t/t5303-hash-object.sh

diff --git a/hash-object.c b/hash-object.c
index 0a58f3f..ff60f0f 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -41,6 +41,7 @@ int main(int argc, char **argv)
 	const char *prefix = NULL;
 	int prefix_length = -1;
 	int no_more_flags = 0;
+	int hashstdin = 0;
 
 	git_config(git_default_config);
 
@@ -64,9 +65,8 @@ int main(int argc, char **argv)
 			}
 			else if (!strcmp(argv[i], "--help"))
 				usage(hash_object_usage);
-			else if (!strcmp(argv[i], "--stdin")) {
-				hash_stdin(type, write_object);
-			}
+			else if (!strcmp(argv[i], "--stdin"))
+				hashstdin = 1;
 			else
 				usage(hash_object_usage);
 		}
@@ -79,5 +79,7 @@ int main(int argc, char **argv)
 			no_more_flags = 1;
 		}
 	}
+	if (hashstdin)
+		hash_stdin(type, write_object);
 	return 0;
 }
diff --git a/t/t5303-hash-object.sh b/t/t5303-hash-object.sh
new file mode 100755
index 0000000..23dcfcb
--- /dev/null
+++ b/t/t5303-hash-object.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description=git-hash-object
+
+. ./test-lib.sh
+
+test_expect_success \
+    'git hash-object -w --stdin saves the object' \
+    'echo foo | git hash-object -w --stdin &&
+    test -r .git/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99 &&
+    rm -f .git/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99'
+    
+test_expect_success \
+    'git hash-object --stdin -w saves the object' \
+    'echo foo | git hash-object --stdin -w &&
+    test -r .git/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99 &&
+    rm -f .git/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99'    
+
+test_done
-- 
1.5.4.1
