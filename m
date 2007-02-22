From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-diff{,-files} the new option `--no-index`
Date: Thu, 22 Feb 2007 10:09:47 -0800
Message-ID: <7vvehuf4ic.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702201944340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzm76fpia.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702221724090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 19:10:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKIOE-0002xQ-4T
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 19:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbXBVSJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 13:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbXBVSJv
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 13:09:51 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35162 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbXBVSJs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 13:09:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222180949.FIWN2670.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 13:09:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Si9n1W00Y1kojtg0000000; Thu, 22 Feb 2007 13:09:48 -0500
In-Reply-To: <Pine.LNX.4.63.0702221724090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Feb 2007 17:25:49 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40364>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 22 Feb 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > +int run_diff_files(struct rev_info *revs, int argc, const char **argv)
>> >  {
>> >  	int entries, i;
>> > +	int diff_unmerged_stage;
>> > +	int silent_on_removed;
>> > +
>> > +	if (handle_diff_files_args(revs, argc, argv, &silent_on_removed))
>> > +		return -1;
>> > +
>> > +	diff_unmerged_stage = revs->max_count;
>> > +
>> > +	if (revs->max_count == -2) {
>> > +		if (revs->diffopt.nr_paths != 2)
>> > +			return error("need two files/directories with --no-index");
>> > +		queue_diff(&revs->diffopt, revs->diffopt.paths[0],
>> > +				revs->diffopt.paths[1]);
>> > +		diffcore_std(&revs->diffopt);
>> > +		diff_flush(&revs->diffopt);
>> > +		return 0;
>> > +	}
>> 
>> I do not mind the "max_count == -2 is some magic" hack too much,
>> but I do not think it belongs to a generic service function
>> whose purpose is to run "diff-files" aka "diff between index and
>> working tree".  run_diff_files() is used by other applications
>> (most notably wt-status) for example, and I expect we would need
>> that when we rewrite git-commit itself in C.
>
> Well, the alternative is to duplicate code, as you need both the option 
> parsing and the special handling of max_count==-2 in both builtin-diff.c 
> and builtin-diff-files.c.

Can't they made to call a new function, which has the option
parsing followed by the switch between magic max_count==-2
codepath and run_diff_files()?
