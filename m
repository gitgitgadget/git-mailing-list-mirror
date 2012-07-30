From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Mon, 30 Jul 2012 10:12:06 +0200
Message-ID: <3225988.4e4jhmQGr7@flomedio>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1609414.ugUML9Yn73@flomedio> <20120728070030.GC4739@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:12:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svl5V-0001Ss-V0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 10:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab2G3IMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 04:12:19 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34827 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab2G3IMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 04:12:17 -0400
Received: by bkwj10 with SMTP id j10so2693719bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=jyDeFL22NJ2l+HT7uVnixLWDAlbJvSmxVuHdhQ8dS7Q=;
        b=1GHlHGie4WrKI8x2CJ1hacf2YFykBXN6jCwUFDobpzeGYMVlgTpJ8GM0enAoEdf1jP
         ySSQtAtNIlWt/gNL6W8JnXtK6EIiq7P1yES7Qh/n2cMp4dVFdgW73zKA97c6d2dSMx3p
         KAl/BN6VYa7wXPQINT1QwPzdS7iiKarY5z3PacRJ6CYEE6GKae8nkfshDHpDi9ojF7Hn
         tthiGSbF4wLRpFLAdtoM8XoumKTfuRlQiiLQ3gcE6MwC9ounbHPKL4YeiZOAYOaZmEQr
         QD1T7+Cv4M7b7SW0O/tKdQCGpDztaEvyLlPVfcAfjUmkrvkeGCfVAZQgM3kYs4FD166f
         GMvg==
Received: by 10.204.157.146 with SMTP id b18mr3650610bkx.108.1343635933425;
        Mon, 30 Jul 2012 01:12:13 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id hs2sm3171580bkc.1.2012.07.30.01.12.11
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 01:12:12 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120728070030.GC4739@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202525>

On Saturday 28 July 2012 02:00:31 Jonathan Nieder wrote:
> Thanks for explaining.  Now we've discussed a few different approproaches,
> none of which is perfect.
> 
> a. use --cat-blob-fd, no FIFO
> 
>    Doing this unconditionally would break platforms that don't support
>    --cat-blob-fd=(descriptor >2), like Windows, so we'd have to:
> 
>    * Make it conditional --- only do it (1) we are not on Windows and
>      (2) the remote helper requests backflow by advertising the
>      import-bidi capability.
> 
>    * Let the remote helper know what's going on by using
>      "import-bidi" instead of "import" in the command stream to
>      initiate the import.

Generally I like your prefered solution.
I think there's one problem:
The pipe needs to be created before the fork, so that the fd can be inherited. 
There is no way of creating it if the remote-helper advertises a capability, 
because it is already forked then. This would work with fifos, though.

We could:
- add a capability: bidi-import. 
- make transport-helper create a fifo if the helper advertises it.
- add a command for remote-helpers, like 'bidi-import <pipename>' that makes 
the remote helper open the fifo at <pipename> and use it.
- fast-import is forked after the helper, so we do already know if there will 
be a back-pipe. If yes, open it in transport-helper and pass the fd as command 
line argument cat-blob-fd. 

--> fast-import wouldn't need to be changed, but we'd use a fifo, and we get 
rid of the env-vars.
(I guess it could work on windows too).

What do you think?

> 
> b. use envvars to pass around FIFO path
> 
>    This complicates the fast-import interface and makes debugging hard.
>    It would be nice to avoid this if we can, but in case we can't, it's
>    nice to have the option available.
> 
> c. transport-helper.c uses FIFO behind the scenes.
> 
>    Like (a), except it would require a fast-import tweak (boo) and
>    would work on Windows (yea)
> 
> d. use --cat-blob-fd with FIFO
> 
>    Early scripted remote-svn prototypes did this to fulfill "fetch"
>    requests.
> 
>    It has no advantage over "use --cat-blob-fd, no FIFO" except being
>    easier to implement as a shell script.  I'm listing this just for
>    comparison; since (a) looks better in every way, I don't see any
>    reason to pursue this one.
> 
> Since avoiding deadlocks with bidirectional communication is always a
> little subtle, it would be nice for this to be implemented once in
> transport-helper.c rather than each remote helper author having to
> reimplement it again.  As a result, my knee-jerk ranking is a > c >
> b > d.
> 
> Sane?
> Jonathan
