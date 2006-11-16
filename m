X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 02:36:11 -0800
Message-ID: <7v1wo3d6g4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151315291.2591@xanadu.home>
	<20061115184914.GA24122@spearce.org> <455B64F7.9040506@gmx.net>
	<7vejs4l9wy.fsf@assigned-by-dhcp.cox.net> <455C0033.2020309@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 10:36:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31567>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkebQ-0004vr-5v for gcvg-git@gmane.org; Thu, 16 Nov
 2006 11:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423710AbWKPKgN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 05:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423732AbWKPKgN
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 05:36:13 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46062 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1423710AbWKPKgM
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 05:36:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116103611.HVXF27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 05:36:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nNcJ1V0011kojtg0000000; Thu, 16 Nov 2006
 05:36:18 -0500
To: Marko Macek <marko.macek@gmx.net>
Sender: git-owner@vger.kernel.org

Marko Macek <marko.macek@gmx.net> writes:

>>> BTW, currently there's a minor bug: git-diff HEAD doesn't work before
>>> you make the first commit. Perhaps this should be special cased.
>>
>> That's only a _bug_ in your implementation of the synonym for
>> "svn diff" which blindly used "git diff HEAD".
>
> My "implementation" is taken from git-diff man page. It seems obvious
> that the situation before the first commit is just a special case if
> we consider git-diff to be Porcelain (which I do).

Yes, "git diff" is a Porcelain.  No question about it.

I do not consider the current behaviour of "git diff HEAD" that
complains instead of giving runs of "foo is a new file and no
diff is available for it" a bug; you asked for diff from some
commit but the commit you gave was bogus (does not exist yet).
But if you feel strongly about it, it should be trivial to
special case the yet-to-be-born HEAD case and run the
equilvalent of:

	git ls-files | sed -e 's/$/ is a new file, no diff is available./'

in such a case.  Or you could even go fancier and do an
equivalent of:

	git ls-files |
        while read path
        do
		l=`wc -l <"$path"`
        	echo "diff --git a/$path b/$path"
                echo "--- a/$path"
                echo "--- b/$path"
                echo "@@ -0,0 +1,$l @@"
                sed -e 's/^/+/' <"$path"
	done

and you can claim that it makes it consistent with the case
where you already have commits.

But I happen to think that consistency is only of academic
interest.  After all, how often would one create a true "root"
commit?  We are not talking about creating a new repository that
starts its life as a clone of something else, but a truly empty
one in which the initial commit is made.  And how often would
one want to view "diff" from void while preparing for that
initial commit?  Both that low frequency _and_ general
uselessness of the output from either of the above shell
scripts, would it be worth "fixing" it?

I do not think it adds any real practical value, and does not
even have much to do with being user friendly.  I would put it
in the "when somebody is really bored and has nothing better to
do, then this _could_ be done" category.
