From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 02:04:11 -0700
Message-ID: <7v6494dwms.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	<7v8xe0h19a.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140128y46ff6bb6m503eeae00c043ddf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 10:04:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRPP6-00021m-SS
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 10:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933896AbXCNJEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 05:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933901AbXCNJEN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 05:04:13 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53798 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933896AbXCNJEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 05:04:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314090412.DEZN748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 05:04:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aZ4B1W00J1kojtg0000000; Wed, 14 Mar 2007 05:04:12 -0400
In-Reply-To: <81b0412b0703140128y46ff6bb6m503eeae00c043ddf@mail.gmail.com>
	(Alex Riesen's message of "Wed, 14 Mar 2007 09:28:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42187>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Challenging... Now, if someone just told me where to look for
> differences in diff-tree case...

As the resident git-diff expert I might hack on this myself as
the --quiet options are useful, and --exit-code comes almost
free when you properly do --quiet that implies --quick.

>> A slight tangent, but what Linus recalled he thought he did but
>> he didn't is related to the parts you touched in diff-tree
>> above.  Because of the interaction with diffcore, these changes
>> should not be used for the purpose of -exit-code, but catching
>> the tree level change in the above places and leaving early
>> would be the right thing to do for comparing the whole tree for
>> the purpose of simplifying the parents.  Tomorrow will be my git
>> day so I might whip up a patch to speed that up.
>
> Can it eventually be wired to "-s" (DIFF_FORMAT_NO_OUTPUT)?

I do not think so.  When we run diff internally to pick the set
of paths (i.e. run diffcore and check contents of diff_queue,
just like you did for diff-index/diff-files), we internally use
NO_OUTPUT.  See merge-recursive.c for an example.

>> >       diffcore_std(&revs->diffopt);
>> > +     ret = revs->diffopt.diff_exit_code && diff_queued_diff.nr ? 1: 0;
>> >       diff_flush(&revs->diffopt);
>> >       return ret;
>> >  }
>>
>> This side looks correct, as you are counting queued_diff.nr after
>> letting diffcore_std() to filter the results.
>
> And it will continue to work if the diffing is left early because of
> no output needed. Err, will it?

To implement --quick correctly, you need to know when it is safe
to leave early.  Presence of -S (pickaxe) would most likely mean
you shouldn't leave early.
