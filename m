From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Interpretation of '/' changed sparse-checkout
Date: Thu, 24 May 2012 21:28:58 +0700
Message-ID: <20120524142858.GA10938@do>
References: <loom.20120521T183651-286@post.gmane.org>
 <loom.20120523T160215-390@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Marchent <cmarchent@aminocom.com>
X-From: git-owner@vger.kernel.org Thu May 24 16:33:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXZ68-0003TY-Bt
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731Ab2EXOc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:32:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48265 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab2EXOc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:32:58 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so334617pbb.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/KwFI/aC8L+t1zS8sj3c1EOpR++O+KnZnsQbspt2FDM=;
        b=Yv8scjWwyE+wuKEHo5fIEExPzfr50/pCAbbZFPb5WOWM/FMa22FONs86Ftilv9g2/o
         aHzae19VqkULXWIpzsrl8rAEbcae5C6s4EibVHzPXUhEGJ7OqYq66eQQ+gsakDpZIc8E
         cPqs88D6FgDG0cJjcArtGpXUIQBWhZ/f2zJxcFtCG7hdnlnQ6g5dtotuwiZu6IlDR3pW
         d3LnuHzP1lHRSRMgmBDQJHcEgMuwBWFz2kHD1dawp2zJOZW2pYfxj9mVriv8nTn91o5v
         gl3wzUExm4btetzmFzMnaVdg1qrZu/h0UU3lOZv5n2W95d6NPAkDBfdQhDqxmFOP/ize
         Fw6Q==
Received: by 10.68.191.68 with SMTP id gw4mr21816499pbc.135.1337869977896;
        Thu, 24 May 2012 07:32:57 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.39.86])
        by mx.google.com with ESMTPS id ub1sm5632918pbc.68.2012.05.24.07.32.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:32:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 May 2012 21:28:58 +0700
Content-Disposition: inline
In-Reply-To: <loom.20120523T160215-390@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198385>

Hi,

On Wed, May 23, 2012 at 02:09:24PM +0000, Caleb Marchent wrote:
> Caleb Marchent <cmarchent <at> aminocom.com> writes:
> 
> Corrected cut-paste errors on first submission, seems I missed a bunch of 
> terminating '/' when hand-copying the text in from the sparse-checkout files :-( 
> Sorry.
> 
> I have a system where I checkout by default everything except one directory. 
> Then the rules in the top-level sources can selectivly reintroduce 
> subdirectories as required for the build target.
> I have deployed, using git 1.7.2.5, a set of git trees which use the following 
> sparse-checkout rules to achieve this.
> 
> /
> !exclude/
> exclude/reinclude/
> 
> 
> I have however discovered that if the reincluded directory is the same as the 
> first part of any other path then that path will also be checked out.
>  
> /
> !exlcude/
> exclude/wanted/
> 
>  
> will checkout both:
> 
> exclude/wanted/
> exclude/wanted_not/
> 
> 
> This appears to have bee fixed in git 1.7.10.2 but from that version of git 
> onwards using '/' to request everything and then exclude a specific directory 
> from it no longer works.

As a user I agree that "/" should mean "everything under the sky" and
your use case should work (i.e. it is broken in 1.7.10.2). If you can
build git, you can try the patch below. I'll submit a patch for
inclusion to git later (perhaps with optimization for this special case).

-- 8< --
diff --git a/unpack-trees.c b/unpack-trees.c
index bcee99c..188c196 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -838,7 +838,8 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	int dtype = DT_DIR;
 	int ret = excluded_from_list(prefix, prefix_len, basename, &dtype, el);
 
-	prefix[prefix_len++] = '/';
+	if (prefix_len)
+		prefix[prefix_len++] = '/';
 
 	/* If undecided, use matching result of parent dir in defval */
 	if (ret < 0)
@@ -953,10 +954,12 @@ static int clear_ce_flags(struct cache_entry **cache, int nr,
 			    struct exclude_list *el)
 {
 	char prefix[PATH_MAX];
-	return clear_ce_flags_1(cache, nr,
-				prefix, 0,
-				select_mask, clear_mask,
-				el, 0);
+	*prefix = '\0';
+	return clear_ce_flags_dir(cache, nr,
+				  prefix, 0,
+				  "",
+				  select_mask, clear_mask,
+				  el, 0);
 }
 
 /*

-- 8< --

>  
> While I have been able to contrive the same effect with recent versions of git 
> using the following updated sparse-checkout rules
>  
> /*
> !exclude/
> exclude/reinclude/
> 
>  
> Even with this work-around there are two problems:
> 
> 1) If I have a path: exclude/reinclude/exclude, this will now be exluded where 
> I would expect it to be included as it was with 1.7.2.5
>  
> 2) I have a large number of deployed trees across a number of machines that 
> have the existing format which will break when git operations are performed 
> after a upgrade to the latest git.
>  
> I believe that the interpretation of '/' should be 'everything in the repo', 
> from which later rules can exclude. I think this is a bug in recent versions 
> of git. I have been working on some ideas for a fix to the git code based along 
> these lines. Can anyone confirm if my analysis is correct or provide an 
> alternate solution?
>  
> Also I would like to know if anyone knows the solution to point 1) above as 
> this also blocks upgrading to the latest version of git.

-- 
Duy
