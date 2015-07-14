From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/16] worktree: use "git reset --hard" to populate worktree
Date: Tue, 14 Jul 2015 12:40:46 -0400
Message-ID: <CAPig+cS9RVvLd8+uY1CsJzFYmLsNn9S0Z=FLQvpLQYYDX0LiBw@mail.gmail.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
	<xmqqsi8rzyzo.fsf@gitster.dls.corp.google.com>
	<55A4DC1C.90908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 14 18:40:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF3GH-0003dG-So
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 18:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbbGNQkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 12:40:47 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35905 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbbGNQkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 12:40:47 -0400
Received: by ykay190 with SMTP id y190so12933139yka.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=evrc46x0kwmLjRqNG92+HxjGSqYlAVJ0fa6x9DzyXPk=;
        b=zBz2YtD7WiN1eqseh5zBmAyvcicYdfU2G6asl64d+ku16pp64jHPt1WRr7OotLAE/Y
         MAdAcXD1uV19DtYP2IKVpYABLocAA3U2ntqMbk858GZmBFhJxq3fJr/ncnEZNP6bSj4V
         csLGqt9qnGa5F29gEWh+qR1w5cuB+432LtBynCYBy2bQUEoqYqX6lGQkaEZ0Uh3X2PmY
         +yYv869nEwW9mCbgN1Bq3JGNEc+Xlipx1ksSuZNdQdPlNjm4OqP2MkJ+V4Pssvjw6K+b
         kltrYBTRXk1wehEeefrpxswHvBlITFHgqJi/MBNpTOd4UdxlZM8ynsZiQH5yH8+3asDP
         yRKw==
X-Received: by 10.129.70.69 with SMTP id t66mr45162961ywa.4.1436892046218;
 Tue, 14 Jul 2015 09:40:46 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 14 Jul 2015 09:40:46 -0700 (PDT)
In-Reply-To: <55A4DC1C.90908@drmicha.warpmail.net>
X-Google-Sender-Auth: dOZmkO60kQvGbZsiXpgeCtHBZoM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273965>

On Tue, Jul 14, 2015 at 5:53 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> This is a follow-on series to [1], which migrated "git checkout --to"
>>> functionality to "git worktree add". That series continued using "git
>>> checkout" for the initial population of the new worktree, which required
>>> git-checkout to have too intimate knowledge that it was operating in a
>>> newly created worktree.
> Related to that, I'm interested in "worktree list", and I'm wondering
> how many more worktree commands we foresee[...]

The ones I and others came up with (beyond 'add' and 'prune') are
'list', 'remove', 'mv', and 'lock' (for locking and unlocking). I
specifically added a BUGS section to the documentation[1] as a
reminder.

[1]: http://article.gmane.org/gmane.comp.version-control.git/273431

> , and therefore how much
> refactoring should be done: Currently, the parsing of the contents of
> .../worktrees/ into worktree information is done right in prune-spcefic
> functions. They will have to be refactored. The following questions come
> to my mind:
>
> - Is a simple funtion refactoring enough, or should we introduce a
> worktree struct (and a list of such)?
> - Should each command do its own looping, or do we want
> for_each_worktree() with a callback?

for_each_worktree() might be overkill at this time, as I think only
'prune' and 'list' would benefit directly. 'remove', 'lock', and 'mv'
probably just want to lookup a particular worktree (with 'mv', when
renaming, also possibly looking up the destination worktree to check
if it already exist).

> - Is a fixed output format for "list"[1] enough, or do we want something
> like for-each-ref or log formats (GSOC project...)?
> - Finally: Who will be stepping on whose toes doing this?

I had considered working on some of the commands as time permits, but
don't currently have concrete plans to do so. You're welcome to jump
in and tackle these ideas (but perhaps let us know, so toes don't get
trod upon).

> [1] Something like:
>
> * fooworktree (master)
>   barworktree (HEAD detached from deadbeef)
>
> with "*" denoting the worktree you're in (if any) and (optionally?)

Considering that "git worktree list" can be invoked from the main
worktree or any linked worktree, it would be a good idea to include
the main worktree in the output as well.

> adding the "on" info from "git branch" in parentheses after each
> worktree (checked out branch name, or detached info). Maybe the path, too?

I also had something very much like this in mind, possibly extending
the output either with --verbose or custom format capability (keeping
the GSoC project in mind), but otherwise hadn't put much thought into
it.

Showing the path seems quite important, so I'd say yes to that
question, probably by default.
