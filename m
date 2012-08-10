From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Porting git to HP NonStop
Date: Fri, 10 Aug 2012 09:27:38 -0700
Message-ID: <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, rsbecker@nexbridge.com
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:28:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szs4E-0006Mn-N2
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 18:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab2HJQ2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 12:28:01 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:64851 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab2HJQ2A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 12:28:00 -0400
Received: by ghrr11 with SMTP id r11so1775743ghr.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WRiQH1xWhLLTmvfmpAdeDbPH1CwGpf8tNRk3I7rPA48=;
        b=AbQr90qHdKhDwowrqyeuNAsV1CgtTakBXPy2LF38Cumfenpy3aCrf2tS1N8o7NsDj0
         kMXrkwrWs5G7hcNgRYbEww62hR1HXU/YCI3R0LRf6fTsMyHxWHW3tVtCW2HwRi2vIoVP
         AWJvKMXigOf3xkEb9zSjK6gE7sRIZWDscghi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=WRiQH1xWhLLTmvfmpAdeDbPH1CwGpf8tNRk3I7rPA48=;
        b=h4pWO3vzLLiUuWV4Mkoez1x3678ieQTsl8od+6KCUyQXkjZEuLllu+h8JeLKs0506P
         IcPmQ5qMnvoBsv8ie7vePZsGSde2jVFRrUObC5hURXXli2G2Izx1VEvumyO0wKuHxX47
         odpipyFVHZB8nDE+KsWS7w5mkrslOWpGpGXS9skKlJTuSt0uGiKgDGNY+TBS3CWU2bXQ
         FbcdIFqss2ejcOk/p7SxBkOmoXU6zkh3/3R25don9hMLe6PPYiB7u35OlyGIXnLs8pHf
         LEP2KZyKKAhV7kWxip1eQ9oeAj/NCiFMui5lpqZZKIxgN7MBXfJS4o9ZX1DcoAwjalKI
         DmFg==
Received: by 10.50.188.130 with SMTP id ga2mr293545igc.32.1344616078911; Fri,
 10 Aug 2012 09:27:58 -0700 (PDT)
Received: by 10.64.22.231 with HTTP; Fri, 10 Aug 2012 09:27:38 -0700 (PDT)
In-Reply-To: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
X-Gm-Message-State: ALoCoQlS2c5ykA55nMQZ9g/7ST596qJnnxOpudikVD/oUnZCHDlfBNyGzTpIz4qgZYooMXW22CWn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203231>

On Fri, Aug 10, 2012 at 8:04 AM, Joachim Schmitz
<jojo@schmitz-digital.de> wrote:
>>
>> - HP NonStop is lacking poll(), git is making quite some use of it.
>> My Solution: I 'stole' the implementation from GNUlib, which implements
>> poll() using select().
>> Git should either provide its own poll(), not use it at all or resort to
> using
>> GNUlib, what do you think?.

poll() is usually better than select() because you don't need to worry
about FD_SETSIZE. That said, the compat/ directory contains
implementations of some functions. You could contribute a fake poll
that uses select if it was under the GPLv2.

>> - HP NonStop is lacking getrlimit(), fsync(), setitimer() and memory
> mapped IO.
>> For now I've commented out the part that used getrlimit() and use a home
>> brewed implementation for fsync(), setitimer() and mmap().

There is no need to define your own mmap(). Define NO_MMAP=1 in the
Makefile. Git already has its own fake mmap and knows how to write it
back to disk when making changes.

>> - git makes use of some C99 features or at least feature that are not
> availabe in
>> C89, like 'inline'
>> C89 is the default compiler on HP NonStop, but we also habe a c99
> compiler, so
>> telling configure to search for c99  should help here.

You could also disable inline by #define inline /**/, but this will
probably result in a slower binary.

>> - HP NonStop doesn't have stat.st_blocks, this is used in
> builtin/count-objects.c
>> around line 45, not sure yet how to fix that.

IIRC the block count is only used to give the user some notion of how
much disk was wasted by the repository. You could hack a macro that
redefines this as st_size.

>> - HP NonStop doesn't have stat.st_?time.nsec, there are several places
> what an
>> "#ifdef USE_NSEC" is missing, I can provide a diff if needed (offending
>> files: builtin/fetch-pack.c and read-cache.c).

I think this would be appreciated by anyone else that has a similar
problem where the platform lacks nsec.

>> - Once compiled and installed, a simple jojo@\hpitug:/home/jojo/GitHub $
> git
>> clone git://github.com/git/git.git fails with:
>> /home/jojo/GitHub/git/.git/branches/: No such file or directory After
> creating
>> those manually it fails because the directory isn't empty,
>> catch-22
>> After some trial'n'error I found that the culprit seems to be the
> subdirectories
>> branches, hook and info in /usr/local/share/git-core/templates/, if I
>> remove/rename those, the above command works fine.
>> I have no idea why that is nor how to properly fix it, anyone out there?

This sounds like the templates directory was not created correctly
during installation, or is being copied incorrectly during the git
init process. I would start by comparing the structure and permissions
of the templates directory on your HP NonStop system to one on a Linux
system and see if there was a mistake made during the installation
process. If the directory matches, I would then use `git init --bare`
in a new directory to copy in the templates, and see if its the
template copying code that is making an incorrect copy.
