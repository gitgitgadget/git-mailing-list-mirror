From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 12:11:27 +0000
Message-ID: <f36b08ee0607170511u97b1c35s546a47bf8035eb70@mail.gmail.com>
References: <20060706055729.GA12512@admingilde.org>
	 <87k66p8jee.fsf@mid.deneb.enyo.de>
	 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <87fyh1ncm0.fsf@mid.deneb.enyo.de>
	 <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
	 <20060716223607.GA6023@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Florian Weimer" <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 14:11:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2Rx0-00011O-Jv
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 14:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWGQML3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 08:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWGQML3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 08:11:29 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:49311 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750742AbWGQML2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 08:11:28 -0400
Received: by py-out-1112.google.com with SMTP id x31so4187277pye
        for <git@vger.kernel.org>; Mon, 17 Jul 2006 05:11:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OxmaR8J77X6NF5NMQx26kP82IAlKbebGfpSUZMcVdXxO+aSZpArdKBoZ7HcuxL/7TakxAKRuqShTJS1WPlp4ZD1zEgzhwbUCIcp5yEX/UtvU9+eJvMCXvaKx6wGgPPx4Dpx8rgSXBTiNIEjrVTiEg0BvYkG3Iu7OB9MuMjQ3Jc8=
Received: by 10.35.106.15 with SMTP id i15mr3944067pym;
        Mon, 17 Jul 2006 05:11:28 -0700 (PDT)
Received: by 10.35.14.14 with HTTP; Mon, 17 Jul 2006 05:11:27 -0700 (PDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <20060716223607.GA6023@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23968>

Florian Weimer wrote:
> And GIT's workaround is to read the whole file into memory and close
> it after that?  Uh-oh.

On 7/16/06, Alex Riesen <fork0@t-online.de> wrote:
> Yakov Lerner, Sun, Jul 16, 2006 17:03:49 +0200:
> > Cygwin has mmap. But cygwin's mmap() not good enough for git.
> > What happens is that git does rename() when target file has active mmap().
> > In cygwin, this makes rename() to fail. This is what makes cygwin's
> > mmap unusable for git. (BTW for read-only git access, mmap() will work
> > on cygwin, for what I saw. But attempts to modify index will break).
>
> It is not Cygwin really. It's windows. You can't rename or delete an
> open or mmapped file in that thing.

We have right to expect cygwin to do some effort to emulate the unix
mmap() semantics on top of different semantics of windows memory-mapped files.
Why doesn't cygwin do some effort to detect active mmap()s on the file
before rename and do something like (1) unmap (2) rename the target to temp name
(3) remap. (4) take care of temp file cleanup  ?  Probably too messy even if
possible. Is it reasonable to expect git to do this mess ?
It probably belongs to the generic cygwin layer anyway.

I did try another kind of workaround, in which I unmapped the target file
before rename. But it didn't work in all situations and was too intrusive
to the git-apply logic. Didn't work.

Regarding the existing workaround (NO_MMAP), well, cygwin is not exactly a
speed champion in many areas. I didn't really notice speed loss with
NO_MMAP, maybe because cygwin loses time here and there anyway ?

Yakov
