From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git bug(?) for commit baf18fc261ca475343fe3cb9cd2c0dded4bc1bb7
Date: Mon, 7 Nov 2011 17:41:28 +0700
Message-ID: <20111107104128.GA2964@do>
References: <BC404302028E4B6F8F2C27DC8E63545F@gmail.com>
 <CACsJy8C25qurZwTLuuZ8X4EUzg-NP_qwFjcPTZoEs7QOOS-WBA@mail.gmail.com>
 <841269128C1D4788816CA66A33ED39E5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tony Wang <wwwjfy@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 11:42:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNMfF-00012l-11
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 11:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab1KGKmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 05:42:47 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39880 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab1KGKmr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 05:42:47 -0500
Received: by iage36 with SMTP id e36so5706130iag.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 02:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nGQfJQgMCPq9D0IbPhdRyCq92105pCGQfi1hpTRIEL8=;
        b=B1bTCIwLjMOmeGe4UWp22x7nZIJU5BTvTgzKUL22IL7hJErXNp3B0purRZRjIAC9Lo
         d/1Nr6vK7lI7B7aSFz+Qqw+uelVxjIuqXj+Z3iK3mV3CdYk8CXxDaFr0He4Sf6Dnv11E
         PNJeJcdwfW4JW5UnPK1/JCyLIGPqI76wwO+8Y=
Received: by 10.231.64.78 with SMTP id d14mr10572548ibi.56.1320662566602;
        Mon, 07 Nov 2011 02:42:46 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.33])
        by mx.google.com with ESMTPS id km16sm35415545pbb.9.2011.11.07.02.42.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 02:42:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 07 Nov 2011 17:41:28 +0700
Content-Disposition: inline
In-Reply-To: <841269128C1D4788816CA66A33ED39E5@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184972>

On Mon, Nov 07, 2011 at 05:48:25PM +0800, Tony Wang wrote:
> > It was on purpose. HEAD may contain a tag, in which case
> > lookup_commit() would to return a commit fail while
> > lookup_commit_reference() can peel the tag to the commit.
> 
> However, I tried to make it lookup_commit and it worked as expected. I'll try to read some detail. 

and the strange value of branch "s/origin/b" in your previous message..

> > 
> > > I tried to debug, and found after this
> > > merge.c:1104
> > > head_commit = lookup_commit_or_die(head_sha1, "HEAD");
> > > the variable branch becomes "s/origin/b", which is previously "b".

..led me to think that it's because branch points to the static buffer
returned by by resolve_ref().

lookup_commit_reference() may call resolve_ref() again and change the
buffer value, which also changes "branch" variable.

So, does this help?

-- 8< --
diff --git a/builtin/merge.c b/builtin/merge.c
index 581f494..4f20833 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1029,7 +1029,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch = resolve_ref("HEAD", head_sha1, 0, &flag);
+	branch = xstrdup(resolve_ref("HEAD", head_sha1, 0, &flag));
 	if (branch && !prefixcmp(branch, "refs/heads/"))
 		branch += 11;
 	if (!branch || is_null_sha1(head_sha1))
-- 8< --
-- 
Duy
