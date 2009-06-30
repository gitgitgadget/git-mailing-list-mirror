From: Jason Holden <jason.k.holden@gmail.com>
Subject: [PATCH 0/2] Don't delete untracked submodule's .git dirs by default
Date: Mon, 29 Jun 2009 22:10:43 -0400
Message-ID: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com>
Cc: Jason Holden <jason.k.holden@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 04:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLSoZ-0005dY-T5
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 04:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbZF3CLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 22:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbZF3CLF
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 22:11:05 -0400
Received: from mail-qy0-f193.google.com ([209.85.221.193]:59264 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbZF3CLD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 22:11:03 -0400
Received: by qyk31 with SMTP id 31so5261900qyk.33
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 19:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DuiKeHsQozhsUaLEJpXnHzaBjYRnO7w3q2Jkf1dhbts=;
        b=u/tjEttxrIDL7IDG2axAJ2UjCoLc/T3NeCk2OWSZxHyMc2FhYuMUL3raV7nffS+7AT
         0bTeF8I8yz5ACknSvtxJxS9wm/DORJN29aKkv4Cr0l51yxCi15lZQknMuFxy9p/TEZVZ
         QS4XxeksccXUJz42kCV96TQxSE/kSN68G7uEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rDGmG0zzf0eqAJpdx+RoO94mmfh/iYvNxluIIodx4Rc48WF1OZSYlK5T9G0NwYuanJ
         GDNTa001T99pSgBVoO9qGWLFU13ndCLNDc1Tt5yTovSGwvooBeQG6RapeIWFkumYbbXu
         aOuMPoj54Ln/40tY6bUq317jriD5S5Kgly+m4=
Received: by 10.224.54.82 with SMTP id p18mr6303275qag.281.1246327866029;
        Mon, 29 Jun 2009 19:11:06 -0700 (PDT)
Received: from localhost (c-75-69-254-77.hsd1.nh.comcast.net [75.69.254.77])
        by mx.google.com with ESMTPS id 2sm851163qwi.33.2009.06.29.19.11.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 19:11:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.207.ga8208
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122480>

Git-clean is not safe when there is a submodule tracked in a local branch that
is not tracked in the mainline branch. Running git-clean from the mainline
branch when we have unpushed changes in a submodule tracked only in a local
branch can lose local changes to that submodule permanentely.

I have accidentally lost changes in this way when working with very 
large projects where a git-clean is more reliable than a makefile's 
"make clean". 

By changing the default behavior of git-clean to not delete the .git
directories allows the history of the submodules to be recovered.

# Example of issue:
#
# Clone mainline project
git clone git://github.com/thoughtbot/paperclip.git           
cd paperclip/

# Add a submodule not tracked by mainline
git checkout -b test_submodule_clean
git submodule add git://github.com/technoweenie/attachment_fu.git attachement_fu
git commit -m "add submodule"

# Make a modification to the submodule.  Note that we haven't pushed the change
cd attachement_fu/
git checkout -b mod_readme_in_submodule
vi README 
git add README
git commit -m "Small change in submodule"

# Go back to mainline's master branch and do a clean
cd ..
git checkout master
git clean -f -d

# Our change to the submodule, that was never pushed, is now gone forever 
# because all the history stored in the submodule's .git direct is deleted.
# There is no recovering from this.
# This breaks the "git must be safe" rule, as we've lost potentially a lot of
# changes to any submodule projects that didn't get pushed yet. Solve
# this issue by not deleting any .git directories we come across during a
# git-clean, unless the "-m" option is passed to git-clean.

This is my first email submittal using git, so apologies in advance for any
formatting issues

Jason Holden (2):
  Add option to not delete a .git directory in remove_dir_recursively()
  Don't clean any untracked submodule's .git dir by default in
    git-clean

 Documentation/git-clean.txt |    6 +++++-
 builtin-clean.c             |   15 +++++++++++++--
 builtin-clone.c             |    4 ++--
 dir.c                       |   17 +++++++++++++++--
 dir.h                       |    2 +-
 refs.c                      |    2 +-
 transport.c                 |    4 ++--
 7 files changed, 39 insertions(+), 11 deletions(-)
