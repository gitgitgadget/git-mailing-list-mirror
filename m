From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] commit: search author pattern against mailmap
Date: Sun, 25 Aug 2013 15:37:24 +0200
Message-ID: <CALWbr2zfpZYGri9aGL3DGhadnYF=0xx_h95ZjN7S4beoAES68A@mail.gmail.com>
References: <xmqqob8ml588.fsf@gitster.dls.corp.google.com>
	<1377424889-15399-1-git-send-email-apelisse@gmail.com>
	<20130825103041.GB12556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 25 15:40:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDaY6-0008Mq-6c
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 15:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab3HYNhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 09:37:25 -0400
Received: from mail-qe0-f46.google.com ([209.85.128.46]:35821 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab3HYNhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 09:37:25 -0400
Received: by mail-qe0-f46.google.com with SMTP id f6so1247321qej.19
        for <git@vger.kernel.org>; Sun, 25 Aug 2013 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n7GhXQmiSN2pQlWOnm+s5CPBgIYxextcZGGHrp579Y0=;
        b=oDTBzBCzVnO/b2pNPEkYTcifkc6rFhIp9WhyPVAY/85QtFYjtuoAcDgyKA3eKao7ib
         fnWlZixFwX5ueqnfQvzQ13xMIxML+XWz15Yg4/SAkhJHF8qH+CdkhGAVj4tmNqd5Ylvj
         V8pxJpZfIV31Xczl1S7PZ+sDWPJv3pXJyUZlMZRQe65/KUOZQX70wflQkZi4mmbEkulG
         KB92y2Mehc/7wJF78QHYtSA0Kd4rYinELFVXpOKi0kwiR1syZLEWR2kcmSqsP6EzrFVr
         RtRR+C6kTGTxGWRtI/cY22CcKkc5VfRZ2We2tFmuZo9Euf7Ilphk/295x0XB4jPDQdve
         eEEg==
X-Received: by 10.224.138.8 with SMTP id y8mr10664192qat.27.1377437844398;
 Sun, 25 Aug 2013 06:37:24 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Sun, 25 Aug 2013 06:37:24 -0700 (PDT)
In-Reply-To: <20130825103041.GB12556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232959>

On Sun, Aug 25, 2013 at 12:30 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Aug 25, 2013 at 12:01:29PM +0200, Antoine Pelisse wrote:
>
>> So I kept clear_mailmap() where you put it, but I think it could be moved
>> right after get_revision(). That is because I think format_commit_message()
>> will run another read_mailmap() with an heap-allocated string_list.
>> Anyway, I'm not sure it makes a big difference here.
>
> Yeah, format_commit_message does not even pay attention to our
> revs.mailmap.
>
> It does make me wonder if there should simply be a static singleton
> mailmap that gets loaded once per program invocation and then cleaned up
> at exit. That is clearly what format_commit_message is doing. Is there
> actually a use case for having a custom one in rev_info? It's not like
> you can even control where it reads from when you call read_mailmap.
>
> I guess we need it as a boolean "do we want to mailmap at all" for the
> regular pretty formats, but it could just be a flag in rev_info instead
> of a pointer.

So we would stop passing mailmap string_list along down to map_user(),
and the mailmap file (or blob) would be read the first time it's
needed, and stored in a static global variable in mailmap.c. I think
I'm OK with that because I don't think it would make sense to have
multiple instances of a mailmap string_list in the same git-command
instance.

Who would be responsible for deleting the string_list ? It would
either be done in each command, or done through a atexit(3) registered
function (but then, why would we even care about cleaning it up?).
