From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/3] Add read-cache--daemon
Date: Tue, 13 May 2014 16:06:30 +0200
Message-ID: <CABPQNSZoo_GD6c6_9my1=+6b2noHWhQSGtYAz-MHE76G-SyyQA@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-3-git-send-email-pclouds@gmail.com>
 <CABPQNSaSDRhuQYey0ad6J0cXrCzrK1CYZQar5GgUM8g3JVmRSA@mail.gmail.com>
 <CACsJy8BFEtXQc7mO1pvdeQ9GMofcW0H2uJF=E6yfN4SwQWgRbw@mail.gmail.com>
 <CABPQNSbu9uVh_LZqQupG9TJe0_ggA1EmAWnk8H7+xOBvcsrcOg@mail.gmail.com> <CACsJy8Du+tvQ=EhZ0rdumeQwfcenhg6R9pbGcYV9bCMqSfHzfw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 16:09:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkDO5-0002SH-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 16:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933870AbaEMOIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 10:08:53 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:46750 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760527AbaEMOHL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 10:07:11 -0400
Received: by mail-ie0-f179.google.com with SMTP id rd18so349389iec.38
        for <git@vger.kernel.org>; Tue, 13 May 2014 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5xXMPtMp+5ukNeD1thoOlSJ6QMNiugOoW/kyj5vntbM=;
        b=E2g37cY4eHDGn1+1dnrKrg0Eaied/xGtnHL1M96Bgqv0ZuWjU12vm9V119EpNhlEJT
         mN/lioK6IRBVQeWUP9acY8C+IDaOWUrfCb1m3oteMnRZq5YZuXjcUy7H4RnpqzHwY0et
         9twwP3hQplBeXjJ6SqDkdU+pMtTQbAV2G2gpyHTMq2v037a2fZ6tyWRGSTdnAc76Eq4W
         YfqqPJWn/vCwt/ssCZXGBRIbRe3E1oIaDhuEVM6GCFSVBLxPeMjOos5XrzyPyBq/UgM9
         dgcc24aU8b6+JUHh9seqpnezqU+08gbJEXYSt/nC/MUxSerAWQVYN78gHDwss9Ss4NFN
         gIrg==
X-Received: by 10.50.238.229 with SMTP id vn5mr56776562igc.45.1399990031168;
 Tue, 13 May 2014 07:07:11 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 13 May 2014 07:06:30 -0700 (PDT)
In-Reply-To: <CACsJy8Du+tvQ=EhZ0rdumeQwfcenhg6R9pbGcYV9bCMqSfHzfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248785>

On Tue, May 13, 2014 at 3:49 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 13, 2014 at 8:37 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Tue, May 13, 2014 at 3:01 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> What do you think is a good replacement for unix socket on Windows?
>>> It's only used to refresh the cache in the daemon, no sensitive data
>>> sent over, so security is not a problem. I'm thinking maybe just
>>> TCP/IP server, but that's going to be a system-wide daemon.. Perhaps
>>> the windows daemon could just monitor $GIT_DIR/index and refresh it?
>>
>> Windows has support for Named Pipes, which seems like the right kind
>> of communication channel. However, the programming model differs quite
>> a bit from unix-sockets:
>>
>> http://msdn.microsoft.com/en-us/library/windows/desktop/aa365594%28v=vs.85%29.aspx
>
> Yeah that was my first option, but if code cannot be shared to
> differences then we probably should go another way. The old
> FindWindow/PostMessage still works with modern Windows, right? Maybe
> we could create a window with a name derived from the daemon's pid and
> save the name in the index, then PostMessage can signal the daemon. On
> the UNIX front, we store pid and send SIGUSR1 instead..The good thing
> here is the Git side will be very simple (PostMessage vs kill).

Hmmm.... I'm a bit worried about having to load in USER32.DLL just to
read the cache that way. But it seems we already do that, thanks to
compat/poll/poll.c (it depends on DispatchMessage,
MsgWaitForMultipleObjects, PeekMessage and TranslateMessage, all from
that DLL).

Preferably, we should delay-load USER32.DLL in compat/poll/poll.c, but
if we start needing it for the reading the index, it'll be loaded by
the vast majority of processes anyway.
