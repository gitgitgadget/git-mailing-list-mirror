From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Thu, 14 Mar 2013 17:58:18 +0700
Message-ID: <CACsJy8BOW-B0_gaNyL5dfdD-eKyknQEvEvf2nNy7xDWr=G02bQ@mail.gmail.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
 <513FB85C.5010106@gmail.com> <CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
 <5140BC80.4000201@gmail.com> <7vtxof146d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 11:59:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG5sY-00069C-VH
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 11:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221Ab3CNK6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 06:58:50 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:38495 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757104Ab3CNK6t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 06:58:49 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so2150886oag.9
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 03:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=F//JxlATcsoKYjT6xlaB3LV0JGdBg7dsDsHnuHWaWGk=;
        b=B6SXo9YQDdvzutaZRI+zg5/yBhETwrjGqgRKl5Klnv7edJiBrXuY1Uu9K2QUos1qFe
         sTeRePYwnvp6ixwjTruyRvnA3BodibtsKuJO50jEbSXtA7kCCQ/YaKGt7+/90aaLA7yq
         MTqoJmz8qH84saSSsnSQ2lWPBkeNfLEiGhvrVQ8Lyd79ItoEM+NPoneRdAaJGVqN0f+5
         Wob+sklWlFMNsZ6CCRzQu9TiyjN9mqclRomSin/KlnziCYcr35BspCtosHE5wLUhUr1Q
         Y2Sii+oqjxWNDgkHMD3UmIlrlU4fbh3QiHjA8ycoZYtyJhEZMlDL/efgNxNHOA4Hpaya
         WW9g==
X-Received: by 10.60.171.230 with SMTP id ax6mr919261oec.25.1363258728577;
 Thu, 14 Mar 2013 03:58:48 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Thu, 14 Mar 2013 03:58:18 -0700 (PDT)
In-Reply-To: <7vtxof146d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218126>

On Thu, Mar 14, 2013 at 2:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karsten Blees <karsten.blees@gmail.com> writes:
>
>> However, AFAIK inotify doesn't work recursively, so the daemon
>> would at least have to track the directory structure to be able to
>> register / unregister inotify handlers as directories come and go.
>
> Yes, and you would need one inotify per directory but you do not
> have an infinite supply of outstanding inotify watch (wasn't the
> limit like 8k per a single uid or something?), so the daemon must be
> prepared to say "I'll watch this, that and that directories, but the
> consumers should check other directories themselves."

Hey I did not know that. Webkit has about 6k leaf dirs and 182k files.
Watching the top N biggest directories would cover M% of cached files:

   N     M%
  10   8.60
  20  13.28
  30  17.52
  40  20.52
  50  23.55
 200  49.70
 676  75.00
 863  80.00
1486  90.00

So it's trade-off. We can cut some syscall cost off but we probably
need to pay some for inotify. And we definitely can't watch full
worktree. I don't know how costly it may be for watching many
directories. If it's not so costly, watching 256 or 512 dirs might be
enough.

What about Windows? Does the equivalent mechanism have similar limits?

> FWIW, I share your suspicion that an effort in the direction this
> thread suggests may end up duplicating what the caching vfs layer
> already does, and doing so poorly.

I'm still curious how it works out. Maybe it's not up to the original
expectation, but hopefully it will speed things up a bit.
-- 
Duy
