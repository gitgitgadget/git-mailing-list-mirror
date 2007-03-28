From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Wed, 28 Mar 2007 00:57:12 -0700
Message-ID: <7vbqidls13.fsf@assigned-by-dhcp.cox.net>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org>
	<200703280544.47569.chriscool@tuxfamily.org>
	<7vk5x1ly2g.fsf@assigned-by-dhcp.cox.net>
	<200703280952.57058.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 09:57:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWT2B-000269-9n
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 09:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933808AbXC1H50 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 03:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbXC1H50
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 03:57:26 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51102 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbXC1H5O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2007 03:57:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328075713.BUBN28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 28 Mar 2007 03:57:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id g7xD1W00F1kojtg0000000; Wed, 28 Mar 2007 03:57:13 -0400
In-Reply-To: <200703280952.57058.chriscool@tuxfamily.org> (Christian Couder's
	message of "Wed, 28 Mar 2007 09:52:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43357>

Christian Couder <chriscool@tuxfamily.org> writes:

> git bisect run --not grep string my_file
>
> instead of something like
>
> git bisect run ! grep string my_file

How's the former more useful than the latter was what I was
wondering but I do not care too deeply.

> For example one could write:
>
> git bisect run --good rev1 --bad rev2 my_script
>
> instead of
>
> git bisect start
> git bisect good rev1
> git bisect bad rev2
> git bisect run my_script

Likewise.

>> > --check or --test
>> > run the script once and then do nothing if the result is good
>>
>> How would you use this?=20
>
> For example if you know that the last nightly build=20
> tagged "nightly_2007_03_27" was ok, you could use:
>
> git bisect start
> git bisect good nightly_2007_03_27
> git bisect run --check make > /dev/null || {
> 	# extract commit and author email address from "$GIT_DIR/BISECT_RUN"
> 	#=C2=A0and send flame to author who broke the build with the commit
> }
>
> to automatically check that current source code builds ok.

As I said, bisect fundamentally needs one bad commit to start
bisecting, so after you give only one good commit, it would not
move to bisect branch nor suggest which commit to test.  I
assume you intend to run the test on the tip of the current
branch here, but then your "git bisect run --check ./run-script"
is equivalent to running ./run-script and checking the exit
value.

In other words, the above would be equilvalent to

  git bisect start
  git bisect good nightly_2007_03_27
  make >/dev/null || {
	  git bisect bad
          git bisect run make >/dev/null
          # extract commit and author email address from "$GIT_DIR/BISE=
CT_RUN"
          #=C2=A0and send flame to author who broke the build with the =
commit
  }

I happen to find the latter easier to read as a shell script.
