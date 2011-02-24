From: Johan Herland <johan@herland.net>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive
 filesystems
Date: Thu, 24 Feb 2011 01:58:24 +0100
Message-ID: <201102240158.24363.johan@herland.net>
References: <201102231811.45948.johan@herland.net>
 <AANLkTi=gAM3LGwU47_EkENerZeKmjwuhWhpHZJGSiW=n@mail.gmail.com>
 <7vfwre8sax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 01:58:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsPXL-0005Hn-Nk
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab1BXA60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 19:58:26 -0500
Received: from smtp.getmail.no ([84.208.15.66]:58307 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755079Ab1BXA60 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 19:58:26 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LH30002XK1CT780@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 24 Feb 2011 01:58:24 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id CC1B71EEEDCC_D65AD30B	for <git@vger.kernel.org>; Thu,
 24 Feb 2011 00:58:24 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 9F20E1EEEC91_D65AD30F	for <git@vger.kernel.org>; Thu,
 24 Feb 2011 00:58:24 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LH300NPPK1C1B10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 24 Feb 2011 01:58:24 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <7vfwre8sax.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167760>

On Wednesday 23 February 2011, Junio C Hamano wrote:
> I think two things are sensible to do, are relatively low hanging fruits,
> and are of low risk:
> 
>  - break checkout on such a tree on incapable filesystems; and

Wouldn't that be a regression from the current state (where the poor user in 
a case-insensitive worktree can at least "git rm" the offending files, and 
keep working without assistance from a case-sensitive worktree)?

What about giving a warning on checkout, instead, explaining the problem, 
and advising that - for now - the user can remove the offending files with 
"git rm"?

>  - per project configuration (or attribute given to paths underneath a
>    particular directory) that forbids or warns addition of case colliding
>    paths to the index; enforce it at write_index() codepath; and
> 
>  - if we choose to just warn in the second item above instead of
> downright forbidding, barf in cache_tree_update() codepath when the per
> project configuration (or attribute) triggers upon case colliding paths,
> to prevent a commit from being made.

I support making this a per-project configuration that will trigger at tree-
creation (i.e. commit) time. I would even argue that the default should be 
to warn about (though maybe not refuse) case-colliding filenames, since they 
are either (a) directly harmful for cross-platform projects, or (b) probably 
unwanted in most projects anyway.

Having a per-project configuration sure beats trying to solve the problem in 
a hook script (using "pre-commit" introduces the logistical problem making 
sure everybody installs/enables the hook, whereas using "update" requires 
(precious) server runtime, triggers too late in the developer's workflow 
(forcing developer to amend/rebase), and probably confuses newbie developers 
as well).

> I think "warn at add time, fail at write-tree time" is more preferrable,
> as it might be more convenient if you can add hello.c while you still
> have HELLO.c in the index as long as you do not forget to remove HELLO.c
> from the index before making your next commit.

Agreed.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
