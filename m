From: Daniel Barkalow <barkalow@iabervon.org>
Subject: =?ISO-8859-15?Q?Re=3A_Schr=F6dinger's_diff?=
Date: Tue, 7 Jul 2009 13:36:08 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1226545847-1246988168=:2147"
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 19:36:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOEaY-0005yO-9l
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 19:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbZGGRgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 13:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbZGGRgK
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 13:36:10 -0400
Received: from iabervon.org ([66.92.72.58]:36984 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbZGGRgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 13:36:10 -0400
Received: (qmail 29322 invoked by uid 1000); 7 Jul 2009 17:36:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jul 2009 17:36:08 -0000
In-Reply-To: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122855>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1226545847-1246988168=:2147
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 6 Jul 2009, Eric Raible wrote:

> git version 1.6.3.2.1299.gee46c (msysgit)
> 
> In trying to track down some annoying crlf corruption in a repo
> I have found a Schrödinger's diff.  In other words it's unknown
> whether the diff will produce output or not on any particular run
> of the following script.
> 
> Sometimes it does, and sometimes it doesn't (seems to be about
> 50/50).  But either way in any given repo rerunning the git-diff will
> always give the same result.
> 
> Doing an "git ls-tree HEAD" gives an identical tree in both cases.
> 
> Can anyone explain why the output to this is not deterministic?
> I'm at a complete loss.
> 
> 	# Clean up from last run and start over
> 	rm -rf .git has-crlf
> 	git init
> 	git config core.autocrlf false
> 
> 	# Add a "bad" file
> 	perl -e 'printf( "12%c%c", 0xd, 0xa )' > has-crlf
> 	git add has-crlf

If has-crlf and .git/index have the same timestamp, git does not know 
whether the file has been modified afterwards or not. If they have 
different timestamps, git knows the file hasn't been modified after the 
add. (More precisely, the index contains the mtime of the file, and it 
will agree with the file system. However, if the timestamp on the index 
matches a timestamp *in* the index, that means that, when the index was 
written, the time period represented by that timestamp was not yet over 
when git looked at the file. Therefore, the file could have changed 
again after that time and still gotten the same timestamp it already had. 
This means that git can't be sure that there's nothing new to see in the 
filesystem.)

> 	git commit -m"add crlf"
> 
> 	# I realize that switching is ill-advised, but I'm
> 	# trying to track down a possibly related problem...
> 	git config core.autocrlf true
> 
> 	# This sometimes produces output and sometimes it doesn't.
> 	# Either way rerunning just git-diff always gives the same result
> 	# as the first run in this repo.
> 	git diff

If git knows the file hasn't been modified, it doesn't produce a diff. 

If it doesn't know the file hasn't been modified, it looks at the actual 
contents and it find that the result of reading the disk applying autocrlf 
now doesn't match the contents of the index.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1226545847-1246988168=:2147--
