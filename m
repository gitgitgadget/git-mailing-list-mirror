From: Jacob Keller <jacob.keller@gmail.com>
Subject: proper remote ref namespaces
Date: Tue, 11 Aug 2015 23:43:56 -0700
Message-ID: <CA+P7+xpj+8DZ=K0pna299Mu3nsQ4+JV_JUK=WFzzAFnJN+Bkbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 08:44:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPPm1-0006Ni-18
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 08:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933504AbbHLGoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 02:44:18 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34315 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933411AbbHLGoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 02:44:16 -0400
Received: by igui7 with SMTP id i7so55749990igu.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 23:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=s9MYf3919fzXDBVs/bhU3Jhj6Noz+YwnhiM7I+5xD+U=;
        b=Q9V+fkBvBfstvw0FMC9G5Dk97iSRu42hPtcshtrXD5XEQ6oBX9oqk3NT6tXbCwtzrw
         F0m6/4xpmSPUPYSoeggs3+DjSZv9BCp9PiXb879VoDKqSrRIyEu0PrYFICpFNXU64FbM
         ON+5Z7oW5kQjTQkSx5T5UsuqeaKQy/rC8g/sRnk2V1ISqao3X73RwsWWBUW6nO8jIQLU
         pAE+mH//JT8+3eXn+j47C4nD6q19xQeHqdTOpiVJvzPTDyjIVYniHhETcrdAZrTAWnq/
         OjcoQm9g5/MnmR8HqJEF0pGAIiimo3kP3JDzuRlY1P2hRtsDzULthrXYlxagb0GuiLF/
         mkSA==
X-Received: by 10.50.27.39 with SMTP id q7mr21039398igg.73.1439361855674; Tue,
 11 Aug 2015 23:44:15 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 11 Aug 2015 23:43:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275757>

Hello,

Recently there was some discussion about git-notes and how we do not
fetch notes from remotes by default. The big problem with doing so is
because refs/remotes/* hierarchy is only setup for branches (heads),
so we don't have any clean location to put them.

Around the time of git 1.8.0, Johan Herland made a proposal for
remotes to put all their refs in refs/remtoes/*, by moving heads into
refs/remotes/<remote>heads/* [1]

In addition, his proposal was to include remote tags into
refs/remotes/<remote>/tags and also refs/remotes/<remote>/replace and
notes similarly.

During this discussion there was many people who liked the idea, and
others who rejected it. The main rejection reason  was two fold:

(a) tags are "global" per project, so their namespace should be
treated global as it is now.

The proposal's counter to this is that tags aren't guaranteed to be
global, because today two remotes you fetch might have tags that are
the same name with different pointers. This is currently hidden, and
git silently picks the tag it fetched first.

(b) script compatibility, as changing the ref layout  such that new
git can't work with old repository would be bad

the counter to this, is that we make git smart enough to recognize old
remote format, and continue to work with it. Scripts which depend on
this layout will break, but that may not be such a huge concern.

Personally, I think this proposal at least for heads, notes, replace,
and other remote refs we'd like to pull is very useful. I don't
rightly know the answer for tags. The linked discussion below covers
several pages of back and forth between a few people about which
method is best.

I like the idea of simplifying tags and branches and notes and others
to all fetch the same way. local stuff is in refs/heads or refs/notes
and remote stuff is (by default) in refs/remotes/<remote>/tags etc

But it does bring up some discussion as today we "auto follow" tags
into refs/tags, and it can get weird for tags since now "ambiguous"
tags must mean if there are tags of same name which point to different
refs, and we'd need to teach a bunch of logic to the ref lookup code.

I am looking at ways to help git-notes be easier to use, so that we by
default fetch notes, and enable easier merge, since we'd have default
locations to merge from and to. This would make the sharing of notes a
lot easier, which is one of their primary sticking points.. you can't
really share them without *everyone* working to do it the same way you
do. By making a default policy, sharing becomes natural, and users can
easily add *public* notes to commits for things such as bug ids and
other things which are not discovered until after the commit is
created.

In addition, the easy ability to share replaces might also be helpful,
though IMHO not as valuable as git-notes.

I think that the only logical refs layout is
"refs/remotes/<remote>/(heads|tags|notes|replace)"

and adding "refs/remote-notes" and "refs/remote-replace" is not really
a clean solution.

Given that the 1.8.0 proposal mostly died, does anyone have any thoughts now?

The proposal suggested by Johan makes sense to me, and I believe we
can code up logic to make it easy for new git to keep logic of the old
layout.

Personally, I think the best solution is to only store that layout for
a given clone, using a config option that defaults to false, where
new-git sets it to true for all clones. Then, provide a command to
renew remotes-layout that does this if the user wishes. Thus, clones
for the old style will be handled, and new clones would have the new
layout. (ie: no mixing layouts in a single repository).

I'm really not sure if this is the best solution, but seems like the
cleanest solution.

Regards,
Jake

[1] http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=165885
