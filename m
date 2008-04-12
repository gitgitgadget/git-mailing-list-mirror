From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: [RFC] git status oddity
Date: Sat, 12 Apr 2008 17:43:11 +0200
Message-ID: <bd6139dc0804120843m2dd2ec3k69a3ba2809f1e955@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 12 17:44:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkhta-0007Ep-U7
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 17:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbYDLPnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 11:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755429AbYDLPnO
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 11:43:14 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:61725 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbYDLPnM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 11:43:12 -0400
Received: by wf-out-1314.google.com with SMTP id 28so911910wff.4
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=b/izEUNLLf/3bWF9pKmsK4E2QZceoyr1RtnSLAJ1ZSg=;
        b=DEn2WDHyX4X51bFCdIRIETMtjreDc/KAJwh4Z+j+d9WWnJen90wlQOK1UDLZPE023H8luRObC1nLXV8o9rBlfoHGN7TxXKJJhiMlfi2sG3u12iXwTcDxPJKFI0SSmqofCYf61VOd7EC9L1jTZ6pz+VU1fDoFPrQCMTrbYxgIyDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Jf10HaKo4wRb2yghv7Pc1aJCOyfAEpsR5V7jtrZOhJHfASibgbwTOxLSnGDRwr5oxku27q5QDSKWGLVZZH3dmXv8Bw49luUvGfikYxo3ftbd5ieO+G12wVUeNj2agfQgHxoPOz+sSr3k+lrz/GNuhDIh1UfWtkBckKDYiLqwPeg=
Received: by 10.142.155.4 with SMTP id c4mr1183628wfe.208.1208014991335;
        Sat, 12 Apr 2008 08:43:11 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Sat, 12 Apr 2008 08:43:11 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79366>

Heya,

I have a directory structure that groups files together in such a way
that usually when I change files in the same directory I commit all
those in one go. As such I am a great fan of 'git diff .' and 'git
commit .' because they allow me to make such partial commits. Sadly,
'git status' does not play along well with this workflow. What I would
expect is 'git status .' to return changes made in the current
directory. More general, I expect 'git status <filter>' to perform
it's magic on only the files that match the filter. What I deduct from
the man page however, 'git status' is merely a 'dry run' of git
commit. While this make sense when using it as part of git commit (to
generate a commit msg), it does not make a lot of sense when using it
as a first-class citizen.

I suggest changing this behavior to be more intuitive (e.g., matching
'git diff' and 'git commit's filtering behavior). As a result commands
that assume 'git status' is a dry run of 'git commit' would have to be
changed to pass an additional argument to 'git status' to tell it to
perform it's old behavior. Even better, a '-d' (for --dry-run) switch
could be added to 'git commit' which would make it act as 'git status'
does currently.

Proposed:
1. Add a '-d'/'--dry-run' switch to 'git commit' which makes it behave
as 'git status' does currently
2. Improve git status to instead take a path argument on which it will
filter it's output.
3. From here on additional improvements to 'git status' can be made
without having to worry about breaking 'git commit' dry-run capability
since that functionality has been put where it belongs, that is, in
'git commit -d'.

This would break programs and scripts that assume 'git status' is a
dry-run of 'git commit', as such I realize this would probably not be
integrated anytime soon. Also, I would like to know whether the
community agrees that current 'git status' behavior does not make
sense when using it as a first-class citizen. Of course, I assume here
that 'git status' is indeed a first-class citizen, if this assumption
is wrong please explain why.

Below is a trivial workflow example.

ubuntu@ubuntu:~/code/StatusExample$ git init
Initialized empty Git repository in .git/
ubuntu@ubuntu:~/code/StatusExample$ mkdir dir1 dir2
ubuntu@ubuntu:~/code/StatusExample$ touch dir1/foo dir1/bar dir2/foobar
ubuntu@ubuntu:~/code/StatusExample$ git add .
ubuntu@ubuntu:~/code/StatusExample$ git commit -m "Initial"
Created initial commit 35dc187: Initial
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 dir1/bar
 create mode 100644 dir1/foo
 create mode 100644 dir2/foobar
ubuntu@ubuntu:~/code/StatusExample$ echo "1" >> dir1/foo
ubuntu@ubuntu:~/code/StatusExample$ echo "2" >> dir1/bar
ubuntu@ubuntu:~/code/StatusExample$ echo "3" >> dir2/foobar
ubuntu@ubuntu:~/code/StatusExample$ cd dir1/
ubuntu@ubuntu:~/code/StatusExample/dir1$ git status .
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   dir1/bar
#       modified:   dir1/foo
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   dir2/foobar
#

The above result would be the output of 'git commit -d .'
Expected output:
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   dir1/bar
#       modified:   dir1/foo
#


Thank you for your time,

Sverre Rabbelier
