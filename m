X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 15:36:38 -0800
Message-ID: <7vslg0ecc9.fsf@assigned-by-dhcp.cox.net>
References: <45357CC3.4040507@utoronto.ca> <456E8147.9070304@gmx.net>
	<fcaeb9bf0611300101s51a53b75lc7e771b067ba6e33@mail.gmail.com>
	<200611300930.33537.alan@chandlerfamily.org.uk>
	<ekm8ig$usu$1@sea.gmane.org> <7vbqmpjlsz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611302338190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 23:36:56 +0000 (UTC)
Cc: jnareb@gmail.com, Alan Chandler <alan@chandlerfamily.org.uk>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611302338190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 30 Nov 2006 23:45:20 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32832>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpvSX-0003Zy-8F for gcvg-git@gmane.org; Fri, 01 Dec
 2006 00:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967974AbWK3Xgl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 18:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967980AbWK3Xgk
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 18:36:40 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56505 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S967974AbWK3Xgk
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 18:36:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130233639.KMET97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Thu, 30
 Nov 2006 18:36:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tBco1V0081kojtg0000000; Thu, 30 Nov 2006
 18:36:48 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 30 Nov 2006, Junio C Hamano wrote:
>
>> Somehow we ended up introducing that twisted semantics and that was 
>> where --only came from, which unfortunately later became the default 
>> (and I already said that I realize this was a big mistake).
>
> If you are talking about "git commit file1 file2" ignoring the current 
> index, and building a new index just updating file1 and file2 from the 
> working directory, I disagree that it was a big mistake.

When I wrote that paragraph, I said:

        Much later, people from CVS background wanted to say "edit foo
        bar; git update-index bar; git commit foo" to mean "I might have
        done something to the index, but I do not want to care about it
        now -- please make a commit that includes only the changes to
        bar and I do not want the changes to foo included in the
        commit".  Somehow we ended up introducing that twisted semantics
        and that was where --only came from, which unfortunately later
        became the default (and I already said that I realize this was a
        big mistake).

But ignoring the index was not because of that command sequence,
as you reminded me in your message I am replying to.  It was to
allow this sequence, which is natural with CVS:

	$ git-checkout  ;# existing project that did not have Makefile
	$ edit hello.c  ;# to fix wording of the message
        $ edit Makefile ;# anybody who is self respecting should have one
	$ git-add Makefile ;# do not forget to add it
        $ git-commit hello.c ;# the fix is important independent of Makefile
	... then maybe the next commit is to add Makefile ...

If you view this sequence with CVS mindset, there is nothing
surprising about the commit _not_ committing Makefile in this
example.

But if you come from the school that "git-add" is about adding
"the contents (and the path, but only because content cannot be
added without the path)", and if you already understood that
"git-commit" without parameters nor options is a way to make a
commit out of the index, it certainly is counterintuitive.  

Granted, parameters and options are ways to affect what the
command does, but usually it does so by modifying and enhancing
what the command does without breaking the basic premise.  What
the --only does is quite different -- it bypasses the index
completely.

In fact, what it does is _so_ counterintuitive that I did not
even remember what the real motivation behind it was, and sent
my message with a much more implausible sequence which had an
explicit update-index (no sane person would do that).  That
should tell you something.

Remember, new peole will not stay "newbies" forever.  The
original "inclusive" semantics is a lot easier to explain once
you get what index does.  The way to introduce "index" to people
Nico proposed would not have to talk about "Ah, but there are
these two twists" if we did not make the --only the default
semantics.  What I find a big mistake is not the --only option;
the mistake is that it is the default.
