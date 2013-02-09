From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sat, 9 Feb 2013 09:10:25 +0700
Message-ID: <CACsJy8DW=tkEy2iOAZxQ+ZyVQ+L11JsPcSxrES5YY7gECmX7UQ@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 03:11:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3zuU-0003qg-Mw
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 03:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760542Ab3BICK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 21:10:58 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33327 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760541Ab3BICK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 21:10:57 -0500
Received: by mail-oa0-f46.google.com with SMTP id k1so4678037oag.19
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 18:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IRl7pLu0/K05vPslIqL8fGOAk7HdfBkE9eP+wxTSvVI=;
        b=FM05RCcGACILta/QF1V5p4WSag6u+FYotGxpO5jDBX7jGVLLhkPghUdAo1QiLe69KK
         5D1jb+5XTKx4jMIpfWMAW5RP5mfJe0w5WVjA3yuVCMqrvP2Hr8CSyPljb3wRJRMTI5D8
         PKiZ/hvvu5hZCRBtzmqdPWZ5DUTJ17lmk7m5iVsYtYG/O56Tz8bGK8V1Vau0pMunpHfL
         FUf0cMI/6MbjCh5A2J4P5MURW+n0OyvLCsDCGiGy7Qvxl8oxtE/JLCyVuzB2WJbJh5EE
         08Ta3qoEL1DmSmY+YAq6TB/Aw1v+Iz9FTffU3X9gNzJ3o6aAodP5YXJooquCwY+O8vSt
         aaUQ==
X-Received: by 10.60.7.167 with SMTP id k7mr5967759oea.20.1360375856025; Fri,
 08 Feb 2013 18:10:56 -0800 (PST)
Received: by 10.182.129.46 with HTTP; Fri, 8 Feb 2013 18:10:25 -0800 (PST)
In-Reply-To: <7va9rezaoy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215845>

On Sat, Feb 9, 2013 at 5:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> ...  Will Git ever
>>> consider using inotify on Linux?  What is the downside?
>>
>> I think this has come up from time to time, but my understanding is
>> that nobody thought things through to find a good layer in the
>> codebase to interface to an external daemon that listens to inotify
>> events yet.  It is not something like "somebody decreed that we
>> would never consider because of such and such downsides."  We are
>> not there yet.
>
> I checked read-cache.c and preload-index.c code.  To get the
> discussion rolling, I think something like the outline below may be
> a good starting point and a feasible weekend hack for somebody
> competent:
>
>  * At the beginning of preload_index(), instead of spawning the
>    worker thread and doing the lstat() check ourselves, we open a
>    socket to our daemon (see below) that watches this repository and

Can we replace "open a socket to our daemon" with "open a special file
in .git to get stat data written by our daemon"? TCP/IP socket means
system-wide daemon, not attractive. UNIX socket is not available on
Windows (although there may be named pipe, I don't know).

>    make a request for lstat update.  The request will contain:
>
>     - The SHA1 checksum of the index file we just read (to ensure
>       that we and our daemon share the same baseline to
>       communicate); and
>
>     - the pathspec data.
>
>    Our daemon, if it already has a fresh data available, will give
>    us a list of <path, lstat result>.  Our main process runs a loop
>    that is equivalent to what preload_thread() runs but uses the
>    lstat() data we obtained from the daemon.  If our daemon says it
>    does not have a fresh data (or somehow our daemon is dead), we do
>    the work ourselves.
>
>  * Our daemon watches the index file and the working tree, and
>    waits for the above consumer.  First it reads the index (and
>    remembers what it read), and whenever an inotify event comes,
>    does the lstat() and remembers the result.  It never writes
>    to the index, and does not hold the index lock.  Whenever the
>    index file changes, it needs to reload the index, and discard
>    lstat() data it already has for paths that are lost from the
>    updated index.


-- 
Duy
