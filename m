From: David Kastrup <dak@gnu.org>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 19:50:43 +0100
Message-ID: <87y51g88sc.fsf@fencepost.gnu.org>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
	<CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 19:50:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDetU-00014V-If
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbaBLSuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:50:46 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:56362 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbaBLSup (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:50:45 -0500
Received: from localhost ([127.0.0.1]:55403 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDetQ-0001mI-7R; Wed, 12 Feb 2014 13:50:44 -0500
Received: by lola (Postfix, from userid 1000)
	id B8745E047A; Wed, 12 Feb 2014 19:50:43 +0100 (CET)
In-Reply-To: <CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
	(Stefan Zager's message of "Wed, 12 Feb 2014 10:12:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242009>

Stefan Zager <szager@chromium.org> writes:

> On Tue, Feb 11, 2014 at 6:11 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> I have no comments about thread safety improvements (well, not yet).
>> If you have investigated about git performance on chromium
>> repositories, could you please sum it up? Threading may be an option
>> to improve performance, but it's probably not the only option.
>
> Well, the painful operations that we use frequently are pack-objects,
> checkout, status, and blame.

Have you checked the patch in
<URL:http://thread.gmane.org/gmane.comp.version-control.git/241448> and
followups,
Message-ID: <1391454849-26558-1-git-send-email-dak@gnu.org>?

While this does not yet support -M and -C options, it's conceivable that
you don't use them in your server/scripts.

> Anything on Windows that touches a lot of files is miserable due to
> the usual file system slowness on Windows, and luafv.sys (the UAC file
> virtualization driver) seems to make it much worse.

There is an obvious solution here...  Dedicated hardware is not that
expensive.  Virtualization will always have a price.

> Blame is something that chromium and blink developers use heavily, and
> it is not unusual for a blame invocation on the blink repository to
> run for 30 seconds.  It seems like it should be possible to
> parallelize blame, but it requires pack file operations to be
> thread-safe.

Really, give the above patch a try.  I am taking longer to finish it
than anticipated (with a lot due to procrastination but that is,
unfortunately, a large part of my workflow), and it's cutting into my
"paychecks" (voluntary donations which to a good degree depend on timely
and nontrivial progress reports for my freely available work on GNU
LilyPond).

Note that it looks like the majority of the remaining time on GNU/Linux
tends to be spent in system time: I/O time, memory management.  And I
have an SSD drive.  When using packed repositories of considerable size,
decompression comes into play as well.  I don't think that you can hope
to get noticeably higher I/O throughput by multithreading, so really,
really, really consider dedicated hardware running on a native Linux
file system.

-- 
David Kastrup
