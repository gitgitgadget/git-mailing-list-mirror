From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Thu, 26 Jul 2012 04:08:42 -0500
Message-ID: <20120726090842.GA4999@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <23122876.7xH9dZiP4M@flobuntu>
 <20120702110741.GA3527@burratino>
 <44779150.xA3SZNmQ1h@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 11:08:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuK41-0005xy-Oa
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 11:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab2GZJIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 05:08:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39171 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab2GZJIv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 05:08:51 -0400
Received: by yhmm54 with SMTP id m54so1701839yhm.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rP78SqPuiMsYVHqiyO6bruzhDXLxxrrguoA/yDOpCrg=;
        b=0/pDTi0Vun2WBAw1h2PFIv7BJTbFo7zDHx5D54PJDlBN97jy4tFN+lWgP1+IKWpUfH
         PVcUpuaarFNiE/de6Ty1Hspyzfp/3GwZcxBgdPiRstMx2YnC3HdjOkg2ENzaPQb6WHlx
         YJohw7cSFXWK/us8Lca/hYRpTVV6xw3jH6R7L1JsQZAyjgwlahsAUtROUivMoSTk46pX
         IUQdqT+vPUmLiuQmHs1kkd6G/ktFHb6Vc5KiiABNo3i45xBlBYOUvUqdGlQQ5bT6Nibm
         bHs1md3yPQw/VdMbKA/qUW02T04jgfC2V7Et/yHJYa6BcoaxVR+BlAVOQWVsaK7DyRXI
         6kaw==
Received: by 10.50.46.231 with SMTP id y7mr1002760igm.21.1343293730091;
        Thu, 26 Jul 2012 02:08:50 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id qo3sm6554766igc.8.2012.07.26.02.08.49
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 02:08:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <44779150.xA3SZNmQ1h@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202252>

Florian Achleitner wrote:

> Most of this review went into the new version.. 
> For the remaining points, some comments follow.

Thanks for this.

> On Monday 02 July 2012 06:07:41 Jonathan Nieder wrote:

[...]
>>> +
>>> +static inline void printd(const char* fmt, ...)
[...]
>> Why not use trace_printf and avoid the complication?
>
> Hm.. I tried. It wasn't exactly what I wanted. When I use trace_printf, it's 
> activated together with all other traces. I can use trace_vprintf and specify 
> a key, but I would always have to print the header "rhsvn debug: " and the key 
> by hand. So I could replace vfprintf in this function by trace_vprintf to do 
> that. But then there's not much simplification. (?)

Hmm.  There's no trace_printf_with_key() but that's presumably because
no one has needed it.  If it existed, you could use

	#define printd(msg) trace_printf_with_key("GIT_TRACE_REMOTE_SVN", "%s", msg)

But now that I check, I don't see how the current printd() calls would
be useful to other people.  Why announce these moments and not others?
They're just temporary debugging cruft, right?

For that, plain trace_printf() works great.

[...]
>>> +
>>> +enum cmd_result { SUCCESS, NOT_HANDLED, ERROR };
[...]
> Hm.. the enum now has SUCCESS, NOT_HANDLED, TERMINATE.

Much nicer.

I think this tristate return value could be avoided entirely because...
[continued at (*) below]

[...]
>>> +
>>> +	printf("import\n");
>>> +	printf("\n");
>>> +	fflush(stdout);
>>> +	return SUCCESS;
>>> +}
>>
>> Why the multiple printf?  Is the flush needed?
>
> Excess printf gone.
> Flush is needed. Otherwise it doesn't flush and the other end waits forever.

Ah, fast-import is ready, remote helper is ready, no one initiates
pumping of data between them.  Maybe the purpose of the flush would
be more obvious if it were moved to the caller.

[...]
>>> +	/* opening a fifo for usually reading blocks until a writer has opened
>>> it too. +	 * Therefore, we open with RDWR.
>>> +	 */
>>> +	report_fd = open(back_pipe_env, O_RDWR);
>>> +	if(report_fd < 0) {
>>> +		die("Unable to open fast-import back-pipe! %s", strerror(errno));
>>> +	}
>>
>> Is this necessary?  Why shouldn't we fork the writer first and wait
>> for it here?
>
> Yes, necessary.

Oh, dear.  I hope not.  E.g., Cygwin doesn't support opening fifos
RDWR (out of scope for the gsoc project, but still).

[...]
> E.g. If there's have nothing to import, the helper sends only 'done' to fast-
> import and quits.

Won't the writer open the pipe and wait for us to open our end before
doing that?

[...]
>>> +
>>> +	code = start_command(&svndump_proc);
>>> +	if(code)
>>> +		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
>>
>> start_command() is supposed to have printed a message already when it
>> fails, unless errno == ENOENT and silent_exec_failure was set.
>
> Yes, but it doesn't die, right?

You can exit without writing a message with exit(), e.g. like so:

	if (code)
		exit(code);

or like so:

	if (code)
		exit(128);

[...]
>>> +
>>> +	close(svndump_proc.out);
>>
>> Important?  Wouldn't finish_command do this?
>
> As far as I understood it, it doesn't close extra created pipes. Probably I 
> just didn't find it in the code ..

So this is to work around a bug in the run-command interface?

[...]
>>> +	close(report_fd);
>>
>> What is the purpose of this step?
>
> Close the back-report pipe end of the remote-helper.

That's just repeating the question. :)  Perhaps it's supposed to
trigger some action on the other end of the pipe?  It would just be
useful to add a comment documenting why one shouldn't remove this
close() call, or else will probably end up removing it and needlessly
suffering.

[...]
>>> +
>>> +	code = finish_command(&svndump_proc);
>>> +	if(code)
>>> +		warning("Something went wrong with termination of %s, code %d",
>>> svndump_proc.argv[0], code);
>> finish_command() is supposed to print a message when it fails.
>
> I changed the message text. It should tell us if svnrdump exited with non-
> zero.

I'd suggest looking at other finish_command() callers for examples.

[...]
>>> +enum cmd_result do_command(struct strbuf* line)
>>> +{
>>> +	const command* p = command_list;
>>> +	enum cmd_result ret;
>>> +	printd("command line '%s'", line->buf);
>>> +	while(*p) {
>>> +		ret = (*p)(line);
>>> +		if(ret != NOT_HANDLED)
>>> +			return ret;
>>> +		p++;
>>> +	}
>>
>> If possible, matching commands by name (like git.c does) would make
>> the behavior easier to predict.
>
> There is some usecase for this. The intention was, that command handlers 
> should be able to process more than one 'name'. E.g. an import batch is 
> terminated by a newline. This newline is handled by the import handler if it 
> is a batch. (This feature wasn't implemented in the version reviewed here.)
>
> So I decided to let the handler functions tell if they handle this line.

[continued from (*) above]
... it isn't needed at the moment.

See http://c2.com/xp/YouArentGonnaNeedIt.html

[...]
>>> +	free((void*)url);
>>> +	free((void*)private_refs);
>>
>> Won't this crash?
>
> Crash? It frees detached strbuf buffers.

I see "url = argv[2];" a few lines above, but it looks like the variable
was reused for two different purposes. :(

I'm not sure why you detach url, by the way.  If the goal is to free it,
why not use strbuf_release()?

Thanks,
Jonathan
