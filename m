From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Mon, 30 Jul 2012 15:55:14 +0200
Message-ID: <19477122.a5lMBqWgns@flomedio>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <3225988.4e4jhmQGr7@flomedio> <20120730082951.GA7702@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 15:55:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvqRR-0001bg-Ll
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 15:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab2G3NzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 09:55:21 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53385 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab2G3NzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 09:55:20 -0400
Received: by bkwj10 with SMTP id j10so2839042bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=D1Dgs6nSNJdIIRyBnpjGAhhTGYIiWg6Pz+npL8CshaM=;
        b=qMMxpCHnBK/BqAqbFv0HjhTPABAj/DKxLmMLGZx6XC6YbM9y3j6nS58pa0D2yGywXH
         UlV7rKS9cEwpwvh+Y8Wpei9DPr1/UxjTeYuGURRgCljiYmouOhGVaoaFDT6sxquA2LgB
         8Q+Dx7Q6HvwLCml5BFgF5CVe2OIhLcj75yf+hpSXuhM8OqqKOz38tQt2u8BV4ACelr/9
         LoPT8wsIr97evKTypktlrN+FyA+wlQx/gZ3eB5bwWYW8MnYif/JTpJXgiLACpl2SSvnA
         YkLFM2gQhTp4OJjl39u3sR18OJogAUCucDGio0mwFc365aJmrfMTKGyDFd+NqeQ10Dhy
         WgZw==
Received: by 10.205.125.4 with SMTP id gq4mr3884236bkc.109.1343656518691;
        Mon, 30 Jul 2012 06:55:18 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm3858868bkv.14.2012.07.30.06.55.16
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 06:55:17 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120730082951.GA7702@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202544>

On Monday 30 July 2012 03:29:52 Jonathan Nieder wrote:
> > Generally I like your prefered solution.
> > I think there's one problem:
> > The pipe needs to be created before the fork, so that the fd can be
> > inherited. 
> The relevant pipe already exists at that point: the remote helper's
> stdin.
> 
> In other words, it could work like this (just like the existing demo
> code, except adding a conditional based on the "capabilities"
> response):
> 
>         0. transport-helper.c invokes the remote helper.  This requires
>            a pipe used to send commands to the remote helper
>            (helper->in) and a pipe used to receive responses from the
>            remote helper (helper->out)
> 
>         1. transport-helper.c sends the "capabilities" command to decide
>            what to do.  The remote helper replies that it would like
>            some feedback from fast-import.
> 
>         2. transport-helper.c forks and execs git fast-import with input
>            redirected from helper->out and the cat-blob fd redirected
>            to helper->in

fast-import writes to the helpers stdin..

>         3. transport-helper.c tells the remote helper to start the
>            import

transport-helper writes commands to the helper's stdin.

> 
>         4. wait for fast-import to exit

Hm .. that would mean, that both fast-import and git (transport-helper) would 
write to the remote-helper's stdin, right?
