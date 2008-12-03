From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement rebase -q to fix pull --rebase -q
Date: Wed, 03 Dec 2008 13:14:09 -0800
Message-ID: <7vljuxc672.fsf@gitster.siamese.dyndns.org>
References: <1228277212-5917-1-git-send-email-tuncer.ayaz@gmail.com>
 <7vej0pheww.fsf@gitster.siamese.dyndns.org>
 <4ac8254d0812030007w3217f6eei3d364ce2272930c3@mail.gmail.com>
 <7vr64pfyvg.fsf@gitster.siamese.dyndns.org>
 <4ac8254d0812030035n52fde4b3s29c0f525e175f123@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7z4P-0000UI-3E
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 22:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbYLCVOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 16:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbYLCVOR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 16:14:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbYLCVOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 16:14:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9286D83DB6;
	Wed,  3 Dec 2008 16:14:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 049BD83DB4; Wed,
  3 Dec 2008 16:14:10 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 566B5942-C17F-11DD-AAED-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102288>

"Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:

> On Wed, Dec 3, 2008 at 9:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Ahh, ok, if this is for cron jobs, then it is understandable that:
>>
>>  (1) You may want a successful "git pull" or "git pull --rebase" to be
>>     absolutely silent about what it did; and
>>
>>  (2) A failed "git pull" and "git pull --rebase" that produces information
>>     other than the fact it failed would not help you, the receiver of a
>>     cron job report, very much.  You would go to the repository when it
>>     fails, reset the mess away, and then do the pull or pull-rebase
>>     yourself manually anyway.
>>
>> If that is the motivation behind the series, I think you would really want
>> to squelch output from "format-patch | am -3" pipeline.
>
> You mean I should follow this path and produce a patch series instead?

Not necessarily.  It is entirely up to you.

An important point at this point is that the patch as submitted, without
such a change, will not be useful to achieve the goal (1) above, because
it will still be chatty.

>> would be driving "git pull" from a cron job.  IOW, you probably would want
>> something like "--really-quiet" mode.
>
> Yeah, it gets messy and in the current codebase. I am also not sure whether
> the effort/benefit ratio is good enough.

I doubt "the current codebase" has more downside than upside as you seem
to imply.  The way rebase uses layered set of other commands keeps the
door open to spread the benefits around.  If you squelch format-patch, you
would help people who would want to drive it from their cron job (perhaps
they are on dial-up and they would rather batch things up than running
format-patch and send-email from their post-receive hook).  If you squelch
am, you would help people who use it as a part of their mailing list
scanning software that runs unattended.  Of course, you could choose to
squelch the "format-patch | am -3" pipeline in one go by redirecting the
entire pipe to somewhere, instead of giving individual commands --quiet
option.  If you did so, obviously the benefits won't be spread to users of
these underlying commands.

But I do not think squelching of these individual commands such as
format-patch, am, and pull are so useful in the larger picture in the
context of scripting; see below.

>> I would write such a cron-job script to capture the log and send it only
>> upon failure from the underlying command if I were doing this myself,
>> though.
>
> This is the way I do it now and I'm surprised I found no other simple way
> than writing a wrapper script for it. At least not with vixie-cron.

Actually I am not so surprised.

A cron job that contains a git pull most likely needs to be a script that
wants to do many other things anyway, such as chdir into the target
repository, make sure nobody (including yourself) did not by mistake went
into the repository and made local changes that may interfere with the
pull and if so abort, perform the pull, noticing its exit status, produce
the error report and exit if pull fails, validate each new commits the
pull brought in against some in-house coding standard, run a build test
(perhaps "make test") if pull succeeded, noticing its exit status, produce
the error report and exit if the build fails, install the build result if
build succeeded, and so on.  Individual steps such as "git pull" and "make
install" are only small self-contained building blocks in such a workflow,
and it is not unusual for such a script to redirect output from the
building blocks it uses and produce a summarized report at the very end of
the run using the redirected output, while emitting messages on its own.

In such an arrangement, having "a bit quieter than usual" option in the
underlying command, which would be what we would want for these primarily
interactive commands, is not very useful anyway, because the "quieter"
output mode may drop some information you might want to include in the
fuller report when something goes wrong, and filtering such "a bit
quieter" output takes as much effort as filtering the output from the
normal mode when there is nothing noteworthy to report and your script
wants to squelch the output entirely.
