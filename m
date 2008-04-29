From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Mon, 28 Apr 2008 22:17:10 -0700
Message-ID: <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
 <20080422095549.GB3752@alea.gnuu.de>
 <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness>
 <7vy775ygjm.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness>
 <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 29 07:18:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqiEJ-000687-Dn
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 07:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbYD2FR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 01:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbYD2FR2
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 01:17:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbYD2FR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 01:17:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BEF693A87;
	Tue, 29 Apr 2008 01:17:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8CCDA3A83; Tue, 29 Apr 2008 01:17:18 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> (Johannes
 Schindelin's message of "Tue, 29 Apr 2008 01:39:51 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80647>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> No, read the message again and think for 5 minutes.
>
> pick abcdefg
> pick pqrstuv
>
> Now imagine that pqrstuv is a unique commit name _before_ cherry-picking 
> abcdefg, but not _after_ it.  Unlikely?  Yes.  Impossible?  No.

No, I am still being misunderstood.  That is not the uniqueness issue I
was talking about.

As I tried to describe in a message that used a phrase "the beauty of your
approach" (which I suspect you stopped reading after that phrase), your
rule "an object name names the commit after the last operation that used
the commit, unless it is the first appearance in the sequence, in which
case it names the original commit" works most of the time, but becomes
cumbersome and unwieldy when the history you try to reproduce becomes more
elaborate.  And the reason I suggested 'mark' was because I was seeing
this in the context of the sequencer, not just "rebase -i".

This is just a minor syntax issue and I am not sure why we got into this
misunderstanding, but let's try again.  Suppose you want to recreate this
history on top of a different O'.  For merges, upper parents are earlier
ones:

     A         reset O'
    / \        pick  B
   /   X       reset O'
  /   / \      pick A
 O---B   Z     merge B -- recreate X
  \   \ /      reset O'
   \   Y       pick C
    \ /        merge B? -- recreate Y
     C         reset B -- go back to recreated X
               merge B? -- recreate Z

The above sequence does not work.  As you already used B to create X',
when you want to recreate Y, the last operation used B is now X' and you
cannot name B' to merge that to C' to produce Y' (and the above sequence
is wrong in that it attempts to recreate Y' in a wrong order --- we should
reset to the recreated B and merge recreated C to produce Y', but for that
you need to be able to say "reset to B'", but you've already used B to
recreate X' so you cannot do that).

You could (because you are intelligent human) reorder things to take
advantage of the fact that pick and merge uses the "current detached HEAD"
to avoid refering to B in this particular case, like this:

        reset O'
        pick A
        reset O'
        pick B	
        reset O'
        pick C
        reset B	-- go back to recreated B
        merge C -- recreate Y
        reset A -- go back to recreated A
        merge B -- recreate X
        merge C -- recreate Z

But I think the only reason you can do this in this case is because B is
used only twice.  If you have a history where rewritten B itself (not the
result of applying/merging the rewritten B) needs to be used more than
twice as the second or later merge parent, I do not think you would have a
way to name that rewritten B for the later uses.

I may be mistaken and you may even be able to prove that there is always a
way to recreate any shape of history by reordering insns and still using
your rule, but the point is that the insn sequence needs to be prepared by
tools (i.e. frontends for the sequencer), and I do not want to make the
life of people who are writing the frontends any harder than necessary.

The syntax and semantics that uses 'mark' avoids this unwieldiness by
making the rule much simpler.

 * Operation operates on the current detached HEAD (as in your rule)

 * A commit object name always names _that_ commit object.

 * If you need to name an intermediate result, you 'mark' it.
