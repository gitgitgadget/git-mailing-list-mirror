From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Yet another set of merge test cases from the kernel tree.
Date: Tue, 20 Sep 2005 07:50:22 +0200
Message-ID: <20050920055022.GB12979@c165.ib.student.liu.se>
References: <20050907164734.GA20198@c165.ib.student.liu.se> <20050907165012.GA20392@c165.ib.student.liu.se> <7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net> <7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net> <7vvf13b1hi.fsf_-_@assigned-by-dhcp.cox.net> <20050919161312.GB1782@c165.ib.student.liu.se> <7vek7kfqs2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 07:50:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHb1e-0007ej-4l
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 07:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVITFuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 01:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVITFuY
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 01:50:24 -0400
Received: from [85.8.31.11] ([85.8.31.11]:46496 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932462AbVITFuX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 01:50:23 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 8A07840FD; Tue, 20 Sep 2005 07:55:49 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EHb1K-0003PI-00; Tue, 20 Sep 2005 07:50:22 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek7kfqs2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8977>

On Mon, Sep 19, 2005 at 06:53:49PM -0700, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > +def mergeFile(path, oSha, oMode, aSha, aMode, bSha, bMode,
> > +              branch1Name, branch2Name):
> >...
> > +    if aMode == oMode:
> > +        mode = bMode
> > +    else:
> > +        mode = aMode
> 
> Note: preferring "our" mode if there is a conflict instead of
> barfing.  I do not know which is more useful in practice.
> 

I just realized that this piece of code is broken with respect to type
changes. Trying to merge a symlink with a file should give us a
conflict.

> > +
> > +    return [sha, mode, clean, merge]
> > +
> > +def updateFile(clean, sha, mode, path, cleanCache, onlyWd=False):
> > +    updateCache = not onlyWd and (cleanCache or (not cleanCache and clean))
> > +    updateWd = onlyWd or (not cleanCache and clean)
> > +
> > +    if updateWd:
> > +        prog = ['git-cat-file', 'blob', sha]
> > +        if stat.S_ISREG(mode):
> > +            try:
> > +                os.unlink(path)
> > +            except OSError:
> > +                pass
> > +            if mode & 0100:
> > +                mode = 0777
> > +            else:
> > +                mode = 0666
> > +            fd = os.open(path, os.O_WRONLY | os.O_TRUNC | os.O_CREAT, mode)
> > +            proc = subprocess.Popen(prog, stdout=fd)
> > +            proc.wait()
> > +            os.close(fd)
> > +        elif stat.S_ISLNK(mode):
> > +            linkTarget = runProgram(prog)
> > +            os.symlink(linkTarget, path)
> > +        else:
> > +            assert(False)
> 
> Could it happen trying to update a file 'foo' when the working
> tree has 'foo/bar' file (i.e. D/F conflict)?
> 

We get a list of all files and directories in getFilesAndDirs. This
list is then used in processEntry to check for d/f conflicts, so it
shouldn't happen in that case.

The rename path do currently not check for d/f conflicts so it could
probably happen there.

- Fredrik
