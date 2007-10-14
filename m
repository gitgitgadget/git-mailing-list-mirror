From: Andreas Ericsson <ae@op5.se>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 01:55:56 +0200
Message-ID: <4712AC8C.9050006@op5.se>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, Johannes.Schindelin@gmx.de,
	tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 01:56:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhDJi-00027U-74
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 01:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbXJNX4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 19:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754579AbXJNX4F
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 19:56:05 -0400
Received: from mail.op5.se ([193.201.96.20]:53226 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbXJNX4D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 19:56:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2812B173068B;
	Mon, 15 Oct 2007 01:55:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q4ugQmtwSguT; Mon, 15 Oct 2007 01:55:44 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 8F93B173068A;
	Mon, 15 Oct 2007 01:55:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <u7ilpjp3x.fsf@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60929>

Eli Zaretskii wrote:
>> Date: Mon, 15 Oct 2007 00:14:46 +0200
>> From: Alex Riesen <raa.lkml@gmail.com>
>> Cc: Andreas Ericsson <ae@op5.se>, Benoit SIGOURE <tsuna@lrde.epita.fr>,
>> 	git list <git@vger.kernel.org>, Eli Zaretskii <eliz@gnu.org>,
>> 	Make Windows <make-w32@gnu.org>
>>
>> Re "functional". Have to remind something (besides the fork):
> 
> That's a 20-20 hindsight: if you deliberately write a program to rely
> heavily on Posix-isms, don't be surprised when you discover that it
> cannot be easily ported to other platforms.
> 

True. It was originally developed because Linux kernel development came
to a stand-still and needed an scm quickly. Since the original design
worked out nicely, nobody bothered (then) about possible future porting
issues. Windows is still a second class citizen, but that's true for
pretty much every unix-born application out there, so I'm not all that
stressed out about it.

> 
>> - no proper filename semantics (case-insensitivity and stupid rules for
>>   allowed characters in filenames, like ":" in filenames in
>>   cross-platform projects)
> 
> There's a flag on Windows to open files case-sensitively, if you need
> that.  In any case, I don't see how this can be of any real relevance
> to porting GIT.


Because having

	Path/foo
	path/Foo
	PATH
	path/foo

is possible in git's native playground, but not on windows, so it can
quite seriously hamper cross-platform cooperation. When that happens,
users usually start blaming the tools in use. Browse the list archives
for HFS and you'll see what I mean, although come to think of it, the
HFS problems might actually be worse, since HFS reports case-changes
while not actually being case-sensitive.


>  As for ":" in file names, simply don't use it, like
> you don't use white space or characters below 32 decimal: it's
> inconvenient, even if it's allowed.
> 

It's still a real problem because sooner or later someone will use that,
and it needs to be handled with a bit more grace than just bombing out.

> 
>> - no real "mmap" (which kills perfomance and complicates code)
> 
> You only need mmap because you are accustomed to use it on GNU/Linux.
> 

Not really. mmap() provides a real performance boost when reading large
repos, due to the sliding window code that handles pack-files. mmap
was invented for occasions like that, and was allowed to endure because
it was a much better solution than simply read(fd, buf, st.st_size) and
moving pointers around.


>> Interprocess communication:
>>
>> - no reliable text environment (I'm programming in the damn thing for
>>   10 years and I still don't know how to pass an environment variable
>>   _for_sure_)
>>
>> - it has only one argument (limited in size) passed to started
>>   programs, which means that there is no possible way to safely pass
>>   file and text arguments on command line (more than one, that is)
> 
> Not enough context, so I cannot talk intelligently about this.  Why do
> you need interprocess communication in the first place?


Because some of the commands operate on large data-sets that are best
passed as a stream. It's ridiculously easy to set that up on unix, but
(afaiu) quite troublesome under windows.


> why not simply
> give birth to a subsidiary process and pass it a command line (which
> can be up to 32KB)?

I believe work is in progress that will run things as threads rather
than using fork()+execve(). 32KiB of data is nowhere near enough to
sustain many of the more data-hungry commands. Or rather, it won't be
once the repository has grown passed 50-odd revisions.


All that being said, welcome to the git mailing list. Hopefully you
can help iron out the wrinkles on windows. You seem to have a fairly
good grasp of what's available there, and I'm sure the msys team would
be pretty happy to get a few patches to speed them on their way.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
