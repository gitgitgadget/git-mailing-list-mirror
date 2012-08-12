From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Sun, 12 Aug 2012 12:06:59 +0200
Message-ID: <1636924.tANzCnKezB@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1447696.eZjtSkvvWp@flomedio> <20120801194247.GE24357@copier>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 12:07:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0V4y-0003gR-2p
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 12:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab2HLKHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 06:07:13 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38661 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2HLKHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 06:07:11 -0400
Received: by wicr5 with SMTP id r5so1696230wic.1
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=C0lSfHh7aPOwrazmZupcbZHsTyADX7OYAKxWIKQl95A=;
        b=X2PJ9ykb5w3vHdXGu+b20htU+aUAoRB9WxCWvDIOAr49zrIZ+QUtmRN/8C3t6HYWXj
         V0zDaoLvqyQa0PC15qHJO8gJsFZjcaQn8k/0fDkHNL2GOgwjVRma3Vz5Noupiqsx9LHA
         pxy+Bus9Y7gVC4RHAxIiIACI2adQlKOAMzp512p5uyx32Pf0RdBePECofMdDLSHxTFJu
         wtRX1/4HAmHLMAh93WwDqyKIGIf+JD7k2eusy+uMQCE19ubogiErRc3rbLFdiCilc5yF
         3yLgy+QqG088BbjwZeBuARmOtGLUuwJAMyUxB7ae5xiz3e/6O2jeCjV1g5S29IH+JNMy
         9a8w==
Received: by 10.180.83.66 with SMTP id o2mr9664645wiy.14.1344766030402;
        Sun, 12 Aug 2012 03:07:10 -0700 (PDT)
Received: from flobuntu.localnet (93-82-149-199.adsl.highway.telekom.at. [93.82.149.199])
        by mx.google.com with ESMTPS id ck9sm13659422wib.2.2012.08.12.03.07.07
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Aug 2012 03:07:08 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120801194247.GE24357@copier>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203306>

Hi,

back to the pipe-topic.

On Wednesday 01 August 2012 12:42:48 Jonathan Nieder wrote:
> Hi again,
> 
> Florian Achleitner wrote:
> > When the first line arrives at the remote-helper, it starts importing one
> > line at a time, leaving the remaining lines in the pipe.
> > For importing it requires the data from fast-import, which would be mixed
> > with import lines or queued at the end of them.
> 
> Oh, good catch.
> 
> The way it's supposed to work is that in a bidi-import, the remote
> helper reads in the entire list of refs to be imported and only once
> the newline indicating that that list is over arrives starts writing
> its fast-import stream.  We could make this more obvious by not
> spawning fast-import until immediately before writing that newline.
> 
> This needs to be clearly documented in the git-remote-helpers(1) page
> if the bidi-import command is introduced.
> 
> If a remote helper writes commands for fast-import before that newline
> comes, that is a bug in the remote helper, plain and simple.  It might
> be fun to diagnose this problem:

This would require all existing remote helpers that use 'import' to be ported 
to the new concept, right? Probably there is no other..

> 
> 	static void pipe_drained_or_die(int fd, const char *msg)
> 	{
> 		char buf[1];
> 		int flags = fcntl(fd, F_GETFL);
> 		if (flags < 0)
> 			die_errno("cannot get pipe flags");
> 		if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
> 			die_errno("cannot set up non-blocking pipe read");
> 		if (read(fd, buf, 1) > 0)
> 			die("%s", msg);
> 		if (fcntl(fd, F_SETFL, flags))
> 			die_errno("cannot restore pipe flags");
> 	}
> 	...
> 
> 	for (i = 0; i < nr_heads; i++) {
> 		write "import %s\n", to_fetch[i]->name;
> 	}
> 
> 	if (getenv("GIT_REMOTE_HELPERS_SLOW_SANITY_CHECK"))
> 		sleep(1);
> 
> 	pipe_drained_or_die("unexpected output from remote helper before
> fast-import launch");
> 
> 	if (get_importer(transport, &fastimport))
> 		die("couldn't run fast-import");
> 	write_constant(data->helper->in, "\n");

I still don't believe that sharing the input pipe of the remote helper is 
worth the hazzle.
It still requires an additional pipe to be setup, the one from fast-import to 
the remote-helper, sharing one FD at the remote helper.
It still requires more than just stdin, stdout, stderr.

I would suggest to use a fifo. It can be openend independently, after forking 
and on windows they have named pipes with similar semantics, so I think this 
could be easily ported. 
I would suggest the following changes:
- add a capability to the remote helper 'bidi-import', or 'bidi-pipe'. This 
signals that the remote helper requires data from fast-import.

- add a command 'bidi-import', or 'bidi-pipe' that is tells the remote helper 
which filename the fifo is at, so that it can open it and read it when it 
handles 'import' commands.

- transport-helper.c creates the fifo on demand, i.e. on seeing the capability, 
in the gitdir or in /tmp.

- fast-import gets the name of the fifo as a command-line argument. The 
alternative would be to add a command, but that's not allowed, because it 
changes the stream semantics.
Another alternative would be to use the existing --cat-pipe-fd argument. But 
that requires to open the fifo before execing fast-import and makes us 
dependent on the posix model of forking and inheriting file descriptors, while 
opening a fifo in fast-import would not.
