From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fix overslow :/no-such-string-ever-existed diagnostics
Date: Tue, 10 May 2011 12:02:54 -0700
Message-ID: <7vzkmuidk1.fsf@alter.siamese.dyndns.org>
References: <7vhb92jujt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 21:03:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJsDG-0003Cj-NV
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 21:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab1EJTDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 15:03:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab1EJTDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 15:03:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C4CE5325;
	Tue, 10 May 2011 15:05:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LTKocZZ02c+9Tfe9mFS54xDl5L4=; b=hZPuk9
	p9U7FXRro2ZBu40xBTeAtfau1SPAOmSMm14ubRpUfm3tzEJYVv29/F40yd8ue5TS
	v9aGipkrFbeqccXcgj8aNQrg4kKNIKE4Azx2dNc8HDuQowiS9HY9XpfJt6wvMECG
	n+NdExg8BxSA9WhONmE5kraIXN0rNRLP0JxRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i3j0DmeGWzt3IdFIyQglP/1d5PZjrnSo
	bmMdK8kcmXr9440tbyFEEMvOwOiO3i2vk/m2cIFIFgcJTv4iEk+eyrW4JI69Re4n
	6KbUD5qkFMa3UQZVRlNwmQASRR9nd3Nt0RrjA7ib+1waHghF47rnYS/V8wtHk3Kq
	NI8UKNQJA0s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B44E5323;
	Tue, 10 May 2011 15:05:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2F50F5322; Tue, 10 May 2011
 15:05:01 -0400 (EDT)
In-Reply-To: <7vhb92jujt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 10 May 2011 11:10:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B88698A-7B38-11E0-9606-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173346>

"git cmd :/no-such-string-ever-existed" runs an extra round of get_sha1()
since 009fee4 (Detailed diagnosis when parsing an object name fails.,
2009-12-07).  Once without error diagnosis to see there is no commit with
such a string in the log message (hence "it cannot be a ref"), and after
seeing that :/no-such-string-ever-existed is not a filename (hence "it
cannot be a path, either"), another time to give "better diagnosis".

The thing is, the second time it runs, we already know that traversing the
history all the way down to the root will _not_ find any matching commit.

Rename misguided "gently" parameter, which is turned off _only_ when the
"detailed diagnosis" codepath knows that it cannot be a ref and making the
call only for the caller to die with a message.  Flip its meaning (and
adjust the callers) and call it "only_to_die", which is not a great name,
but it describes far more clearly what the codepaths that switches their
behaviour based on this variable do.

On my box, the command spends ~1.8 seconds without the patch to make the
report; with the patch it spends ~1.12 seconds.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Yes, we often say "this is an error path and paying the price in
   performance for a better diagnosis is worth", and it is correct.
   But it is not an excuse to spend unnecessary cycles.

   We may want to add a guard at the beginning of die_verify_filename() to
   omit the extra call to get_sha1_with_mode_1(only_to_die=1) when arg
   looks like a magic pathspec, i.e. ":" followed by anything !isalnum().

 cache.h     |    8 ++++----
 setup.c     |    2 +-
 sha1_name.c |   17 +++++++++--------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index be6ce72..a9e6419 100644
--- a/cache.h
+++ b/cache.h
@@ -785,15 +785,15 @@ struct object_context {
 };
 
 extern int get_sha1(const char *str, unsigned char *sha1);
-extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int gently, const char *prefix);
+extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int only_to_die, const char *prefix);
 static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
 {
-	return get_sha1_with_mode_1(str, sha1, mode, 1, NULL);
+	return get_sha1_with_mode_1(str, sha1, mode, 0, NULL);
 }
-extern int get_sha1_with_context_1(const char *name, unsigned char *sha1, struct object_context *orc, int gently, const char *prefix);
+extern int get_sha1_with_context_1(const char *name, unsigned char *sha1, struct object_context *orc, int only_to_die, const char *prefix);
 static inline int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc)
 {
-	return get_sha1_with_context_1(str, sha1, orc, 1, NULL);
+	return get_sha1_with_context_1(str, sha1, orc, 0, NULL);
 }
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
diff --git a/setup.c b/setup.c
index 5048252..50e8548 100644
--- a/setup.c
+++ b/setup.c
@@ -86,7 +86,7 @@ static void NORETURN die_verify_filename(const char *prefix, const char *arg)
 	unsigned char sha1[20];
 	unsigned mode;
 	/* try a detailed diagnostic ... */
-	get_sha1_with_mode_1(arg, sha1, &mode, 0, prefix);
+	get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
 	/* ... or fall back the most general message. */
 	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
 	    "Use '--' to separate paths from revisions", arg);
diff --git a/sha1_name.c b/sha1_name.c
index faea58d..ec83611 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1080,11 +1080,12 @@ static void diagnose_invalid_index_path(int stage,
 }
 
 
-int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode, int gently, const char *prefix)
+int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
+			 int only_to_die, const char *prefix)
 {
 	struct object_context oc;
 	int ret;
-	ret = get_sha1_with_context_1(name, sha1, &oc, gently, prefix);
+	ret = get_sha1_with_context_1(name, sha1, &oc, only_to_die, prefix);
 	*mode = oc.mode;
 	return ret;
 }
@@ -1108,7 +1109,7 @@ static char *resolve_relative_path(const char *rel)
 
 int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			    struct object_context *oc,
-			    int gently, const char *prefix)
+			    int only_to_die, const char *prefix)
 {
 	int ret, bracket_depth;
 	int namelen = strlen(name);
@@ -1130,7 +1131,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 		struct cache_entry *ce;
 		char *new_path = NULL;
 		int pos;
-		if (namelen > 2 && name[1] == '/') {
+		if (!only_to_die && namelen > 2 && name[1] == '/') {
 			struct commit_list *list = NULL;
 			for_each_ref(handle_one_ref, &list);
 			return get_sha1_oneline(name + 2, sha1, list);
@@ -1173,7 +1174,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			}
 			pos++;
 		}
-		if (!gently)
+		if (only_to_die && name[1] && name[1] != '/')
 			diagnose_invalid_index_path(stage, prefix, cp);
 		free(new_path);
 		return -1;
@@ -1189,7 +1190,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
 		char *object_name = NULL;
-		if (!gently) {
+		if (only_to_die) {
 			object_name = xmalloc(cp-name+1);
 			strncpy(object_name, name, cp-name);
 			object_name[cp-name] = '\0';
@@ -1202,7 +1203,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			if (new_filename)
 				filename = new_filename;
 			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
-			if (!gently) {
+			if (only_to_die) {
 				diagnose_invalid_sha1_path(prefix, filename,
 							   tree_sha1, object_name);
 				free(object_name);
@@ -1215,7 +1216,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			free(new_filename);
 			return ret;
 		} else {
-			if (!gently)
+			if (only_to_die)
 				die("Invalid object name '%s'.", object_name);
 		}
 	}
   
