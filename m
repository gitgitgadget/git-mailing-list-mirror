X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 12:39:50 +0100
Message-ID: <457D4386.70408@op5.se>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>	 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org> <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 11:40:37 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33994>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtjWM-00060C-7U for gcvg-git@gmane.org; Mon, 11 Dec
 2006 12:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762835AbWLKLjx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 06:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762836AbWLKLjx
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 06:39:53 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:38441 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1762835AbWLKLjw (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 06:39:52 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 162FD6BCBF; Mon, 11 Dec 2006 12:39:51 +0100 (CET)
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Marco Costalba wrote:
> On 12/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>>
>> Why don't you use the pipe and standard read()?
>>
>> Even if you use "popen()" and get a "FILE *" back, you can still do
>>
>>         int fd = fileno(file);
>>
>> and use the raw IO capabilities.
>>
>> The thing is, temporary files can actually be faster under Linux just
>> because the Linux page-cache simply kicks ass. But it's not going to be
>> _that_ big of a difference, and you need all that crazy "wait for 
>> rev-list
>> to finish" and the "clean up temp-file on errors" etc crap, so there's no
>> way it's a better solution.
>>
> 
> Two things.
> 
> - memory use: the next natural step with files is, instead of loading
> the file content in memory and *keep it there*, we could load one
> chunk at a time, index the chunk and discard. At the end we keep in
> memory only indexing info to quickly get to the data when needed, but
> the big part of data stay on the file.
> 

memory usage vs speed tradeoff. Since qgit is a pure user-app, I think 
it's safe to opt for the memory hungry option. If people run it on too 
lowbie hardware they'll just have to make do with other ways of viewing 
the DAG or shutting down some other programs.

> - This is probably my ignorance, but experimenting with popen() I
> found I could not know *when* git-rev-list ends because both feof()
> and ferror() give 0 after a fread() with git-rev-list already defunct.
> Not having a reference to the process (it is hidden behind popen() ),
> I had to check for 0 bytes read after a successful read (to avoid
> racing in case I ask the pipe before the first data it's ready) to
> know that job is finished and call pclose().
> 

(coding in MUA, so highly untested)

pid_t runcmd(const char **argv, const char **env, int *out, *int err)
{
	int pid;

	pipe(out);
	pipe(err);

	pid = fork();


	/* parent returns upon forking */
	if (pid) {
		/* close childs file-descriptors in our address space */
		close(out[0]);
		close(err[0]);
		return pid;
	}

	/* child */
	/* close parents file-descriptors */
	close(out[0]);
	close(err[0]);

	/* stdout and stderr writes to childs ends of the pipes */
	dup2(out[1], STDOUT_FILENO);
	dup2(err[1], STDERR_FILENO);
	execve(argv[0], argv, NULL);

	_exit(0); /* not reached unless execve() failed */
}

The caller can now read out[0] and err[0] as regular file-descriptors 
and has the pid of the child-process in the return value. The parent 
receives SIGCHILD if the child exits, the child receives EPIPE when 
writing if the parent crashes.

In a prudent implementation, the parent should waitpid(pid_t pid, int 
*status, WNOHANG) for the child every once in a while to collect its 
exit status gracefully.

Do some experimenting and I'm sure you'll find something suitable for you.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
