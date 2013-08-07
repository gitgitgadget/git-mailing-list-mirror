From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] replace: forbid replacing an object with one of a different
 type
Date: Wed, 07 Aug 2013 06:42:47 +0200
Message-ID: <20130807044248.17464.35806.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 07:02:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6vt5-0000pl-E9
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 07:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab3HGFCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 01:02:14 -0400
Received: from delay-2y.bbox.fr ([194.158.98.17]:61686 "EHLO delay-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134Ab3HGFCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 01:02:14 -0400
X-Greylist: delayed 743 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Aug 2013 01:02:13 EDT
Received: from mail-1y.bbox.fr (bt8sssom.cs.dolmen.bouyguestelecom.fr [172.24.208.144])
	by delay-2y.bbox.fr (Postfix) with ESMTP id 71BAC2670D7
	for <git@vger.kernel.org>; Wed,  7 Aug 2013 06:52:50 +0200 (CEST)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 5613F48;
	Wed,  7 Aug 2013 06:49:46 +0200 (CEST)
X-git-sha1: 132b1a0384f651756ed7f783b8bb6879c232ce03 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231806>

Users replacing an object with one of a different type were not
prevented to do so, even if it was obvious, and stated in the doc,
that bad things would result from doing that.

To avoid mistakes, it is better to just forbid that though.

The doc will be updated in a later patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
If this patch is considered useful, I will update the doc and
maybe add tests.

 builtin/replace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/replace.c b/builtin/replace.c
index 59d3115..0246ab3 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -85,6 +85,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 			  int force)
 {
 	unsigned char object[20], prev[20], repl[20];
+	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
 	struct ref_lock *lock;
 
@@ -100,6 +101,14 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	if (check_refname_format(ref, 0))
 		die("'%s' is not a valid ref name.", ref);
 
+	obj_type = sha1_object_info(object, NULL);
+	repl_type = sha1_object_info(repl, NULL);
+	if (obj_type != repl_type)
+		die("Object ref '%s' is of type '%s'\n"
+		    "while replace ref '%s' is of type '%s'.",
+		    object_ref, typename(obj_type),
+		    replace_ref, typename(repl_type));
+
 	if (read_ref(ref, prev))
 		hashclr(prev);
 	else if (!force)
-- 
1.8.4.rc1.22.g132b1a0
