From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 4/7] git-rebase--interactive.sh: look up subject in add_pick_line
Date: Fri, 20 Jul 2012 08:47:58 -0700
Message-ID: <CAOeW2eHeySzEzj_8BByuz4jrc_CreLtZpTshcYsTxqBrtxyg0g@mail.gmail.com>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com>
	<5009135C.208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:48:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFQz-0007qs-E4
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab2GTPsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:48:00 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62500 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599Ab2GTPr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:47:59 -0400
Received: by pbbrp8 with SMTP id rp8so6330808pbb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qrFf+mOanIY6DPm1ndSp2PHkaCnoZiW2O8L/YD3OopM=;
        b=elGhSG3N4/HcGYOgSGnfqpc8JA+6YzckCWGcmBrGExvrpG/doMYLBQnIOyGmwLHbId
         BtAlDzDfSFQ59BWSVxPD+OpmfDsas54Lb5eeDYZugneTMkB4XAapDn20vDwX2jhhOnRz
         8hIYdeGZbn7/jnSLcC0YvQ+S2Yx+XjHaKYYK8hi1wd8iyFXZaJoU6UZUcqsZPVXE0bZd
         hGdsei7kbjDyebKmwnogybDYKn3HcbDmaXF/eFObFrhm2OTKgIoC7mnWcAdpN3ZNZE+s
         rBvNmIQnHsCmqQVPi+EVMoAhgpGiUUnbTsCoxHxJ6s/3FdOqGASHM5tvBLL1heQ55MDY
         Tvfg==
Received: by 10.68.203.66 with SMTP id ko2mr14928159pbc.84.1342799278890; Fri,
 20 Jul 2012 08:47:58 -0700 (PDT)
Received: by 10.68.236.138 with HTTP; Fri, 20 Jul 2012 08:47:58 -0700 (PDT)
In-Reply-To: <5009135C.208@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201779>

Thanks for reviewing.

On Fri, Jul 20, 2012 at 1:14 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 7/18/2012 9:27, schrieb Martin von Zweigbergk:
>> @@ -814,7 +814,8 @@ add_pick_line () {
>>       else
>>               comment_out=
>>       fi
>> -     printf '%s\n' "${comment_out}pick $1 $2" >>"$todo"
>> +     line=$(git rev-list -1 --pretty=oneline --abbrev-commit --abbrev=7 $1)
>> +     printf '%s\n' "${comment_out}pick $line" >>"$todo"
>
> I don't like this. On Windows, rebase -i is already slow, and these extra
> processes will make it even slower.

I don't like it either :-(.

> Anything that can be done about this? Perhaps the rev-list call can
> generate all of the full SHA1, the short SHA1, and the subject with a
> --pretty format?

After patch 7/7, cherry is used instead of rev-list. Ideally, I would
have liked to teach "git rev-list --cherry-pick" to somehow use a
<limit> just like cherry does, but I couldn't think of a generic way
of doing that (in this case, we want to say something like "range
a..b, but drop commits that are equivalent to any in b..c"). I
actually don't remember if I gave up because I couldn't think of a
sensible way of specifying ranges like that, or if I just ran out of
time (not familiar with the revision-walking code). Now it seems to me
that something like "git rev-list a..b --not-cherry-picks b..c" makes
sense, but maybe it's just too specific and we should just support the
limited (no pun intended) case we need to emulate "git cherry", i.e.
something like "git rev-list --cherry-with-limit=a c...b". Feedback
appreciated.

Martin
