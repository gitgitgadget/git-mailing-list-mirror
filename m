From: Michael Olson <mwolson@gnu.org>
Subject: [PATCH/RFC 0/2] git-svn: Allow certain refs to be ignored
Date: Tue, 20 Apr 2010 14:30:09 -0700
Message-ID: <o2xc8b3bef91004201430m10bbe060q7d8ebd3a1ac4c3bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 23:30:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4L1j-0008Vb-7I
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 23:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab0DTVad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 17:30:33 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50984 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab0DTVad (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 17:30:33 -0400
Received: by pvg13 with SMTP id 13so356874pvg.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 14:30:32 -0700 (PDT)
Received: by 10.220.81.20 with HTTP; Tue, 20 Apr 2010 14:30:09 -0700 (PDT)
X-Originating-IP: [209.104.55.5]
X-Google-Sender-Auth: 1ab67611a822175b
Received: by 10.140.58.11 with SMTP id g11mr5664637rva.240.1271799030822; Tue, 
	20 Apr 2010 14:30:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145398>

This change allows certain refs to be ignored while importing svn
history.  This is useful for:

 - Performing overlapping transforms from svn's branch namespace into
   git's namespace.  The overlapping refs can be ignored.  It might
   potentially be a better idea in this case to make git-svn assign
   precedence according to the order in which the branch patterns are
   specified, perhaps with an option to trigger that behavior (which
   is out of scope for this patch series).

 - Avoiding some refs that represent bad svn operations which cause
   git-svn to take a very long time.  Example: copying one module
   accidentally into another module's branch namespace.

A new config directive called "ignore-refs" implements this feature by
means of a regex of refs to ignore.  I haven't written the necessary
git-svn documentation updates for it yet.

In addition, I ran across a problem where git-svn would die if a
parent ref did not exist.  This might possibly have been exposed as a
result of the first patch.  I threw an eval around the offending code,
and that seems to work, though some review would be appreciated.

Here is an example ~/.git/config file which works with these changes.
The example upstream svn repository has branches in tags in 2
different namespaces.  Originally all tags/branches were directly
under /root/mod/branches and /root/mod/tags.  Later on, they created
new branches and tags in subdirectories such as
/root/mod/branches/myorg/bugs/BUGID.  This config file forces
old-style branches and tags into the "old/" namespace in git, and puts
new-style branches and tags into (for example) "myorg/bugs/BUGID".
The "ignore-refs" directive prevents the first level of the new
namespace ("myorg", in particular) from being replicated underneath
"old/" in git.

[core]
       repositoryformatversion = 0
       filemode = true
       bare = false
       logallrefupdates = true
[svn-remote "svn"]
       url = https://svn.my.org/svn/root
       fetch = mod/trunk:refs/remotes/trunk
       branches = mod/branches/*:refs/remotes/old/*
       tags = mod/tags/*:refs/remotes/tags/old/*
       branches = mod/branches/myorg/bugs/*:refs/remotes/myorg/bugs/*
       tags = mod/tags/myorg/bugs/*:refs/remotes/tags/myorg/bugs/*
       branches = mod/branches/myorg/projects/*:refs/remotes/myorg/projects/*
       tags = mod/tags/myorg/projects/*:refs/remotes/tags/myorg/projects/*
       branches = mod/branches/myorg/releases/*:refs/remotes/myorg/releases/*
       tags = mod/tags/myorg/releases/*:refs/remotes/tags/myorg/releases/*
       ignore-refs = ^refs/remotes/(tags/)?old/myorg

Michael Olson (2):
  git-svn: Allow certain refs to be ignored
  git-svn: Don't allow missing commit parent to stop git-svn

 git-svn.perl |   40 ++++++++++++++++++++++++++++++++++------
 1 files changed, 34 insertions(+), 6 deletions(-)
