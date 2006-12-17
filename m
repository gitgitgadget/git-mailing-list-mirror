X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 16 Dec 2006 16:19:20 -0800
Message-ID: <7v4prv8jcn.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
	<em1vgj$bc3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 00:19:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34668>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvjkS-0005hB-OG for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751193AbWLQATW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWLQATW
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:19:22 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57493 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751193AbWLQATV (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 19:19:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217001920.HFIS20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 19:19:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zcKY1V00s1kojtg0000000; Sat, 16 Dec 2006
 19:19:33 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Things that I feel should be done need to be done to complete
>> v1.5.0 are:
> [...]
>>  - now reflog is enabled by default for user repositories, I
>>    have two worries about its effect, fortunately can be killed
>>    with a single stone.
>> 
>>    * the reflog grows unbounded;
>> 
>>    * revisions recorded in the reflog can be pruned out,
>>      rendering some entries in reflog useless.
>> 
>>    I am thinking about teaching fsck-objects and prune to keep
>>    revisions recorded in the reflog; we would need an end-user
>>    way to prune older reflog entries and I would appreciate
>>    somebody codes it up, but even without it, people can always
>>    use "vi" or "ed" on reflog files ;-).
>
> I'd rather not have prune keep revisions recorded in reflog. Reflog
> keeps also amended commits, and blobs from incrementally staged
> commits.

That is exactly why I would want to protect them from pruning;
the current alternative, git-lost-found, is usable but not so
nice from the point of view of end users .  The user should be
able to use show-branch --reflog, or use a different mode of
operation in the log family [*1*] to inspect the otherwise lost
commits, and as you prune unneeded reflog entries you could
prune those objects.

You could certainly arrange things the other way around.  As a
part of prune, you can prune the reflog entries that refer to
commits that were pruned away and no longer available.

HOWEVER, that is very unfriendly to the end users, because they
do not have much control in what 'prune' removes.  If you want
to keep a dozen or so recent states just in case you may have to
salvage rewound states (e.g. you may realize your amended commit
was faulty), how would you tell 'prune' to keep only those
objects from getting pruned?

That's right -- by holding references to them.  And that is
exactly how making prune to take reflog into account would help
the user.  If the user has unwanted commits (say, everything
that are more than 7 days old, plus this and that commits you
rewound an hour ago), they can be pruned away from reflog and
prune will take care of the rest.

So doing it in the way I described makes a lot more sense than
doing the other way around.

[Footnote]

*1* I have to warn you that this would require quite different
code to walk the commits, but certainly a lot simpler than the
ancestry traversal.  If you are interested in learning the
internals, this may be a good project to start with.
