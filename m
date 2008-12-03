From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement rebase -q to fix pull --rebase -q
Date: Wed, 03 Dec 2008 00:26:27 -0800
Message-ID: <7vr64pfyvg.fsf@gitster.siamese.dyndns.org>
References: <1228277212-5917-1-git-send-email-tuncer.ayaz@gmail.com>
 <7vej0pheww.fsf@gitster.siamese.dyndns.org>
 <4ac8254d0812030007w3217f6eei3d364ce2272930c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 09:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7n5Z-0004rW-29
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 09:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbYLCI0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 03:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbYLCI0g
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 03:26:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbYLCI0g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 03:26:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D6CF717FF5;
	Wed,  3 Dec 2008 03:26:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9097517FD2; Wed, 
 3 Dec 2008 03:26:29 -0500 (EST)
In-Reply-To: <4ac8254d0812030007w3217f6eei3d364ce2272930c3@mail.gmail.com>
 (Tuncer Ayaz's message of "Wed, 3 Dec 2008 09:07:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 181763B8-C114-11DD-860E-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102226>

"Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:

> I mainly use -q in automation where I only want output if something
> goes wrong. Just like good old cp or mv do.
> Do you think this is the wrong way to go?
>
>> How are you dealing with messages from the actual replaying of each local
>> commit on top of what is fetched?  In order to be able to tell where you
>> are when one of them fail in conflicts, you cannot stay silent while doing
>> so.
>
> Fair point.

Ahh, ok, if this is for cron jobs, then it is understandable that:

 (1) You may want a successful "git pull" or "git pull --rebase" to be
     absolutely silent about what it did; and

 (2) A failed "git pull" and "git pull --rebase" that produces information
     other than the fact it failed would not help you, the receiver of a
     cron job report, very much.  You would go to the repository when it
     fails, reset the mess away, and then do the pull or pull-rebase
     yourself manually anyway.

If that is the motivation behind the series, I think you would really want
to squelch output from "format-patch | am -3" pipeline.

Another thing to consider is that, unlike simple single-operation commands
such as "mv" or "cp" you mentioned, what "git pull" does is much more
involved and has many different failure modes, so you cannot compare them
fairly.  Simple commands can have a single "quiet" level, but I have a
feeling that there is a difference between "quiet mode" I expect when I am
running "git pull" interactively and "quiet mode" I would want when I
would be driving "git pull" from a cron job.  IOW, you probably would want
something like "--really-quiet" mode.

I would write such a cron-job script to capture the log and send it only
upon failure from the underlying command if I were doing this myself,
though.
