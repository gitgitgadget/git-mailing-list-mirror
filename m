From: Paul Salmon <paul.b.salmon@gmail.com>
Subject: Request: refuse to commit .gitattributes unless the change also
 commits correct line endings
Date: Sun, 10 May 2015 01:57:37 +0100
Message-ID: <CA+nXY9ZfeNAmLcwvYyigKAPtWg9i_0xAiKVAvUCcGZ6OXAfv_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 02:57:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrFYu-0007Mh-Ah
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 02:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbbEJA5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 20:57:39 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35444 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbbEJA5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 20:57:38 -0400
Received: by obcus9 with SMTP id us9so49066446obc.2
        for <git@vger.kernel.org>; Sat, 09 May 2015 17:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ezI4Y17mRpIsRIVoxeSuN1mFksMw7UNWl6+YfiZ4fAM=;
        b=Jf5aKQ1OvMlVGLpjy8TECI3KE2l6RcKeL06sraKJI1SFtILvooD9G4/x4vVQmbW1PP
         IFI51TNHJoqRa1/QFRCdHAgam5Xwz+En/3JGlszqr50LN/7ZBI/9soP0EY14nAfZlEH6
         KWrR/7CvU3PIO/7V7t4RWhrGuDaYgHBiYhdmV2qOFFI2jCFE92OI7AaemmaEIvazzWLf
         +p8TN+rqIqeUJYpwRSRoL+uvfcwo6fLhH7CsMyFFdfX18w+3zbSxcZqmfJVPif/94KoC
         1ph99WIGFE1yOV8wbZgZqdCwYT3aTIbfZ9TS7AXgW0oFk/LQskkog/hE+XOZv11YuH21
         y/Mg==
X-Received: by 10.202.73.81 with SMTP id w78mr3180616oia.89.1431219457931;
 Sat, 09 May 2015 17:57:37 -0700 (PDT)
Received: by 10.76.18.104 with HTTP; Sat, 9 May 2015 17:57:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268715>

When .gitattributes is updated to mark that certain files must contain
certain line endings, those files become "due" for an update. But git
allows .gitattributes to be committed without updating those files to
match. In fact, it won't even tell the committer that they've just
made some files "stale" in this way.

The problem is that when there are files that are pending such a line
endings update, git behaves very badly. In particular, one gets
modified files that absolutely cannot be reverted, and (a much worse
problem) some merges become impossible: you start with a clean
checkout, run a merge, and then git decides that your checkout wasn't
clean after all.

The solution is simple: commit a change that fixes all the line
endings. But until this is done, the repo is pretty broken.

REQUEST

Don't let the repo get into this state in the first place. Or at least
not without a "--force" flag.

Basically, if a commit contains a .gitattributes change, I'd like git
to check whether any files that were previously OK have become "due"
for a newline fix.

If so, Git should error out, explaining that the developer should also
commit fixed newlines at the same time. Or if the developer insists
that they want to break everything, use --force.

MOTIVATION

I recently tried to submit a few pull requests to someone else's
repository that had this problem. First I went through the infuriating
experience of figuring out why git was being so weird (I'm not a
_complete_ git noob but this was totally new to me). Then I found
myself unable to actually make any contributions. I imagine it's OK if
you're the owner, but pull requests require merges from time to time,
and I was almost always prevented from merging things.

On top of this, I had to convince the repo owner that his repo
required a change (a 200 kLOC change!). I wasn't even sure I was right
to begin with. In fact I still wonder if I got it totally wrong and
you guys are going to tell me how dumb I am being.

Paul
