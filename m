From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Fri, 27 Jul 2012 09:23:42 +0200
Message-ID: <9398008.kKbpiTCtsb@flomedio>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1486896.KW3TvzfC56@flomedio> <20120726145426.GB3058@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Steven Michalske <smichalske@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 09:24:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suetu-00080h-CL
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 09:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657Ab2G0HXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 03:23:49 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49042 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab2G0HXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 03:23:48 -0400
Received: by bkwj10 with SMTP id j10so1724979bkw.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=IYxDU1CmEi9uIcU7CvLcT0un6njXi6yL6Ut0h4879Q0=;
        b=b8XHsrD2HqZXkXgKdf8N6ULVQL96aDwyTwTXq+PP0gWWU1xcCvQ/4060yG/Ottva8a
         rMY5kUq9IHefiF5b6+k18g1RD9fumdO4EN5QFiQQl96yJn/eg0kE2gRlUGploCjpLBtk
         2eVXNsl4JeDmuTW1QaWfCDlfCqBS8XwSj6vGinSC8fT38MGEj6X+JiNQjmJTpUbgua6v
         gL6dfQYooKRRc6jmuo864nKLaAANQbrd7ljmDq86zag305gIWiAOvh7ZXexNaALIgt3m
         Qn+F7a2vDQpRIUycIWyIvsbTmZ5OrCFNyt/6BNX8BZG6i+DDtTDLwt7PDAaPFbJTvSpq
         WJlw==
Received: by 10.204.130.10 with SMTP id q10mr491432bks.90.1343373827072;
        Fri, 27 Jul 2012 00:23:47 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id 25sm406405bkx.9.2012.07.27.00.23.44
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Jul 2012 00:23:45 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120726145426.GB3058@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202343>

On Thursday 26 July 2012 09:54:26 Jonathan Nieder wrote:
> 
> Since the svn remote helper relies on this, it seems worth working on,
> yeah.  As for how to spend your time (and whether to beg someone else
> to work on it instead :)): I'm not sure what's on your plate or where
> you are with respect to the original plan for the summer at the
> moment, so it would be hard for me to give useful advice about how to
> balance things.

Btw, the pipe version did already exist before I started, it was added with 
the cat-blob command and already used by Dmitry's remote-svn-alpha.
I didn't search for design discussions in the past ..

> 
> What did you think of the suggestion of adding a new bidi-import
> capability and command to the remote helper protocol?  I think this
> would be clean and avoid causing a regression on Windows, but it's
> easily possible I am missing something fundamental.

I don't have much overview over this topic besides the part I'm working on, 
like other users of fast-import. 
The bidi-import capability/command would have the advantage, that we don't 
have to bother with the pipe/fifo at all, if the remote-helper doesn't use it.

When I implemented the two variants I had the idea to pass it to the 'option' 
command, that fast-import already has. Anyways, specifying cat-blob-fd is not 
allowed via the 'option' command (see Documentation and 85c62395).
It wouldn't make too much sense, because the file descriptor must be set up by 
the parent.

But for the fifo, it would, probably. The backward channel is only used by the 
commands 'cat-blob' and 'ls' of fast-import. If a remote helper wants to use 
them, it would could make fast-import open the pipe by sending an 'option' 
command with the fifo filename, otherwise it defaults to stdout (like now) and 
is rather useless.
This would take the fifo setup out of transport-helper. The remote-helper would 
have to create it, if it needs it.

Apropos stdout. That leads to another idea. You already suggested that it 
would be easiest to only use FDs 0..2. Currently stdout and stderr of fast-
import go to the shell. We could connect stdout to the remote-helper and don't 
need the additional channel at all.
(Probably there's a good reason why they haven't done that ..)
Maybe this requires many changes to fast-import and breaks existing frontends.

--
Florian
