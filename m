From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/7] object: call "check_sha1_signature" with the
 replacement sha1
Date: Fri, 23 Jan 2009 10:07:10 +0100
Message-ID: <20090123100710.21f5556d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 10:08:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQI1u-0007ur-3I
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 10:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbZAWJG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 04:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754811AbZAWJG4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 04:06:56 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:40152 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753873AbZAWJGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 04:06:52 -0500
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id E4A4CE080F5;
	Fri, 23 Jan 2009 10:06:45 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with SMTP id E1AC0E08076;
	Fri, 23 Jan 2009 10:06:42 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106863>

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
1.6.1.231.g9c286
