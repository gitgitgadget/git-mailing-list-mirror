From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Sat, 28 Jul 2012 02:00:31 -0500
Message-ID: <20120728070030.GC4739@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <44779150.xA3SZNmQ1h@flomedio>
 <20120726090842.GA4999@burratino>
 <1609414.ugUML9Yn73@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 09:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv111-0004AM-KM
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 09:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab2G1HAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 03:00:37 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61372 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab2G1HAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 03:00:36 -0400
Received: by gglu4 with SMTP id u4so3848627ggl.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=w6ODpodZ+i0OOnXVJtlXRx4Td6rkW+DgNOrz3etn1G0=;
        b=rQxc1LUA2kDDEaDG4H7N1qvH9qToziZa0OCcazkvIW26V7xhzDuh8KbZ+X8/X59kbI
         r+FiZ+vOFUkVybgNrZpICTFLSceiUPWh646NkZdhC6HTphmDaWK/XZvy2fP6eAD1Iay7
         c6leM/kuF3rmwrSgboLLHQhIAr8ZTGLE0ffSfpJP1uGs82qc7wkK2RzGvv6V5pan118X
         qiPaGdGWSxLM8GJ1lyetWIh1Ympeek9k7GzW5Cqca/kboC/7lMMxRlryKg5ujTgm4cSu
         H48wpZmT6ASTgihdoI2xe/fm0byjI8qPe4GaTDp8kNdQSe94aKp6drqicBt3toOee2vv
         kkUQ==
Received: by 10.42.46.133 with SMTP id k5mr3126015icf.43.1343458835258;
        Sat, 28 Jul 2012 00:00:35 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id if4sm1150878igc.10.2012.07.28.00.00.34
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 00:00:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1609414.ugUML9Yn73@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202407>

Florian Achleitner wrote:

> So I should kick printd out?

I think so, yes.

"git log -SGIT_TRANSPORT_HELPER_DEBUG transport-helper.c" tells me
that that option was added to make the transport-helper machinery make
noise to make it obvious at what stage a remote helper has deadlocked.

GIT_TRANSPORT_HELPER_DEBUG already takes care of that, so there would
not be need for an imitation of that in remote-svn, unless I am
missing something (and even if I am missing something, it seems
complicated enough to be worth moving to another patch where it can be
explained more easily).

[...]
>>>>> +
>>>>> +	printf("import\n");
>>>>> +	printf("\n");
>>>>> +	fflush(stdout);
>>>>> +	return SUCCESS;
>>>>> +}
[...]
>>                                Maybe the purpose of the flush would
>> be more obvious if it were moved to the caller.
>
> Acutally this goes to the git parent process (not fast-import), waiting for a 
> reply to the command. I think I have to call flush on this side of the pipe. 
> Can you flush it from the reader? This wouldn't have the desired effect, it 
> drops buffered data.

*slaps head*  This is the "capabilities" command, and it needs to
flush because the reader needs to know what commands it's allowed to
use next before it starts using them.  My brain turned off and I
thought you were emitting an "import" command rather than advertising
that you support it for some reason.

And 'printf("\n")' was a separate printf because that way, patches
like

	 	printf("import\n");
	+	printf("bidi-import\n");
	 	printf("\n");
	 	fflush(stdout);

become simpler.

I'm tempted to suggest a structure like

		const char * const capabilities[] = {"import"};
		int i;

		for (i = 0; i < ARRAY_SIZE(capabilities); i++)
			puts(capabilities[i]);
		puts("");	/* blank line */

		fflush(stdout);

but your original code was fine, too.

[...]
>>>>> +	/* opening a fifo for usually reading blocks until a writer has opened
>>>>> it too. +	 * Therefore, we open with RDWR.
>>>>> +	 */
>>>>> +	report_fd = open(back_pipe_env, O_RDWR);
>>>>> +	if(report_fd < 0) {
>>>>> +		die("Unable to open fast-import back-pipe! %s", strerror(errno));
[...]
> I believe it can be solved using RDONLY and WRONLY too. Probably we solve it 
> by not using the fifo at all.
> Currently the blocking comes from the fact, that fast-import doesn't parse 
> it's command line at startup. It rather reads an input line first and decides 
> whether to parse the argv after reading the first input line or at the end of 
> the input. (don't know why)
> remote-svn opens the pipe before sending the first command to fast-import and 
> blocks on the open, while fast-import waits for input --> deadlock.

Thanks for explaining.  Now we've discussed a few different approproaches,
none of which is perfect.

a. use --cat-blob-fd, no FIFO

   Doing this unconditionally would break platforms that don't support
   --cat-blob-fd=(descriptor >2), like Windows, so we'd have to:

   * Make it conditional --- only do it (1) we are not on Windows and
     (2) the remote helper requests backflow by advertising the
     import-bidi capability.

   * Let the remote helper know what's going on by using
     "import-bidi" instead of "import" in the command stream to
     initiate the import.

b. use envvars to pass around FIFO path

   This complicates the fast-import interface and makes debugging hard.
   It would be nice to avoid this if we can, but in case we can't, it's
   nice to have the option available.

c. transport-helper.c uses FIFO behind the scenes.

   Like (a), except it would require a fast-import tweak (boo) and
   would work on Windows (yea)

d. use --cat-blob-fd with FIFO

   Early scripted remote-svn prototypes did this to fulfill "fetch"
   requests.

   It has no advantage over "use --cat-blob-fd, no FIFO" except being
   easier to implement as a shell script.  I'm listing this just for
   comparison; since (a) looks better in every way, I don't see any
   reason to pursue this one.

Since avoiding deadlocks with bidirectional communication is always a
little subtle, it would be nice for this to be implemented once in
transport-helper.c rather than each remote helper author having to
reimplement it again.  As a result, my knee-jerk ranking is a > c >
b > d.

Sane?
Jonathan
