From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git checkout under 1.7.6 does not properly list untracked
 files and aborts
Date: Wed, 21 Sep 2011 18:58:42 +1000
Message-ID: <20110921085842.GA29768@duynguyen-vnpc>
References: <4E6A7167.6070408@workspacewhiz.com>
 <4E779BA4.8070109@workspacewhiz.com>
 <4E78ACE2.60306@drmicha.warpmail.net>
 <4E78DACF.3030200@workspacewhiz.com>
 <4E7996AA.4040909@drmicha.warpmail.net>
 <4E79A04B.7080607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 21 10:58:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Idu-0004To-GK
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 10:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab1IUI6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 04:58:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54278 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab1IUI6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 04:58:51 -0400
Received: by ywb5 with SMTP id 5so964874ywb.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T1i4gV1nC94D4URi5oz3kF9Gwfjq4GGtgayIq8thWR8=;
        b=dcdhJD9Pz8yxrTkk/3VGi0qnC7C+WXlUwWlz6PsCT/Xajv5RUCxsQkLtid0qbjVA31
         diWbyP6lQez+XGJf/Sf+b0h5gE5Iq+WxKSo/uLgh+cYomiANmF5Dt0gDBoVTH05IrmK5
         rXaqPuHaYY7GCyqyCYAeWya18b68c8FushhyE=
Received: by 10.150.177.14 with SMTP id z14mr671783ybe.12.1316595531120;
        Wed, 21 Sep 2011 01:58:51 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id c9sm1041581yba.13.2011.09.21.01.58.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Sep 2011 01:58:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 21 Sep 2011 18:58:42 +1000
Content-Disposition: inline
In-Reply-To: <4E79A04B.7080607@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181827>

On Wed, Sep 21, 2011 at 10:28:59AM +0200, Michael J Gruber wrote:
> So, I bisected it. The first bad commit is
> 
> 9037026 (unpack-trees: fix sparse checkout's "unable to match
> directories", 2010-11-27)
> 
> although the real culprit may be its predecessor
> 
> 2431afb (unpack-trees: move all skip-worktree checks back to
> unpack_trees(), 2010-11-27)
> 
> which does not compile:
> 
>     CC unpack-trees.o
> unpack-trees.c: In function 'mark_new_skip_worktree':
> unpack-trees.c:852:75: error: 'o' undeclared (first use in this function)
> unpack-trees.c:852:75: note: each undeclared identifier is reported only
> once for each function it appears in
> make: *** [unpack-trees.o] Error 1

This may help

--8<--
diff --git a/unpack-trees.c b/unpack-trees.c
index a6518db..a239af7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -245,13 +245,13 @@ static int check_updates(struct unpack_trees_options *o)
 static int verify_uptodate_sparse(struct cache_entry *ce, struct unpack_trees_options *o);
 static int verify_absent_sparse(struct cache_entry *ce, enum unpack_trees_error_types, struct unpack_trees_options *o);
 
-static int will_have_skip_worktree(const struct cache_entry *ce, struct unpack_trees_options *o)
+static int will_have_skip_worktree(const struct cache_entry *ce, struct exclude_list *el)
 {
 	const char *basename;
 
 	basename = strrchr(ce->name, '/');
 	basename = basename ? basename+1 : ce->name;
-	return excluded_from_list(ce->name, ce_namelen(ce), basename, NULL, o->el) <= 0;
+	return excluded_from_list(ce->name, ce_namelen(ce), basename, NULL, el) <= 0;
 }

 static int apply_sparse_checkout(struct cache_entry *ce, struct unpack_trees_options *o)
@@ -849,7 +849,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
 
-		if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
+		if (!ce_stage(ce) && will_have_skip_worktree(ce, el))
 			ce->ce_flags |= skip_wt_flag;
 		else
 			ce->ce_flags &= ~skip_wt_flag;
--8<--

> Duy, sorry for prodding you again.

No problem (and sorry for breaking the build). I'll also have a look
at this problem.
