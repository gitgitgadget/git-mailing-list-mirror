From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Thu, 14 May 2015 15:25:33 -0700
Message-ID: <xmqq7fsaiyoy.fsf@gitster.dls.corp.google.com>
References: <55534D95.60609@alum.mit.edu>
	<xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
	<xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
	<xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
	<20150514063317.GA22509@peff.net>
	<xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
	<xmqqfv6yj0dl.fsf@gitster.dls.corp.google.com>
	<20150514215453.GA16897@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 15 00:25:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt1ZV-0006Y4-RT
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 00:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbbENWZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 18:25:36 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37231 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030200AbbENWZf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 18:25:35 -0400
Received: by igbsb11 with SMTP id sb11so85629565igb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9J0s5MenSkRXHBTwrkVNPgxPM7OCQUclRgi5rgfzLuI=;
        b=oUQ5psw4hbd6EE2nCUFLqlkw3gtBkobo0nRq1QNwXWh6v28cx51YENhu5kZ4+3Dyx3
         jqGR1uWBwQBCjrQPL25mskps7dv2PFec5vBtx7GicNatHfSKO1aQDEydMiDu5mERVWsk
         LH1dKeIZKDqABMP5jvkKrz2Lm5sGbvi7t3tIXBXC+GYMvW31xTkJK5mScNeFrCTeHJFn
         p0yDLzdvBNeiKJ0Qx2TtLBPXwmLSIiVGvY4sh1PqC0dUCb3k1JGRD1tVQA5QZP9MQvKD
         0x+ehx4NezDIrG7+AQA3uUUAjkgPIPNB3yQJVAiLiI9aJR1oFQJ6RdilWvvkXnJuX2UU
         hYwQ==
X-Received: by 10.43.39.1 with SMTP id tk1mr15509501icb.26.1431642334866;
        Thu, 14 May 2015 15:25:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id d15sm25286igo.8.2015.05.14.15.25.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 15:25:34 -0700 (PDT)
In-Reply-To: <20150514215453.GA16897@peff.net> (Jeff King's message of "Thu,
	14 May 2015 17:54:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269114>

Jeff King <peff@peff.net> writes:

>> The change may look something like this.  I do not think it would
>> make a difference to the get_cached_commit_buffer() codepath (when
>> we use the commit->buffer, we pretty much know we use that for all
>> commits), though.
>
> I'm not sure that's true. Most of the _users_ of the commit buffer will
> try to look in the cache, and if it's not there, do a one-off read.  But
> they don't attach the result to the commit; they throw it away. The
> reasoning is that we don't have a cached buffer because we are going to
> look at a lot of commits (i.e., save_commit_buffer is off).
>
> So basically anytime save_commit_buffer is off (e.g., in rev-list) we
> are expanding the slab unnecessarily, even though literally nobody will
> write to it.
> ...
> I think you need matching changes in unused_commit_buffer and
> free_commit_buffer. And detach_commit_buffer, too, I guess. Basically
> everywhere except set_commit_buffer would want to use the peek version.

Yeah, I didn't consider the "we are not using buffer but are still
calling into the slab code" case at all.

The other two slabs (indegree and author) in commit.c are used only
when needed, and when they are used they are fully populated anyway,
so I think this patch covers that file fully.

There are saved_parents slab used in revision.c and ref_bitmap slab
used in shallow.c; they may also need similar fixups to save memory.

 commit-slab.h | 27 ++++++++++++++++++++++++---
 commit.c      | 28 ++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/commit-slab.h b/commit-slab.h
index 375c9c7..3334ab2 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -15,7 +15,13 @@
  * - int *indegree_at(struct indegree *, struct commit *);
  *
  *   This function locates the data associated with the given commit in
- *   the indegree slab, and returns the pointer to it.
+ *   the indegree slab, and returns the pointer to it.  The location to
+ *   store the data is allocated as necessary.
+ *
+ * - int *indegree_peek(struct indegree *, struct commit *);
+ *
+ *   This function is similar to indegree_at(), but it will return NULL
+ *   until a call to indegree_at() was made for the commit.
  *
  * - void init_indegree(struct indegree *);
  *   void init_indegree_with_stride(struct indegree *, int);
@@ -80,8 +86,9 @@ static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
 	s->slab = NULL;							\
 }									\
 									\
-static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
-				       const struct commit *c)		\
+static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
+						  const struct commit *c, \
+						  int add_if_missing)   \
 {									\
 	int nth_slab, nth_slot;						\
 									\
@@ -90,6 +97,8 @@ static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
 									\
 	if (s->slab_count <= nth_slab) {				\
 		int i;							\
+		if (!add_if_missing)					\
+			return NULL;					\
 		s->slab = xrealloc(s->slab,				\
 				   (nth_slab + 1) * sizeof(*s->slab));	\
 		stat_ ##slabname## realloc++;				\
@@ -103,6 +112,18 @@ static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
 	return &s->slab[nth_slab][nth_slot * s->stride];				\
 }									\
 									\
+static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
+					     const struct commit *c)	\
+{									\
+	return slabname##_at_peek(s, c, 1);				\
+}									\
+									\
+static MAYBE_UNUSED elemtype *slabname## _peek(struct slabname *s,	\
+					     const struct commit *c)	\
+{									\
+	return slabname##_at_peek(s, c, 0);				\
+}									\
+									\
 static int stat_ ##slabname## realloc
 
 /*
diff --git a/commit.c b/commit.c
index 65179f9..4f2ce9f 100644
--- a/commit.c
+++ b/commit.c
@@ -244,7 +244,12 @@ void set_commit_buffer(struct commit *commit, void *buffer, unsigned long size)
 
 const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
 {
-	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	if (!v) {
+		if (sizep)
+			*sizep = 0;
+		return NULL;
+	}
 	if (sizep)
 		*sizep = v->size;
 	return v->buffer;
@@ -271,24 +276,31 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 
 void unuse_commit_buffer(const struct commit *commit, const void *buffer)
 {
-	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
-	if (v->buffer != buffer)
+	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	if (v && v->buffer != buffer)
 		free((void *)buffer);
 }
 
 void free_commit_buffer(struct commit *commit)
 {
-	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
-	free(v->buffer);
-	v->buffer = NULL;
-	v->size = 0;
+	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	if (v) {
+		free(v->buffer);
+		v->buffer = NULL;
+		v->size = 0;
+	}
 }
 
 const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 {
-	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	void *ret;
 
+	if (!v) {
+		if (sizep)
+			*sizep = 0;
+		return NULL;
+	}
 	ret = v->buffer;
 	if (sizep)
 		*sizep = v->size;
