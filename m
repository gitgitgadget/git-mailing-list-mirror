From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Implementing $Date$ substitution - problem with git status
Date: Sun, 9 Aug 2009 22:52:58 +0200
Message-ID: <200908092252.58363.j6t@kdbg.org>
References: <alpine.DEB.2.00.0908092127420.17141@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sun Aug 09 22:53:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaFOC-0006Bm-4T
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 22:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbZHIUxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 16:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbZHIUxD
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 16:53:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:62770 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbZHIUxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 16:53:01 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1FA86CDF87;
	Sun,  9 Aug 2009 22:52:59 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CD24B4360D;
	Sun,  9 Aug 2009 22:52:58 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.2.00.0908092127420.17141@perkele.intern.softwolves.pp.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125380>

On Sonntag, 9. August 2009, Peter Krefting wrote:
> I finally got around to moving my web site repository over from CVS to Git,
> and to not have to redo everything about how it is set up, I set up a
> filter that fakes CVS' handling of "$Date$" keywords. Since I cannot access
> any information about the file from the "smudge" filter, I set up a "clean"
> filter that edits the $Date$ token on "git add":
>
>    #!/usr/bin/perl -wTp -i.bak
>    if (/\$Date:?[^\$]*\$/)
>    {
>      my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
> localtime(); my $now = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year +
> 1900, $mon + 1, $mday, $hour, $min, $sec);
>      s/\$Date:?[^\$]*\$/\$Date: ${now} \$/;
>    }
>
> In .gitattributes I have lines like:
>
>    *.html filter=date crlf=true ident
>
> and filter.date.clean is set to point to the script above in .git/config.
>
> This works fine, except that I have some problems with files that I cannot
> get to be "clean" in git status. "git diff" shows only a difference in the
> "$Date$" token, which is different each time I run "git diff" (the "+" line
> shows the current time):
>
>    diff --git a/.htaccess b/.htaccess
>    index 2dfbc32..d8ac343 100644
>    --- a/.htaccess
>    +++ b/.htaccess
>    @@ -2,7 +2,7 @@
>     # -----------------------------------------------------
>
>     # $Id$
>    -# $Date: 2009-08-09 19:52:30 $
>    +# $Date: 2009-08-09 20:31:56 $
>    [...]

The clean filter is applied before 'git diff' generates the diff. Since you 
have unstaged changes (I take [...] to mean this), you see a new date on 
every invocation.

After 'git add .htaccess' subsequent 'git diff' should not show any changes.

> Strangely, the $Id$ line above (which is handled by me adding the "ident"
> attribute to all text files), does not exhibit the same problem.
>
> Doing "git reset --hard" or "git checkout master filename" does not help,
> the file is still believed to be modified by git.

Now, that's an entirely different problem, and I think that there is a bug. I 
have observed this as well with my own clean filter sometimes, but not 
always. I haven't found a recipe that reliably exhibits the problem.

-- Hannes
