From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 4/4 v3] Add cat-blob report fifo from fast-import to
 remote-helper.
Date: Sun, 22 Jul 2012 16:24:24 -0500
Message-ID: <20120722212424.GA680@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <3246520.u1PcGtbf0N@flobuntu>
 <20120721154437.GC19860@burratino>
 <5489458.8D23shS0RV@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:24:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St3dn-0005YS-JZ
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 23:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab2GVVYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 17:24:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45704 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab2GVVYd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 17:24:33 -0400
Received: by yenl2 with SMTP id l2so4953445yen.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HVgDXhwZdZbz/l2FkzEke8QdRckMcnsIbNESF7MjyN0=;
        b=C2LPDLLv12q0R93Oal3wY9M7WQBAZrFjSUtbyL2xmno+Fs5GMKT8diyYJv7k7MjX0G
         a0PndZvasUjc4Xe392YuHPgQl+XFmPx3IqS29tplm6G8JIp4audY4u5ShQowKkeJ+nc6
         6JEtXncWf1MQASVs5UeDqDLJ8m/O7ivaNyy24JP9Leru0P6PrWIBRvnAe/HcBy4ZPBjK
         zlwY8TTe/lNYHrVjHJqd2J7qk+UbbXMr8UNihXpxTmwmLiu/lSdkPoo0olaU4jGcHXTc
         XTCjsdka3GLwYRZuZGs5+SiAqymHliXGAHpGiWluU2SRnoCZRbTZsFpLvMChplDM/D3s
         u9mg==
Received: by 10.50.106.166 with SMTP id gv6mr5754521igb.46.1342992272513;
        Sun, 22 Jul 2012 14:24:32 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ud8sm9960792igb.4.2012.07.22.14.24.31
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 14:24:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5489458.8D23shS0RV@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201868>

Hi,

Florian Achleitner wrote:

> On Windows, processses are not forked but spawned from new and therefore can't 
> inherit pipe file descriptors.

Ok, this is what I didn't understand (and still don't understand).

Yes, on Windows processes are spawned instead of forked.  But does
that mean they can't inherit pipes?  How do pipelines in the shell
work at all, then?

I thought what Hannes said was rather that the current C runtime
used by Git for Windows doesn't take care of inherited file
descriptors, period, other than 0, 1, and 2.  This has nothing to do
with the fork/spawn distinction.  So while --cat-blob-fd or some other
mechanism could be made to work on Windows in the future, *relying* on
--cat-blob-fd on Windows today is a no-go, since it rely on file
descriptors >2 and break the remote helper infrastructure completely
there.

That does not force us into a corner at all.  We have multiple
options.  Here is what I propose:

Remote helpers declare using a capability (e.g., "bidi-import") that
they would like a bidirectional communication channel with
fast-import.  Git tells the remote helper that its request has been
granted by using a different command (e.g., "bidi-import") instead of
"import" to start the import process.

The responses from fast-import come on stdin (file descriptor 0), so
in principle it should be possible to implement this interface on
Windows.  The interface is portable, even if the initial
implementation isn't.

Existing remote helpers using the "import" capability would be
unaffected and would work as before.

On Windows, Git would not take advantage of the bidi-import capability
for now.  Windows support is an added complication and we have enough
to do this summer.

Then interested people using Windows would be able to experiment using
whatever mechanism they please (CRT support for inherited file
descriptors >2, fifos, sockets, some other Windows-specific thing) to
implement the bidi-import capability.  Once that is implemented, they
automatically get support for remote helpers that rely on the
bidirectional communication functionality.

What do you think?

Thanks for explaining,
Jonathan
