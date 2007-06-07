From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix clone to setup the origin if its name ends with .git
Date: Wed, 06 Jun 2007 19:08:28 -0700
Message-ID: <7vejkott2b.fsf@assigned-by-dhcp.cox.net>
References: <20070606224906.GB3969@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 04:08:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw7QU-00087V-MO
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 04:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935352AbXFGCIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 22:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935415AbXFGCIb
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 22:08:31 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48333 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935352AbXFGCIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 22:08:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070607020829.VVIS5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 22:08:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8S8V1X0061kojtg0000000; Wed, 06 Jun 2007 22:08:30 -0400
In-Reply-To: <20070606224906.GB3969@steel.home> (Alex Riesen's message of
	"Thu, 7 Jun 2007 00:49:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49338>

Alex Riesen <raa.lkml@gmail.com> writes:

> The problem is visible when cloning a local repo. The cloned
> repository will have the origin url setup incorrectly: the origin name
> will be copied verbatim in origin url of the cloned repository.
> Normally, the name is to be expanded into absolute path.

Thanks.

> diff --git a/git-clone.sh b/git-clone.sh
> index fdd354f..d45618d 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -20,7 +20,7 @@ usage() {
>  get_repo_base() {
>  	(
>  		cd "`/bin/pwd`" &&
> -		cd "$1" &&
> +		cd "$1" || cd "$1.git" &&
>  		{
>  			cd .git
>  			pwd

We would probably need a to clean up this test a bit, though.
When we write our tests, we tend to forget testing the cases
where things ought to fail.

I'll probably redo the test myself, but for the record...

 - Please never "unset" GIT_CONFIG.  We do not want the tests to
   get affected with /etc/gitconfig or $HOME/.gitconfig;

 - We would also want to test the cases where a bare repository
   x exists and x.git does not, and try cloning it into y and z
   respectively.  Obviously the former should work and the
   latter should fail.
