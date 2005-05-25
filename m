From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Tue, 24 May 2005 20:22:59 -0700
Message-ID: <7vwtpong4s.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org>
	<7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org>
	<7v3bscqdlr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505242002340.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 05:22:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DamSh-0000wt-FO
	for gcvg-git@gmane.org; Wed, 25 May 2005 05:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVEYDXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 23:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVEYDXK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 23:23:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:51108 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262252AbVEYDXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 23:23:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525032259.WFMF7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 23:22:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505242002340.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 20:04:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Tue, 24 May 2005, Junio C Hamano wrote:
>> 
LT> Also, what language do you actually speak?
>> 
>> Japanese.

LT> It is possible it is cultural. I certainly find it harder to read the 
LT> "unexpected" way. 

I doubt it is Japanese vs Western kind of cultural.  When I said
"people around me", that set of people did not include a single
Japanese.  I meant people who worked with the person I was
trained by to use this style.  Cultural, maybe, but that is
programming culture and definitely not natural language culture
in my case.

Here is a quick and dirty experiment which showed quite an
interesting statistics.  It counts number of '<' and '>' in the
program text, after stripping out ptr->deref (yes it catches
#include <stdlib.h>, but they even out and it also catches
whatever is in comments, but this is just a Q&D stats for fun).
The percentage is how close the program text is to "visually
ordered" style:

    $ cat count-compare.perl
    #!/usr/bin/perl -w 

    for my $filename (@ARGV) {
        open I, '<', $filename;
        my ($lt, $gt) = (0, 0);
        while (<I>) {
            s/->//g; # pointer deref not comparison
            $lt += tr/</</; # count
            $gt += tr/>/>/; # count
        }
        close I;
        my $ratio = ($lt / ($lt + $gt)) * 100;
        printf "'<' (%d) '>' (%d) (%d%%) %s\n", $lt, $gt, $ratio, $filename;
    }
    $ perl count-compare.perl diff*.c
    '<' (9) '>' (4) (69%) diff-cache.c
    '<' (20) '>' (26) (43%) diff-delta.c
    '<' (8) '>' (1) (88%) diff-files.c
    '<' (12) '>' (1) (92%) diff-helper.c
    '<' (11) '>' (11) (50%) diff-tree.c
    '<' (28) '>' (10) (73%) diff.c
    '<' (3) '>' (0) (100%) diffcore-pathspec.c
    '<' (2) '>' (0) (100%) diffcore-pickaxe.c
    '<' (22) '>' (6) (78%) diffcore-rename.c

This clearly shows that diff-delta.c does not have my code at
all.  Most of the others have been touched moderately to heavily
by me, or in some cases done entirely by me.

Personally, what I find most interesting is that diff-tree.c is
something you did quite a lot of nice features (and hence
something I was afraid to touch), and the number clearly shows
my hesitation.  It does not have as many '<' as it would have
had, if I had mucked with it as freely as I did to the others.

