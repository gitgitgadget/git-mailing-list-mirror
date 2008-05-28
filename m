From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fix sha1_pack_index_name()
Date: Wed, 28 May 2008 09:47:43 -0700
Message-ID: <7vskw2v0i8.fsf_-_@gitster.siamese.dyndns.org>
References: <483D7E27.7030809@isy.liu.se>
 <7v1w3mwffq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustaf Hendeby <hendeby@isy.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Wed May 28 18:48:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1OpR-0007O8-Hh
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 18:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbYE1Qry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 12:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbYE1Qry
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 12:47:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbYE1Qrx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 12:47:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CBFDB4D4F;
	Wed, 28 May 2008 12:47:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F3AD84D4E; Wed, 28 May 2008 12:47:45 -0400 (EDT)
In-Reply-To: <7v1w3mwffq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 May 2008 09:39:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CEAF29B8-2CD5-11DD-B3F3-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83108>

An earlier commit 633f43e (Remove redundant code, eliminate one static
variable, 2008-05-24) had a thinko (perhaps an eyeno) that broke
sha1_pack_index_name() function.  One symptom of this was that the http
walker is now completely broken.

This should fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9679040..adcf37c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -177,7 +177,7 @@ char *sha1_file_name(const unsigned char *sha1)
 }
 
 static char *sha1_get_pack_name(const unsigned char *sha1,
-				char **name, char **base)
+				char **name, char **base, const char *which)
 {
 	static const char hex[] = "0123456789abcdef";
 	char *buf;
@@ -187,7 +187,8 @@ static char *sha1_get_pack_name(const unsigned char *sha1,
 		const char *sha1_file_directory = get_object_directory();
 		int len = strlen(sha1_file_directory);
 		*base = xmalloc(len + 60);
-		sprintf(*base, "%s/pack/pack-1234567890123456789012345678901234567890.pack", sha1_file_directory);
+		sprintf(*base, "%s/pack/pack-1234567890123456789012345678901234567890.%s",
+			sha1_file_directory, which);
 		*name = *base + len + 11;
 	}
 
@@ -206,14 +207,14 @@ char *sha1_pack_name(const unsigned char *sha1)
 {
 	static char *name, *base;
 
-	return sha1_get_pack_name(sha1, &name, &base);
+	return sha1_get_pack_name(sha1, &name, &base, "pack");
 }
 
 char *sha1_pack_index_name(const unsigned char *sha1)
 {
 	static char *name, *base;
 
-	return sha1_get_pack_name(sha1, &name, &base);
+	return sha1_get_pack_name(sha1, &name, &base, "idx");
 }
 
 struct alternate_object_database *alt_odb_list;
