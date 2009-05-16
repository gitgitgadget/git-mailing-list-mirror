From: Daniel Cordero <theappleman@gmail.com>
Subject: [PATCH] builtin-checkout: Don't tell user that HEAD has moved
	before it has
Date: Sat, 16 May 2009 10:54:45 -0700
Message-ID: <20090516175444.GA1000@cumin.applehq.eu>
References: <20090516192531.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat May 16 19:55:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5O6X-0006Rf-Cq
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 19:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbZEPRyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 13:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbZEPRyN
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 13:54:13 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:21539 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbZEPRyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 13:54:12 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1518858wfd.4
        for <git@vger.kernel.org>; Sat, 16 May 2009 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=t8enQ365q2bixxvJgav88SG2QlSlSTdrDzIizVTptW0=;
        b=p9eL6VRN4nXndO9s7fQ/Nwe2k9DnIa8Kqj5kxiR1dZHLC6BicLMHpOXtmsLWXAXW7B
         QGB/3o83Wlf43libxZeTeYk/s/inJPPq44Zk+7xWM49YY8gW13mGoA0vCmmjWfPDgnA8
         Q5XnvvFcNaHgoZVh2EB18SvnVDm9lROgOv1dU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=N8+T+c6qes5pO9ykCNN/1kT8BHaqUmKuYwV5g8ZjUWXnws6bqek7OSFhTDw6V8Qn3B
         SQCESCBJe0aMnecFkIuE8B01eJsHlvOsd56YuWW9hXx6unbr5tW6NhdZMHvK7G6aeN0h
         HuNhK9GH7io/wIS/Bgv6fLDZiEZ8/+lnuzoTU=
Received: by 10.142.68.2 with SMTP id q2mr1437914wfa.223.1242496453256;
        Sat, 16 May 2009 10:54:13 -0700 (PDT)
Received: from cumin.applehq.eu (pool-72-67-228-190.lsanca.fios.verizon.net [72.67.228.190])
        by mx.google.com with ESMTPS id 24sm5252774wfc.37.2009.05.16.10.54.12
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 10:54:12 -0700 (PDT)
Mail-Followup-To: Daniel Cordero <theappleman@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090516192531.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.19 (2009-04-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119371>

Previously, checkout would tell the user this message before moving HEAD,
without regard to whether the upcoming move will result in success.
If the move failed, this causes confusion.

Show the message after the move, unless the move failed.

Signed-off-by: Daniel Cordero <theappleman@gmail.com>
---
 builtin-checkout.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index dc4bfb5..f2d7ef0 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -541,14 +541,6 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 		parse_commit(new->commit);
 	}
 
-	/*
-	 * If we were on a detached HEAD, but we are now moving to
-	 * a new commit, we want to mention the old commit once more
-	 * to remind the user that it might be lost.
-	 */
-	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
-		describe_detached_head("Previous HEAD position was", old.commit);
-
 	if (!old.commit && !opts->force) {
 		if (!opts->quiet) {
 			warning("You appear to be on a branch yet to be born.");
@@ -561,6 +553,14 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	if (ret)
 		return ret;
 
+	/*
+	 * If we were on a detached HEAD, but have now moved to
+	 * a new commit, we want to mention the old commit once more
+	 * to remind the user that it might be lost.
+	 */
+	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
+		describe_detached_head("Previous HEAD position was", old.commit);
+
 	update_refs_for_switch(opts, &old, new);
 
 	ret = post_checkout_hook(old.commit, new->commit, 1);
-- 
1.6.3.1.93.g8d138
