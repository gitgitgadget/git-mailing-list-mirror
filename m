From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Migrate bisect to C
Date: Sat, 14 Mar 2009 01:16:59 -0700
Message-ID: <7v63iccydg.fsf@gitster.siamese.dyndns.org>
References: <20090312085103.e83b34a5.chriscool@tuxfamily.org>
 <200903130702.01039.chriscool@tuxfamily.org>
 <7vfxhhj4mh.fsf@gitster.siamese.dyndns.org>
 <200903140846.17599.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Mar 14 09:18:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiP4u-00018y-4r
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 09:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbZCNIRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 04:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbZCNIRO
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 04:17:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbZCNIRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 04:17:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A1345AA5;
	Sat, 14 Mar 2009 04:17:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3EF665AA3; Sat,
 14 Mar 2009 04:17:01 -0400 (EDT)
In-Reply-To: <200903140846.17599.chriscool@tuxfamily.org> (Christian Couder's
 message of "Sat, 14 Mar 2009 08:46:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 835704B6-1070-11DE-A24B-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113243>

Christian Couder <chriscool@tuxfamily.org> writes:

> Do you mean that you want this series to migrate both "filter_skipped" and
> "check_good_are_ancestors_of_bad" to C? Or is it ok 
> if "check_good_are_ancestors_of_bad" migrates later?

One small step at a time.  That's the only sane way we can get there.

> If it is ok to migrate "check_good_are_ancestors_of_bad" later, then I think 
> something like the 8/7 patch I posted yesterday might be a good way, 

In the final shape, you will be reading from refs/bisect namespace using
for_each_ref(), and at that point you won't have anybody feeding the
skipped from the standard input.  The code you would add in [8/7] would
have to be removed if you go that route.  If you make the filter_skipped
codepath to read from for_each_ref() during this round, you can still keep
that codepath even after you fully migrate everybody to C, no?

> ...
> That means that at least one <commit-id> should always be passed to "git 
> rev-list".

But you do not have to even be tied to rev-list.  After all, the partial
migration of filter_skipped is not "git bisect in C", but more like the
first subcommand to "git bisect--helper" command that is written in C and
can be called from shell.  The next subcommand might be check_good_are...
and eventually you will have all the necessary and complex pieces the
shell version of "git bisect" currently implements as shell function as
the subcommands of "git bisect--helper".  Finally, "git bisect in C" will
then make direct calls to the functions that would implement that "git
bisect--helper" command, and gets rid of the "helper" command altogether.

	Side note.  That was how git-fetch--tool was started; it was a
	helper to partially migrate slower parts of git-fetch.sh to C.  I
	suspect we can almost remove it but not quite yet...
