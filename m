From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Diff updates, fixing pathspec and rename/copy
 interaction.
Date: Fri, 27 May 2005 11:22:23 -0700
Message-ID: <7vd5rczfz4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 20:22:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbjSq-0003kr-5v
	for gcvg-git@gmane.org; Fri, 27 May 2005 20:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVE0SXa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 14:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVE0SX3
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 14:23:29 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56476 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262518AbVE0SWa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 14:22:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527182224.SJON7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 14:22:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 27 May 2005 08:56:35 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I would much prefer a _much_ simpler fix at least for the pathname part,
LT> which is to just always require that pathspec handling is done _first_.

LT> Why? Because that's fundamentally how git-diff-tree has to work, and it's
LT> how my mental model has always been: the path limitations are a
LT> first-order filter, and if you give a directory, the end result should
LT> always look exactly as if that directory was a project of its own.

Enlightment!

My initial thinking was to do rename/copy first, deliberately
ignoring pathspec (I was thinking about tweaking diff-tree to
break out of its built-in pathspec limit to feed diffcore
_everything_, even things outside of the specified directories
when --detect-copies-harder is used), to cast a wider net so
that it can come up with "the best matches".  But what you just
said made me realize that the definition of "the best matches" I
had in mind was not best at all.  I agree with you 100% that
pathspec should come first before everything else to limit the
world diffcore operates in, not just to limit the set of output
paths.

I still want to do what this patch does for another reason.  It
is so much simpler if I do not have to carry around _some_
unmatched pair after rename/copy.  The earlier representation
was forcing all the downstream diffcore filters to be aware of
what rename/copy did, which was simply _wrong_.  They should not
have to care.

About ordering of pickaxe and rename/copy, I think for most uses
of diffcore filters, not limited to pickaxe, would make more
sense if they come after rename/copy when rename/copy detection
is in effect.  What I really wanted to do (I made a side note
comment in the earlier discussion about this, saying "something
like streams", but have not pursued it further) is to make these
diffcore filters/transformations stackable so that the main
programs can control not just if each of them is used or not,
but the order of application of the used ones.  I cannot offhand
think of a good use case of having pickaxe come _before_
rename/copy, but there may be a case the user want to have
things in that order, and having the application order not
hardcoded in three diff-* brothers is a major problem if we
wanted to give that option.

