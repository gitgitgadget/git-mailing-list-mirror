X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 02:01:00 -0800
Message-ID: <7vbqmpjlsz.fsf@assigned-by-dhcp.cox.net>
References: <45357CC3.4040507@utoronto.ca> <456E8147.9070304@gmx.net>
	<fcaeb9bf0611300101s51a53b75lc7e771b067ba6e33@mail.gmail.com>
	<200611300930.33537.alan@chandlerfamily.org.uk>
	<ekm8ig$usu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 10:01:23 +0000 (UTC)
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ekm8ig$usu$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	30 Nov 2006 10:35:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32716>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpij6-0006X6-C7 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 11:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933835AbWK3KBE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 05:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933753AbWK3KBE
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 05:01:04 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:44026 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S933817AbWK3KBB
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 05:01:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130100101.FOCX7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Thu, 30
 Nov 2006 05:01:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id sy191V00H1kojtg0000000; Thu, 30 Nov 2006
 05:01:10 -0500
To: jnareb@gmail.com
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, short option -i is not --index but --include (i.e. commit
> both changes in index and files mentioned on command line). Perhaps -I?

Just in case nobody noticed after looking at the first part of
my patch a few nights ago, --include happens to mean exactly
what --index would mean anyway.

By default, "git commit" without parameter does "make a commit
out of the index".  With paths, it used to mean "oh, by the way,
I forgot to run update-index on these paths, so could you please
do that for me now before you make the commit", and has been
that way for a long time.

Much later, people from CVS background wanted to say "edit foo
bar; git update-index bar; git commit foo" to mean "I might have
done something to the index, but I do not want to care about it
now -- please make a commit that includes only the changes to
bar and I do not want the changes to foo included in the
commit".  Somehow we ended up introducing that twisted semantics
and that was where --only came from, which unfortunately later
became the default (and I already said that I realize this was a
big mistake).

While we transitioned to switch the default, we first came up
with a name to ask for the traditional semantics (--include),
warned people who gave paths without either -i nor -o that the
--include semantics is still the default but would change soon
(which meant that -i was a no-op back then), then switched the
default and we now warn that the default is now -o (so now -o is
a no-op) when people give only paths without -i nor -o.

Currently (that is, without the first part of my two patches),
"git commit -i" and "git commit -o" without paths refuse to
work, saying that these modes of operation do not make sense
without any path.

However, you can think of the simplest "commit the current
index" semantics as a degenerated case of saying "oh, by the
way, please run update-index on these paths I forgot to do
earlier before you make the commit" and giving no paths.

So "git commit -i" without paths _could_ mean "commit the index
as is" very naturally without introducing an independent switch
with different name.  That is what the first part of my two
patches to Carl does.


