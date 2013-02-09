From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sat, 9 Feb 2013 17:02:04 +0530
Message-ID: <CALkWK0ms76MYa7ddp4F2uyntkFFoBO7gA5JH5Om=OrHxh-encQ@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 12:32:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U48ft-00029I-6e
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 12:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab3BILc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 06:32:26 -0500
Received: from mail-ia0-f179.google.com ([209.85.210.179]:57591 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab3BILcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 06:32:25 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so5075074iak.24
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 03:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wIbrl8esA7CRjI8lEvL5KHIwMg8WzeGYxQqBR93fVMw=;
        b=fCK9p07aTMAA8/8Zps1EekvsSPYyO+ciFGcTXMpkysLx0KU3iWYztqf+Iwsn0i2Pz/
         KwRXU796pCA6rGd9cPwAV9oKSfXt0F5Ro0YaRzbOq9rVgUW47aX7XrnShuHpbRGczr0E
         iL7+pTWkNqJJTIl5oUx/PMLwfsoaLcMdSRjyWqcA7fEVEtT7we82o0gTrVLuH7ncJ3zl
         BU+lVd9J6dPIRNCUhMnVuKvOlaEb4TdXsr5tJyRGig3FteqGdKopn1UhadsXrIpi3gaa
         eFw9231KRE/pH6qXtThoCIjak53oiVlYtZjGy773+N5mjVj4ODJDaIhIpozhm0nNk4Ll
         g7PQ==
X-Received: by 10.42.18.138 with SMTP id x10mr13465137ica.22.1360409544434;
 Sat, 09 Feb 2013 03:32:24 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Sat, 9 Feb 2013 03:32:04 -0800 (PST)
In-Reply-To: <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215858>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I checked read-cache.c and preload-index.c code.  To get the
>> discussion rolling, I think something like the outline below may be
>> a good starting point and a feasible weekend hack for somebody
>> competent:
>>
>>  * At the beginning of preload_index(), instead of spawning the
>>    worker thread and doing the lstat() check ourselves, we open a
>>    socket to our daemon (see below) that watches this repository and
>>    make a request for lstat update.  The request will contain:
>>
>>     - The SHA1 checksum of the index file we just read (to ensure
>>       that we and our daemon share the same baseline to
>>       communicate); and
>>
>>     - the pathspec data.
>>
>>    Our daemon, if it already has a fresh data available, will give
>>    us a list of <path, lstat result>.  Our main process runs a loop
>>    that is equivalent to what preload_thread() runs but uses the
>>    lstat() data we obtained from the daemon.  If our daemon says it
>>    does not have a fresh data (or somehow our daemon is dead), we do
>>    the work ourselves.
>>
>>  * Our daemon watches the index file and the working tree, and
>>    waits for the above consumer.  First it reads the index (and
>>    remembers what it read), and whenever an inotify event comes,
>>    does the lstat() and remembers the result.  It never writes
>>    to the index, and does not hold the index lock.  Whenever the
>>    index file changes, it needs to reload the index, and discard
>>    lstat() data it already has for paths that are lost from the
>>    updated index.
>
> I left the details unsaid in thee above because I thought it was
> fairly obvious from the nature of the "outline", but let me spend a
> few more lines to avoid confusion.
>
>  - The way the daemon "watches" the changes to the working tree and
>    the index may well be very platform dependent.  I said "inotify"
>    above, but the mechanism does not have to be inotify.

Is the BSD kernel's inotify the same as the one on Linux?  Must we
design something that's generic enough from the start?

More importantly, do you know of a platform-independent inotify
implementation in C?  A quick Googling turned up QFileSystemWatcher
[1], a part of QT.

[1]: http://qt-project.org/doc/qt-4.8/qfilesystemwatcher.html

>  - The channel the daemon and the client communicates would also be
>    system dependent.  UNIX domain socket in $GIT_DIR/ with a
>    well-known name would be one possibility but it does not have to
>    be the only option.

UNIX domain sockets are also preferred because we'd never want to
connect to a watch daemon over the network?

Then the communication channel code also has to be generic enough.

>  - The data given from the daemon to the client does not have to
>    include full lstat() information.  They start from the same index
>    info, and the only thing preload_index() wants to know is for
>    which paths it should call ce_mark_uptodate(ce), so the answer
>    given by our daemon can be a list of paths.

Right.
