X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 03:11:59 -0800
Message-ID: <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<455C412D.1030408@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 11:12:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455C412D.1030408@xs4all.nl> (Han-Wen Nienhuys's message of "Thu,
	16 Nov 2006 11:45:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31570>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkfAC-00042D-FQ for gcvg-git@gmane.org; Thu, 16 Nov
 2006 12:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031157AbWKPLMC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 06:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031160AbWKPLMB
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 06:12:01 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:9119 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1031157AbWKPLMA
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 06:12:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116111159.LHFE7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 06:11:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nPC51V00E1kojtg0000000; Thu, 16 Nov 2006
 06:12:06 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

You claim it is _an interface_ issue but it is not.

> With GIT, this is what happens
>
> [hanwen@haring y]$ git pull ../x
> fatal: Needed a single revision
> Pulling into a black hole?

You asked it to fetch from the neighbour repository and merge it
into your current branch which does not exist (I presume that
you omitted to describe what you did in directory y/ and I am
assuming you did "mkdir y && cd y && git initdb" and nothing
else).  You are pulling into a black hole.

> [hanwen@haring y]$ git fetch ../x
>...
> [hanwen@haring y]$ git checkout

You fetched without telling it in which tracking branch to store
what you fetched, and as a result your HEAD is not updated, so
your current branch still does not exist.  A failure from
checking out nothingness is not an interface issue; expectation
for it to work is a concept level issue.

> [hanwen@haring y]$ git branch master
> fatal: Needed a single revision

You are not at any commit yet and you try to create a branch?

Of course, the "right" (in some sense of the word) thing is to
do "git clone x y" in the parent directory, without creating y
upfront.

If you have an empty y to begin with, then you can do this:

	$ git fetch ../x :origin
        $ git reset --hard origin

which would mirror a part of what "git clone" would have done
for you.  It copies from the other repository, stores the tip in
your tracking branch called "origin", and make your HEAD to be
the same as origin.  After these two commands, you would have
two branches, origin and master, and you will be on master.

You can name 'origin' any way you want.  You might want to name
it 'x' to make it clear (to yourself) that it is used to track
what will happen in the neighboring repository 'x'.  Also, you
would most likely be fetching and merging from the same ../x
from now on, so it might be handy to set up the remotes for it:

	$ cat >.git/remotes/x <<EOF
        URL: ../x
        Pull: master:origin
	EOF

Then subsequent work of yours would be done on 'master' branch
(you have only two branches, and origin is a tracking branch so
you will never make commits on it, which means the above is a
logical consequence), and from time to time you would sync with
whoever is working in ../x

	$ git pull x

Here, 'x' is just a shorthand which looks up the URL: and Pull: line
through .git/remotes/x.  If your .git/remotes/ file was named origin
(not x), you could even have written:

	$ git pull

because pull defaults to 'origin' (without any other configuration).

>> Let's face it, you could just alias "merge" to "pull", and it
>> wouldn't really change ANYTHING.
>
> I don't want ANYTHING to really change, I just want a sane interface to it.

I agree that you do not want to change anything.  You just
needed a bit of handholding, because you deviated from the
cookbook usage, to correct your course.



