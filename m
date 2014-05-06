From: Nathan Collins <nathan.collins@gmail.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Tue, 6 May 2014 12:36:58 -0700
Message-ID: <CAO8RVvfHVBG6QZ5M1DJK4kOX8GMDrvEw4_L=LsEc4G6E0pP7ug@mail.gmail.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
 <20140501024042.GX9218@google.com> <CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
 <xmqqa9aug4my.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:27:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhlBQ-0006MN-LK
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbaEFThl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:37:41 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36608 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbaEFThk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:37:40 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so4383315qgd.37
        for <git@vger.kernel.org>; Tue, 06 May 2014 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GFM9ynY1mQPLgMaz0UrC4iyH9BQjTMN03bf8oO/OwcY=;
        b=VldJzRfye/YqtbsBayEBAzKEHlduBSRpcuJ+cjZUitFR8xcnsXs/F4hVEViewnZqJl
         yvRJ6r9ccFR5L7/K7ceijfpE8jTadwGI87ZPEmI8dL6H27+1My76GB93Xv6DjAXJ57uu
         in964zcl57v9loXdxFajLwmfONOzjHtwRmeJVMR4ETHGx//9LZi2RG67QTc2685R1NWF
         zyM6E/9eT1gj0CtzQlRizJwnwfslq/gT6RNjfx+EoIh7D4iXLv738NmyXrRWsgS3pFWW
         W3kk5q7Y5B1QOBGvHzE1aLDQTCvXtrCrrSR+Q6F1GxvBhbkIf3fBKNqSRT5F/Ts6sK6R
         VJ5Q==
X-Received: by 10.229.134.198 with SMTP id k6mr56907565qct.13.1399405059576;
 Tue, 06 May 2014 12:37:39 -0700 (PDT)
Received: by 10.229.150.208 with HTTP; Tue, 6 May 2014 12:36:58 -0700 (PDT)
In-Reply-To: <xmqqa9aug4my.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248241>

On Tue, May 6, 2014 at 11:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nathan Collins <nathan.collins@gmail.com> writes:
>
>> Hmmm. Maybe a warning that the patch is expected to be in '-p1'
>> format, and that setting 'diff.noprefix=true' makes some commands
>> generate '-p0' patches?
>
> "some"?  Do you have exceptions in mind?

As Jonathan pointed out in his first reply, 'git diff-tree' ignores
the 'diff.noprefix=true' setting.  Compare

  git -c diff.noprefix=true diff HEAD~

with

  git -c diff.noprefix=true diff-tree -p HEAD

(E.g.

   diff <(git -c diff.noprefix=true diff HEAD~) <(git -c
diff.noprefix=true diff-tree -p HEAD)

)

>> But I worry this would just confuse / distract
>> the people that don't have 'diff.noprefix=true' set,
>
> Probably.  But that would suggest that the place to improve the doc
> is for diff.noprefix configuration variable, no?

I don't think that would actually help much in practice. The problem
is that a person (like me) that set 'diff.noprefix=true' in their
~/.gitconfig months or years ago is unlikely to do 'man git-config'
when 'git apply' fails. Having the warning in 'man git-apply' is
better than (only) in 'man git-config', if making 'git apply' smarter
is not an option.

>> Better I think would be for 'git apply' to be
>> smarter, as you suggest below.
>
> As it is a plumbing command behind "add -p", "am", and friends, I
> would hate to see "git apply" pretend to be smarter than its users.
> When the user tells it to use -p0, it shouldn't guess, and when the
> user tells it to use -p1 by not giving any -p$n, it shouldn't guess.

Is there a non-plumbing command for applying patches not in mailboxes?
I don't see how to replace '| git apply --reverse' with '| git am ???'
here.

> As long as we make it clear "git apply" without any explicit -p$n
> means the user is telling it to do -p1 in its documentation, I think
> it would be fine.

OK, then how about a smarter error message? Right now I get

  git -c diff.noprefix=true diff HEAD~ | git -c diff.noprefix=true
apply --reverse
  error: Data/Function/Decorator/Memoizer/Unsafe.hs: No such file or directory

vs

  git -c diff.noprefix=true diff HEAD~ | patch --reverse
  can't find file to patch at input line 5
  Perhaps you should have used the -p or --strip option?
  [...]

But 'git apply' could be much more helpful than 'patch' even, since
the presence or absence of the 'a/' and 'b/' prefixes in the patch,
and the 'diff.noprefix' setting, give Git enough info to be very
helpful to the user.

Cheers,

-nathan
