From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] unpack-trees: don't update files with CE_WT_REMOVE set
Date: Sat, 18 Jul 2015 15:37:19 +0700
Message-ID: <20150718083719.GA19676@lanh>
References: <xmqqk2ty1reo.fsf@gitster.dls.corp.google.com>
 <1437167967-5933-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anatole Shaw <git-devel@omni.poc.net>,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 10:36:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGNbi-0006Wj-7j
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 10:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712AbbGRIgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 04:36:25 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34945 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbbGRIgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 04:36:23 -0400
Received: by pabkd10 with SMTP id kd10so1010335pab.2
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q/w9V6AjgWnN4QSJKEccEsntK8VdFo44QQpdqjvLm4c=;
        b=GxtQsPBxuA+/IirOfNR+7WNUN0VRLdxMqMLlA/8Egm+7hV72OUZfxw6/Dq+fEvM7WK
         2BptUkDLXfIrjj6p381zLZTW3VHAM6GaKVU5FZ/f/+jOlD/H2rUg+HgB0DYG6LtWkdEr
         LPTTOSZkfoFh/SFsc+d8dc0skfo3MAuElmE8710PsrWIpa2Qi3UnVly+bHfjgzzZUdiE
         mN8r7HpQbYffkZ8qdZpLBWyudNiRW3Zxi04iIbXilfrT5TLjkUukjsmazaz4bdQMuPZB
         /jLsOZqlrs2eJNuxBFs1xzvC8mm6ZWj/ctptyiWMFea9rJ1MEZXX1/POHvu79sGW0oj/
         rZMQ==
X-Received: by 10.66.159.1 with SMTP id wy1mr38055158pab.103.1437208583443;
        Sat, 18 Jul 2015 01:36:23 -0700 (PDT)
Received: from lanh ([115.73.55.71])
        by smtp.gmail.com with ESMTPSA id u2sm13577037pbs.88.2015.07.18.01.36.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2015 01:36:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 18 Jul 2015 15:37:19 +0700
Content-Disposition: inline
In-Reply-To: <1437167967-5933-1-git-send-email-dturner@twopensource.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274158>

On Fri, Jul 17, 2015 at 05:19:27PM -0400, David Turner wrote:
> Don't update files in the worktree from cache entries which are
> flagged with CE_WT_REMOVE.
> 
> When a user does a sparse checkout, git removes files that are marked
> with CE_WT_REMOVE (because they are out-of-scope for the sparse
> checkout). If those files are also marked CE_UPDATE (for instance,
> because they differ in the branch that is being checked out and the
> outgoing branch), git would previously recreate them.  This patch
> prevents them from being recreated.
> 
> These erroneously-created files would also interfere with merges,
> causing pre-merge revisions of out-of-scope files to appear in the
> worktree.

Thank you both for catching this. Just a small suggestion. Perhaps we
should do this instead. apply_sparse_checkout() is the function where
all "action" manipulation (add, delete, update files..) for sparse
checkout occurs and it should not ask to delete and update both at the
same time.

-- 8< --
diff --git a/unpack-trees.c b/unpack-trees.c
index 2927660..d6cf849 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -224,6 +224,9 @@ static int check_updates(struct unpack_trees_options *o)
 		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_UPDATE) {
+			if (ce->ce_flags & CE_WT_REMOVE)
+				die("BUG: both update and delete flags are set on %s",
+				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
@@ -293,6 +296,7 @@ static int apply_sparse_checkout(struct index_state *istate,
 		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
 			return -1;
 		ce->ce_flags |= CE_WT_REMOVE;
+		ce->ce_flags &= ~CE_UPDATE;
 	}
 	if (was_skip_worktree && !ce_skip_worktree(ce)) {
 		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
-- 8< --

--
Duy
