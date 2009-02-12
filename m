From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: How to use path limiting (using a glob)?
Date: Thu, 12 Feb 2009 11:27:20 +0100
Message-ID: <20090212102719.GD27232@m62s10.vlinux.de>
References: <20090211191432.GC27232@m62s10.vlinux.de> <alpine.LFD.2.00.0902111129190.3590@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 11:27:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXYnQ-0008Vb-JJ
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 11:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415AbZBLK00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 05:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbZBLK0Z
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 05:26:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:49986 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751619AbZBLK0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 05:26:24 -0500
Received: (qmail invoked by alias); 12 Feb 2009 10:26:22 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp071) with SMTP; 12 Feb 2009 11:26:22 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/OirMkBbTOEifQqtQ+Rl4cOYZStHmVHQgkxVc/Ij
	GLJkFnuu/1VxQK
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 2754E1997C; Thu, 12 Feb 2009 11:27:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902111129190.3590@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109597>

On Wed, Feb 11, 2009 at 11:40:44AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 11 Feb 2009, Peter Baumann wrote:
> 
> > after reading Junio's nice blog today where he explained how to use git grep
> > efficiently, I saw him using a glob to match for the interesting files:
> > 
> > 	 $ git grep -e ';;' -- '*.c'
> > 
> > Is it possible to have the same feature in git diff and the revision
> > machinery?
> 
> Not really. Git has two different kinds of path limiters, and they are 
> really really different.
> 
>  - the "walk current index/directory recursively" kind that "git ls-files" 
>    uses, which takes a 'fnmatch()' type path regexp (not a real regexp, 
>    but the kind you're used to with shell)
> 
>    NOTE! On purpose, we don't set the FNM_PATHNAME, so "*.c" here is 
>    different from *.c in shell (it's more like "**.c" in tcsh). IOW, * 
>    matches '/' too, and will walk subdirectories.
> 

Hm. But if git does only anchor the * at the current directory, wouldn't
this solve (or at least reduce) the performance problems you described in the
later paragraph? Having the "**.c" do a recurisve search for every .c
file would then be used to do a recusrive search. 

>  - the "revision limiter" pathspec. This is *not* a regexp, it's a pure 
>    prefix matcher, for a very simple reason: performance.
> 
> > 	$ cd $path_to_your_git_src_dir
> > 	$ git log master -p -- '*.h'
> > 	.... No commit shown 
> > 
> > 	$ git diff --name-only v1.5.0  v1.6.0 -- '*.c'
> > 
> > and both don't return anything.
> 
> Yeah, in the revision matcher you can still depend on the shell 
> expansion, and it will do _almost_ the right thing. So if you do
> 
> 	git log master -p *.c
> 
> without the quotes, the shell expansion will work, and that in turn will 
> give a set of filenames that "git log" will restrict the log to. HOWEVER, 
> it's not a real wildcard - it's literally looking at what you have now in 
> your current working directory, and saying "give me the logs of those 
> pathnames", not "give me the logs of everything ending with .c".
> 

Ok. Thats actually the reason why I asked for this, because if a file
got removed it wouldn't be found by this.

> We _could_ make the revision limiter understand fnmatch-style patterns, 
> but quite frankly, it's very very expensive - too expensive to be useful 
> for big repositories. The point about only matching prefixes is that it 
> allows the revision limiter to not even walk into subdirectories that 
> don't match, but if you do the "*.c" kind of pattern, now the revision 
> code has to look up every tree recursively. That code is also _extremely_ 
> performance-critical, so we really don't want to use fnmatch() when we can 
> currently use just "memcmp()".
> 
> So yes, it's kind of odd how we have two totally different concepts of 
> pathname patterns, but it's probably easiest to remember that "'git grep' 
> is just special". 
> 
> 		Linus
