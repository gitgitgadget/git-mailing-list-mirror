From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC PATCH 2/3] mergetools/kdiff3: allow opting-out of auto-merges
Date: Thu, 9 May 2013 15:17:30 -0700
Message-ID: <CAJDDKr4S6=U1d1fWixaiAzf46KLBDNsi85fgvXy0Uu_aRJyoyw@mail.gmail.com>
References: <1368090810-40596-1-git-send-email-davvid@gmail.com>
	<1368090810-40596-2-git-send-email-davvid@gmail.com>
	<7vli7ob0c4.fsf@alter.siamese.dyndns.org>
	<20130509172334.GK25912@serenity.lan>
	<7v38tw9d7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Charles Bailey <charles@hashpling.org>,
	"Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 00:17:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZ9b-0007nX-TT
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 00:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095Ab3EIWRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 18:17:32 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:63143 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab3EIWRb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 18:17:31 -0400
Received: by mail-ea0-f169.google.com with SMTP id n15so1905420ead.28
        for <git@vger.kernel.org>; Thu, 09 May 2013 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=2ZcfobdNqsLuTFoQw9/eAQkY0nt/LjT3Aq0RnZj7kpY=;
        b=hBsSOWszE6iFlMuD73MZa60qKBI+3NpaD80nMITuHLLRMoORbKDkeEj6Cuo6tezeDR
         7CjzLYrMP5GcBiWeOW3EvkNgEq+g5jvRLmSsV0J+TWAsvIDr75ZD9YkQV57muUw4sxfG
         2RbL3C4ssRYQURdwI8kDHJC10K0C1Y3fVN6rGO7DQ5GkpgjQ2QgLexhuYzKydUmwJgfr
         ihvhhk+sB9IVCrBQ+BS78ypSPlEtP8hGJTIrONgU+1GdyTH7VNXguulTO9uDaKDyDyoM
         M/QlGq6qs/dsEZgWtX0loTbgCZyBgW3v4BbKp00r6dzMoPp2XGqhVXb1jYQMK38H3aOV
         fYFg==
X-Received: by 10.15.33.195 with SMTP id c43mr34361972eev.2.1368137850169;
 Thu, 09 May 2013 15:17:30 -0700 (PDT)
Received: by 10.14.32.65 with HTTP; Thu, 9 May 2013 15:17:30 -0700 (PDT)
In-Reply-To: <7v38tw9d7r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223787>

On Thu, May 9, 2013 at 12:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> On Thu, May 09, 2013 at 09:10:51AM -0700, Junio C Hamano wrote:
>>> David Aguilar <davvid@gmail.com> writes:
>>>
>>> > Marked "RFC" because I am kinda against adding more configuration
>>> > variables.
>>>
>>> Just like "git merge" has -X<option> escape hatch to allow us to
>>> pass backend-specific options, perhaps you can add a mechanism to
>>> "git mergetool" to let the user pass --no-auto from the command
>>> line?
>>
>> We already have "mergetool.<tool>.cmd" which allows a completely custom
>> command line to be specified.
>
> Then probably it is a good idea to drop this patch and replace it
> with a documentation patch to suggest those who do not want --auto
> to use that mechanism?

Generally, "mergetool.<tool>.cmd" is not general enough since we've
always special cased the base vs. no-base code paths and we run
different commands depending on whether a base is available.

It might make sense to extend that mechanism to allow
"mergetool.<tool>.merge2cmd" for the no-base form and allow .cmd to
remain as-is for the full 3-arg base form, but IMO that's an even
worse solution for the end user as they now need to configure two
separate variables and know all the intimate details about how to
configure it.  OTOH, a boolean git configuration flag is much easier
and simpler for the user.

The -X--no-auto idea could work, but I was hoping for a "set once and
forget" fix I could hand to a user, which would remove the need for
such a feature.

Here's the background behind why I wrote this patch -- yesterday
someone at work asked, "does git mergetool not work with stash?"  This
caught me by surprise, "yes, of course it does", I replied, but they
showed me a case where the behavior was confusing.

They had done "git stash && git pull --rebase && git stash pop".  That
last pop created a merge conflict in one file.

They then ran "git mergetool" to resolve the merge but they never saw
the GUI and their changes were automatically staged.  From a user's
POV this is unintuitive and confusing behavior because they were
expecting to run kdiff3, but instead it silently staged the file with
kdiff3's auto-merged result.

We could drop --auto altogether, which maybe is a better course of
action since it makes the behavior predictable and un-surprising, but
I do not know if anyone has come to rely on kdiff3's "auto-merge"
feature (hence the extended Cc: list).

Because I do not know exactly why "kdiff3" thinks these are "trivial
merges" it can resolve while "git stash pop" disagrees and cannot
trivially merge them, I seems that dropping "--auto" really may be the
better choice all around.  In general, git tries to be extremely
careful and defers to the user in the face of ambiguity.  Dropping
--auto would make sense from that POV since kdiff3 is preventing the
user from inspecting the result.

In other words, if there are no strong reasons to keep --auto then I
would not be opposed to changing the default.  OTOH if there are users
that want it and some that don't, then the config variable is helpful,
and maybe it can be flipped the other way:  call it
"mergetool.kdiff3.autoMerge", keep it False today, and maybe change
the default to True with Git 2.0.

But I would really prefer no configuration and the most intuitive and
least-surprising behavior.  I think I've convinced myself that
dropping --auto altogether could accomplish this, but I do not want to
pull the rug out from under existing users, *if they exist*.  If
everyone in this discussion is in the camp of, "I didn't even know it
worked that way" then changing the behavior is not so big a deal and
we can do without extra variables.

Would it be acceptable for me to rework this patch to drop --auto altogether?
--
David
