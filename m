From: David Aguilar <davvid@gmail.com>
Subject: Re: Where is information of "git read-tree" stored?
Date: Sun, 25 Sep 2011 03:30:45 +0200
Message-ID: <20110925013043.GB19780@gmail.com>
References: <loom.20110919T103707-867@post.gmane.org>
 <7vzki0a0yd.fsf@alter.siamese.dyndns.org>
 <j586pb$emh$1@dough.gmane.org>
 <7vobyg89rh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Sun Sep 25 03:30:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7dXp-000709-Vu
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 03:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab1IYB35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 21:29:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49813 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab1IYB34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 21:29:56 -0400
Received: by wyg34 with SMTP id 34so4972730wyg.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kFRiPnHWY+//bcKV7ujM7Ith9oGzS+JPSo87DXa7Xg0=;
        b=DyRTmWGUYLkigb2XdPPguBSsJYG7Klpqhj6wdNHscNpHDtf0ZDwRZbsunDFwRa+AUF
         PW2JIrHYxkYlL6Z6q6Sa3VQ7rOT4rFJadAvGYXPQueZmD7hWdPj6hL8pVw+VGCY3wP1c
         QK+p37vOvLVzOrerL9oR9kctKaVCZwZG2yUXY=
Received: by 10.227.147.84 with SMTP id k20mr4001602wbv.71.1316914195102;
        Sat, 24 Sep 2011 18:29:55 -0700 (PDT)
Received: from gmail.com (172.Red-83-60-36.dynamicIP.rima-tde.net. [83.60.36.172])
        by mx.google.com with ESMTPS id o7sm23729520wbh.8.2011.09.24.18.29.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 18:29:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobyg89rh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182052>

On Mon, Sep 19, 2011 at 03:09:22PM -0700, Junio C Hamano wrote:
> 
> To a certain degree, the point of a tool is that the user does not need to
> know about the details, but if you are interested...

git-subtree allows you to not have to know about the details:

https://github.com/apenwarr/git-subtree

https://github.com/apenwarr/git-subtree/blob/master/git-subtree.txt

git-subtree, combined with Junio's wonderful write-up below,
should get you on the right track.


> Suppose you have this tree structure in your "original" project:
> 
>         Documentation/README.txt
>         hello.c
> 	Makefile
> 
> and then somebody else has this structure in his project (in your case, it
> may happen to be stored in SVN but once it is slurped in a git repository,
> it does not matter):
> 
>         goodbye.c
> 	Makefile
> 
> Further suppose that you would want to end up with this tree structure:
> 
>         Documentation/README.txt
> 	Makefile
>         hello.c
>         imported/Makefile
>         imported/goodbye.c
> 
> i.e. you would want to move stuff that came from the other project in imported/
> hierarchy.  There may be many other files, and even subdirectories, in the
> other project, but they all are shifted one level down and placed in imported/
> hierarchy.
> 
> The first four steps of the howto is to create such a final tree structure
> and make a merge commit out of that tree.
> 
> After you update your project (which now has both the original files such
> as hello.c etc., may have added new files, and may even have updated stuff
> inside imported/ hierarchy) and the other side updated their project (e.g.
> it may have updated goodbye.c whose change you would want to carry over to
> your imported/goodbye.c, or it may have added a new file welcome.c, which
> you would want to import as imported/welcome.c), you would invoke "pull -s
> subtree", which in turn runs "merge -s subtree".
> 
> The subtree strategy first compares the shapes of two trees being merged,
> and tries to find how much they have to be shifted to match.  Your tree
> may now have:
> 
>         Documentation/README.txt
> 	Makefile
> 	hello.h (added)
>         hello.c
>         imported/Makefile
>         imported/goodbye.c
> 
> while the other side may now have:
> 
>         goodbye.c
> 	Makefile
> 	welcome.c
> 
> The subtree strategy notices that by prefixing "imported/" in front of the
> paths, the tree from the other side will match the shape of the subtree
> you have under "imported/". Thus it can pair:
> 
> 	their "goodbye.c" with your "imported/goodbye.c"
>         their "Makefile" with your "imported/Makefile"
>         their "welcome.c" with your "imported/welcome.c"
> 
> and merge the changes. The common ancestor commit of this merge will be
> the initial merge you made with the first 4-step, so the three-way merge
> logic would notice that there wasn't "welcome.c" in the beginning, they
> added that path, while you did not do anything to the path that
> corresponds to it (namely, "imported/welcome.c"), so the new "welcome.c"
> file from the other project would simply be copied as "imported/welcome.c"
> to your tree, and the change they made to "goodbye.c" and your changes you
> made to your "imported/goodbye.c" will be merged and result is recorded in
> your "imported/goodbye.c".
> 
> If "compares the shape and figures out how much to shift" makes you feel
> uneasy (and it probably should), you can give an explicit directory prefix 
> as the backend option "subtree" (see "git merge help" for details).

-- 
					David
