From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fsck: do not give up too early in fsck_dir()
Date: Wed, 26 Jan 2011 13:01:54 -0800
Message-ID: <7vlj27js59.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 26 22:02:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCVD-00056a-Ix
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab1AZVCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:02:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab1AZVCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:02:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF9A3378D;
	Wed, 26 Jan 2011 16:02:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Xqtu
	IXDdwvAEX7sOYiUh8fR9yp0=; b=INfdZkql+1pUwI1OBwfjpuTjii7LdGnUM2gM
	K8qPe2cqtPZiOxfnvn5AmzrJle5wI6JCa0uJf4IEWQfy6JHP+koUhqHAIxFEccf/
	UaCvOgRAXGK8MtUjS5IIRaGgJ9hao3XdT6VdmyOSn2kJGAmJ2PPgaZNR+VFXFu0q
	Wx9NyaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=F7h
	HWw1iop0ZAKEBScnlZN2XJ+Bnb6jJQq3fq1XRm3tvCHt6egH56z14kOViJyTjShh
	JwIhd9fAzF4RgYgU4HIf1UDud16qFsTgyUXGOtoPyjJQAgtfpsmzdvTX3adKs3tA
	yDpv4Zte0m1yiRPZrApwC/3vBiltir3Jd4RZesxo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D87CF3786;
	Wed, 26 Jan 2011 16:02:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C0F973784; Wed, 26 Jan 2011
 16:02:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0497876-298F-11E0-AB53-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165545>

When there is a random garbage file whose name happens to be 38-byte
long in a .git/objects/??/ directory, the loop terminated prematurely
without marking all the other files that it hasn't checked in the
readdir() loop.

Treat such a file just like any other garbage file, and do not break out
of the readdir() loop.

While at it, replace repeated sprintf() calls to a single one outside the
loop.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * For readability, I think it also makes sense to move the surrounding
   code so that "tmp_obj_" check and the "is_dot_or_dotdot" check are next
   to each other, as they are both in "we know this is not a loose object
   file, and we don't want to warn about its existence" category, but that
   is a minor point.

 builtin/fsck.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 91409a0..795aba0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -392,10 +392,20 @@ static void add_sha1_list(unsigned char *sha1, unsigned long ino)
 	sha1_list.nr = ++nr;
 }
 
+static inline int is_loose_object_file(struct dirent *de,
+				       char *name, unsigned char *sha1)
+{
+	if (strlen(de->d_name) != 38)
+		return 0;
+	memcpy(name + 2, de->d_name, 39);
+	return !get_sha1_hex(name, sha1);
+}
+
 static void fsck_dir(int i, char *path)
 {
 	DIR *dir = opendir(path);
 	struct dirent *de;
+	char name[100];
 
 	if (!dir)
 		return;
@@ -403,17 +413,13 @@ static void fsck_dir(int i, char *path)
 	if (verbose)
 		fprintf(stderr, "Checking directory %s\n", path);
 
+	sprintf(name, "%02x", i);
 	while ((de = readdir(dir)) != NULL) {
-		char name[100];
 		unsigned char sha1[20];
 
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
-		if (strlen(de->d_name) == 38) {
-			sprintf(name, "%02x", i);
-			memcpy(name+2, de->d_name, 39);
-			if (get_sha1_hex(name, sha1) < 0)
-				break;
+		if (is_loose_object_file(de, name, sha1)) {
 			add_sha1_list(sha1, DIRENT_SORT_HINT(de));
 			continue;
 		}
