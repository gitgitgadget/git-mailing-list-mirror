From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Documentation: enhance gitignore whitelist example
Date: Tue, 5 Apr 2011 23:15:54 +0200
Message-ID: <201104052315.54375.j6t@kdbg.org>
References: <1302032214-11438-1-git-send-email-eblake@redhat.com> <20110405194005.GA32427@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <eblake@redhat.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:16:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Dbn-0004Bx-Na
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab1DEVQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:16:00 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:38167 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753605Ab1DEVQA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:16:00 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E5A6C2C4010;
	Tue,  5 Apr 2011 23:15:55 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0902E19F5C0;
	Tue,  5 Apr 2011 23:15:55 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20110405194005.GA32427@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170916>

On Dienstag, 5. April 2011, Jonathan Nieder wrote:
> Eric Blake wrote:
> > @@ -70,7 +70,9 @@ PATTERN FORMAT
> >   - An optional prefix '!' which negates the pattern; any
> >     matching file excluded by a previous pattern will become
> >     included again.  If a negated pattern matches, this will
> > -   override lower precedence patterns sources.
> > +   override lower precedence patterns sources.  However, a
> > +   file negation does not override a path that has already
> > +   been excluded by a directory match.

I don't think this is the right place to explain this caveat. Here we describe 
the format and behavior of the patterns in a rather formal manner.

> > @@ -87,7 +89,8 @@ PATTERN FORMAT
> >
> >   - Otherwise, git treats the pattern as a shell glob suitable
> >     for consumption by fnmatch(3) with the FNM_PATHNAME flag:
> > -   wildcards in the pattern will not match a / in the pathname.
> > +   wildcards in the pattern will not match a / in the pathname,
> > +   and do not ignore files with a leading . in the pathname.

I don't think this is correct. * matches .gitignore. I tried it.

> > @@ -116,8 +119,11 @@ EXAMPLES
> >      [...]
> >      # Untracked files:
> >      [...]
> > +    #       Documentation/build
> >      #       Documentation/foo.html
> >      #       Documentation/gitignore.html
> > +    #       build/log
> > +    #       build/.file
> >      #       file.o
> >      #       lib.a
> >      #       src/internal.o
> > @@ -125,6 +131,10 @@ EXAMPLES
> >      $ cat .git/info/exclude
> >      # ignore objects and archives, anywhere in the tree.
> >      *.[oa]
> > +    # ignore files in the immediate child directory build,
> > +    /build/*
> > +    # except for the log.
> > +    !/build/log

Doesn't this example give the false impression that you could do

	/foo/*
	!/foo/bar/baz

and have foo/bar/baz not ignored? But it is still ignored.

I propose a paragraph like this in the NOTES section:

--- 8< ---
When a directory is ignored, it is not possible to un-ignore a single file 
somewhere in the directory using another pattern. E.g., with the patterns

--------------
/build/
!/build/tests/results
--------------

the file "build/tests/results" is still ignored because when a directory is 
ignored, its contents are never investigated. In a situation where a few 
exceptions in an otherwise ignored hierarchy are needed, the recommended 
procedure is to specify to ignore the root of the hierarchy and then to 'git 
add -f' the exceptional files. Subsequent changes to the files will not be 
ignored.
--- 8< ---

-- Hannes
