From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: add config option for custom
Date: Mon, 8 Jun 2015 12:01:26 -0400
Message-ID: <CANoM8SXM=gk9jpi7PJQh6dVeg=Nbg9bJD0eoU=Y-76vHBsHjcw@mail.gmail.com>
References: <0000014dd0a821f6-a4ffca2d-d242-4e96-aeec-7a52186c5df1-000000@eu-west-1.amazonses.com>
 <xmqqsia2cj8c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:01:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zUm-0003c2-3M
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbbFHQBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:01:47 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36797 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbbFHQBq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:01:46 -0400
Received: by obbqz1 with SMTP id qz1so83696807obb.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BvOvr4rP9J6o50Kjhsp829oYHC1aB/NSyCQNcbA/5JM=;
        b=SXlEa0XB4B+2/YXVHU+2KGjJOvsUtB7oT0lIRaO0UJQdZxC7xqz+0ZYSIbx4VYoG13
         HRr6sKEl8fGqfrjshlfP8EzW8PbLripHCS/jAZBjXixnWaee9Ia6UFHdQMZFD6wujPa5
         WwKd/W+grnEkWbcpO13erJ/jSm+vgCGd/LUrRY8rO1Ol/UUOaHfnjXHvNdh3Tabv103c
         Xf90gOxjthAMS1AsbeQaKgWKAOsbFDMV+tZvzvCDyRVxXsF1lt9vfsKCbsOvFnpmwrWF
         +SLjq+P31N1P2x4oJz0fRQyLNdSgHNxMWUbOmiU8J+beAtPFi0eEyHEKcubbICKltNbd
         r7cg==
X-Received: by 10.202.227.15 with SMTP id a15mr14512017oih.59.1433779306350;
 Mon, 08 Jun 2015 09:01:46 -0700 (PDT)
Received: by 10.202.204.20 with HTTP; Mon, 8 Jun 2015 09:01:26 -0700 (PDT)
In-Reply-To: <xmqqsia2cj8c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271060>

On Mon, Jun 8, 2015 at 11:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
>> A config option 'rebase.instructionFormat' can override the
>> default 'oneline' format of the rebase instruction list.
>>
>> Since the list is parsed using the left, right or boundary mark plus
>> the sha1, they are prepended to the instruction format.
>>
>> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
>> ---
>
> Thanks.  Roberto's gizmo seems to be working OK ;-)

Will see if the pull request -> email contraption will allow me to put
[patch v2] in there.  I also need to see if it can make a [patch 0/1]

>
>>  git-rebase--interactive.sh | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index dc3133f..cc79b81 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -977,7 +977,14 @@ else
>>       revisions=$onto...$orig_head
>>       shortrevisions=$shorthead
>>  fi
>> -git rev-list $merges_option --pretty=oneline --reverse --left-right --topo-order \
>> +format=$(git config --get rebase.instructionFormat)
>> +if test -z "$format"
>> +then
>> +   format="%s"
>
> Style.  One indent level in our shell scripts is one HT, not a few spaces.
>
>> +fi
>> +# the 'rev-list .. | sed' requires %m to parse; the instruction requires %h to parse
>> +format="%m%h ${format}"
>
> I think you want %H not %h here.  If you check how the default
> "--pretty=online" is shown, you would see something like this:
>
>     >1e9676ec0a771de06abca3009eb4bdc5a4ae3312 lockfile: replace ...
>     >2024d3176536fd437b4c0a744161e96bc150a24e help.c: wrap wait-...
>
>> +git rev-list $merges_option --pretty="${format}" --reverse --left-right --topo-order \
>>       $revisions ${restrict_revision+^$restrict_revision} | \
>>       sed -n "s/^>//p" |

I will make the changes from above, and resubmit a patch.

>
> This is optional, but I still wonder why the command line cannot be
> more like this, though:
>
>         format=$(git config --get rebase.insnFormat)
>         git log --format="%H ${format-%s}" --reverse --right-only --topo-order \
>                 $revisions ${restrict_revision+^$restrict_revision} |
>         while read -r sha1 junk
>         do
>                 ...
>
> That way we can optimize one "sed" process away.
>
> If this is a good idea, it needs to be a separate follow-up patch
> that changes "%m filtered by sed" to "use --right-only".  I do not
> think such a change breaks anything, but I do not deal with complex
> histories myself, so...
>

As far as I can tell, the rev-list will return multiple lines when not
using 'oneline'.  The 'sed -n' will join the lines back together.  I
will take a look at moving it to 'git log' for a future change.  I
have a huge codebase with tons of branches to experiment with.
