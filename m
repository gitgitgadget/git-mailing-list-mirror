From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] merge-recursive: leave unmerged entries in the index.
Date: Sun, 11 Dec 2005 10:25:31 +0100
Message-ID: <20051211092531.GA4919@c165.ib.student.liu.se>
References: <7vek4ktai1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 10:26:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElNSk-000543-Rd
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 10:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbVLKJZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 04:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbVLKJZj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 04:25:39 -0500
Received: from [85.8.31.11] ([85.8.31.11]:52173 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161106AbVLKJZj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 04:25:39 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 97CEA40FF; Sun, 11 Dec 2005 10:35:50 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1ElNSV-0003x7-00; Sun, 11 Dec 2005 10:25:31 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek4ktai1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13492>

On Sat, Dec 10, 2005 at 10:26:30PM -0800, Junio C Hamano wrote:
> This does two things.
> 
>  - When one branch renamed and the other branch did not, the
>    resulting half-merged file in the working tree used to swap
>    branches around and showed as if renaming side was "ours".
>    This was confusing and inconsistent (even though the conflict
>    markers were marked with branch names, it was not a good
>    enough excuse).  This changes the order of arguments to
>    mergeFile in such a case to make sure we always see "our"
>    change between <<< and ===, and "their" change between ===
>    and >>>.
> 
>  - When both branches renamed to the same path, and when one
>    branch renamed and the other branch did not, we attempt
>    mergeFile.  When this automerge conflicted, we used to
>    collapse the index.  Now we use update-index --index-info
>    to inject higher stage entries to leave the index in unmerged
>    state for these two cases.
> 
> What this still does _not_ do is to inject unmerged state into
> the index when the structural changes conflict.  I have not
> thought things through what to do in each case yet, but the
> cases this commit cover are the most common ones, so this would
> be a good start.
> 

Good work! I have one comment, see below.

> e5c23ede9ccc6ddd5f2cf13154f977bb1b687051
> diff --git a/git-merge-recursive.py b/git-merge-recursive.py
> index b7fb096..767b13c 100755
> --- a/git-merge-recursive.py
> +++ b/git-merge-recursive.py
> @@ -280,6 +280,22 @@ def updateFileExt(sha, mode, path, updat
>          runProgram(['git-update-index', '--add', '--cacheinfo',
>                      '0%o' % mode, sha, path])
>  
> +def setIndexStages(path,
> +                   oSHA1, oMode,
> +                   aSHA1, aMode,
> +                   bSHA1, bMode):
> +    prog = ['git-update-index', '-z', '--index-info']
> +    proc = subprocess.Popen(prog, stdin=subprocess.PIPE)
> +    pipe = proc.stdin
> +    # Clear stages first.
> +    pipe.write("0 " + ("0" * 40) + "\t" + path + "\0")
> +    # Set stages
> +    pipe.write("%o %s %d\t%s\0" % (oMode, oSHA1, 1, path))
> +    pipe.write("%o %s %d\t%s\0" % (aMode, aSHA1, 2, path))
> +    pipe.write("%o %s %d\t%s\0" % (bMode, bSHA1, 3, path))
> +    pipe.close()
> +    proc.wait()
> +

It might be cleaner to use

runProgram(['git-update-index', '-z', '--index-info'],
           input="0 " + ("0" * 40) + "\t" + path + "\0" + \
                 "%o %s %d\t%s\0" % (oMode, oSHA1, 1, path) + \
                 "%o %s %d\t%s\0" % (aMode, aSHA1, 2, path) + \
                 "%o %s %d\t%s\0" % (bMode, bSHA1, 3, path))

here instead. With this code we will get an exception if
git-update-index exits with an error code. It is also consistent with
the rest of the code.

- Fredrik
