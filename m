From: Junio C Hamano <junkio@cox.net>
Subject: Re: Yet another set of merge test cases from the kernel tree.
Date: Mon, 19 Sep 2005 18:53:49 -0700
Message-ID: <7vek7kfqs2.fsf@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<20050907165012.GA20392@c165.ib.student.liu.se>
	<7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvf13b1hi.fsf_-_@assigned-by-dhcp.cox.net>
	<20050919161312.GB1782@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 03:54:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXKZ-0000Ok-5P
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 03:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVITBxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 21:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVITBxz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 21:53:55 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:9355 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964825AbVITBxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 21:53:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920015352.QZQG28889.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 21:53:52 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8946>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> ... The support for
> renames is currently interleaved with other unrelated changes and
> this patch should not yet be considered for inclusion. With the rename
> patch we get clean merges that matches the actual commit for all of
> those except for 46f5.... git-merge-recursive.py do not merge
> 46f5... cleanly with the rename patch applied.

That is very interesting.

> +getFilesRE = re.compile('([0-9]+) ([a-z0-9]+) ([0-9a-f]{40})\t(.*)')
> +def mergeTrees(head, merge, common, branch1Name, branch2Name,
> +               cleanCache):
> ...
> +    if cleanCache:
> +        updateArg = '-i'
> +    else:
> +        updateArg = '-u'
> +
> +    runProgram(['git-read-tree', updateArg, '-m', common, head, merge])

It _might_ make sense if we make '-i' and '-u' imply instead of
require '-m' in read-tree, but that will be an independent
patch.

> +def mergeFile(path, oSha, oMode, aSha, aMode, bSha, bMode,
> +              branch1Name, branch2Name):
>...
> +    if aMode == oMode:
> +        mode = bMode
> +    else:
> +        mode = aMode

Note: preferring "our" mode if there is a conflict instead of
barfing.  I do not know which is more useful in practice.

> +
> +    return [sha, mode, clean, merge]
> +
> +def updateFile(clean, sha, mode, path, cleanCache, onlyWd=False):
> +    updateCache = not onlyWd and (cleanCache or (not cleanCache and clean))
> +    updateWd = onlyWd or (not cleanCache and clean)
> +
> +    if updateWd:
> +        prog = ['git-cat-file', 'blob', sha]
> +        if stat.S_ISREG(mode):
> +            try:
> +                os.unlink(path)
> +            except OSError:
> +                pass
> +            if mode & 0100:
> +                mode = 0777
> +            else:
> +                mode = 0666
> +            fd = os.open(path, os.O_WRONLY | os.O_TRUNC | os.O_CREAT, mode)
> +            proc = subprocess.Popen(prog, stdout=fd)
> +            proc.wait()
> +            os.close(fd)
> +        elif stat.S_ISLNK(mode):
> +            linkTarget = runProgram(prog)
> +            os.symlink(linkTarget, path)
> +        else:
> +            assert(False)

Could it happen trying to update a file 'foo' when the working
tree has 'foo/bar' file (i.e. D/F conflict)?

> +def getRenames(treeOrig, tree):
>...
> +def processRenames(entries, renamesA,...
>...

These are indeed very interesting.
