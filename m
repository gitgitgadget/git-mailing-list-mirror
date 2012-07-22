From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 4/4 v3] Add cat-blob report fifo from fast-import to remote-helper.
Date: Sun, 22 Jul 2012 23:03:13 +0200
Message-ID: <5489458.8D23shS0RV@flomedio>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <3246520.u1PcGtbf0N@flobuntu> <20120721154437.GC19860@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:03:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St3JG-0003wd-0x
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 23:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab2GVVDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 17:03:21 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50028 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab2GVVDU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 17:03:20 -0400
Received: by bkwj10 with SMTP id j10so4650652bkw.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=G/phwBwnNTJZX1XkzehFceiWQhcmxCYLzaroz266FXw=;
        b=kuKVO7clCgi3PWUSXTwjI2HCZqJVIJru5GOjPnpo41XzCEQLdG17bqtFCh2zzVe7WI
         s/cdhKVZDrlJ6ryNiWZjF1ei9YWI7F1VzU6TLB5Blbw7F7tapKLKp7X7rl/VMBTNBqno
         Pvd4US9frxXC3YJwsBcRs1AxVyae1RPPOQ0jLAruWbG/cs3iZd6TcLcjAojVqPZnxOna
         ZC/6Bpfr9KQ9nl+yLOfIr+mMSkwz3tFE49TgoX1yZ3WOdY6xUkCsiG0OjHjdAT7+OsLw
         8+dqItyOfjAoLgPXlP6D8+3Ji/Ps0qRE1TkHuPPeuPVJMOx89Jfo9yl0ZlO8rfzlx4I9
         4LRA==
Received: by 10.204.136.205 with SMTP id s13mr6372050bkt.22.1342990998815;
        Sun, 22 Jul 2012 14:03:18 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id hs2sm5749707bkc.1.2012.07.22.14.03.16
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 14:03:17 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120721154437.GC19860@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201864>

On Saturday 21 July 2012 10:44:37 Jonathan Nieder wrote:
> Florian Achleitner wrote:
> > On Saturday 21 July 2012 09:48:34 Jonathan Nieder wrote:
> >> To sum up: I think we should just stick to pipes --- why all this fifo
> >> complication?
> > 
> > People didn't like pipe variant (prexec_cb not being compatible to
> > windows'
> > process creation model), so I learned about fifos and implemented a
> > (basic) fifo variant. *shrug*
> 
> Ok, can you elaborate on that?  What does it mean that preexec_cb is
> not compatible to windows' process creation model?  Don't the people
> of the future working on this code deserve to know about that, too, so
> they don't break it?

Let's discuss how to describe the solution after we decide which of the two 
variants we choose.

Summarizing the earlier discussion (in this thread as replies to version 1 of 
the patch) more verbosely:
I used the prexec_cb feature of start_command which allows to install a 
callback function that is called just before exec.
It's purpose is to close the other pipe end in each of the processes that 
inherited both ends after fork.
The pipe is created in transport-helper.c, because it forks fast-import as 
well as the remote-helper, which inherit the pipe's file descriptors.

On Windows, processses are not forked but spawned from new and therefore can't 
inherit pipe file descriptors. So we had the idea to use a fifo, which can be 
opened after the creation of the process. Also there are named pipes on 
Windows which are similar to fifos (though I've never used them).

Mostly out of curiosity I played around with fifos and implemented this 
additional cat-blob-pipe feature, like a proof-of-concept.

The first version used the pipes because this feature already exists.

> 
> Come on --- I'm not asking these questions just to make your life
> difficult.  Please make it easy to understand your code changes and to
> keep them maintained.

The reason why I resent the patch in version 3 these days is that I the 
problem of blocking open calls leading to potential deadlocks.
Of course I should tell future maintainers better what its all about, if we 
really want that feature.

Hope that helps,
Florian
