From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] apply: free patch->{def,old,new}_name fields
Date: Wed, 21 Mar 2012 15:18:18 -0700
Message-ID: <7v1uol1tud.fsf_-_@alter.siamese.dyndns.org>
References: <cover.1331158240.git.jaredhance@gmail.com>
 <eadfc83a0d823cc04ea37bf606b57597fb632156.1331158240.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 23:19:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SATs5-0002xo-2o
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 23:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085Ab2CUWSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 18:18:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965077Ab2CUWSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 18:18:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4570C6ECF;
	Wed, 21 Mar 2012 18:18:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N9D7HUun8TxGZxSOeuNFRmBcyCc=; b=cpI7Ib
	igoUCAFyVliTFB6SE1K+zZ0gzO5B/RmwfGSUwF/uAACUkY5hyZkZl7UMXK8yHGDP
	XnGKcx/6xoZlmvfD2mRRK4wXxM7GaQEb6ZYzn8pKWr7h+xKX8zvXua6+RElqK24Y
	RHJx8t0WtgRjyX+mrLeBpP7biW7vlek7Yk0Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cMVQ4yJ+PefVf4TDOTKFGrVL/D9Lya3t
	JetZVeELz+QfsifZ2JB4rP6XCihlEcXBe3mzDK1L2es+rFer5LBMWWQunzN+9wu2
	EMnw3/0W1nnA/RkEGCzTw2YebdIS0PGLLc4E+XaxfcxDtgm6Lm4LSrVyVxZePubM
	KVBlTW3xmUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF9E6ECE;
	Wed, 21 Mar 2012 18:18:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45AD66ECC; Wed, 21 Mar 2012
 18:18:20 -0400 (EDT)
In-Reply-To: <eadfc83a0d823cc04ea37bf606b57597fb632156.1331158240.git.jaredhance@gmail.com> (Jared Hance's message of "Wed, 7 Mar 2012 17:21:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3FEFF02-73A3-11E1-B463-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193623>

These were all allocated in the heap by parsing the header parts of the
patch, but we did not bother to free them.  Some used to share the memory
(e.g. copying def_name to old_name) so this is not just the matter of
adding three calls to free().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c |   65 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 427c263..5d03e50 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -209,6 +209,9 @@ static void free_patch(struct patch *patch)
 			free(fragment);
 			fragment = fragment_next;
 		}
+		free(patch->def_name);
+		free(patch->old_name);
+		free(patch->new_name);
 		free(patch);
 		patch = patch_next;
 	}
@@ -434,7 +437,7 @@ static char *squash_slash(char *name)
 	return name;
 }
 
-static char *find_name_gnu(const char *line, char *def, int p_value)
+static char *find_name_gnu(const char *line, const char *def, int p_value)
 {
 	struct strbuf name = STRBUF_INIT;
 	char *cp;
@@ -457,11 +460,7 @@ static char *find_name_gnu(const char *line, char *def, int p_value)
 		cp++;
 	}
 
-	/* name can later be freed, so we need
-	 * to memmove, not just return cp
-	 */
 	strbuf_remove(&name, 0, cp - name.buf);
-	free(def);
 	if (root)
 		strbuf_insert(&name, 0, root, root_len);
 	return squash_slash(strbuf_detach(&name, NULL));
@@ -626,8 +625,13 @@ static size_t diff_timestamp_len(const char *line, size_t len)
 	return line + len - end;
 }
 
-static char *find_name_common(const char *line, char *def, int p_value,
-				const char *end, int terminate)
+static char *null_strdup(const char *s)
+{
+	return s ? xstrdup(s) : NULL;
+}
+
+static char *find_name_common(const char *line, const char *def,
+			      int p_value, const char *end, int terminate)
 {
 	int len;
 	const char *start = NULL;
@@ -648,10 +652,10 @@ static char *find_name_common(const char *line, char *def, int p_value,
 			start = line;
 	}
 	if (!start)
-		return squash_slash(def);
+		return squash_slash(null_strdup(def));
 	len = line - start;
 	if (!len)
-		return squash_slash(def);
+		return squash_slash(null_strdup(def));
 
 	/*
 	 * Generally we prefer the shorter name, especially
@@ -662,8 +666,7 @@ static char *find_name_common(const char *line, char *def, int p_value,
 	if (def) {
 		int deflen = strlen(def);
 		if (deflen < len && !strncmp(start, def, deflen))
-			return squash_slash(def);
-		free(def);
+			return squash_slash(xstrdup(def));
 	}
 
 	if (root) {
@@ -860,8 +863,10 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 		name = find_name_traditional(first, NULL, p_value);
 		patch->old_name = name;
 	} else {
-		name = find_name_traditional(first, NULL, p_value);
-		name = find_name_traditional(second, name, p_value);
+		char *first_name;
+		first_name = find_name_traditional(first, NULL, p_value);
+		name = find_name_traditional(second, first_name, p_value);
+		free(first_name);
 		if (has_epoch_timestamp(first)) {
 			patch->is_new = 1;
 			patch->is_delete = 0;
@@ -871,7 +876,8 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 			patch->is_delete = 1;
 			patch->old_name = name;
 		} else {
-			patch->old_name = patch->new_name = name;
+			patch->old_name = name;
+			patch->new_name = xstrdup(name);
 		}
 	}
 	if (!name)
@@ -921,13 +927,19 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 
 static int gitdiff_oldname(const char *line, struct patch *patch)
 {
+	char *orig = patch->old_name;
 	patch->old_name = gitdiff_verify_name(line, patch->is_new, patch->old_name, "old");
+	if (orig != patch->old_name)
+		free(orig);
 	return 0;
 }
 
 static int gitdiff_newname(const char *line, struct patch *patch)
 {
+	char *orig = patch->new_name;
 	patch->new_name = gitdiff_verify_name(line, patch->is_delete, patch->new_name, "new");
+	if (orig != patch->new_name)
+		free(orig);
 	return 0;
 }
 
@@ -946,20 +958,23 @@ static int gitdiff_newmode(const char *line, struct patch *patch)
 static int gitdiff_delete(const char *line, struct patch *patch)
 {
 	patch->is_delete = 1;
-	patch->old_name = patch->def_name;
+	free(patch->old_name);
+	patch->old_name = null_strdup(patch->def_name);
 	return gitdiff_oldmode(line, patch);
 }
 
 static int gitdiff_newfile(const char *line, struct patch *patch)
 {
 	patch->is_new = 1;
-	patch->new_name = patch->def_name;
+	free(patch->new_name);
+	patch->new_name = null_strdup(patch->def_name);
 	return gitdiff_newmode(line, patch);
 }
 
 static int gitdiff_copysrc(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
+	free(patch->old_name);
 	patch->old_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
 	return 0;
 }
@@ -967,6 +982,7 @@ static int gitdiff_copysrc(const char *line, struct patch *patch)
 static int gitdiff_copydst(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
+	free(patch->new_name);
 	patch->new_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
 	return 0;
 }
@@ -974,6 +990,7 @@ static int gitdiff_copydst(const char *line, struct patch *patch)
 static int gitdiff_renamesrc(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
+	free(patch->old_name);
 	patch->old_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
 	return 0;
 }
@@ -981,6 +998,7 @@ static int gitdiff_renamesrc(const char *line, struct patch *patch)
 static int gitdiff_renamedst(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
+	free(patch->new_name);
 	patch->new_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
 	return 0;
 }
@@ -1421,7 +1439,8 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 				if (!patch->def_name)
 					die("git diff header lacks filename information when removing "
 					    "%d leading pathname components (line %d)" , p_value, linenr);
-				patch->old_name = patch->new_name = patch->def_name;
+				patch->old_name = xstrdup(patch->def_name);
+				patch->new_name = xstrdup(patch->def_name);
 			}
 			if (!patch->is_delete && !patch->new_name)
 				die("git diff header lacks filename information "
@@ -3104,6 +3123,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
  is_new:
 	patch->is_new = 1;
 	patch->is_delete = 0;
+	free(patch->old_name);
 	patch->old_name = NULL;
 	return 0;
 }
@@ -3684,15 +3704,8 @@ static void prefix_patches(struct patch *p)
 	if (!prefix || p->is_toplevel_relative)
 		return;
 	for ( ; p; p = p->next) {
-		if (p->new_name == p->old_name) {
-			char *prefixed = p->new_name;
-			prefix_one(&prefixed);
-			p->new_name = p->old_name = prefixed;
-		}
-		else {
-			prefix_one(&p->new_name);
-			prefix_one(&p->old_name);
-		}
+		prefix_one(&p->new_name);
+		prefix_one(&p->old_name);
 	}
 }
 
-- 
1.7.10.rc1.76.g1a8310
