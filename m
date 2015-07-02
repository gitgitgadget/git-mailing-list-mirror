From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Thu, 2 Jul 2015 12:59:18 -0400
Message-ID: <CAPig+cS+4cbSNZJEHMoj+NRRt3N2guUH_byMb=k9QHeNS--SqQ@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<xmqqr3orakex.fsf@gitster.dls.corp.google.com>
	<CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
	<CACsJy8BdvLiM8Ki=N1k-fBrqqoEONhjwcN6jzGUk=3NPRRujQw@mail.gmail.com>
	<CAPig+cT=U6LxpJuUMaCd-x=gQPvh89SDNUo12+2_3uYb_q3=Og@mail.gmail.com>
	<CACsJy8Dce4ErwaRM7zTgLmRzcHxKOr4J8St46urettr5R4DbVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:02:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAhsv-00017J-Hc
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 19:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbbGBRCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 13:02:45 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35918 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbbGBQ7T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 12:59:19 -0400
Received: by ykdr198 with SMTP id r198so73652150ykd.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xbz40Jp415YdiHBwIcL1JDNdgL5HIir/wm10Odauhi4=;
        b=BYT7XdJHNcw+X9jqaSBqG1CaCwtjCFflHennGxSGwyy40+PFkBX9zem5ezocviT5Wr
         sRl+vrbFn/ysnmPF/DsZvuJ3TxsT3IG2HBj/4XpXVgQBMXoSvB+y724Cc/VIu620Blg6
         UAXoo/w82oAIZIEwwkRwRi8x9qxeJVil96EpiTtDkl5kueZ2rBAfuK1EWMCd/1mwKkt1
         gioQ8/ZFREP+0cx3tSLfVt666vtwGfvrsat4MzyMj6KhTaGwZQlpUpjfv7ozgBuEiNhr
         fJkCEr78YvhyA5HJcxnBAbd3R7SHS0Syw16/DBOg6JAd4aTIMnM0k22r2A8T44+67lDQ
         o5mQ==
X-Received: by 10.170.220.214 with SMTP id m205mr5961169ykf.13.1435856358219;
 Thu, 02 Jul 2015 09:59:18 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 2 Jul 2015 09:59:18 -0700 (PDT)
In-Reply-To: <CACsJy8Dce4ErwaRM7zTgLmRzcHxKOr4J8St46urettr5R4DbVg@mail.gmail.com>
X-Google-Sender-Auth: 4riyrHinQ3sBn9vXe-yv2JELLd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273245>

On Thu, Jul 2, 2015 at 8:41 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 2, 2015 at 9:52 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> The recursion protection is indeed no longer needed and gets removed
>> by the "worktree add" patch. However, there are still a few bits of
>> code which want to know that the checkout is happening in a new
>> worktree. I haven't examined them closely yet to diagnose if this
>> specialized knowledge can be eliminated. Perhaps you can weight in. In
>> particular:
>>
>> checkout_paths:
>>     if (opts->new_worktree)
>>         die(_("'%s' cannot be used with updating paths"), "--to");
>
> This one is easy, as "--to" is gone, no reason to report anything about "--to"

In the "worktree add" patch, I kept this one (with s/--to/worktree
add/) assuming that your intention was that a new worktree should
never start with a partial checkout due to specifying paths. Looking
at it more closely, I'm still not convinced that it can be removed.
Given:

    git worktree new <path> <branch> -- <file>

it creates <path> and checks out <file> (and only <file>) into <path>,
however, the resulting worktree is "not on any branch". The latter, I
think is because switch_branches() doesn't get called in this case;
instead, it's just at whatever HEAD was faked up to appease
is_git_directory().
