From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] filter-branch -d: Export GIT_DIR earlier
Date: Tue, 17 Feb 2009 13:44:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171327270.6185@intel-tinevez-2-302>
References: <20090217083146.GA7338@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 13:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZPKf-00009w-GB
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 13:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbZBQMoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 07:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbZBQMoF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 07:44:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:59193 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753209AbZBQMoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 07:44:04 -0500
Received: (qmail invoked by alias); 17 Feb 2009 12:44:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp001) with SMTP; 17 Feb 2009 13:44:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4UGZP5NS4QNGi8LO4K3GufJTHJ9P/JbsAC/ujhC
	tAVXgDmu7prG4n
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090217083146.GA7338@lars.home.noschinski.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110366>

Hi,

On Tue, 17 Feb 2009, Lars Noschinski wrote:

> The improved error handling catches a bug in filter-branch when using
> -d pointing to a path outside any git repository:
> 
> $ mkdir foo
> $ cd foo
> $ git init
> $ touch bar
> $ git add bar
> $ git commit -m bar
> $ cd ..
> $ git clone --bare foo
> $ cd foo.git
> $ git filter-branch -d /tmp/filter master
> fatal: Not a git repository (or any of the parent directories): .git

This could be written as

	$ cd .git
	$ git filter-branch -d /tmp/bla master

Right?

	
>  git-filter-branch.sh     |   12 ++++++------
>  t/t7003-filter-branch.sh |    9 +++++++++
>  2 files changed, 15 insertions(+), 6 deletions(-)

Funny, git am -3 reports:

	Did you hand edit your patch?
	It does not apply to blobs recorded in its index.
	Cannot fall back to three-way merge.

After realizing that the common lines were prefixed with a double space, 
and applying my l33t patch m0nkey ski77z, I could verify that it works as 
expected (in addition to looking at the patch and deeming it correct).

> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 56b5ecc..446700b 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -48,6 +48,15 @@ test_expect_success 'result is really identical' '
>  	test $H = $(git rev-parse HEAD)
>  '
>  
> +TRASHDIR=$(pwd)
> +test_expect_success 'correct GIT_DIR while using -d' '
> +        mkdir drepo && cd drepo && git init && make_commit drepo &&

I usually prefer those to be on one line, each.

> +        git filter-branch -d "$TRASHDIR/dfoo" \
> +            --index-filter "cp \"$TRASHDIR\"/dfoo/backup-refs \"$TRASHDIR\""
> &&
> +        cd .. &&

We try to avoid cd'ing back, by using constructs like this:

	(cd drepo &&
	 ...
	) &&

After those two (maybe three) changes and your SOB: ACK.

BTW the reason I wanted to test this thing is that I suspected that you 
meant test_commit instead of make_commit.  But then, I realized that there 
exists a make_commit in t7003... which shares the shortcoming of our 
previous implementation of test_commit in that it adds ambiguities on 
case-insensitive filesystems.

So I _had_ to look who introduced make_commit:

	$ git blame -L '/make_commit/,/}/' t/t7003*

Making a fool out of yourself -- priceless.

Ciao,
Dscho
