From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Fri, 22 May 2015 14:21:16 -0700
Message-ID: <xmqqmw0we2b7.fsf@gitster.dls.corp.google.com>
References: <55534D95.60609@alum.mit.edu>
	<xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
	<xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
	<xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
	<20150514063317.GA22509@peff.net>
	<xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
	<xmqqfv6yj0dl.fsf@gitster.dls.corp.google.com>
	<20150514215453.GA16897@peff.net>
	<xmqq7fsaiyoy.fsf@gitster.dls.corp.google.com>
	<20150514223313.GA21149@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 22 23:21:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvuNr-00043q-Di
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 23:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757737AbbEVVVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 17:21:22 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32854 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757652AbbEVVVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 17:21:19 -0400
Received: by igbpi8 with SMTP id pi8so1316794igb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QRvBQJpJVLqjJKJjvt1SJh1IBLC1gcNQCsRqlouku8Y=;
        b=HaD0KuJRMex2iMFNYv5VPU1GzC8I+uFMdFm1/5gVpFh44tg5LqoTXIleN+eskD50wm
         qvMcAgdQ37wVzb2Atyh0zmln1fSwnnLMcYEyvZzOy1vRTUN4/MFcw+TV7UccF4Oqeqcn
         OMuKpdkGbVh6GL01HcTJDIQsOINHtUyhAVJR2xUKzb1tfz3vc4EMDyDnKIk368SDOP87
         xXgnHtiiTEN2CoUMfiyvE5gNhrlEC/bAEjGSma/C7Kg4irqLTTZMuKCZYXbBWWrF/Fgm
         e19Wc5RU8o8rlpwQ/ZZOs53tmS5K+qJ1c0L0irVbqiavQKxCqq5NewIRjHtgQXvwCikP
         ZXxg==
X-Received: by 10.50.43.196 with SMTP id y4mr8259647igl.14.1432329678256;
        Fri, 22 May 2015 14:21:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id k186sm2657651ioe.37.2015.05.22.14.21.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 14:21:17 -0700 (PDT)
In-Reply-To: <20150514223313.GA21149@peff.net> (Jeff King's message of "Thu,
	14 May 2015 18:33:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269763>

Jeff King <peff@peff.net> writes:

> On Thu, May 14, 2015 at 03:25:33PM -0700, Junio C Hamano wrote:
>
>> @@ -90,6 +97,8 @@ static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
>>  									\
>>  	if (s->slab_count <= nth_slab) {				\
>>  		int i;							\
>> +		if (!add_if_missing)					\
>> +			return NULL;					\
>>  		s->slab = xrealloc(s->slab,				\
>>  				   (nth_slab + 1) * sizeof(*s->slab));	\
>>  		stat_ ##slabname## realloc++;				\
>
> This skips extending the list of slabs if we would go past the nth slab.
> But we don't fill in each slab in the first place. I.e., we may have 10
> slabs, but only s->slab[10] is non-NULL.
>
> A few lines below this, we xcalloc() it if necessary. I think that needs
> to respect add_if_missing, as well.

Yup, thanks.

>
>>  void unuse_commit_buffer(const struct commit *commit, const void *buffer)
>>  {
>> -	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
>> -	if (v->buffer != buffer)
>> +	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
>> +	if (v && v->buffer != buffer)
>>  		free((void *)buffer);
>>  }
>
> I think you want:
>
>   if (!v || v->buffer != buffer)
>
> here. IOW, we free it only if it is not our cached buffer, and it cannot
> be if we do not have a cached buffer. It may be easier to read by
> flipping the logic:
>
>   if (v && v->buffer == buffer)
> 	return; /* it is saved in the cache */
>   free((void *)buffer);
>
> Or some variation on that.

I ended up doing it as a variant of the latter, "free unless we have
v->buffer pointing at it".

Sorry for a long delay.

-- >8 --
Subject: [PATCH] commit-slab: introduce slabname##_peek() function

There is no API to ask "Does this commit have associated data in
slab?".  If an application wants to (1) parse just a few commits at
the beginning of a process, (2) store data for only these commits,
and then (3) start processing many commits, taking into account the
data stored (for a few of them) in the slab, the application would
use slabname##_at() to allocate a space to store data in (2), but
there is no API other than slabname##_at() to use in step (3).  This
allocates and wasts new space for these commits the caller is only
interested in checking if they have data stored in step (2).

Introduce slabname##_peek(), which is similar to slabname##_at() but
returns NULL when there is no data already associated to it in such
a use case.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-slab.h | 34 +++++++++++++++++++++++++++++-----
 commit.c      | 28 ++++++++++++++++++++--------
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/commit-slab.h b/commit-slab.h
index 375c9c7..9d12ce2 100644
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
@@ -97,10 +106,25 @@ static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
 			s->slab[i] = NULL;				\
 		s->slab_count = nth_slab + 1;				\
 	}								\
-	if (!s->slab[nth_slab])						\
+	if (!s->slab[nth_slab]) {					\
+		if (!add_if_missing)					\
+			return NULL;					\
 		s->slab[nth_slab] = xcalloc(s->slab_size,		\
 					    sizeof(**s->slab) * s->stride);		\
-	return &s->slab[nth_slab][nth_slot * s->stride];				\
+	}								\
+	return &s->slab[nth_slab][nth_slot * s->stride];		\
+}									\
+									\
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
 }									\
 									\
 static int stat_ ##slabname## realloc
diff --git a/commit.c b/commit.c
index 65179f9..5fb9496 100644
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
+	if (!(v && v->buffer == buffer))
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
-- 
2.4.1-449-g1f6c7df
