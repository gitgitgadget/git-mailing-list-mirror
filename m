From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/24] packed-ref cache: forbid dot-components in refnames
Date: Wed, 1 Oct 2014 19:16:52 -0700
Message-ID: <20141002021652.GJ1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:17:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVwx-0004ql-Lq
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbaJBCQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:16:56 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48403 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaJBCQz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:16:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so1369395pad.33
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ypab3d4ZuKXMaB1C7kzVrwU4wwrSaVmcSA+/orkddXA=;
        b=OtyjNax4bwGtOmdLQUz2kpYqSzE0xI/Ozsftf+biqweCHN92FROgqf54/gfer2vfOV
         o2ajZHGqOiibWxjUnXPVeN0dHN/+oeLod4ZqFijpkINKHcmcaQfctaR4WFu6rfmQ9PCE
         n7L/NeErQM0CrvEvCp371hKpt703/mZTlCBfSOkFs4Tu9Ue4ZDR11+BrYRiOdsuaY8D2
         sVqWnVBVoY1z52v6L0Yxf3xtupBBfdq2N9xSzf73H0IbAsogVIyQK2RsPd1Ns5fryEEe
         1O01VDggBPwYiM9lCNK6h7TVxHssZInLx/9oSZSqMjob9Q2I0qG/+uRlmnv8lRfsylJh
         u4pQ==
X-Received: by 10.68.162.3 with SMTP id xw3mr82684423pbb.142.1412216215151;
        Wed, 01 Oct 2014 19:16:55 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ix1sm2096551pbc.60.2014.10.01.19.16.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:16:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257788>

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
Noticed while reviewing other patches.

 refs.c | 14 +++-----------
 refs.h |  6 +-----
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 490e788..94d6d89 100644
--- a/refs.c
+++ b/refs.c
@@ -69,16 +69,8 @@ static int check_refname_component(const char *refname, int flags)
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
 	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
 		return -1; /* Refname ends with ".lock". */
 	return cp - refname;
@@ -288,7 +280,7 @@ static struct ref_entry *create_ref_entry(const char *refname,
 	struct ref_entry *ref;
 
 	if (check_name &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
diff --git a/refs.h b/refs.h
index b62c4c4..e48d8b9 100644
--- a/refs.h
+++ b/refs.h
@@ -226,7 +226,6 @@ extern int for_each_reflog(each_ref_fn, void *);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
-#define REFNAME_DOT_COMPONENT 4
 
 /*
  * Return 0 iff refname has the correct format for a refname according
@@ -234,10 +233,7 @@ extern int for_each_reflog(each_ref_fn, void *);
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
