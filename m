From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Sat, 22 Mar 2008 12:40:16 -0700
Message-ID: <7v3aqik0nz.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
 <7vmyospgz7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "alturin marlinon" <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 20:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd9aX-0002cj-Uo
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 20:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbYCVTk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 15:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753707AbYCVTk3
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 15:40:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbYCVTk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 15:40:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EC6901021;
	Sat, 22 Mar 2008 15:40:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 081E7101F; Sat, 22 Mar 2008 15:40:23 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77842>

Junio C Hamano <gitster@pobox.com> writes:

> "alturin marlinon" <alturin@gmail.com> writes:
>
>> My plan for this summer is to create a 'statistics' feature for git.
>>
>> It would provide the following functionality:
>> * Show how many commits a specific user made.
>> * Show the (average) size of their changes (in lines for example).
>> * Show a 'total diff', that is, take the difference between the source
>> with, and without their changes, including its size (with for example
>> a -c switch).
>> * Show which contributors have contributed to the part of the code
>> that a patch modifies.
>> * Show what part of the code a maintainer is working on the most.
>> * Define an output format for this information that can be used by
>> other tools (such as gitk and git-web)
>> * (Optional) Integrate all this information with gitk and git-web.
>
> * Within reasonable amount of time suitable for interactive use, if you
>   intend it to work with gitk.
>
> What's the ballpack performance goal for e.g. post 2.6.12 kernel history
> which is about 85k commits, 3800 authors, 24k files?
>
> * Who contributed the most code that needed the many fix-ups on top?
>
> * Which part of the codebase had the most commits that had "oops, screwed
>   up, I am fixing this but this is a tricky code" fixes?

A couple more food-for-thought.

* Figure out which blocs of lines (not necessarily the whole files) relate
  to each other by noticing that they are often modified in the same
  commit.

  For example, if you find that the earlier part of a file A.c is updated
  often only by itself, but many other commits often modify the later part
  of A.c and another file B.c at the same time, it might suggest that a
  better reorganization of the code is to split the later part of A.c and
  move it to B.c.

* Who are early birds and who are late night owls?  Who are day-job
  contributors and who are weekenders?

* Identify "buggy commits" from history, without testing.  Zeroth order
  approximation is that the lines it introduced were later rewritten by
  other later commits, but the later ones are not necessarily fixes but
  can be enhancements, so you would need a way to tell which ones are
  "fixing commits" and which ones are not.  You may want to use project
  specific hints to help you doing this:

  - a log that matches /This(?: commit) fixes/ is likely to be a fix;

  - a commit that touches the same vicinity of another commit after a
    short interval is likely to be a fix;

  - a commit that is made on 'maint' branch by definition is a fix;

  - a commit that changes test_expect_failure to test_expect_success have
    a high probability that it itself is a fix, or it comes soon after a
    fix;

  Once you have "these are buggy commits, these are fixes" in place, the
  remaining would be "enhancements" and you can do interesting things.

  * For the integrator, can you spot a pattern like "what he accepts
    during weekdays tend to be buggier than what he applies during
    weekends"?

  * For each contributor, can you spot a pattern like "his late night
    commits are buggier than his early morning commits"?

  * Can you spot a pattern like "his changes to this area tends to be
    buggy but to that area tends to be very good"?

  * Who tends to introduce more bugs, who tends to do more fixes than
    enhancements?

  * Is their correlation between being a day-job contributor and being
    more fixer than bug-introducer?
