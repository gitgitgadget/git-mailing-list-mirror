From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Tue, 19 Feb 2008 16:48:05 -0800
Message-ID: <7v4pc4fo6y.fsf@gitster.siamese.dyndns.org>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
 <20080219074423.GA3982@steel.home>
 <76718490802190549p549a34afo913efefebaf5fa97@mail.gmail.com>
 <20080220001339.GA16574@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 01:49:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRd8z-0003kf-OA
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 01:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757997AbYBTAsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 19:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757726AbYBTAsa
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 19:48:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760AbYBTAs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 19:48:29 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8722B778F;
	Tue, 19 Feb 2008 19:48:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 499C97785; Tue, 19 Feb 2008 19:48:17 -0500 (EST)
In-Reply-To: <20080220001339.GA16574@steel.home> (Alex Riesen's message of
 "Wed, 20 Feb 2008 01:13:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74486>

Alex Riesen <raa.lkml@gmail.com> writes:

> Well, it could also mean that there is no rules yet, and you can
> do the next sane thing of your choice.
>
>> enum color_branch {
>> 	COLOR_BRANCH_RESET = 0,
>> 	COLOR_BRANCH_PLAIN = 1,
>> 	COLOR_BRANCH_REMOTE = 2,
>> 	COLOR_BRANCH_LOCAL = 3,
>> 	COLOR_BRANCH_CURRENT = 4,
>> };

This enum is used as an index into branch_colors[] array.  Of
course, by omitting everything you will get the default "start
with 0, incrementing by 1" which will be the right assignment
anyway.  But we would want to leave a clue for people who would
want to touch this later that individual values have some
meaning, more than just that they have to be distinct.

>> enum {
>> 	TAGS_UNSET = 0,
>> 	TAGS_DEFAULT = 1,
>> 	TAGS_SET = 2
>> };

This one can be made unspecified or even shuffled, because
nobody does:

	int function_that_acts_on_tag_setting(int tag) {
                if (!tag) {
                        ... do something ...
                }
                if (TAGS_DEFAULT <= tag) {
                        ... do something else ...
                }
                return some_array[tag];
	}

So there is no reason to spell out any of the values.

>> enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;

Likewise.

>> enum exist_status {
>> 	index_nonexistent = 0,
>> 	index_directory,
>> 	index_gitdir,
>> };

Likewise, modulo that making "nonexistent" explicitly to 0 is a
very sensible thing whoever wrote that code has done.  This is
used as a type of directory_exists_in_index() function, and
callers can say:

       	if (!directory_exists_in_index(dirname)) {
        	... ah, there is no such directory ...
	} else {
        	... something exists, but I do not care what kind ...
	}

So spelling out that "nonexistent MUST BE 0" (even though C
language will give value 0 to it anyway) is a good convention.

>> enum CAPABILITY {
>> 	NOLOGIN = 0,
>> 	UIDPLUS,
>> 	LITERALPLUS,
>> 	NAMESPACE,
>> };

This seems to be meant to match the order in the corresponding
cap_list[] array, so this cannot be reshuffled (iow, it is
similar to color_branch).

If you do not need to have any specific value assigned nor order
among the enum tokens, (i.e. somebody later can add a new enum
anywhere in the decl or even reshuffle the existing ones without
breaking your code), it is a good idea to hint that fact by not
having any "= value" in the decl.  If you do rely on specific
one being zero (see "exist_status" example above), it is better
to spell it out that it has to be zero even if it is the first
entry to hint that fact.  Of course, if you need a set of values
that are not sequential, you would need to spell out each and
every one of them.
