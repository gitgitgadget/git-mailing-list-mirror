From: Jeff King <peff@peff.net>
Subject: Re: Re* git commit fails under some circumstances
Date: Tue, 5 Apr 2011 13:36:04 -0400
Message-ID: <20110405173603.GD9965@sigill.intra.peff.net>
References: <AANLkTikHRM10p9e8XCzuiih7cYtQRG7Az2Qn5qtPzhZJ@mail.gmail.com>
 <7vhbagh3aw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Laszlo Papp <djszapi@archlinux.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 19:36:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7AAo-00078s-Nd
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 19:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab1DERgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 13:36:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36186
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037Ab1DERgH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 13:36:07 -0400
Received: (qmail 26044 invoked by uid 107); 5 Apr 2011 17:36:52 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Apr 2011 13:36:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Apr 2011 13:36:04 -0400
Content-Disposition: inline
In-Reply-To: <7vhbagh3aw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170893>

On Sat, Apr 02, 2011 at 12:16:23PM -0700, Junio C Hamano wrote:

> When running "commit" and "status" with files marked with "intent to add",
> I think there are three possible interpretations of what the user wants to
> do.
> 
>  (1) I earlier said "I'll decide the exact contents to be committed for
>      these paths and tell you by running 'git add' later." when I said
>      'git add -N'.  But I forgot to do so before running "git commit".
>      Thanks for catching this mistake and erroring out.
> 
>  (2) I said "I'll decide the exact content to be committed ... later."
>      when I said 'git add -N'. I am running "git commit" now, but I still
>      don't know what the final contents for this path should be.  I
>      changed my mind, and I do not want to include the addition of these
>      paths in the commit I am making.  Please do not error out, but just
>      ignore the earlier 'add -N' for now.
> 
>  (3) I said "I'll decide the exact content to be committed ... later."
>      when I said 'git add -N'. I am running "git commit" now, without
>      explicitly telling you with 'git add' about the final contents for
>      these paths.  Please take it as an implicit hint that I am happy with
>      the contents in the working tree and commit them as if I said 'git
>      add' on these paths, but do leave modifications to already tracked
>      paths that I haven't added with 'git add'.
> 
> The current behaviour of "git commit" that refuse to commit without
> telling git what the final contents for these pathse is a very deliberate
> design and implementation of (1).

I think that all three of those are reasonable things to want to do, and
that the current behavior of (1) is a nice, conservative default. But
where we could do better is in helping the user understand what happened
and what their options are.

In Laszlo's example, he saw:

  $ git commit
  lib/achievement.cpp: not added yet
  lib/achievement.h: not added yet
  lib/achievementparser.cpp: not added yet
  lib/achievementparser.h: not added yet
  error: Error building trees

I see a couple of places to improve:

  1. We say "not added yet", which is a good start. We at least point
     out the problematic paths. But it's perhaps a little confusing.
     Those paths _have_ been added. It's just that no content was added
     at them yet.

  2. The "error: Error building trees" is unnecessarily scary, as it
     looks like git ran into some error while trying to do what you
     wanted (and indeed, that is the same message you get for something
     like "oops, we couldn't write to the object db"). It's not even
     clear from that output that the "not added yet" lines are the cause
     of the error, unless you understand how "git commit" is
     implemented.

  3. There is no advice given on how to proceed.

So I think a much nicer output would be something like:

  $ git commit
  error: some paths could not be committed
  The following paths were marked with intent-to-add, but have
  not had any content added:

    lib/achievement.cpp
    lib/achievement.h
    lib/achievementparser.cpp
    lib/achievementparser.h

  If you want to commit them with their current content, use "git add".
  If you want git to forget about them, use "git rm --cached".

We could also provide some options to git commit to make those
operations easier. Especially "ignore these for this commit but leave
them in the index" is a little awkward to do.

> Having said all that, we might want to differentiate these paths in the
> output from 'status'.

Yes, that was my first thought on reading Laszlo's message. We are
somewhat lying to say "changes to be committed". Your suggestion:

>     # ... to be committed ...
>     # new file: RENAMING (needs 'git add')
>     # ... have local changes ...
>     # modified: RENAMING

You could also give them a separate stanza, like:

  # Changes to be committed:
  #   (use "git reset HEAD <file>..." to unsage)
  #
  #     modified: some-other-file
  #
  # Paths marked for addition, but needing content:
  #   (use "git add <file>..." to update what will be committed)
  #
  #     new file: RENAMING

> if we don't care about the backward compatibility.

I don't know how much we need to care about "git status" output of this
form. It is parsed mainly be editors' syntax highlighters. Adding this
new information might not get highlighted as nicely, but it's probably
not a big deal.

I am much more concerned with whether and how this information would be
represented in the "git status --porcelain" format.

-Peff
