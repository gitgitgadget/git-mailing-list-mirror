From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] gc and impatience
Date: Sat, 3 Aug 2013 12:25:11 +0700
Message-ID: <CACsJy8DO4VyCK_xDJDGVx6JLTqjKAf24AUOW3=kZEMEVjAUSVw@mail.gmail.com>
References: <CALkWK0k2B5OW9zMrw0jBDDWpufojYDJybXa7jCBdzftNUc7mxA@mail.gmail.com>
 <CACsJy8DRo9Akoydwn9-EPOSyJiPhqAf1=HncYjHvXZwS4S_d7A@mail.gmail.com> <CAPc5daXi_ZG6GcK6pWafffyOY4MEZHUMkZxTxiRiU4BaFybqqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 07:25:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5ULa-0004FY-Cw
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 07:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142Ab3HCFZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 01:25:42 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:40531 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab3HCFZl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 01:25:41 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so1398264pbc.30
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 22:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AdntgaXWM17WeZqA0RywEW5FK12z+scZGmWVj+OPdpA=;
        b=0jSIUTHECt6S/Ve3leQXz2oGV5Z4ZB/8He06hgUoaoOPZVu5ayGjG0LF232Hz7C45S
         nXpwsWIeDMVzM4Mu4JWWjZEC8+zN5GcXppc5UWUX1w9lKlMlY+wvWnVAIa90cMGkjNkD
         J73qg7UUlSeZrJLukb+P4ECVnRYAY0/+OTT2g2Lik0a7PI7n8fB1SxrsRfOEkCLUvwMc
         Ox9eXIOMZr4oam0Y/8wVjJvq7gritWpfHeHJSvA+j7HifMbgDvlR19PmAFjZC96ep5Ya
         s4SoCd/y/pT0D00+Uz68+HgXrZhO0R2+MTGrzPQA+A74jIJSiI2nE/ixIF0/VcedThlL
         e3fw==
X-Received: by 10.68.105.195 with SMTP id go3mr11021324pbb.180.1375507541265;
 Fri, 02 Aug 2013 22:25:41 -0700 (PDT)
Received: by 10.70.7.195 with HTTP; Fri, 2 Aug 2013 22:25:11 -0700 (PDT)
In-Reply-To: <CAPc5daXi_ZG6GcK6pWafffyOY4MEZHUMkZxTxiRiU4BaFybqqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231561>

On Sat, Aug 3, 2013 at 11:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Fri, Aug 2, 2013 at 8:53 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Good point. I think that is because gc does not check if gc is already
>> running. Adding such a check should not be too hard. I think gc could
>> save its pid in $GIT_DIR/auto-gc.pid. The next auto-gc checks this, if
>> the pid is valid, skip auto-gc.
>
> Defining "valid" is a tricky business, though, as pid can and will
> wrap around,

Yes there is a chance that the old pid is not used for another process
and it could get worse when that process is a daemon and runs forever.
If we go the optimistic way, we could check mtime of auto-gc.pid. If
it's older than a couple hours, ignore it and run gc anyway, assuming
gc can't last longer than an hour or so. A more reliable way is save a
unix socket instead of auto-gc.pid and send something over the socket
to verify it's gc, but I think it's overkill.

> and the directory could be shared on multiple machines. A
> pid written by a process on one machine has no relation to any pid on
> another machine.

I worry less about this. It's not the right model to have two machines
modify the same shared repository (gc --auto is only triggered when we
think there are new objects) even though I think we support it. If
it's two _scripts_ modifying the same repo, I don't care as this is
more about user interaction. If it's two people modifying the same
repo, it sounds like an insane setup and there may be more issues to
worry about than gc --auto.
-- 
Duy
