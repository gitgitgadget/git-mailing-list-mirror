From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH 2/3] upload-pack: Introduce new "fixed-off-by-one-depth" server feature
Date: Thu, 11 Jul 2013 13:25:53 +0200
Message-ID: <1373541954-16493-2-git-send-email-matthijs@stdin.nl>
References: <20130711105733.GG10217@login.drsnuggles.stderr.nl>
 <1373541954-16493-1-git-send-email-matthijs@stdin.nl>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org, Matthijs Kooijman <matthijs@stdin.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxF15-0006gD-LK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407Ab3GKL0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:26:25 -0400
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:53750 "EHLO
	grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932363Ab3GKL0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:26:20 -0400
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
	(envelope-from <matthijs@stdin.nl>)
	id 1UxF0l-0004If-Gm; Thu, 11 Jul 2013 13:26:11 +0200
X-Mailer: git-send-email 1.8.3.rc1
In-Reply-To: <1373541954-16493-1-git-send-email-matthijs@stdin.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230089>

Commit 682c7d2 (upload-pack: fix off-by-one depth calculation in shallow
clone) changed the meaning of the fetch depth sent over the wire to mean
the total number of commits to return, instead of the number of commits
beyond the first. However, when this change is deployed on some servers
but not others, this can cause a client to behave differently based on
the server version, which is unexpected.

To prevent this, the new, fixed, depth behaviour is advertised as a server
feature and the old behaviour is restored when the feature is not
requested by the client.

Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
---
 upload-pack.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 127e59a..59f43d1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -46,6 +46,7 @@ static unsigned int timeout;
 static int use_sideband;
 static int advertise_refs;
 static int stateless_rpc;
+static int fixed_depth;
 
 static void reset_timeout(void)
 {
@@ -633,6 +634,8 @@ static void receive_needs(void)
 			no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
+		if (parse_feature_request(features, "fixed-off-by-one-depth"))
+			fixed_depth = 1;
 
 		o = parse_object(sha1_buf);
 		if (!o)
@@ -669,10 +672,14 @@ static void receive_needs(void)
 				struct object *object = shallows.objects[i].item;
 				object->flags |= NOT_SHALLOW;
 			}
-		else
+		else {
+			/* Emulate off-by-one bug in older versions */
+			if (!fixed_depth)
+				depth++;
 			backup = result =
 				get_shallow_commits(&want_obj, depth,
 						    SHALLOW, NOT_SHALLOW);
+		}
 		while (result) {
 			struct object *object = &result->item->object;
 			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
@@ -738,7 +745,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed fixed-off-by-one-depth";
 	const char *refname_nons = strip_namespace(refname);
 	unsigned char peeled[20];
 
-- 
1.8.3.rc1
