From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] for-each-ref: Field with abbreviated objectname
Date: Thu, 13 May 2010 14:31:46 +0200
Message-ID: <dc7a785c8051aa1f742b75c03ddd1fdba57272db.1273753841.git.git@drmicha.warpmail.net>
References: <20100504110134.GA7947@coredump.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 14:31:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCXZt-0008Gx-42
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 14:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857Ab0EMMbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 08:31:44 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34742 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752796Ab0EMMbn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 08:31:43 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A9537F5C7E;
	Thu, 13 May 2010 08:31:42 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 13 May 2010 08:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=ThQZHJv4nfRsiUL023OfEN4GQsY=; b=saVon0guiAupFBFo5kYhpqIt4eUcUtjU3WukoCkEqg5DSRr/c6aDNuT9PjH5KLfgOUlk/O6PKwYOMB3kc6tVY37maF5+8Lt9J93oZUNXMgbQUfEarWNU5N4ylYjBti2HkV8VWYkb25xubgaGGHAhnUguL5nHHCDjjYGurDHJr0s=
X-Sasl-enc: C1kBdE3jBM/LynBGMkHdZRQ+pfbKAzUIK/oIxyRBG56b 1273753901
Received: from localhost (p54859DBB.dip0.t-ipconnect.de [84.133.157.187])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D5EB63D4EB;
	Thu, 13 May 2010 08:31:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <20100504110134.GA7947@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146997>

Introduce a :short modifier to objectname which outputs the abbreviated
object name.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-for-each-ref.txt |    1 +
 builtin/for-each-ref.c             |    3 +++
 t/t6300-for-each-ref.sh            |    9 +++++++++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7e83288..390d85c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -86,6 +86,7 @@ objectsize::
 
 objectname::
 	The object name (aka SHA-1).
+	For a non-ambiguous abbreviation of the object name append `:short`.
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 62be1bb..3a97953 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -227,6 +227,9 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			strcpy(s, sha1_to_hex(obj->sha1));
 			v->s = s;
 		}
+		else if (!strcmp(name, "objectname:short")) {
+			v->s = find_unique_abbrev(obj->sha1, DEFAULT_ABBREV);
+		}
 	}
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8052c86..7dc8a51 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -295,6 +295,15 @@ test_expect_success 'Check short upstream format' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+67a36f1
+EOF
+
+test_expect_success 'Check short objectname format' '
+	git for-each-ref --format="%(objectname:short)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
-- 
1.7.1.240.geeaa4d
