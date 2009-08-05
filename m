From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Help/Advice needed on diff bug in xutils.c
Date: Wed, 5 Aug 2009 22:45:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052239180.8306@pacific.mpi-cbg.de>
References: <1249428804.2774.52.camel@GWPortableVCS>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thell Fowler <tbfowler4@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:45:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnM7-0003Gk-Q9
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbZHEUo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbZHEUoz
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:44:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:51552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752670AbZHEUoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:44:55 -0400
Received: (qmail invoked by alias); 05 Aug 2009 20:44:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 05 Aug 2009 22:44:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+d9MpLEnmdMCb9NI0BBmPmwxCyDgpsZprWIOaxVR
	wwskJZQdtGmFMi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1249428804.2774.52.camel@GWPortableVCS>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124975>

Hi,

On Tue, 4 Aug 2009, Thell Fowler wrote:

> There is a bug in git diff (ignoring whitespace) that does not take into 
> account a trailing space at the end of a line at the end of a file when 
> no new line follows.
> 
> Here is the example of the bug:
> mkdir test_ws_eof
> cd test_ws_eof
> git init
> echo -n "Test" > test.txt
> git add .
> git commit -m'test'
> git symbolic-ref HEAD refs/heads/with_space
> rm .git/index
> git clean -f
> echo -n "Test ">test.txt
> git add .
> git commit -m'test'
> # Ignoring all whitespace there shouldn't be a diff.
> git diff -w master -- test.txt
> # Ignoring space at eol there shouldn't be a diff
> git diff --ignore-space-at-eol master -- test.txt
> # Ignoring with -b might have a case for a diff showing.
> git diff -b master -- test.txt

If you turn that into a patch to, say, t/t4015-diff-whitespace.sh (adding 
a test_expect_failure for a known bug), it is much easier to convince 
developers to work on the issue.

> In the xutils.c xdl_hash_record_with_whitespace function the trailing 
> space prior to eof was being calculated into the hash, I fixed that with 
> the change below, but there is still a difference being noted in 
> xdl_recmatch because of the size difference.
> 
> Before I go changing something that shouldn't be changed could someone
> provide some input please?
> 
> Thanks for reading,
> Thell
> 
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 04ad468..623da92 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -243,17 +243,17 @@ static unsigned long
> xdl_hash_record_with_whitespace(char
> const **data,
>                 if (isspace(*ptr)) {
>                         const char *ptr2 = ptr;
>                         while (ptr + 1 < top && isspace(ptr[1])
> -                                       && ptr[1] != '\n')
> +                                       && ( ptr[1] != '\n' && ptr[1] !=
> '\0' ) )

First, your coding style is different from the surrounding code.  I think 
it goes without saying that this should be fixed.

Second, you do not need the parentheses at all (and therefore they should 
go).

Third, libxdiff does not assume to be fed NUL delimited strings.

Fourth, that condition "ptr + 1 < top" is already doing what you tried to 
accomplish here.

So I guess that you need to do add "ptr + 1 < top" checks 
instead.

Thanks,
Dscho
