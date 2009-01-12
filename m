From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 5/7] object: call "check_sha1_signature" with the
 replacement sha1
Date: Mon, 12 Jan 2009 18:51:11 +0100
Message-ID: <20090112185111.c889feef.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 18:52:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQxK-0002SF-GY
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 18:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbZALRuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 12:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZALRub
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 12:50:31 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:56208 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbZALRua (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 12:50:30 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D8DE494098B;
	Mon, 12 Jan 2009 18:50:22 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id DD4A9940559;
	Mon, 12 Jan 2009 18:50:19 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105367>

Otherwise we get a "sha1 mismatch" error for replaced objects.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 object.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index 50b6528..217bee9 100644
--- a/object.c
+++ b/object.c
@@ -187,17 +187,18 @@ struct object *parse_object(const unsigned char *sha1)
 	unsigned long size;
 	enum object_type type;
 	int eaten;
-	void *buffer = read_sha1_file(sha1, &type, &size);
+	const unsigned char *repl;
+	void *buffer = read_sha1_file_repl(sha1, &type, &size, &repl);
 
 	if (buffer) {
 		struct object *obj;
-		if (check_sha1_signature(sha1, buffer, size, typename(type)) < 0) {
+		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
 			free(buffer);
-			error("sha1 mismatch %s\n", sha1_to_hex(sha1));
+			error("sha1 mismatch %s\n", sha1_to_hex(repl));
 			return NULL;
 		}
 
-		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
+		obj = parse_object_buffer(repl, type, size, buffer, &eaten);
 		if (!eaten)
 			free(buffer);
 		return obj;
-- 
1.6.1.83.g16e5
