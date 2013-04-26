From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/20] remote-bzr: massive changes
Date: Thu, 25 Apr 2013 20:07:48 -0500
Message-ID: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:09:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAG-0003Ju-BY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582Ab3DZBJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:24 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:42519 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882Ab3DZBJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:23 -0400
Received: by mail-oa0-f41.google.com with SMTP id g12so3463414oah.28
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=yxH58BwYY0o+4n7jcLEIYQZxrfkPPYbtwiE81bBzrR8=;
        b=RWG//xsIrRFqOt3IDUMO8GSN2UTHKn1cH7nmf+5mtvWPWldo+v871FIeduB/v38Fqz
         u84FKtPCkkD6R9QBJdrsJNtmn0td5tH9zXVhdZNkaKivAuRKAKzzuCeR2Utaml5hi6VI
         Uq86J89bWfdGBNOYwFMPQYhkx3BZXzZzrvvZZGTUR3PNXwbgkcz9p0aDLX+pd6Rq37vO
         Kg7p5GPDukUO70o0x3NDJdk75yGDT7q9V861IX7DV1d1opTgiObT99qhq8492SMbD9K7
         5Q9VakAB5NehG9LOqIEWotKZmSX6dE3l9+CQzEtzwbfn0KIFg6e0yuwtdFVcvr6g3CIo
         3V4A==
X-Received: by 10.60.54.6 with SMTP id f6mr16736201oep.136.1366938563260;
        Thu, 25 Apr 2013 18:09:23 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm5845632obb.14.2013.04.25.18.09.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222482>

Hi,

After being contacted by the emacs developers and others who are stuck with
Bazaar, which at this point seems to be utterly abandoned, I realized the
current implementation is too crude.

Bazaar branches are very simplistic, and our support for them is the same; we
need to create one remote per branch. This works nicely if you work on small
projects with few branches, but doesn't scale.

Big projects like emacs take a lot of space, and creating a remote per branch
is unrealistic, because each remote will have the whole Bazaar repository
copied, wasting space, and time each time a remote (for a bzr branch) is set
up.

Moreoever, a developer needs to constantly reset the master branch to the
commit he/she wants to push before pushing, since the transport-helper
infraestructure doesn't support pushing with refspecs (xwidget:master).

That is of course, if pushing actually worked (which in many cases doesn't).

In short, our support for real-world projects suck.

These patches fix all the issues I encountrered.

 1) First of all, there are several improvements for pushing. Before, we failed
    when trying to push a merge, now, even tricky merges work.
 
 2) Secondly, bzr branches are tied to a transport, so they time out if not
    used for a period of time, and importing/exporting huge chunks of a
    repository do take some time. So now they are only opened when they are
    about to be used.

 3) Then the big one; now bzr repositories are supported. They are very simple:
    basically an object store with no notion of branches, so to find the
    branches we need to traverse a directory (sometimes) remote, to find them.
    This is how Bazaar does it, ableit very slowly. Naturally, a lot of code
    had to be changed to support more than one branch.

 4) In addition, now remotes share all the objects, so adding a new remote
    doesn't imply fetchng a bunch of duplicated objects. They are just re-used
    automagically.

 5) Since the bzr objects are shared now, it only makes sense to share the
    remote-bzr marks, so we don't have to fast-import them again.

 6) The code was also reorganized to keep referenced as few objects as
    possible, since Bazaar seems to be need *a ton* of memory for them.

Finally, after all these changes I was finally able to clone the whole emacs
repository, all 130685 commits, and 56 branches without running out of memory
in my modest laptop.

Since the purpose of remote-bzr is to actually be usable for the poor souls
stucks in DSCMs that are not git, these changes are a must. I propose they be
merged for the next major version of git (v1.8.3) if no issues are found. They
changes pass all the tests, and work on various repositories I've tried. I'll
ask the emacs developers to give them a try, and let's see how it goes.

Cheers.

Felipe Contreras (20):
  remote-bzr: cleanup CustomTree
  remote-bzr: delay blob fetching until the very end
  remote-bzr: fix order of locking in CustomTree
  remote-bzr: always try to update the worktree
  remote-bzr: add support to push merges
  remote-bzr: fixes for branch diverge
  remote-bzr: fix partially pushed merge
  remote-bzr: use branch variable when appropriate
  remote-bzr: add support for bzr repos
  remote-bzr: fix branch names
  remote-bzr: add support for shared repo
  remote-bzr: split marks file
  remote-bzr: improve author sanitazion
  remote-bzr: add custom method to find branches
  remote-bzr: add option to specify branches
  remote-bzr: improve progress reporting
  remote-bzr: iterate revisions properly
  remote-bzr: delay peer branch usage
  remote-bzr: access branches only when needed
  remote-bzr: export HEAD

 contrib/remote-helpers/git-remote-bzr | 365 +++++++++++++++++++++++++---------
 contrib/remote-helpers/test-bzr.sh    |  36 ++++
 2 files changed, 302 insertions(+), 99 deletions(-)

-- 
1.8.2.1.884.g3532a8d
