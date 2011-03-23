From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] tree-diff: make diff_tree_sha1 return void
Date: Tue, 22 Mar 2011 20:30:21 -0500
Message-ID: <20110323013021.GC10621@elie>
References: <cover.1300798069.git.johannes.schindelin@gmx.de>
 <91afab0d46939238dd7c90ea2902b02cae083316.1300798069.git.johannes.schindelin@gmx.de>
 <7v7hbrkovz.fsf@alter.siamese.dyndns.org>
 <20110323012654.GA10621@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 02:30:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Cu7-0005q7-Mo
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 02:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184Ab1CWBa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 21:30:27 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46127 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab1CWBaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 21:30:25 -0400
Received: by yia27 with SMTP id 27so3148349yia.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 18:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yTBOIJ87Jc9StdWMC9dfxu6DU/hz8SBS7Mr/hKFGuH0=;
        b=UhWqe9RjtDe2Ul6vRaKkpEilScYeXvkOwMp6FqTNRz505wu0rmAfDdFly9Yl6pjjoI
         ECFpvS3TByvwlOhnlZgmjOMYqgeykaNeu+EF2CoHq8arFgEbFYtUYMMtferdGQWxM0P0
         8G7GTF4V8SuTPWpCA0Wvi9Kw6YQ3EG2lc8isU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wARvqlgKLrYsCshhaPUC6kfWoofDageWt1hcZd+SXsAjPW1HGMUrjUaqdquv3D3K6g
         5vrT5RLlqMixZpiR0phZgbh+XUc8GvmzVY8UE+4oMcS44OTiTSGHe4SYTIrt+MQbj5l6
         Pw/EaQIx3V5wQZNLcEuLvsqprMn3vuJLUObR0=
Received: by 10.236.79.200 with SMTP id i48mr7951205yhe.317.1300843825091;
        Tue, 22 Mar 2011 18:30:25 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.sbcglobal.net [68.255.102.141])
        by mx.google.com with ESMTPS id x58sm543534yhn.6.2011.03.22.18.30.23
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 18:30:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110323012654.GA10621@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169794>

diff_tree_sha1 does not return -1 on errors; it die()s.  Now it would
obviously be lovely to change that so long-running programs could call
diff_tree_sha1 without fear, but until then, let's face the reality:

 - nobody has tested what would happen if it started returning
   instead of dying on failure;
 - the callers overwhelmingly ignore the return value.

Returning void also saves readers the trouble of checking
documentation each time they use diff_tree_sha1 to see if its return
value follows the GNU diff exit code convention.

So it's just more honest to return void.  Do so.

Noticed with gcc-4.6 -Wunused-but-set-variable (because one caller
couldn't decide --- it saves the return value, but never does anything
with it).

Noticed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 diff.h      |    2 +-
 revision.c  |    4 +---
 tree-diff.c |    6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/diff.h b/diff.h
index 4fde7f3..0a8a06c 100644
--- a/diff.h
+++ b/diff.h
@@ -165,7 +165,7 @@ extern void diff_tree_setup_paths(const char **paths, struct diff_options *);
 extern void diff_tree_release_paths(struct diff_options *);
 extern void diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		     const char *base, struct diff_options *opt);
-extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
+extern void diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
 extern int diff_root_tree_sha1(const unsigned char *new, const char *base,
                                struct diff_options *opt);
diff --git a/revision.c b/revision.c
index a6e78c9..0c810b4 100644
--- a/revision.c
+++ b/revision.c
@@ -329,9 +329,7 @@ static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct
 
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
-	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
-			   &revs->pruning) < 0)
-		return REV_TREE_DIFFERENT;
+	diff_tree_sha1(t1->object.sha1, t2->object.sha1, "", &revs->pruning);
 	return tree_difference;
 }
 
diff --git a/tree-diff.c b/tree-diff.c
index d1a7ae9..03b8ca0 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -17,7 +17,6 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 	const unsigned char *sha1, *sha2;
 	int cmp, pathlen1, pathlen2;
 	int old_baselen = base->len;
-	int retval = 0;
 
 	sha1 = tree_entry_extract(t1, &path1, &mode1);
 	sha2 = tree_entry_extract(t2, &path2, &mode2);
@@ -53,7 +52,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 				    sha1, sha2, base->buf, 0, 0);
 		}
 		strbuf_addch(base, '/');
-		retval = diff_tree_sha1(sha1, sha2, base->buf, opt);
+		diff_tree_sha1(sha1, sha2, base->buf, opt);
 	} else {
 		opt->change(opt, mode1, mode2, sha1, sha2, base->buf, 0, 0);
 	}
@@ -279,7 +278,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	q->nr = 1;
 }
 
-int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
+void diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
 {
 	void *tree1, *tree2;
 	struct tree_desc t1, t2;
@@ -301,7 +300,6 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	}
 	free(tree1);
 	free(tree2);
-	return 0;
 }
 
 int diff_root_tree_sha1(const unsigned char *new, const char *base, struct diff_options *opt)
-- 
1.7.4.1
