From: Nicolas Dudebout <nicolas.dudebout@gmail.com>
Subject: Uniform branch coloring
Date: Thu, 17 Nov 2011 14:08:38 -0500
Message-ID: <CA+TMmK=476h1YyVcegWia2F+1bhOQyNLf-150qF1bnU8Wu3qJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 20:08:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR7KH-00034V-Lp
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 20:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952Ab1KQTIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 14:08:41 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44733 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab1KQTIk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 14:08:40 -0500
Received: by fagn18 with SMTP id n18so3350858fag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 11:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=43QE/zkfJrBzMKTkEtcy6v1L3ib8PGNJ6AArW2YVjAc=;
        b=WLy3SHiPA4OqD2dPM2hDLJYOtiHew4wg2z+7AHCVvx+vbRkGZu7TXp6PO7W7+0ez/M
         ZACUZzHNvmVK/IbhqWAo90i5o7CBoe2p1wxpRapJMf3Bzp9mAIYrJg+kwHNVyJzeJKAG
         Fw2ZDMdVHfVc2nu54y/5SSAr7kzXzSDLynhGM=
Received: by 10.152.132.72 with SMTP id os8mr24466430lab.4.1321556918259; Thu,
 17 Nov 2011 11:08:38 -0800 (PST)
Received: by 10.152.13.105 with HTTP; Thu, 17 Nov 2011 11:08:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185606>

Hi,

I was looking at the coloring of git branches in the output of
different commands and had an idea.
It seems to me that the color coding for branches should be uniform throughout.

It would for example be nice to be able to set current branch to be
yellow and have it be yellow in:
a) git branch -a
b) git log --decorate
c) git status
d) git status --short --branch
e) git checkout
(this list is most likely not exhaustive)

As of now, you need to set the color of the current branch for each
individual command.
Here are the options you need to set:
a) color.branch.current
b) color.decorate.branch
c) color.status.branch
d) It is impossible to change the color (hard coded to green)
e) It is not colored

I think the problems posed by this approach are clear:
- inconsistent coloring for the same object in different commands: a),
b), c), d), e)
- inconsistent coloring for the same object in the same command with
different options: c), d)
- inconsistent naming for the same object in different commands:
current in a), branch in b)
- impossibility to color some objects: d), e)

I have identified ways to address some of these problems:

[1] git status
As the examples c) and d) show there is an inconsistency between the
short and the default version of the command. There are two colors
defined for the same element, namely WT_STATUS_LOCAL_BRANCH for the
short version and WT_STATUS_ONBRANCH for the default version. One
version should be picked and used in both instances. As this is done,
it would be good to also give the opportunity to chose the color of
the remote branch.
<<This problem [1] is what I was trying to solve when I submitted a
patch last night:
http://article.gmane.org/gmane.comp.version-control.git/185563>>

[2] format_tracking_info(branch, &sb)
The function format_tracking_info defined in remote.c is used in only
two other files wt-status.c and builtin/checkout.c. It does not color
the remote branches, the ahead or behind number (git status -sb to
does the full coloring). It would be nice to have these colored.

[3] color naming
It would be nice to unify the naming of the colors meaning the same
thing. I could see using:
- current: for the current checked-out branch
- local: for other local branches
- remote: for remote branches

[4] single option for a type of branch
It would be really useful to create a unique option
config.color.branches.<slot> with <slot> in {current, local, remote}.
This option could also be overwritten by specific command options such
as color.status.current.

[1] can easily be done, once a color name has been decided
[2] could be a little trickier since it is shared code between status
and checkout (might need to solve [4] first)
[3] should be easy but would create some compatibility issues
[4] I do not know how easy it would be to implement. If git is
structured the way it is right now, there is probably a good reason
for it.

What are your thoughts on that?

Nicolas
