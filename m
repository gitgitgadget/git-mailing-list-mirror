From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 03/15] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 20 Apr 2016 19:31:55 +0700
Message-ID: <CACsJy8D7_MhzG0yYC-fWjBeqeceVj5aPo2-vYdBMdX6xaSVZrg@mail.gmail.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
 <1461108489-29376-4-git-send-email-dturner@twopensource.com> <alpine.DEB.2.20.1604201349590.2826@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 20 14:32:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asrJ1-0004vu-GF
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 14:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbcDTMc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 08:32:27 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36446 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbcDTMc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 08:32:27 -0400
Received: by mail-lf0-f42.google.com with SMTP id g184so39806158lfb.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 05:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JRtmjri++rJ0KYKDQGmPzlldxOx3OYJNQ16k8uVz3H4=;
        b=dDCmuPxlANFEm47m5FZbj9MaBq9XaxJR9v2YVdkfFTsRlHDOBhybnI/di608yPCih1
         C8rOr9S5AHm1Vx2/SHV4skFpPkMHPDtY3WMHn4O/vdIpHXn6hcus0IwAfbdG4a029Pn5
         yN603bYPUTBsLMpFfAmXnRPzt9ItsEkmzwH543ZJHcWLCWgq/et1TJoP5jekZvZht1oX
         vONTJYHqTb0SAmUpkGKk8OeZIdczrMsbVtpT93sPrUHo2WYdUrRQ+Y7hOUhZxghQKp3W
         j2qE0bS8whPoDzAh3JleLu4laJjjb3ZjRPUPoanmJ5GZfN9MlAwoU9sQlPAslDjaEJQB
         CBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JRtmjri++rJ0KYKDQGmPzlldxOx3OYJNQ16k8uVz3H4=;
        b=OXmDJik1FU1/nFJZ4tTNWowiTMwsmKBqpo18eWACtaobPi0tFj0R7CsnH/SlV0MFBP
         VoBNqGNbSOdlbTSijAr+IybLkL4VOwzqEUJ2fQ+bLcw18hOU57XxXRsN3RLABltiI/e3
         GXeep/MBMsfaGZU1Gnp4Y2fr2j/zFIV+cbSOuvDBZS6wRTewdCzZDeEJR0R5MnSp2+8m
         OfDnAkXtBYpjfzQVQMGd2vKzna6kI5s8hudecIDEN7tbnyOu5jYYtF4Dwk8dgp9CGN2n
         Vt46iXQu2UI+Sau4NsnbRMa3tLEb7rSwDMMn6A4DR48F/0f+jKD0+zBfpFQMhwe2dfYn
         qZtQ==
X-Gm-Message-State: AOPr4FWl5yxV5AhIMMDVfr+eBskcFagQ+jiohFR4b0jm9c2/gUmnd/wbVXTR7x7czJVuUgxL+aStqvhY65gO7g==
X-Received: by 10.25.211.75 with SMTP id k72mr3510468lfg.45.1461155545255;
 Wed, 20 Apr 2016 05:32:25 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 20 Apr 2016 05:31:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604201349590.2826@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292007>

On Wed, Apr 20, 2016 at 7:17 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> We keep this daemon's logic as thin as possible. The "brain" stays in
>> git. So the daemon can read and validate stuff, but that's all it's
>> allowed to do. It does not add/create new information. It doesn't even
>> accept direct updates from git.
>
> I like this design. For now. Later, I really think we should add the
> ability to update the index via the index-helper.

Later we do. For watchman, index-helper creates and shares a piece of
information retrieved from watchman, which has to be combined back to
the index by git process. But it's still not a _direct_ index update.

> I am thinking about a
> method similar to watchman where a separate process (that may use the
> inotify syscall on Linux, or tap into the NTFS journal on Windows) tells
> the index-helper specifically which paths to look at, so that nobody ever
> has to look at any files that were not modified at all.

Am I missing something here? I thought watchman could already run on
Windows. We benefit from watchman, which was originally written for
Mercurial. If there's a better way to do inotify equivalent for
Windows, is it possible to do it in watchman so Mercurial can benefit
from it too?

On Wed, Apr 20, 2016 at 7:19 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> On Wed, Apr 20, 2016 at 6:27 AM, David Turner <dturner@twopensource.com> wrote:
>> > Shared memory is done by storing files in a per-repository temporary
>> > directory.  This is more portable than shm (which requires
>> > posix-realtime and has various quirks on OS X).  It might even work on
>> > Windows, although this has not been tested.
>>
>> There's another option, but I'm not sure if it's too clever/tricky to
>> do. Anyway, on *nix we can send file descriptors over unix socket [2],
>> then mmap them back to access content.
>
> This sounds too clever to me ;-)

Well. At least we have considered everything (that I'm aware of).
-- 
Duy
