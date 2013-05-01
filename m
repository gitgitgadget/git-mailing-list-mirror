From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/18] remote-bzr: massive changes
Date: Tue, 30 Apr 2013 20:09:52 -0500
Message-ID: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:11:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLaF-0006ql-K7
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933439Ab3EABLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:11:32 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:59937 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933306Ab3EABLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:11:30 -0400
Received: by mail-yh0-f45.google.com with SMTP id f43so209644yha.32
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=do4584+MMYZxGS5IpD87xt1/XeKiMLtNxectFCXIaEg=;
        b=kLnu6m3G7AZ+HwJzTcaUCe8AKuupXTVPN93ito39Ug4M/xSM/TCTrgqUc9rpngAqj3
         iQzlMi/Pkf5TMRtYnsrzbZYmhMm0pXB8GNNIVmxtuXho1fLTRdBF2302JgEN1Na0FruU
         14CG8n6nbo1fa1kMWdL3EAm61aPDSZxJJSL0AlaxfnV7k4Sq0p53/LcCfodJN0Mhlmbm
         IxDUmUmdIY02yTix2kcqWF3vmIylWIdH66Wzjd9cHBdKYdbVKUn8vJ7BhZ4D3n+a4e4F
         rBAuVSVAg+SVBamVbkRHlgthhAq1X/8JHXi/blLjf30afDENJer9dd8A/RJmX51y7SaG
         jJiw==
X-Received: by 10.236.91.226 with SMTP id h62mr568510yhf.167.1367370689994;
        Tue, 30 Apr 2013 18:11:29 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id l70sm1672554yha.1.2013.04.30.18.11.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:11:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223044>

Hi,

This is the same as last series, except that I dropped a couple of conflicting
patches, and added one test.


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

Felipe Contreras (18):
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
  remote-bzr: improve author sanitazion
  remote-bzr: add custom method to find branches
  remote-bzr: add option to specify branches
  remote-bzr: improve progress reporting
  remote-bzr: iterate revisions properly
  remote-bzr: delay peer branch usage
  remote-bzr: access branches only when needed

 contrib/remote-helpers/git-remote-bzr | 305 ++++++++++++++++++++++++----------
 contrib/remote-helpers/test-bzr.sh    |  72 ++++++++
 2 files changed, 293 insertions(+), 84 deletions(-)

-- 
1.8.3.rc0.399.gc96a135
