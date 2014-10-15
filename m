From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/25] packed-ref cache: forbid dot-components in refnames
Date: Tue, 14 Oct 2014 17:53:23 -0700
Message-ID: <20141015005323.GV32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:53:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCqJ-0003Zr-BP
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbaJOAx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:53:27 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:51172 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932660AbaJOAx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:53:26 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so236096pad.15
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AhhaOcDuCuRhKm0VdpLCTj/5U6oG6W/OiJXY1mutc5c=;
        b=PSw3xkc5JALKQ3qMPMLx1kJgSI7rPwtFQ4H64PMEzDwgBhrk6LsH/I+zjo4Sgggiyx
         FZX+7loxk/UwkPgh1J7QF3cUBLHebKXyPi1lvxa0pDq8V0D17E6JNsVnrP1w4yb5qkBy
         juWm4LcGx6SQOwOiXX1BeugqaF/Z5fQFSW5VkKanCLlfoL3q6cL7yApCEv+eZQKOzuZj
         jieDXwj7jmMIVQP1rBzhg1pBFEypk5H8eI+RpUlLFYPtEsQGdSTtYwQABKrgdyXR2x/0
         I+YnQMAPtqGX+eWsuN5RWaqD7EuNg5vKbwymr0QrxnwAK7wsSCC0KZsLfW+w2fG9Bezf
         j0Yw==
X-Received: by 10.70.94.199 with SMTP id de7mr8892411pdb.3.1413334406425;
        Tue, 14 Oct 2014 17:53:26 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id fn2sm15323829pdb.75.2014.10.14.17.53.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:53:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Date: Fri, 26 Sep 2014 12:22:22 -0700

Since v1.7.9-rc1~10^2 (write_head_info(): handle "extra refs" locally,
2012-01-06), this trick to keep track of ".have" refs that are only
valid on the wire and not on the filesystem is not needed any more.

Simplify by removing support for the REFNAME_DOT_COMPONENT flag.

This means we'll be slightly stricter with invalid refs found in a
packed-refs file or during clone.  read_loose_refs() already checks
for and skips refnames with .components so it is not affected.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 14 +++-----------
 refs.h |  6 +-----
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 4fe263e..fe1352a 100644
--- a/refs.c
+++ b/refs.c
@@ -70,16 +70,8 @@ static int check_refname_component(const char *refname, int flags)
 out:
 	if (cp == refname)
 		return 0; /* Component has zero length. */
-	if (refname[0] == '.') {
-		if (!(flags & REFNAME_DOT_COMPONENT))
-			return -1; /* Component starts with '.'. */
-		/*
-		 * Even if leading dots are allowed, don't allow "."
-		 * as a component (".." is prevented by a rule above).
-		 */
-		if (refname[1] == '\0')
-			return -1; /* Component equals ".". */
-	}
+	if (refname[0] == '.')
+		return -1; /* Component starts with '.'. */
 	if (cp - refname >= LOCK_SUFFIX_LEN &&
 	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
 		return -1; /* Refname ends with ".lock". */
@@ -290,7 +282,7 @@ static struct ref_entry *create_ref_entry(const char *refname,
 	struct ref_entry *ref;
 
 	if (check_name &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
diff --git a/refs.h b/refs.h
index 79802d7..c61b8f4 100644
--- a/refs.h
+++ b/refs.h
@@ -229,7 +229,6 @@ extern int for_each_reflog(each_ref_fn, void *);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
-#define REFNAME_DOT_COMPONENT 4
 
 /*
  * Return 0 iff refname has the correct format for a refname according
@@ -237,10 +236,7 @@ extern int for_each_reflog(each_ref_fn, void *);
  * If REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
  * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
  * allow a "*" wildcard character in place of one of the name
- * components.  No leading or repeated slashes are accepted.  If
- * REFNAME_DOT_COMPONENT is set in flags, then allow refname
- * components to start with "." (but not a whole component equal to
- * "." or "..").
+ * components.  No leading or repeated slashes are accepted.
  */
 extern int check_refname_format(const char *refname, int flags);
 
-- 
2.1.0.rc2.206.gedb03e5
