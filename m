From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 23:18:08 -0800
Message-ID: <7vfypey573.fsf@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
	<7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 08:56:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhMET-0002Ta-Na
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 08:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVK3HSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 02:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVK3HSL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 02:18:11 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:59874 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751095AbVK3HSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 02:18:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130071727.NQFW6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 02:17:27 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511291852530.3099@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 29 Nov 2005 19:12:45 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12991>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 29 Nov 2005, Junio C Hamano wrote:
>> 
>> I have actually resolved one conflicting merge with this and it
>> was OK, except that it was a bit unpleasant when I first did
>> "git-diff-index HEAD" without giving any path ;-),
>
> What does "git-diff-files" do? Just output a lot of nasty "unmerged" 
> messages?

That was not what was unpleasant.  What was unpleasant was those
"unmerged" messages were buried under heap of normal diffs,
showing the successfully merged entries as the result of merge.

I am inclined to munge your patch to do this:

 * Change -0/-1/-2 to -1/-2/-3 to be consistent with stage
   numbers, for technically minded.

 * Give --base, --ours, and --theirs as synonyms for -1/-2/-3,
   for end users.

 * Change it not to pick other unmerged stage (I sent a separate
   message about this already).

 * Change the diff_unmerged_stage default to 0.  While you are
   inspecting a conflicted merge, you need to give --ours (or
   -2) explicitly.  Alternatively we could first check if the
   whole index is unmerged and make it default to 2 without
   flags, but that would mean inspecting 19K entries first
   before starting the main loop for the kernel for normal case.
   With hot cache it is fine, so I'll try it first.

   This "with unmerged defaults to 2 otherwise defaults to 0"
   behaviour needs to be made overridable with an option, say -0
   (or --merged, but that is overkill); otherwise you cannot get
   diffs for merged paths until the index file is unmerged.

 * When diff_unmerged_stage is zero, keep the current behaviour.
   Show diff for only specified stage when diff_unmerged_stage
   is not zero.
