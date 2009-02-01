From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Sun, 01 Feb 2009 11:22:08 -0800
Message-ID: <7vskmyt127.fsf@gitster.siamese.dyndns.org>
References: <871vulda2r.fsf@gigli.quasi.internal>
 <slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>
To: "Raimund Berger" <raimund.berger@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 20:23:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LThuw-0000Na-F6
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 20:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbZBATWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 14:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbZBATWQ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 14:22:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbZBATWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 14:22:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 607142A3CB;
	Sun,  1 Feb 2009 14:22:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4B8B82A3CA; Sun, 
 1 Feb 2009 14:22:10 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A1A68DA6-F095-11DD-AB34-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107989>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Reversing A and B is one thing, applying a sequence of
> merges in a different order is quite something else.

This point is true in theory but I haven't found it to cause problems in
practice.  Textual conflicts between topics do happen, but it does not
happen so often in overlapping areas across more than two topics that
earlier resolutions to them cannot be reused by the rerere mechanism.

Semantic conflicts and dependencies are harder to deal with.

Suppose you have a topic to introduce feature A.  You propose an
enhancement, validate what it does logically makes sense, queue it to the
testing integration branch and unleash it to the world for real world
testing.

    ---o-------*     test integration branch
      /       /
     /       o       feature A
    /       /
   o---o---o---o---o mainline

Later, you find out that there is a bug B, and your enhancement to
implement A does not work as intended when B triggers.

You could do two things.

 (1) You extend feature A topic and queue the fix there.

    ---o-------*---*  test integration branch
      /       /   /
     /       o---o    feature A + bugfix B
    /       /
   o---o---o---o---o  mainline

 (2) Because B is an independent bug, you can have its own topic to fix it
     and merge ot to test integration, planning to merge it later to
     mainline independently from feature A topic.

      ---o-------*---*   test integration branch
        /       /   / 
       /       /   o     bugfix B
      /       /   /
     /       o   /       feature A
    /       /   /
   o---o---o---o---o     mainline


Neither is satisfactory.

The former is bad because it takes hostage of a useful bugfix to the
feature.  Without adding the feature A, which may or may not be what
people want to have, you cannot merge the fix to the mainline.

The latter is better because bugfix B could independently be merged to
mainline, but it risks you forgetting to merge it when you merge feature A
to the mainline.  By the time you decide to merge feature A to the
mainline, the test integration branch has had both for some time, and you
didn't seen the problem bug B causes to feature A there, but if you merge
only feature A but not fix B to the mainline, suddenly you have a buggy
feature on the mainline.

This is where you need to use the tool right to get the most out of it.

You could do this in addition to (2).

 (3) Because B is an independent bug, you can have its own topic to fix it
     and merge it to the test integration, planning to merge it later to
     mainline independently from feature A topic.  But you already know
     feature A depends on bugfix B to work correctly, so you merge the fix
     to the feature as well in advance.

      ---o-------*---*   test integration branch
        /       /   / 
       /       /   o     bugfix B
      /       /   / \
     /       o-------*   feature A
    /       /   /
   o---o---o---o---o     mainline

This way, even if you later choose to merge feature A, forgetting that you
have to have bugfix B for it to work, to the mainline, the merge will
bring in the necessary fix with it automatically.

      ---o-------*---*   test integration branch
        /       /   / 
       /       /   o     bugfix B
      /       /   / \
     /       o-------*   feature A
    /       /   /     \
   o---o---o---o---o---* mainline

This technique to resolve conflicts and dependencies early between topics
to force a merge order to the mainline can be used not only to deal with
semantic conflicts but textual ones, too.  If two branches textually
interact badly, you prepare a consolidated topic between the two, so that
you can merge A alone, B alone, or A+B together to the mainline.

If you end up merging A first and then want to merge B later (or the other
way around, merge B and then A), and if the second merge to the mainline
causes huge textual conflicts, you can instead merge the conslidated topic
A+B to the mainline.
