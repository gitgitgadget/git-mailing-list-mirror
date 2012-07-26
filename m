From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Thu, 26 Jul 2012 18:16:31 +0200
Message-ID: <1609414.ugUML9Yn73@flomedio>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <44779150.xA3SZNmQ1h@flomedio> <20120726090842.GA4999@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 18:16:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuQk4-0001MK-EB
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 18:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab2GZQQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 12:16:37 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35709 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab2GZQQg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 12:16:36 -0400
Received: by bkwj10 with SMTP id j10so1385013bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=ViMpQuNao0CgZW2+V2QApyX4Ku8735SISYGAhAp+h9w=;
        b=QlucmqZ4SdwXgtRqX45oECM3GjVzj8qcQ1lq70gRUD1JFJmTlPCCNOj4gZXuJRcFRc
         QQ2ZhW1EEg+tuc8rCB8Srtb/+wNPcxz0JiPengpsUxI98OggIJdkK5W6Wr2s7wSH+y83
         wruRgHrqCvcstOHZYoJq4+XH5U0eozxZpO4FHanKIiJkunnzkZuKV9szm69rNYZIwVbz
         2D+h1O3JyzgwMufOh5MNneE6SB1E0JWt+r15bldQ0fvgf1/kfI/wskU/rpOn00EF4hJU
         i9P8G8E+CWu5mFhZvEylEhvmkutUzozwGYTV/0NL/UtzVJw9Ahy5HEr78R5UgK5amyK+
         XVhg==
Received: by 10.204.148.66 with SMTP id o2mr13830747bkv.43.1343319394614;
        Thu, 26 Jul 2012 09:16:34 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id u8sm14907690bks.0.2012.07.26.09.16.32
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 09:16:33 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120726090842.GA4999@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202272>

On Thursday 26 July 2012 04:08:42 Jonathan Nieder wrote:
> Florian Achleitner wrote:

> > On Monday 02 July 2012 06:07:41 Jonathan Nieder wrote:
> [...]
> 
> >>> +
> >>> +static inline void printd(const char* fmt, ...)
> 
> [...]
> 
> >> Why not use trace_printf and avoid the complication?
> > 
> > Hm.. I tried. It wasn't exactly what I wanted. When I use trace_printf,
> > it's activated together with all other traces. I can use trace_vprintf
> > and specify a key, but I would always have to print the header "rhsvn
> > debug: " and the key by hand. So I could replace vfprintf in this
> > function by trace_vprintf to do that. But then there's not much
> > simplification. (?)
> 
> Hmm.  There's no trace_printf_with_key() but that's presumably because
> no one has needed it.  If it existed, you could use
> 
> 	#define printd(msg) trace_printf_with_key("GIT_TRACE_REMOTE_SVN", "%s",
> msg)
> 
> But now that I check, I don't see how the current printd() calls would
> be useful to other people.  Why announce these moments and not others?
> They're just temporary debugging cruft, right?
> 
> For that, plain trace_printf() works great.

Yes, it's for debugging only, I could just delete it all. It's inspired by 
transport-helper.c. The env var GIT_TRANSPORT_HELPER_DEBUG enables it. While 
transport-helper has a lot of if (debug) fprintf(..), I encapsulated it in 
printd.
So I should kick printd out?

> >>> +
> >>> +	printf("import\n");
> >>> +	printf("\n");
> >>> +	fflush(stdout);
> >>> +	return SUCCESS;
> >>> +}
> >> 
> >> Why the multiple printf?  Is the flush needed?
> > 
> > Excess printf gone.
> > Flush is needed. Otherwise it doesn't flush and the other end waits
> > forever.
> Ah, fast-import is ready, remote helper is ready, no one initiates
> pumping of data between them.  Maybe the purpose of the flush would
> be more obvious if it were moved to the caller.

Acutally this goes to the git parent process (not fast-import), waiting for a 
reply to the command. I think I have to call flush on this side of the pipe. 
Can you flush it from the reader? This wouldn't have the desired effect, it 
drops buffered data.

> [...]
> 
> >>> +	/* opening a fifo for usually reading blocks until a writer has opened
> >>> it too. +	 * Therefore, we open with RDWR.
> >>> +	 */
> >>> +	report_fd = open(back_pipe_env, O_RDWR);
> >>> +	if(report_fd < 0) {
> >>> +		die("Unable to open fast-import back-pipe! %s", strerror(errno));
> >>> +	}
> >> 
> >> Is this necessary?  Why shouldn't we fork the writer first and wait
> >> for it here?
> > 
> > Yes, necessary.
> 
> Oh, dear.  I hope not.  E.g., Cygwin doesn't support opening fifos
> RDWR (out of scope for the gsoc project, but still).

I believe it can be solved using RDONLY and WRONLY too. Probably we solve it 
by not using the fifo at all.
Currently the blocking comes from the fact, that fast-import doesn't parse 
it's command line at startup. It rather reads an input line first and decides 
whether to parse the argv after reading the first input line or at the end of 
the input. (don't know why)
remote-svn opens the pipe before sending the first command to fast-import and 
blocks on the open, while fast-import waits for input --> deadlock.
with remote-svn: RDWR, fast-import: WRONLY, this works.

Other scenario: Nothing to import, remote-svn only sends 'done' and closes the 
pipe again. After fast-import reads the first line it parses it's command line 
and tries to open the fifo which is already closed on the other side --> 
blocks.
This is solved by using RDWR on both sides.

If we change the points where the pipes are openend and closed, this could be 
circumvented.

> 
> [...]
> 
> > E.g. If there's have nothing to import, the helper sends only 'done' to
> > fast- import and quits.
> 
> Won't the writer open the pipe and wait for us to open our end before
> doing that?
> 
> [...]
> 
> >>> +
> >>> +	code = start_command(&svndump_proc);
> >>> +	if(code)
> >>> +		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
> >> 
> >> start_command() is supposed to have printed a message already when it
> >> fails, unless errno == ENOENT and silent_exec_failure was set.
> > 
> > Yes, but it doesn't die, right?
> 
> You can exit without writing a message with exit(), e.g. like so:
> 
> 	if (code)
> 		exit(code);
> 
> or like so:
> 
> 	if (code)
> 		exit(128);

ok, why not..

> 
> [...]
> 
> >>> +
> >>> +	close(svndump_proc.out);
> >> 
> >> Important?  Wouldn't finish_command do this?
> > 
> > As far as I understood it, it doesn't close extra created pipes. Probably
> > I
> > just didn't find it in the code ..
> 
> So this is to work around a bug in the run-command interface?

Good question. 

> 
> [...]
> 
> >>> +	close(report_fd);
> >> 
> >> What is the purpose of this step?
> > 
> > Close the back-report pipe end of the remote-helper.
> 
> That's just repeating the question. :)  Perhaps it's supposed to
> trigger some action on the other end of the pipe?  It would just be
> useful to add a comment documenting why one shouldn't remove this
> close() call, or else will probably end up removing it and needlessly
> suffering.

It's just closing files I've openend before. I usually do that, when i no 
longer need them. Isn't that common?
I believe it makes no difference if you only call import once. On subsequent 
imports the pipe is still open when it tries to open it again, that could be a 
problem. It would have to statically store report_fd, but what for??

> 
> [...]
> 
> >>> +
> >>> +	code = finish_command(&svndump_proc);
> >>> +	if(code)
> >>> +		warning("Something went wrong with termination of %s, code %d",
> >>> svndump_proc.argv[0], code);
> >> 
> >> finish_command() is supposed to print a message when it fails.
> > 
> > I changed the message text. It should tell us if svnrdump exited with non-
> > zero.
> 
> I'd suggest looking at other finish_command() callers for examples.
> 
> [...]
> 
> >>> +enum cmd_result do_command(struct strbuf* line)
> >>> +{
> >>> +	const command* p = command_list;
> >>> +	enum cmd_result ret;
> >>> +	printd("command line '%s'", line->buf);
> >>> +	while(*p) {
> >>> +		ret = (*p)(line);
> >>> +		if(ret != NOT_HANDLED)
> >>> +			return ret;
> >>> +		p++;
> >>> +	}
> >> 
> >> If possible, matching commands by name (like git.c does) would make
> >> the behavior easier to predict.
> > 
> > There is some usecase for this. The intention was, that command handlers
> > should be able to process more than one 'name'. E.g. an import batch is
> > terminated by a newline. This newline is handled by the import handler if
> > it is a batch. (This feature wasn't implemented in the version reviewed
> > here.)
> > 
> > So I decided to let the handler functions tell if they handle this line.
> 
> [continued from (*) above]
> ... it isn't needed at the moment.
> 
> See http://c2.com/xp/YouArentGonnaNeedIt.html

Hm.. all three values are used, they're not for the future but for now.
Of course it could be done somehow else.

> 
> [...]
> 
> >>> +	free((void*)url);
> >>> +	free((void*)private_refs);
> >> 
> >> Won't this crash?
> > 
> > Crash? It frees detached strbuf buffers.
> 
> I see "url = argv[2];" a few lines above, but it looks like the variable
> was reused for two different purposes. :(

Ooops. That was introduced by splitting out "[RFC 07/16] Allow reading svn 
dumps from files via file:// urls." It makes url malloced unconditionally. Will 
fix.
> 
> I'm not sure why you detach url, by the way.  If the goal is to free it,
> why not use strbuf_release()?

I used the strbuf because of it's nice formatting functions. But on the other 
hand, e.g. url_decode returns a char *, so I stored it in this type.
It doesn't make a big difference if I use three strbufs or one and detach and 
free the char * at the end. In fact, char * will consume some bytes less than 
a strbuf ;)
Another question is, if calling free just before exit makes sense anyways.
(But you learn it in programming courses, and it pleases valgrind :D )

> 
> Thanks,
> Jonathan

Florian
