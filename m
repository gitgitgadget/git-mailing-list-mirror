From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Thu, 14 May 2015 14:49:10 -0700
Message-ID: <xmqqfv6yj0dl.fsf@gitster.dls.corp.google.com>
References: <55534D95.60609@alum.mit.edu>
	<xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
	<xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
	<xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
	<20150514063317.GA22509@peff.net>
	<xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 23:49:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt10I-0006cf-2X
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbbENVtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:49:13 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34008 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161106AbbENVtM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:49:12 -0400
Received: by ieczm2 with SMTP id zm2so739592iec.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DWGm//X4TcvrzZDhpYqP3uYYaWYeuGvxt6M/u+i0Tvo=;
        b=yUs9/pWfT1QsF+FP2PsD+05BVxL1ueGDcM5KDlwRWBnfa2W0V+TGVy75BkfG2yEuuc
         /QFGfVB7SQm9KMIi9KXUZgIT3RyRQyIEBFywTEzqeeQIMntl2KCGpHs1HYlUztBBjNL8
         2LnL1TcyJ7jQVnIeB0cTM7ZxzoeUDe2dl91FmYLnjHiBjvuPwn49POAYTCWbiRPq9t+C
         saL1IC6xoSBjPR2dpLWSRnl5blzE/7QmoLi0W10KratwtKktJEknE4RxBT7izYnPaUA1
         1ziCDYiTvtuplicINGuVO/4vFgKvzknmDuqug84v9JA9PQxslJZz2n6921Q0lxTObiEQ
         6OWQ==
X-Received: by 10.42.100.15 with SMTP id y15mr17082773icn.16.1431640151975;
        Thu, 14 May 2015 14:49:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id rj5sm151130igc.2.2015.05.14.14.49.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 14:49:11 -0700 (PDT)
In-Reply-To: <xmqq8ucr83h8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 14 May 2015 10:37:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269105>

Junio C Hamano <gitster@pobox.com> writes:

> For example, we have this in commit.c:
>
>     const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
>     {
>             struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
>             if (sizep)
>                     *sizep = v->size;
>             return v->buffer;
>     }
>
> But if we do not have the "buffer" data cached for that commit (via
> an earlier call to set_commit_buffer()), we don't have to enlarge
> the slab, as we are not adding anything to the slab system with this
> call.

The change may look something like this.  I do not think it would
make a difference to the get_cached_commit_buffer() codepath (when
we use the commit->buffer, we pretty much know we use that for all
commits), though.

 commit-slab.h | 27 ++++++++++++++++++++++++---
 commit.c      |  7 ++++++-
 2 files changed, 30 insertions(+), 4 deletions(-)

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
index 65179f9..2d1901f 100644
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
