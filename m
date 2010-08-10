From: Joshua Shrader <jshrader83@gmail.com>
Subject: Re: workflow for working on feature branches and incrementally 
	incorporating "master" changes
Date: Tue, 10 Aug 2010 18:26:16 -0400
Message-ID: <AANLkTim8ALA++TS2SsOCxW50f98Q3ADtJgx4H9cF_=pn@mail.gmail.com>
References: <AANLkTi=h2MbSKmQk9p6w44WORAa8XzkpF0nBXKOgJ4T1@mail.gmail.com>
	<AANLkTi=vscGSErrV_6xBqmryc1hFqi4bjmyOTVgTLNsS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bradley Wagner <bradley.wagner@hannonhill.com>, git@vger.kernel.org
To: Chris Mear <chrismear@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 00:26:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OixH5-0003zd-HE
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 00:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416Ab0HJW0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 18:26:19 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51143 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249Ab0HJW0R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 18:26:17 -0400
Received: by vws3 with SMTP id 3so8033005vws.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DzJWz7hD264BBdN0bqGOaFVQG4uB1KnZzDi0u6djPkI=;
        b=dSHsBSE1RUyzVVFtaFIQSzmc0H1kG4ZCMC8QrraNKPgCAVPKicfQzuKoeRh8KfV3F8
         orfTWpSNn5NwfZISwY3aADwLXT+033xObQvHjkunwFrVxYWL+TM2dIfcP452JGD29h4s
         dTULeMtJFHyQBvWDy+lHtKqEz1ECdqDEPq1FA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=A9YEULMyuiyCOvF7zFplfKlioh1l6o3wAn/KgAVWNpBADtl9cKCPdpo4+enfYW/FUq
         srWcNY3TbazX2Yu1Y0lHdfC+TKvEJbwb2MX8dLSZ2dcBn2Db7M5H74688koQTz0037Rc
         6RctAheQMJmCZnrXP/M/HWVDb5PcVzuvSZCvs=
Received: by 10.220.60.133 with SMTP id p5mr10849762vch.169.1281479176468; 
	Tue, 10 Aug 2010 15:26:16 -0700 (PDT)
Received: by 10.220.162.13 with HTTP; Tue, 10 Aug 2010 15:26:16 -0700 (PDT)
In-Reply-To: <AANLkTi=vscGSErrV_6xBqmryc1hFqi4bjmyOTVgTLNsS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153167>

To elaborate on Chris's response, as an alternative to merging to
feature from master repeatedly, you may want to take a look at git
rerere.  The "Discussion" section at
http://www.kernel.org/pub/software/scm/git/docs/git-rerere.html
explains a workflow where this feature is useful.  You don't rebase,
and so preserve where the feature originally branched, but you also
avoid multiple merge commits from master that may clutter the commit
history.  Essentially, you do a merge, resolve any conflicts, and then
back out of the merge with git reset --hard HEAD^.  This removes the
merge commit, but rerere remembers all of the conflicts that you
resolved.  When you repeat this process the next time, you won't have
to re-resolve conflicts that you've already taken care of.

Essentially, the history looks like you've developed the feature in
complete isolation of master, and fixed all of the conflicts at once
during the only publicly visible merge commit from feature back to
master.  But what you've really done is solved the conflicts little by
little, so the final merge isn't a huge pain in the *ss.

This is probably a more advanced use case, and so might not be the
best approach to a team just getting their feet wet with Git, but
still, it's a workflow that does what you're asking.

On Tue, Aug 10, 2010 at 6:05 PM, Chris Mear <chrismear@gmail.com> wrote=
:
> On 10 August 2010 21:20, Bradley Wagner <bradley.wagner@hannonhill.co=
m> wrote:
>> If you're working on a feature branch by yourself, what is a good
>> workflow for keeping the branch in up-to-date with "master" as you'r=
e
>> developing on the feature branch or is this unnecessary? Should you
>> just wait until you want to officially integrate the feature branch
>> into the "master"?
>>
>> We were doing:
>>
>> commit to local feature branch
>> push to remote feature branch
>> ... repeat....
>> rebase from master (occasionally)
>> push to remote
>>
>> but at this point the branches have diverged.
>>
>> We're coming at this from SVN, so we might just be thinking about th=
is
>> the wrong way.
>
> Git's rebase feature is a *very* nice, clean way to keep a feature
> branch up to date with the master branch. But, as you've seen,
> rebasing can make things a bit confusing you need to push that featur=
e
> branch to other people.
>
> I've found that a good rule of thumb is to never rewrite (i.e. rebase=
)
> branches that have already been shared with others. Of course there's
> nothing impossible or fundamentally bad about pushing rewritten
> branches like this. But, unless people are expecting it to happen and
> know how to deal with it when they pull, it can cause confusion,
> particularly on teams that are just getting acquainted with Git.
>
> Instead, if a feature branch is going to be shared with others, and
> it's going to be long-lived, then we keep it up-to-date by merging
> from master every now and again, rather than rebasing.
>
> On the other hand, if I'm working on a feature branch by myself, and =
I
> haven't shared it with anyone yet, I frequently rebase against master
> to keep things clean. I also use interactive rebase a lot to tidy up
> commits. But as soon as I've shared my branch with the team, I no
> longer do any rebasing/rewriting.
>
> If there are Git wizards on your team, it is true that they may find
> this an inflexible way of working. But I've found it to be a good
> compromise between ease of pulling and maintaining a clean commit
> history.
>
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
