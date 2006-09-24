From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4 (take 4)] Add test for the default merges in fetch.
Date: Sat, 23 Sep 2006 18:49:41 -0700
Message-ID: <7vbqp6m3t6.fsf@assigned-by-dhcp.cox.net>
References: <87ac4qfgvc.fsf@gmail.com> <87sliie20o.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 03:49:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRJ7s-0005e1-Ls
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 03:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbWIXBtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 21:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbWIXBtn
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 21:49:43 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14211 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1752052AbWIXBtn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 21:49:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060924014942.IHRW12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Sep 2006 21:49:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id S1pk1V0041kojtg0000000
	Sat, 23 Sep 2006 21:49:44 -0400
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27644>

Santi B=E9jar <sbejar@gmail.com> writes:

> +	cd .. &&
> +	git clone . three &&
> +	cd three &&
> +	git repo-config branch.master.remote two
> +	git repo-config branch.master.merge refs/heads/one
> +	{
> +		echo "URL: ../two/.git/"
> +		echo "Pull: refs/heads/master:refs/heads/two"
> +		echo "Pull: refs/heads/one:refs/heads/one"
> +	} >.git/remotes/two
>  '

Please string them with && unless there is a compelling reason
not to.

That would catch a potential error exit from repo-config,
although it is not a focus of this test.  We have caught
breakage of parts of the system by tests meant for unrelated
parts of the system number of times.

> +test_expect_success "fetch test for-merge" '
> +	cd "$D" &&
> +	cd three &&
> +	git fetch &&
> +	test -f .git/refs/heads/two &&
> +	test -f .git/refs/heads/one &&
> +	{
> +		echo -e "not-for-merge	branch \047master\047 of ../two/"
> +		echo -e "	branch \047one\047 of ../two/"
> +	} > expected &&
> +	cut -f 2- .git/FETCH_HEAD > actual &&
> +	diff expected actual'

Testing for the explicit implementation detail (namely, the
human readable part of the merge log message per branch) makes
me feel uneasy.  Also I've stayed away from "echo -e" for some
inexplicable fear of portability issues and I do not see a
reason to use it here.  Time to learn to use '\'' perhaps?

I would have:

 - arranged branch tips of all the repos that are potentially
   involved to have different object names;

 - checked for the commit object names at the beginning of the
   resulting FETCH_HEAD and not-for-merge markers;

 - ignored the "branch 'foo' of repo" log message pieces;.

In other words, this on top of yours, which I am going to
commit.

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 2d8da59..df0ae48 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -30,8 +30,8 @@ test_expect_success "clone and setup chi
 	cd .. &&
 	git clone . three &&
 	cd three &&
-	git repo-config branch.master.remote two
-	git repo-config branch.master.merge refs/heads/one
+	git repo-config branch.master.remote two &&
+	git repo-config branch.master.merge refs/heads/one &&
 	{
 		echo "URL: ../two/.git/"
 		echo "Pull: refs/heads/master:refs/heads/two"
@@ -57,11 +57,13 @@ test_expect_success "fetch test for-merg
 	git fetch &&
 	test -f .git/refs/heads/two &&
 	test -f .git/refs/heads/one &&
+	master_in_two=3D`cd ../two && git rev-parse master` &&
+	one_in_two=3D`cd ../two && git rev-parse one` &&
 	{
-		echo -e "not-for-merge	branch \047master\047 of ../two/"
-		echo -e "	branch \047one\047 of ../two/"
-	} > expected &&
-	cut -f 2- .git/FETCH_HEAD > actual &&
+		echo "$master_in_two	not-for-merge"
+		echo "$one_in_two	"
+	} >expected &&
+	cut -f -2 .git/FETCH_HEAD >actual &&
 	diff expected actual'
=20
 test_done
