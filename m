From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to use path limiting (using a glob)?
Date: Wed, 11 Feb 2009 11:40:44 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902111129190.3590@localhost.localdomain>
References: <20090211191432.GC27232@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:43:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKz0-0004uJ-A9
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbZBKTl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755735AbZBKTl1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:41:27 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47065 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755538AbZBKTl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 14:41:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1BJejcY012362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Feb 2009 11:40:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1BJeixT012717;
	Wed, 11 Feb 2009 11:40:45 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090211191432.GC27232@m62s10.vlinux.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.457 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109516>



On Wed, 11 Feb 2009, Peter Baumann wrote:

> after reading Junio's nice blog today where he explained how to use git grep
> efficiently, I saw him using a glob to match for the interesting files:
> 
> 	 $ git grep -e ';;' -- '*.c'
> 
> Is it possible to have the same feature in git diff and the revision
> machinery?

Not really. Git has two different kinds of path limiters, and they are 
really really different.

 - the "walk current index/directory recursively" kind that "git ls-files" 
   uses, which takes a 'fnmatch()' type path regexp (not a real regexp, 
   but the kind you're used to with shell)

   NOTE! On purpose, we don't set the FNM_PATHNAME, so "*.c" here is 
   different from *.c in shell (it's more like "**.c" in tcsh). IOW, * 
   matches '/' too, and will walk subdirectories.

 - the "revision limiter" pathspec. This is *not* a regexp, it's a pure 
   prefix matcher, for a very simple reason: performance.

> 	$ cd $path_to_your_git_src_dir
> 	$ git log master -p -- '*.h'
> 	.... No commit shown 
> 
> 	$ git diff --name-only v1.5.0  v1.6.0 -- '*.c'
> 
> and both don't return anything.

Yeah, in the revision matcher you can still depend on the shell 
expansion, and it will do _almost_ the right thing. So if you do

	git log master -p *.c

without the quotes, the shell expansion will work, and that in turn will 
give a set of filenames that "git log" will restrict the log to. HOWEVER, 
it's not a real wildcard - it's literally looking at what you have now in 
your current working directory, and saying "give me the logs of those 
pathnames", not "give me the logs of everything ending with .c".

We _could_ make the revision limiter understand fnmatch-style patterns, 
but quite frankly, it's very very expensive - too expensive to be useful 
for big repositories. The point about only matching prefixes is that it 
allows the revision limiter to not even walk into subdirectories that 
don't match, but if you do the "*.c" kind of pattern, now the revision 
code has to look up every tree recursively. That code is also _extremely_ 
performance-critical, so we really don't want to use fnmatch() when we can 
currently use just "memcmp()".

So yes, it's kind of odd how we have two totally different concepts of 
pathname patterns, but it's probably easiest to remember that "'git grep' 
is just special". 

		Linus
