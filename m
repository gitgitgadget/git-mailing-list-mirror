From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] log: do not shorten decoration names too early
Date: Wed, 13 May 2015 12:40:35 -0700
Message-ID: <xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
References: <55534D95.60609@alum.mit.edu>
	<xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
	<xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 13 21:40:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YscWJ-0000FR-K6
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 21:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbbEMTki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 15:40:38 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32874 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964982AbbEMTkh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 15:40:37 -0400
Received: by igbpi8 with SMTP id pi8so120986012igb.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QtB2+8wdTzJJ0FLY/XCklChO4aWTkKrAIzKliW/cRjE=;
        b=D1lKbD+Q+FkGX3Lb5vh4XumsVOCKp8gS6caQIca5jZGMDowDAfh3Riq3oHEIrMW/09
         HNJUlQUUdkgKwRW9k3gpifw7AXz+if0cnW5pVIYTkgFRVoiYSeCaZo25ymPzJi3xt1aA
         fhPTixzqlVyvkqfroAKjGQjt2Nlyq6RW9+yX39Io9It2AAHb5KLt0tqn0iUMtbt6N9hX
         gxlLZrcW2jjm8ZbRSe1AHn1VMNnJl3WgaXLyiaOyBHNFuYI3veg3pAbB9U30icJdorMK
         YjTt8GF7pk0xUmNKdLT6SLEtcmqHrwPGM/j4cTFJ1CaB6DnBMRkwkmNte4WQ7ewrTe+G
         j2MA==
X-Received: by 10.42.20.14 with SMTP id e14mr11037027icb.76.1431546037207;
        Wed, 13 May 2015 12:40:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id qs10sm4267291igb.14.2015.05.13.12.40.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 12:40:36 -0700 (PDT)
In-Reply-To: <xmqqsib09z8y.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 13 May 2015 10:13:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269003>

The DECORATE_SHORT_REFS option given to load_ref_decorations()
affects the way a copy of the refname is stored for each decorated
commit, and this forces later steps like current_pointed_by_HEAD()
to adjust their behaviour based on this initial settings.

Instead, we can always store the full refname and then shorten them
when producing the output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * [1/2] is just the earlier "this should fix it" patch, with
   adjustments to the existing tests.

   I suspect that it may be a good idea to lose the decoration_flags
   from load_ref_decorations() and instead make that a new parameter
   to format_decorations().  That way, the caller could decide which
   ones to use.  It is not unconceivable to extend "log --format=%d"
   that shows the decoration in the style given by --decorate arg
   and let the callers specify two additional formats (i.e. decorate
   always short, decorate always in full), and for that kind of
   work, this patch will become a prerequisite.

 log-tree.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 92259bc..c931615 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -94,6 +94,8 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	struct object *obj;
 	enum decoration_type type = DECORATION_NONE;
 
+	assert(cb_data == NULL);
+
 	if (starts_with(refname, "refs/replace/")) {
 		unsigned char original_sha1[20];
 		if (!check_replace_refs)
@@ -123,8 +125,6 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	else if (!strcmp(refname, "HEAD"))
 		type = DECORATION_REF_HEAD;
 
-	if (!cb_data || *(int *)cb_data == DECORATE_SHORT_REFS)
-		refname = prettify_refname(refname);
 	add_name_decoration(type, refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
@@ -151,8 +151,8 @@ void load_ref_decorations(int flags)
 	if (!decoration_loaded) {
 		decoration_loaded = 1;
 		decoration_flags = flags;
-		for_each_ref(add_ref_decoration, &flags);
-		head_ref(add_ref_decoration, &flags);
+		for_each_ref(add_ref_decoration, NULL);
+		head_ref(add_ref_decoration, NULL);
 		for_each_commit_graft(add_graft_decoration, NULL);
 	}
 }
@@ -199,18 +199,8 @@ static const struct name_decoration *current_pointed_by_HEAD(const struct name_d
 	if (!(rru_flags & REF_ISSYMREF))
 		return NULL;
 
-	if ((decoration_flags == DECORATE_SHORT_REFS)) {
-		if (!skip_prefix(branch_name, "refs/heads/", &branch_name))
-			return NULL;
-	} else {
-		/*
-		 * Each decoration has a refname in full; keep
-		 * branch_name also in full, but still make sure
-		 * HEAD is a reasonable ref.
-		 */
-		if (!starts_with(branch_name, "refs/"))
-			return NULL;
-	}
+	if (!starts_with(branch_name, "refs/"))
+		return NULL;
 
 	/* OK, do we have that ref in the list? */
 	for (list = decoration; list; list = list->next)
@@ -222,6 +212,14 @@ static const struct name_decoration *current_pointed_by_HEAD(const struct name_d
 	return NULL;
 }
 
+static void show_name(struct strbuf *sb, const struct name_decoration *decoration)
+{
+	if (decoration_flags == DECORATE_SHORT_REFS)
+		strbuf_addstr(sb, prettify_refname(decoration->name));
+	else
+		strbuf_addstr(sb, decoration->name);
+}
+
 /*
  * The caller makes sure there is no funny color before calling.
  * format_decorations_extended makes sure the same after return.
@@ -259,7 +257,7 @@ void format_decorations_extended(struct strbuf *sb,
 			if (decoration->type == DECORATION_REF_TAG)
 				strbuf_addstr(sb, "tag: ");
 
-			strbuf_addstr(sb, decoration->name);
+			show_name(sb, decoration);
 
 			if (current_and_HEAD &&
 			    decoration->type == DECORATION_REF_HEAD) {
@@ -268,7 +266,7 @@ void format_decorations_extended(struct strbuf *sb,
 				strbuf_addstr(sb, " -> ");
 				strbuf_addstr(sb, color_reset);
 				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
-				strbuf_addstr(sb, current_and_HEAD->name);
+				show_name(sb, current_and_HEAD);
 			}
 			strbuf_addstr(sb, color_reset);
 
