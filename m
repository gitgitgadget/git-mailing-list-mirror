From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit -c/-C/--amend: reset timestamp and authorship
 to committer with --reset-author
Date: Tue, 03 Nov 2009 23:14:43 -0800
Message-ID: <7vpr7ykbh8.fsf@alter.siamese.dyndns.org>
References: <1257304811-26812-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:14:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5a53-00036r-8j
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbZKDHOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 02:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbZKDHOq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:14:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZKDHOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 02:14:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2551991C8F;
	Wed,  4 Nov 2009 02:14:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=qjmlTmOCa4fwfDnYmSCQH8psSts=; b=QFLE7jxJ+JmNEPzCjUgxtzq
	y+LFwIPxTPGV7VzkHlPXf7TwDAPC239yePHXJt1SCTW5GVPReiqfZz/kxFXvNSbP
	CTS39c4Ga0dTJ/pz8By32XVMRQr3K0LQOl0T2c1LaQ+wHXwVEGrjODxR5I72UaPg
	G6jDJF2agNe1PxmKAXxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JrrHG9FkCahKMGgJRIqHYOwsiGGYr73nABOl4y6UyGBaVfIpO
	wczr7ElV+2wJQOpY2snMfe2Eov2T1oXPADys/GDZVukqlHuHhUsLUibsUsSMfwtU
	rjlATJXNQ2mRFp6gxGMvfwKABTf5N93dr8FD39ckpz/rVMqI4ucpDCmung=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0573E91C8E;
	Wed,  4 Nov 2009 02:14:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C244491C8D; Wed,  4 Nov 2009
 02:14:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC60F8F2-C911-11DE-B078-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132049>

Erick Mattos <erick.mattos@gmail.com> writes:

> Cutting --author away would make impossible for someone to force a new author
> with a new timestamp in case he is templating.  As an example he can be using
> the --author because he is doing a change in a computer not his own or
> something alike.

Sorry, but I cannot help feeling a bit frustrated and mildly irritated.

I had an impression that we have already established that setting the
author with --author="Somebody Else <s@b.e>" and committing with the
current time does not make much sense from the workflow point of view long
time ago in this thread.

The mail transport might have mangled the name, and when using --amend (or
read-tree followed by commit -c), it is handy to fix the mangled name by
using --author, but in such a case you would actively want to keep the
timestamp obtained from the e-mail via either --amend or -c.

But allowing this combination, even though it might not make much sense,
is just giving extra length to the rope, so it may not be such a big deal.

I didn't feel motivated enough to read the whole thing while other patches
are in my inbox, so I instead ran diff between the previous one (without
my suggestion today) and this round.

I see that you fixed a lot of grammar in the log message of my earlier
suggestion, all of which looked very good.  Also you added a check in the
program to make sure that --renew is given only when -C/-c/--amend is
given, which is also good.  Neither of our set of tests checks this
condition, though.  IOW, we would need to add something like this at the
end of my version (adjust to --reset-author for your version):

    test_expect_success '--mine should be rejected without -c/-C/--amend' '
            git checkout Initial &&
            echo "Test 7" >>foo &&
            test_tick &&
            test_must_fail git commit -a --mine -m done
    '

I am not sure why you insist to use your version of test script and keep
changing it, though.  It looks a lot worse even only after reviewing its
early part.

 - author_id runs an extra grep that is unnecessary.  The separation of
   _id and _timestamp are unnecessary if you checked against an expected
   author ident and timestamp as a single string, i.e.

   FRIGATE='Frigate <flying@over.world>' ;# do this only once at the beginning
   ...
   git commit -C HEAD --reset-author --author="$FRIGATE" &&
   echo "author $FRIGATE $GIT_AUTHOR_TIME" >expect &&
   author_header HEAD >actual &&
   test_cmp expect actual

   This becomes irrelevant if we don't support mixing --renew and
   --author, of course.

 - message_body() now has a backslash whose sole purpose is to be an
   eyesore.

 - initiate_test() does not string the commands together with &&

I might change my mind after I take a break, review others' patches, and
spend some time on my own hacking on other topics before revisiting this
patch, but at this point I find that reviewing newer rounds of this series
has rather quickly diminishing value, and more time is being spent on
teaching shell scripting to you rather than on polishing the end result.

Sorry, but I cannot help feeling a bit frustrated and mildly irritated.
Time to take a break and attend other topics for a change.
