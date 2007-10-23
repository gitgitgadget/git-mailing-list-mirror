From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rev-list: implement --bisect-all
Date: Tue, 23 Oct 2007 14:33:15 -0700
Message-ID: <7vabq97bz8.fsf@gitster.siamese.dyndns.org>
References: <20071008053438.6a829b91.chriscool@tuxfamily.org>
	<Pine.LNX.4.64.0710080442420.4174@racer.site>
	<200710080708.46579.chriscool@tuxfamily.org>
	<Pine.LNX.4.64.0710080607180.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 23 23:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkRNa-000330-13
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 23:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbXJWVdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 17:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXJWVdX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 17:33:23 -0400
Received: from rune.pobox.com ([208.210.124.79]:45457 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbXJWVdW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 17:33:22 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 4E01114EBDE;
	Tue, 23 Oct 2007 17:33:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C4D614EB34;
	Tue, 23 Oct 2007 17:33:39 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710080607180.4174@racer.site> (Johannes
	Schindelin's message of "Mon, 8 Oct 2007 06:08:58 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62161>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 8 Oct 2007, Christian Couder wrote:
>
>> but I am not sure that the "dunno" logic should be the first part of it 
>> to be done in C.
>
> The thing is, git-bisect is porcelain-ish.  And by having a lot of the 
> functionality there, which is not really porcelain, but plumbing, you 
> prevent other porcelains, such as git-gui or qgit, from using that 
> function.
>
> Which is bad.

Still, it is good to prototype in the script while figuring out
what the desired behaviour is, I would say.

What I was hoping to see when I posted --bisect-all suggestion
was a bit different from what Christian did, by the way.

In addition to the bisect/skip-* that are filtered at the shell
level, if you feed the list of commits that cannot be tested to
the bisection plumbing, you can affect the way the resulting
list from the --bisect-all is sorted.

Suppose you have this (B is bad, G is good):

           o---.........---o---Y---o---o---B
          /                       /
     G---o---.........---o---Z---X

and one round of bisection picked X.  You find it untestable,
and Y and Z both bisects the remaining set equally well.  In
such a case, the current code sorts the resulting set, with Y
and Z next to each other (because they are both closest to the
midway), and the Porcelain filters out X which is better than Y
or Z.  You may end up picking Z.

Often, when X is not testable, neither is Z.  We would be better
off to avoid checking a commit close to what are known to be
untestable while there are other commits that are equally close
to the midway.

So instead of sorting the list solely based on the mid-ness like
the current code does (i.e. compare_commit_dist()), we can tweak
commits' mid-ness value (i.e. best_bisection_sorted() computes
it in distance variable) by penalizing it with the closeness of
the commit to known untestable commits.

Naively, "closeness" of commit Z to commit X can be defined as
something simple as "rev-list Z...X | wc -l".  The smaller the
number, the closer the commits.
