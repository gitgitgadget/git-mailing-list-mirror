From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv3 4/9] pack-objects: Teach new option --max-object-count,
 similar to --max-pack-size
Date: Mon, 16 May 2011 11:49:45 +0200
Message-ID: <201105161149.45512.johan@herland.net>
References: <201105151942.29219.johan@herland.net>
 <BANLkTi=qtA=34=pdXuJ_cQu0pv6BnE2uSA@mail.gmail.com>
 <7vmxinmabl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 11:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLuR0-00026e-E5
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 11:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab1EPJts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 05:49:48 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54270 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753767Ab1EPJts (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 05:49:48 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLA002Q98MY5B90@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 16 May 2011 11:49:46 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id B9D4F1EA6082_DD0F33AB	for <git@vger.kernel.org>; Mon,
 16 May 2011 09:49:46 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 6AF391EA318E_DD0F33AF	for <git@vger.kernel.org>; Mon,
 16 May 2011 09:49:46 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLA008WY8MYEV20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 16 May 2011 11:49:46 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7vmxinmabl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173718>

On Monday 16 May 2011, Junio C Hamano wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> > On Sun, May 15, 2011 at 14:37, Johan Herland <johan@herland.net> wrote:
> >> The new --max-object-count option behaves similarly to
> >> --max-pack-size, except that the decision to split packs is
> >> determined by the number of objects in the pack, and not by the size
> >> of the pack.
> > 
> > Like my note about pack size for this case... I think doing this
> > during writing is too late. We should be aborting the counting phase
> > if the output pack is to stdout and we are going to exceed this limit.
> 
> Well, even more important is if this is even useful. What is the user
> trying to prevent from happening, and is it a useful thing?

I initially met this problem at $dayjob, where a user would push a large 
pack from an unrelated repo, and the push would be refused by our update 
hook, but not without storing the pack on the server first. Obviously, the 
main objective of the patch is to prevent the pack from being stored on the 
server in the first place. [1]

Based on that, I do not really care exactly what kind of limit I have to set 
in order to prevent the push. I can easily enough find usable thresholds in 
any of #objects, #commits or pack size.

> I think "do not hog too much disk" (i.e. size) is an understandable wish,
> and max-pack-size imposed on --stdout would be a good approximation for
> that.

Agreed.

> I would understand "this project has only these files, and pushing a tree
> that has 100x leaves than that may be a mistake" (i.e. recursive sum of
> number of entries of an individual tree). I would also sort-of understand
> "do not push too deep a history at once" (i.e. we do not welcome pushing
> a wildly diverged fork that has been allowed to grow for too long).
> 
> But I do not think max-object-count is a good approximation for either
> to be useful.

I agree in principle, but currently, it's the only limit that we can enforce 
on the server side.

> Without a good answer to the above question, this looks like a "because
> we could", not "because it is useful", feature.

Ok, I can drop the client side part of this patch (including the limit-
object-count capability), but I would like to retain the server side part 
(abort if pack header reveals too many objects), since otherwise I have to 
wait for all users to upgrade to a "limit-*"-aware client before I can 
consider this problem truly solved.


...Johan


[1]: There is a followup to this problem, where a subsequent 'git gc' will 
find all the objects in the pushed (but rejected by update-hook) pack to be 
unreferenced, and then explode them into loose objects. In one case, a user 
pushed a 300 MB pack to the server that was then exploded into 5 GB of loose 
objects by a subsequent 'git gc'. Needless to say, we now run 'git gc --
prune=now' as a workaround until this can be fixed.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
