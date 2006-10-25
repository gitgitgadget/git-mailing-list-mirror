X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Combined diff format documentation
Date: Wed, 25 Oct 2006 16:24:19 -0700
Message-ID: <7vslhcj7x8.fsf@assigned-by-dhcp.cox.net>
References: <ehoo2k$1g6$1@sea.gmane.org>
	<7vejswkoi4.fsf@assigned-by-dhcp.cox.net> <ehoq5r$8h5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 23:24:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ehoq5r$8h5$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	26 Oct 2006 00:58:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30125>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcs6l-00011N-7E for gcvg-git@gmane.org; Thu, 26 Oct
 2006 01:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422775AbWJYXYV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 19:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422815AbWJYXYV
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 19:24:21 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10937 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1422775AbWJYXYV
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 19:24:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025232420.CLXX22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 19:24:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id enQ31V00B1kojtg0000000 Wed, 25 Oct 2006
 19:24:03 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Well, the _documentation_ doesn't tell. I haven't fully grokked the code
> for generating and coloring combined diff output besides the fact that
> I think it uses last indicator ('+' or '-') to chose color for the rest
> of line. You said that even if the possibility exist, it is extreme
> unlikely.

Well if I said that I must have been on booze ;-).

A '-' in the nth column means that the line is from the nth
parent and does _not_ appear in the merge result.  A '+' in the
nth column means that the line _appears_ in the merge result,
and the nth parent does not have that line (i.e. added by the
merge itself, or inherited from other parents).

Hence, by definition, you cannot have '-' and '+' on the same
line (otherwise the line has to exist and not exist in the merge
result at the same time).

A ' ' is a bit tricky to interpret.  A ' ' on a line _without_
any '-' means the line is the same as in that parent and the
merge result (i.e. the result inherited the line from that
parent).  A ' ' on a line that has '-' talks nothing about the
merge result (because by definition '-' lines do not exist in
the merge result) nor the parent that has ' '; in other words,
it is a "don't care" bit.  In the example you quoted from the
commit log of af3feefa:

         - static void describe(char *arg)
          -static void describe(struct commit *cmit, int last_one)
         ++static void describe(char *arg, int last_one)
           {

The first parent had it as one-arg function, and the second one
two-arg but the first parameter was of type "struct commit *";
the merge result has it as two-arg with the first parameter of
type "char *".  The second parent does not know about the
one-arg form of the function so it has ' ' in its column for the
first line.

All versions start the function with an opening brace '{' so the
line has two ' ' prefixed, which is an example of ' ' on a line
without any '-'.


