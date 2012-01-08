From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] revert: don't let revert continue a cherry-pick
Date: Sun, 8 Jan 2012 14:22:16 -0600
Message-ID: <20120108202216.GL1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-4-git-send-email-artagnon@gmail.com>
 <20120108193749.GH1942@burratino>
 <CALkWK0=-AWy7HnVASB1rt8njavTYOhV7Zxsdq4TE+VShVZmEzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:17:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjzB5-00052Y-V8
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab2AHURK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 15:17:10 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47469 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab2AHURJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 15:17:09 -0500
Received: by iaeh11 with SMTP id h11so5696037iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C/tlraGgf9Kzm3u9fueldccAlNzy7UwDpzQdGsHlEVo=;
        b=G4HCmB3Ch7QghAcq8fElHeQ/Wij/saRddN0rAR9NW94hhEBlHVr8fcYTv9wtNfR9IH
         Tl5o6v+FHdwZCLcpJQVq7dOcymEH2NwcLif2agb/c8tMTBaXL/srAU5+gV1KD3zeHR2c
         LAAxJjSy6/eMIDw1MNCPTKMZIKgBmO7gAHGFY=
Received: by 10.50.195.227 with SMTP id ih3mr16203854igc.19.1326053829125;
        Sun, 08 Jan 2012 12:17:09 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i2sm11720492igq.6.2012.01.08.12.17.08
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 12:17:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=-AWy7HnVASB1rt8njavTYOhV7Zxsdq4TE+VShVZmEzQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188127>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> I don't know --- it's not confusing to me. =C2=A0Could you explain f=
urther
>> what harm the current behavior does? =C2=A0E.g., could it cause me t=
o
>> misunderstand some basic concepts, or could it lead me to run comman=
ds
>> that cause me to scratch my head or lose data?
>
> Junio explained this to me in [1].  It's very unnatural for a user to
> want to execute "git cherry-pick --continue" when the previous comman=
d
> was a "git revert": it probably means that she forgot about the
> in-progress "git revert".
[...]
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/185355

I don't think that's what Junio said.

Did this actually happen, or is it a theoretical worry?  I think I woul=
d
be more likely to run "git cherry-pick <foo>..<bar>" than "git
cherry-pick --continue" if I had forgotten about an in-progress
revert.  The former already errors out with a sensible message.

Or is the problem that I might run:

	git revert foo..bar
	git reset --merge; # conflict --- let's clean this up

	# ah, I remember reverting the patch that conflicted before;
	# let's reuse the resolution.
	git cherry-pick baz
	edit file.c; # another conflict, sigh
	git add file.c
	git cherry-pick --continue; # oops!

?  That seems like a real worry, but the same problem could happen
with cherry-pick used both for the multipick and single-pick, so I
don't think your patch fundamentally addresses it.

In other words, this is a problem caused by the overloading of the
same cherry-pick command for single-pick and multi-pick.  I think it
should be preventable by remembering which action failed when stopping
a sequence and doing only a single-pick resume if
CHERRY_PICK_HEAD/REVERT_HEAD/whatever doesn't match that.

The "oops" is bad since the operator might have been intending to run
some more tests and amend as necessary before continuing the
multi-pick.  It is not _that_ bad, since more typically one would have
already run some tests before running cherry-pick --continue to commit
the resolution.  Still probably worth fixing.

> The problem becomes more serious when the
> sequencer grows more capabilities: a "git merge --continue" to
> continue a "git am" sounds much more absurd.  Ofcourse, we will
> provide a way to continue any sequencer operation in the future: "git
> continue" seems to be a good candidate.

I don't understand why "cherry-pick --continue" resuming a revert
sequence implies that "merge --continue" would have to as well.

All that said, forbidding cherry-pick --continue from resuming a
revert sequence would be fine with me, _as long as the semantics are
clearly spelled out in the commit message and documentation_.  What
happens when there is a mixture of picks and reverts?

Thanks.
Jonathan
