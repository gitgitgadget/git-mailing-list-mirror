From: David Deutsch <dd212303@gmail.com>
Subject: Re: Spontaneous "changes" upon checking out a commit
Date: Fri, 5 Jun 2015 16:59:00 +0000 (UTC)
Message-ID: <loom.20150605T185726-583@post.gmane.org>
References: <CAE-vyzgSqqidjsD7XByLY+T4G78yUtO-q3G63au4uNPO=1_tcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 19:05:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0v3V-0005qY-Nx
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 19:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423118AbbFERFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 13:05:13 -0400
Received: from plane.gmane.org ([80.91.229.3]:39675 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422809AbbFERFL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 13:05:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z0v3J-0005fR-7Y
	for git@vger.kernel.org; Fri, 05 Jun 2015 19:05:05 +0200
Received: from GENSCAPE-IN.bar1.Boston1.Level3.net ([4.16.9.122])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 19:05:05 +0200
Received: from dd212303 by GENSCAPE-IN.bar1.Boston1.Level3.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 19:05:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 4.16.9.122 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270859>

David Deutsch <dd212303 <at> gmail.com> writes:

> 
> When I checkout a particular commit in my repo and immediately do a
> git status, there is a file that show up as changed. If I look at the
> SHAs for my working copy and the copy in the index/repo, they are
> indeed different. The working copy has carriage returns, and while I
> *suspect* the copy in the index/repo does not have them, the output
> from git cat-file on the repo SHA does have them. In fact, if I
> redirect that output to a file and do a git hash-object of that file,
> I get back the the same SHA as the working copy.
> 
> Doing a git checkout on the file changes nothing, i.e. it is still
> marked as changed in git status. Trying to checkout another commit
> fails, as my "changes" to the file would be overwritten by the
> checkout. Doing a git diff on the file returns nothing.
> 
> The repo has a .gitattributes file, which starts out with "* text=auto
> !eol". Every file in the repo is explicitly listed in .gitattributes
> as -text, *except* the file that has the spontaneous "changes". The
> file's suffix is .cs, which I thought was automatically considered
> text anyway. On my machine, core.autocrlf is false.
> 
> This is running on Windows. Git version is 1.9.5.msysgit.1.
> 
> Does anyone know what might be going on here? It is almost as if git
> is adding the CRs to the file at checkout, but not "realizing" that
> when it comes to deciding if there are local changes.
> 
> Thanks for any insight.
> 

OK, so I am pretty sure I have this figured out. Contrary to my belief, 
the file in the repo did have CRs in it, and was thus exactly equal to 
my working copy. However, since "* text = auto" was specified in 
.gitattributes, the "clean" version git status uses would have its CRs 
stripped, i.e. upon commit. So, git considers the files different. 

An interesting thing to note is that while I was able to reproduce this 
with a test repository using * text = auto in .gitattributes, I could 
not reproduce it if I did not have that line, even while setting 
core.autocrlf to true. The documentation implies the behavior should be 
the same, but that is obviously not the case.
