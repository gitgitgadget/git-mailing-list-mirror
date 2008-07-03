From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Thu, 03 Jul 2008 15:11:45 -0700
Message-ID: <7vlk0iy5we.fsf@gitster.siamese.dyndns.org>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
 <7vbq1f68rh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807031142540.9925@racer>
 <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
 <7vbq1f68rh.fsf@gitster.siamese.dyndns.org>
 <20080703210950.GC6677@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEX2w-0003RL-J4
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 00:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694AbYGCWL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 18:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756723AbYGCWL4
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 18:11:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694AbYGCWLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 18:11:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6EA6A12491;
	Thu,  3 Jul 2008 18:11:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 74AF812490; Thu,  3 Jul 2008 18:11:48 -0400 (EDT)
In-Reply-To: <20080703210950.GC6677@leksak.fem-net> (Stephan Beyer's message
 of "Thu, 3 Jul 2008 23:09:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B73576E-494D-11DD-8038-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87329>

Stephan Beyer <s-beyer@gmx.net> writes:

> +		sed -e 's/[$"\\]/\\&/g' -n -e '
>  			s/^Author: \(.*\)$/GIT_AUTHOR_NAME="\1"/p;
>  			s/^Email: \(.*\)$/GIT_AUTHOR_EMAIL="\1"/p;
>  			s/^Date: \(.*\)$/GIT_AUTHOR_DATE="\1"/p
> ###
>
> Is escaping $, " and \ enough?

Look at how it is done in git-sh-setup get_author_ident_from_commit.

>> > +	if test -n "$failed"
>> > +	then
>> > +		# XXX: This is just a stupid hack:
>> > +		with_author git apply $apply_opts --reject --index "$PATCH"
>> 
>> Please don't do this without being asked, if you are planning to use this
>> in "am" when 3-way fallback was not asked.  It _may_ make sense to give an
>> option to the users to ask for .rej if they prefer to work that way better
>> than working with 3-way merge fallback, but doing this without being asked
>> is not acceptable.
>
> The --reject was just a mind marker for that what I actually think is
> useful and less annoying than the current behavior:
>
>> > +		die_to_continue 'Patch failed. See the .rej files.'
>> > +		# XXX: We actually needed a git-apply flag that creates
>> > +		# conflict markers and sets the DIFF_STATUS_UNMERGED flag.
>> 
>> That is what -3way is all about, and this codepath is when the user did
>> not ask for it, isn't it?
>
> Now imagine you apply a patch that cannot be applied 100% cleanly and
> you don't have the 3-way base in the repo. You know what happens?

Do you think I don't?  You can check who invented 3way by running "git
log" or "git blame" on git-am.sh ;-)

I think you misread my "That is what -3way is all about".  That remark is
about the comment you have about "creates conflict markers".  The conflict
markers is only possible because we do 3-way merge when you ran "am -3".
If you do not have the base object but only a blob and an unapplicable
patch, you cannot do "here is our change since common ancestor, and here
is their change the patch wants to make" conflict markers, because you do
not have the common ancestor.

> Yes, the patch is completly rejected, because apply is atomic.
> And I think a git-apply option that results in a non-atomic behavior,
> that creates conflict markers (and no .rej files), would be a great
> usability feature for the "patch" insn in sequencer.

Yes, I think I already said in the message you are responding to that it
may make sense to have such an option (but at the same time we should
remember that nobody asked to add --reject to "git am").
