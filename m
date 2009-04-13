From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [RFC/PATCH 3/2] rev-parse: --abbrev-ref option to shorten ref name
Date: Mon, 13 Apr 2009 13:20:26 +0200
Message-ID: <1239621626-26952-1-git-send-email-bert.wesarg@googlemail.com>
References: <1239618347-17158-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 13:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtKFO-0001je-Ry
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 13:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbZDMLUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 07:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754450AbZDMLUb
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 07:20:31 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47985 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbZDMLUa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 07:20:30 -0400
Received: by fxm2 with SMTP id 2so1949474fxm.37
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=P0gYITJZ6sRoRUpTZ3MHTDxLKt294xuLtPAKdU7nh+o=;
        b=w9E/VYvz2e7WOws/i/5QoYZABeN4yQKfQtTcFWTflH3slHs5fdbRo6hptnYuARV7sN
         v65yfcUYYICpwABuSDadotCpcR74stg/RV1PMAlbmYhMybj+M/7Fy5FEmRVJ+cJyv65E
         R0fDQ8iyNV16vykngw6nui2Mr4ss0aSa42ds0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cFRACAq1ZRHJq5oRJBwOBBxNYIg+WblEG3CoMjtSnHeq8snai21XhkNNJkrJ8roMOs
         zko65Q5l/LwOhzartYKKUpy6X+1I//sUTZni/kd6M9PQpoXjvhYvVW2EMN5KgwGa4DZs
         YCAfo3mcEGGmXPYIGSqV6hkVmDAtWzgpHEwLI=
Received: by 10.86.92.9 with SMTP id p9mr4748533fgb.15.1239621628054;
        Mon, 13 Apr 2009 04:20:28 -0700 (PDT)
Received: from localhost (p5B0F4888.dip.t-dialin.net [91.15.72.136])
        by mx.google.com with ESMTPS id e20sm7050617fga.4.2009.04.13.04.20.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 04:20:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.463.g124d4
In-Reply-To: <1239618347-17158-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116431>

This applies the shorten_unambiguous_ref function to the object name.
Default mode is controlled by core.warnAmbiguousRefs. Else it is given as
optional argument to --abbrev-ref={strict|loose}.

This should be faster than 'git for-each-ref --format="%(refname:short)" <ref>'
for single refs.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
Cc: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org

Can someone check, if I need to alter the filter, thanks.

Regards,
Bert

 Documentation/git-rev-parse.txt |    5 +++++
 builtin-rev-parse.c             |   23 +++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 5ed2bc8..fba30b1 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -84,6 +84,11 @@ OPTIONS
 	unfortunately named tag "master"), and show them as full
 	refnames (e.g. "refs/heads/master").
 
+--abbrev-ref[={strict|loose}]::
+	A non-ambiguous short name of the objects name.
+	The option core.warnAmbiguousRefs is used to select the strict
+	abbreviation mode.
+
 --all::
 	Show all refs found in `$GIT_DIR/refs`.
 
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 81d5a6f..22c6d6a 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -26,6 +26,8 @@ static int show_type = NORMAL;
 #define SHOW_SYMBOLIC_FULL 2
 static int symbolic;
 static int abbrev;
+static int abbrev_ref;
+static int abbrev_ref_strict;
 static int output_sq;
 
 /*
@@ -109,8 +111,8 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 		return;
 	def = NULL;
 
-	if (symbolic && name) {
-		if (symbolic == SHOW_SYMBOLIC_FULL) {
+	if ((symbolic || abbrev_ref) && name) {
+		if (symbolic == SHOW_SYMBOLIC_FULL || abbrev_ref) {
 			unsigned char discard[20];
 			char *full;
 
@@ -125,6 +127,9 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 				 */
 				break;
 			case 1: /* happy */
+				if (abbrev_ref)
+					full = shorten_unambiguous_ref(full,
+						abbrev_ref_strict);
 				show_with_type(type, full);
 				break;
 			default: /* ambiguous */
@@ -506,6 +511,20 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				symbolic = SHOW_SYMBOLIC_FULL;
 				continue;
 			}
+			if (!prefixcmp(arg, "--abbrev-ref") &&
+			    (!arg[12] || arg[12] == '=')) {
+				abbrev_ref = 1;
+				abbrev_ref_strict = warn_ambiguous_refs;
+				if (arg[12] == '=') {
+					if (!strcmp(arg + 13, "strict"))
+						abbrev_ref_strict = 1;
+					else if (!strcmp(arg + 13, "loose"))
+						abbrev_ref_strict = 0;
+					else
+						die("unknown mode for %s", arg);
+				}
+				continue;
+			}
 			if (!strcmp(arg, "--all")) {
 				for_each_ref(show_reference, NULL);
 				continue;
-- 
tg: (5fec79c..) bw/rev-parse_--abbrev_ref (depends on: bw/utilize-it)
