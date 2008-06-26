From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] for-each-ref: implement missing tag values
Date: Thu, 26 Jun 2008 01:38:04 -0400
Message-ID: <20080626053804.GB20824@sigill.intra.peff.net>
References: <20080626053551.GA20767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 07:39:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBkCM-0002RK-IN
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 07:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbYFZFiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 01:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbYFZFiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 01:38:09 -0400
Received: from peff.net ([208.65.91.99]:3847 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686AbYFZFiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 01:38:08 -0400
Received: (qmail 24153 invoked by uid 111); 26 Jun 2008 05:38:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 26 Jun 2008 01:38:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2008 01:38:04 -0400
Content-Disposition: inline
In-Reply-To: <20080626053551.GA20767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86398>

The "type" and "object" fields for tags were accepted as
valid atoms, but never implemented. Consequently, they
simply returned the empty string, even for valid tags.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-for-each-ref.c  |    7 +++++++
 t/t6300-for-each-ref.sh |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 07d9c57..fef93d7 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -234,6 +234,13 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 			name++;
 		if (!strcmp(name, "tag"))
 			v->s = tag->tag;
+		else if (!strcmp(name, "type") && tag->tagged)
+			v->s = typename(tag->tagged->type);
+		else if (!strcmp(name, "object") && tag->tagged) {
+			char *s = xmalloc(41);
+			strcpy(s, sha1_to_hex(tag->tagged->sha1));
+			v->s = s;
+		}
 	}
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 415e1d1..a3c8941 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -74,8 +74,8 @@ test_atom tag objectname 98b46b1d36e5b07909de1b3886224e3e81e87322
 test_atom tag tree ''
 test_atom tag parent ''
 test_atom tag numparent ''
-test_atom tag object '67a36f10722846e891fbada1ba48ed035de75581' failure
-test_atom tag type 'commit' failure
+test_atom tag object '67a36f10722846e891fbada1ba48ed035de75581'
+test_atom tag type 'commit'
 test_atom tag author ''
 test_atom tag authorname ''
 test_atom tag authoremail ''
-- 
1.5.6
