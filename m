From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Mon, 21 Jun 2010 01:06:07 +0200
Message-ID: <201006210106.07758.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006181140.16652.johan@herland.net>
 <7vzkyptwat.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 01:10:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQTf5-00029w-DN
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 01:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431Ab0FTXGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 19:06:12 -0400
Received: from smtp.getmail.no ([84.208.15.66]:46138 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410Ab0FTXGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 19:06:10 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4C00BGZ5I82320@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 21 Jun 2010 01:06:08 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 587C21EA54B6_C1E9EE0B	for <git@vger.kernel.org>; Sun,
 20 Jun 2010 23:06:08 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1C0631EA2765_C1E9EE0F	for <git@vger.kernel.org>; Sun,
 20 Jun 2010 23:06:08 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4C00E7Z5I8F500@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 21 Jun 2010 01:06:08 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <7vzkyptwat.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149407>

On Sunday 20 June 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > On Thursday 17 June 2010, Jens Lehmann wrote:
> > ...
> > 
> >> And no 'special' branch is used here.
> > 
> > Well, you need to traverse _some_ submodule ref(s) in order to find 'E'
> > at all. My argument is that there may also be _other_ submodule refs
> > that contain merges of 'B' and 'F' as well, and they should _also_ be
> > considered as valid candidates for the resolution in '5'. I would in
> > fact argue that you should traverse _all_ submodule refs (maybe even
> > including remote- tracking refs) to look for merges of 'B' and 'F'
> > [1], and present them all as equal alternatives.
> > 
> > Consider for example this submodule scenario:
> >         -----------G      [maint]
> >        /          /
> >    ---B--------  /        [feature_a]
> >   /    \       \/
> >  A--C---D---E  /\         [master]
> >      \     /  /  \
> >       ----F---    \       [feature_b]
> >               \    \
> >                --H--I--J  [next]
> > 
> > If there exist multiple merges that resolve 'B' and 'F' (in this case:
> > 'G', 'E' and 'I'), then all of those should be presented as equal
> > alternatives to the user.
> 
> You lost me completely here.
> 
> I thought you were going to argue that it would be an utterly wrong thing
> to suggest E or I as a probably resolution if the superproject merge that
> needs to merge superproject commits that binds B and F as its submodules
> is being done in the context of advance 'maint' track of the
> superproject.
> 
> Think of 'D' as a commit that corresponds to a major version bump point
> of the superproject; i.e. it introduces a major change to the submodule.
>  In the 'maintenance track' of the superproject for maintaining the
> previous version, you don't want to have any commit that has 'D' as an
> ancestor.
> 
> For an "automated" heuristics based on "find common descendants" to make
> sense, the branches you are merging have to share the common purpose, and
> you need to limit the common descendants you find to the ones that are
> compatible with the shared purpose.  The purpose of 'maintenance track'
> may be to maintain the previous version without dragging newer and more
> exciting things that happened in the later development.  In the above
> picture, G (that has nothing but B and F) is the only commit that can be
> safely assumed that two commits in the superproject space that bind B and
> F respectively can use as the submodule as their merge result.  E and I
> are contaminated with D and H whose purpose in the superproject space is
> unknown without further hint.

Yes, from a 'maint'-perspective, using G in the superproject probably makes 
more sense than using E or I. From a different superproject perspective, 
though, using E or I might make more sense. If, say, the superproject 
customarily follows the commits on the 'master' branch in the submodule, but 
the superproject has not yet gotten around to updating from A to C, D or E, 
then, by the time we do the superproject merge of Alice and Bob's branches, 
I would still say that using E is better than using G.

My argument is that without knowing the purpose of the superproject merge 
(which Git by itself _cannot_ know), Git should not prefer _any_ of these 
merges over the other, but must present them all as equal alternatives to 
the user.

Of course, the user has other alternatives as well, like creating a whole 
new merge in the submodule, or doing something completely different. But if 
existing submodule merges are to be considered valid alternatives, Git 
cannot pretend to know which of those merges are more suitable. It can only 
present them to the user, and then the user (after having examined the 
merges and their history relative to B and F) may choose the merge that 
matches the purpose of the superproject merge.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
