From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: add config option for custom
Date: Mon, 08 Jun 2015 10:29:58 -0700
Message-ID: <xmqqtwuiaz1l.fsf@gitster.dls.corp.google.com>
References: <0000014dd0a821f6-a4ffca2d-d242-4e96-aeec-7a52186c5df1-000000@eu-west-1.amazonses.com>
	<xmqqsia2cj8c.fsf@gitster.dls.corp.google.com>
	<CANoM8SXM=gk9jpi7PJQh6dVeg=Nbg9bJD0eoU=Y-76vHBsHjcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:30:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20sB-00029a-HA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbbFHRaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:30:03 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36667 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbbFHRaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:30:01 -0400
Received: by igbpi8 with SMTP id pi8so67119718igb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Fi0mo8gKN6ERHfMMDeXXu2fK1reb4gNyFW5QEPBlIJI=;
        b=ThxhFyifw+vqxrNK8826Zoz5KFMu8ZgerfGJRTsyVv1pAyGswVib6pDHkFA+5XSPCU
         rLFkYEqYvuxKe3EyNH1QEnjoUbNRT/zFuxLkXTlfay5jZ9W11gfGQWlOZW+58LQDyoiI
         hB7rqubEZAhD4izCA6e8OYagxj204krOB2eDGQQRiSZ1KEF1WF0b6k7teESW9rNlE3SO
         gCVdRPaScjEvEDrh61M3d4Gufdn/oDSCs11kb2X0s7ltmMJp8Sm/TPXHzUV/CstENkZi
         7Snp01SX52zRibpRTvAYFY6Z6YrNUv7pNTzL5shBwnw058xno1GD33+7UHMRIqjYNpbZ
         O+0g==
X-Received: by 10.107.134.67 with SMTP id i64mr21319854iod.90.1433784600381;
        Mon, 08 Jun 2015 10:30:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id 72sm2139774ioj.27.2015.06.08.10.29.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 10:29:59 -0700 (PDT)
In-Reply-To: <CANoM8SXM=gk9jpi7PJQh6dVeg=Nbg9bJD0eoU=Y-76vHBsHjcw@mail.gmail.com>
	(Mike Rappazzo's message of "Mon, 8 Jun 2015 12:01:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271090>

Mike Rappazzo <rappazzo@gmail.com> writes:

> On Mon, Jun 8, 2015 at 11:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> This is optional, but I still wonder why the command line cannot be
>> more like this, though:
>>
>>         format=$(git config --get rebase.insnFormat)
>>         git log --format="%H ${format-%s}" --reverse --right-only --topo-order \
>>                 $revisions ${restrict_revision+^$restrict_revision} |
>>         while read -r sha1 junk
>>         do
>>                 ...
>>
>> That way we can optimize one "sed" process away.
>>
>> If this is a good idea, it needs to be a separate follow-up patch
>> that changes "%m filtered by sed" to "use --right-only".  I do not
>> think such a change breaks anything, but I do not deal with complex
>> histories myself, so...
>
> As far as I can tell, the rev-list will return multiple lines when not
> using 'oneline'.  The 'sed -n' will join the lines back together.

There is no joining going on.

To "rev-list", a custom --pretty/--format is a signal to trigger its
"verbose" mode, and it shows a "commit <object-name>" line and then
the line in the format specified, e.g.

  $ git rev-list --pretty='%m%H %<(35,trunc)%s' --right-only --reverse ...2024d3
  commit 1e9676ec0a771de06abca3009eb4bdc5a4ae3312
  >1e9676ec0a771de06abca3009eb4bdc5a4ae3312 lockfile: replace random() by ran..
  commit 2024d3176536fd437b4c0a744161e96bc150a24e
  >2024d3176536fd437b4c0a744161e96bc150a24e help.c: wrap wait-only poll() inv..
  ...

Because of that, "format=%m | sed -n s/>//p" would be one way to
make sure that all lines we care about are prefixed by '>' so that
we can pick them while discarding anything else.  So you do need
filtering unless switch to "log", even if you used --right-only.

That is why I didn't use "rev-list" in the message you are
responding to.
