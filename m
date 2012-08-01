From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Wed, 01 Aug 2012 10:25:40 +0200
Message-ID: <1447696.eZjtSkvvWp@flomedio>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <2351904.F5IazNUWoD@flomedio> <CAFzf2XzC4Y1AhBV4BU5zZ411f=oVzoOyNA=e1L2eZd3bjyEgjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 10:26:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwUGQ-0002Jf-IT
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 10:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab2HAIZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 04:25:56 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46293 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab2HAIZx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 04:25:53 -0400
Received: by bkwj10 with SMTP id j10so3640520bkw.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 01:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=x3mX9kxK2L05RWXgM0ove3F3aW76CVMmHRD999xAA9U=;
        b=Ahs266dMCKZWxlORoaC3nR4chfFhvs/HDbLx2G0fshOVw0ZhCt+zby1KdlNEJ6hWhW
         isjSXsJ8afpc590IuS9d/d+gjB8dvXIy7Xsgcx0tGzSM8UBV1cH3HLJWTlXT9ii56yOt
         cNb298e9nbHrrCdEKN7q6neciGP7YLgulWhISqJ5QE7dJulSIPfY6scdOvrLTq3nNm5d
         qFOtFrzh3yR6AVTqaMffKxz/k6tpxYT9ezU+1Ayck7M00MpftxEHJgWuXEH6vn9AokQ0
         /rAiFxg/0JfgERsMnbYimThuyruqaasQOwBQwIm8hr2H/dMt9AjZz7BvTGJwuNMBiacW
         XF6A==
Received: by 10.204.128.214 with SMTP id l22mr6388959bks.86.1343809552450;
        Wed, 01 Aug 2012 01:25:52 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id gq2sm1110595bkc.13.2012.08.01.01.25.49
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Aug 2012 01:25:50 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <CAFzf2XzC4Y1AhBV4BU5zZ411f=oVzoOyNA=e1L2eZd3bjyEgjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202708>

On Tuesday 31 July 2012 15:43:57 Jonathan Nieder wrote:
> Florian Achleitner wrote:
> > I haven't tried that yet, nor do I remember anything where I've already
> > seen two processes writing to the same pipe.
> 
> It's a perfectly normal and well supported thing to do.

I played around with a little testprogram. It generally works.
I'm still not convinced that this doesn't cause more problems than it can 
solve.
The standard defines that write calls to pipe fds are atomic, i.e. data is not 
interleaved with data from other processes, if the data is less than PIPE_BUF 
[1].
We would need some kind of locking/synchronization to make it work for sure, 
while I believe it will work most of the time.

Currently it runs  like this:
transport-helper.c writes one or more 'import <ref>' lines, we don't know in 
advance how many and how long they are. Then it waits for fast-import to 
finish.

When the first line arrives at the remote-helper, it starts importing one line 
at a time, leaving the remaining lines in the pipe.
For importing it requires the data from fast-import, which would be mixed with 
import lines or queued at the end of them.

[1] 
http://pubs.opengroup.org/onlinepubs/009695399/functions/write.html
