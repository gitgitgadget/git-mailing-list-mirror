From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] core: log offset pack data accesses happened
Date: Thu,  7 Jul 2011 17:24:16 -0700
Message-ID: <1310084657-16790-2-git-send-email-gitster@pobox.com>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 02:24:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeyry-0000Tr-R3
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 02:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612Ab1GHAYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 20:24:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1GHAYW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 20:24:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A2A086587;
	Thu,  7 Jul 2011 20:24:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6PUB
	HibZy7F1WjTJ2WCJKAID+N0=; b=ZQt4GIEPAKZW147hDiYtPUykeo7B87+1p5+y
	GhgvZSMw8+rFFxPy4p1IOgp4BpHOvM9NtGRh2BwiioYZZaRlhr3+n8Dd3pL2M2Q3
	3DzSYq6kG7I7fnhRJMIF2R5LHNbqEpoiZTUYTv57u20zfwPVzlOZXyDZkykiyugr
	eSsqLXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	PxdBW7NH5+Bd362LRA6n49lMl7/ow/BhliI0T9Bg7B4NuEGZpGw45x7Uo5PlyDeB
	sbiXHvfvwkyIse9DcVZFQq63LSuYEuDOE5/qG3R68RIRdsBy2+hAvo5EMXVIghUm
	oywGVf9TD2Ro3pRsN75H8yg+KqEswez54IE6q9MxUPc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9BAAF6586;
	Thu,  7 Jul 2011 20:24:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C7B626583; Thu,  7 Jul 2011
 20:24:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.134.gcf13f6
In-Reply-To: <1310084657-16790-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9FD8EB36-A8F8-11E0-B480-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176790>

In a workload other than "git log" (without pathspec nor any option that
causes us to inspect trees and blobs), the recency pack order is said to
cause the access jump around quite a bit. Add a hook to allow us observe
how bad it is.

"git config core.logpackaccess /var/tmp/pal.txt" will give you the log in
the specified file, one line per access, the name of the packfile and the
offset of the accessed location in the packfile. This data can be massaged
to show how large a seek is involved in between each pair of adjacent
accesses to the same packfile.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h       |    3 +++
 config.c      |    3 +++
 environment.c |    1 +
 sha1_file.c   |   21 +++++++++++++++++++++
 4 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index f4bb43e..16a8c7c 100644
--- a/cache.h
+++ b/cache.h
@@ -784,6 +784,9 @@ extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
+/* for development: log offset of pack access */
+extern const char *log_pack_access;
+
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
diff --git a/config.c b/config.c
index e0b3b80..5ef3f39 100644
--- a/config.c
+++ b/config.c
@@ -569,6 +569,9 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.logpackaccess"))
+		return git_config_string(&log_pack_access, var, value);
+
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
 			if (core_eol == EOL_CRLF)
diff --git a/environment.c b/environment.c
index 94d58fd..1935102 100644
--- a/environment.c
+++ b/environment.c
@@ -36,6 +36,7 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 16 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
+const char *log_pack_access;
 const char *pager_program;
 int pager_use_color = 1;
 const char *editor_program;
diff --git a/sha1_file.c b/sha1_file.c
index 064a330..baf5da1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1839,6 +1839,24 @@ static void *unpack_delta_entry(struct packed_git *p,
 	return result;
 }
 
+static void write_pack_access_log(struct packed_git *p, off_t obj_offset)
+{
+	static FILE *log_file;
+
+	if (!log_file) {
+		log_file = fopen(log_pack_access, "w");
+		if (!log_file) {
+			error("cannot open pack access log '%s' for writing: %s",
+			      log_pack_access, strerror(errno));
+			log_pack_access = NULL;
+			return;
+		}
+	}
+	fprintf(log_file, "%s %"PRIuMAX"\n",
+		p->pack_name, (uintmax_t)obj_offset);
+	fflush(log_file);
+}
+
 int do_check_packed_object_crc;
 
 void *unpack_entry(struct packed_git *p, off_t obj_offset,
@@ -1848,6 +1866,9 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	off_t curpos = obj_offset;
 	void *data;
 
+	if (log_pack_access)
+		write_pack_access_log(p, obj_offset);
+
 	if (do_check_packed_object_crc && p->index_version > 1) {
 		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
 		unsigned long len = revidx[1].offset - obj_offset;
-- 
1.7.6.134.gcf13f6
