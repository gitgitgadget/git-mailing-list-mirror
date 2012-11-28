From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git fetch pack freezes
Date: Wed, 28 Nov 2012 08:41:30 -0800
Message-ID: <CAJo=hJvGNUtT+z_E7rSaOr77=7dSo1N+7QiEoHNdEQDV3n7JWw@mail.gmail.com>
References: <87624pizoe.fsf@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Ivan Kanis <ivan.kanis@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdki8-0007Lc-48
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 17:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab2K1Qlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 11:41:53 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39322 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab2K1Qlw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 11:41:52 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so9800110qcr.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VMPVc66xG9LF/P6+RVHg32ihbfdYnT3GpqO6tXRLvJM=;
        b=dDVpk0F8hzjLmX0kMnOCNvs6at8NbBvjiubkiMzASk/V+PElwnPcyF2zMe8Nfg1pYi
         AgjVA6vcBUQOBY/FInClZFBraEH0Ldd40hceHfMghph1PnCKorCE7BB/mxI2tSuM43vB
         g7Z+1Jm34WZAx+TDjOZOfhIwQjQV9zCCW5VBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=VMPVc66xG9LF/P6+RVHg32ihbfdYnT3GpqO6tXRLvJM=;
        b=JmADAHaDdgieTYn9lm8DVCfJBrbav/fTeT25pC84d0oVC7H8zmY7m54ovOQHALlUjj
         pq4qyWi3s4oKP2lA2hX7BRc+1rhhujIs8TJVEXlih8b9u0WwZa54cNPR8aHOp7X5be05
         tTFda0+Am4QF4QwxbvhO+jM1hnjFaeV+2YE78FrzMd9Ys47nSsXziky2Evk2CxyJuErJ
         9y4Epxf/iwwdJuUl+ao6yvROu76/wRhD1Im8WbygUzq5uBTp6v2frVTl60dq8U2cGt+W
         4Shntfv13Px6h+Izk+sWUQo0dTydic+i5sMLtTkUB3CZ2/oJitOxF8LpxcBeaeKnap/O
         B+tQ==
Received: by 10.49.38.98 with SMTP id f2mr4080008qek.32.1354120910777; Wed, 28
 Nov 2012 08:41:50 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Wed, 28 Nov 2012 08:41:30 -0800 (PST)
In-Reply-To: <87624pizoe.fsf@googlemail.com>
X-Gm-Message-State: ALoCoQmAyB2zKoLJ945dTPMvF1ydZhsNuXZ2HS1SWTOMmNWkAaXS9QJGb1QZbepSEP/AwR82AV7L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210738>

On Wed, Nov 28, 2012 at 6:12 AM, Ivan Kanis <ivan.kanis@googlemail.com> wrote:
> We are using git with the smart HTTP protocol. We are seeing the client
> freeze with Jenkins poll. It stops the continuous build which is a bit
> of a pain. It happens with the latest release 1.8.0 on the client side.
> The server is using 1.7.0.4.
>
> On the server we are seeing the following error message:
>
> var/log/apache2/error.log.1:[Mon Nov 19 15:17:12 2012] [error] [client 192.168.50.15] fatal: git upload-pack: not our ref aa92ca2076c2421433f89ee0b0ae89cd36d27481 multi_ack_detailed side-band-64k thin-pack no-progress ofs-delta

Upgrade your server. What happened here is a race condition that is
only possible in the smart HTTP protocol. The client makes an initial
request to ask where the branches are. Then it makes a second (and
possibly more) subsequent request to negotiate a common ancestor and
actually obtain the necessary objects. If a branch is updated between
that initial request and any subsequent request, the server fails with
this error message.

More recent servers handle this more gracefully by looking to see if
the object the client wants is reachable within some reasonable
distance from a current branch. If so, the request is still allowed to
continue, rather than die() with a failure.

> On the client side I compiled git with debugging symbols. I then
> attached the debugger to the process that gets hosed. I get the
> following backtrace:
>
> #5  0x000000010f8a1246 in packet_read_line (fd=0, buffer=0x10f981eb0 "", size=1000) at pkt-line.c:211
> #6  0x000000010f7b5196 in get_ack (fd=0, result_sha1=0x7fff6f377450 "") at builtin/fetch-pack.c:227
> #7  0x000000010f7b4074 in find_common (fd=0x7fff6f377668, result_sha1=0x7fff6f377450 "", refs=0x0) at builtin/fetch-pack.c:416
>
> The file descriptor being 0 in #6 seems a bit suspicious. I am not
> familiar with the git protocol. Could I get some guidance on how to
> troubleshoot some more so that I come up with a patch?

There is actually a parent process in front of this one called
git-remote-http (or git-remote-https depending on protocol). That
parent is doing the HTTP transport and is sending whatever the server
provides into this child's stdin. I'm not surprised there is yet
another deadlock condition in here, its a rather heinous process setup
and way to handle the protocol.

fd in frame #7 is an address of an int array. fd in frame #6 is an
actual fd, the one to read from, which in this case should be 0 to
read from stdin, because its trying to get data from the HTTP server
by way of reading it from the pipe the parent supplied to it on stdin.

So the stack frames are correct. Its just a problem that the parent
didn't identify the server crashing and closing its side of the pipe
on stdin to force it to EOF to prevent the child from getting hung
here in a read.
