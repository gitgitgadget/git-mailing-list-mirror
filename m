X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 14:40:55 +0100
Message-ID: <457D5FE7.3010309@op5.se>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>	 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org>	 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>	 <457D4386.70408@op5.se> <e5bfff550612110459w205cb9b3lf735359012f84f7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 13:41:04 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <e5bfff550612110459w205cb9b3lf735359012f84f7c@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34004>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtlOv-0004KE-76 for gcvg-git@gmane.org; Mon, 11 Dec
 2006 14:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762916AbWLKNk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 08:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762918AbWLKNk6
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 08:40:58 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:39995 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1762916AbWLKNk5 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 08:40:57 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 225956BCC1; Mon, 11 Dec 2006 14:40:56 +0100 (CET)
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Marco Costalba wrote:
> On 12/11/06, Andreas Ericsson <ae@op5.se> wrote:
>> Marco Costalba wrote:
>> > On 12/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> >>
>> >> Why don't you use the pipe and standard read()?
>> >>
>> >> Even if you use "popen()" and get a "FILE *" back, you can still do
>> >>
>> >>         int fd = fileno(file);
>> >>
>> >> and use the raw IO capabilities.
>> >>
>> >> The thing is, temporary files can actually be faster under Linux just
>> >> because the Linux page-cache simply kicks ass. But it's not going 
>> to be
>> >> _that_ big of a difference, and you need all that crazy "wait for
>> >> rev-list
>> >> to finish" and the "clean up temp-file on errors" etc crap, so 
>> there's no
>> >> way it's a better solution.
>> >>
>> >
>> > Two things.
>> >
>> > - memory use: the next natural step with files is, instead of loading
>> > the file content in memory and *keep it there*, we could load one
>> > chunk at a time, index the chunk and discard. At the end we keep in
>> > memory only indexing info to quickly get to the data when needed, but
>> > the big part of data stay on the file.
>> >
>>
>> memory usage vs speed tradeoff. Since qgit is a pure user-app, I think
>> it's safe to opt for the memory hungry option. If people run it on too
>> lowbie hardware they'll just have to make do with other ways of viewing
>> the DAG or shutting down some other programs.
>>
>> > - This is probably my ignorance, but experimenting with popen() I
>> > found I could not know *when* git-rev-list ends because both feof()
>> > and ferror() give 0 after a fread() with git-rev-list already defunct.
>> > Not having a reference to the process (it is hidden behind popen() ),
>> > I had to check for 0 bytes read after a successful read (to avoid
>> > racing in case I ask the pipe before the first data it's ready) to
>> > know that job is finished and call pclose().
>> >
>>
>> (coding in MUA, so highly untested)
>>
> 
> Thanks Andreas, I will do some tests with your code. But at first
> sight I fail to see (I'm not an expert on this tough ;-)  ) where is
> the difference from using popen() and fileno() to get the file
> descriptors.
> 

read() vs fread(), so no libc buffers. When I did comparisons with this 
(a long time ago, I don't have the test-program around) in style of

	read(out[0], buf, sizeof(buf));
	write(fileno(stdout), buf, sizeof(buf));

with a command line like this;

	cat any-file | test-program > /dev/null

I saw a static ~10ms increase in execution time compared to

	cat any-file > /dev/null

regardless of the size of "any-file", so I assume this overhead comes 
from the extra fork(), which you'll never get rid of unless you use 
libgit.a.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
