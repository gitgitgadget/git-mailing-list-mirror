From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: cvsexportcommit dies when applying an (empty) merge commit
Date: Wed, 25 Nov 2009 11:59:22 +0000
Message-ID: <4B0D1C1A.60707@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 12:59:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDGX4-0004dG-Af
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 12:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758761AbZKYL7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 06:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758751AbZKYL7U
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 06:59:20 -0500
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:46213 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758588AbZKYL7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 06:59:18 -0500
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.100])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1NDGWp-0001w9-Th
	for git@vger.kernel.org; Wed, 25 Nov 2009 11:59:24 +0000
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133633>

Hi,

I have a git repository with a merge point on the master branch.  This merge
commit is empty, and just contains a commit message:

  Merge commit 'otherbranch'

I'm trying to export this branch into CVS using git-cvsexportcommit (the latest
version from the master branch). It's actually done in a wrapper script [1] but
the command that gets invoked is essentially:

 git cvsexportcommit -p -v -u -w  'cvscheckout/HEAD/my-cvs-module' -c \
    <parent commit> <commit>

Where <commit> is the empty merge commit.  However this invocation dies and
aborts the process of exporting the branch half way.

The fatal error I get is:

 Applying to CVS commit <commit> from parent <parent commit>
 Checking if patch will apply
 Applying
 error: No changes
 cannot patch at /usr/lib/git-core/git-cvsexportcommit line 324.

The vicinity of line 324 is (with some lines wrapped):

 print "Applying\n";
 if ($opt_W) {
     system("git checkout -q $commit^0") && die "cannot patch";
 } else {
     `GIT_DIR= git-apply $context --summary --numstat --apply
<.cvsexportcommit.diff` || die "cannot patch";
 }

It seems that the file .cvsexportcommit.diff is empty, so git-apply is refusing
to apply it.

Presumably the application would be a no-op, so this git-apply step could be
skipped.  So I tried modifying the script to do that and it seems to work:

 print "Applying\n";
 if ($opt_W) {
     system("git checkout -q $commit^0") && die "cannot patch";
 } elsif (-s ".cvsexportcommit.diff") {
     `GIT_DIR= git-apply $context --summary --numstat --apply
<.cvsexportcommit.diff` || die "cannot patch";
 } else {
    print "No changes\n";
 }

The modified git-cvsexportcommit script completes without errors, but
unsurprisingly, seems to export nothing, so that when imported back into git,
there is no empty commit.  There appears to be no log message added in CVS, either.

This does seem more acceptable than dying, although it doesn't faithfully
reproduce the git history.  However I'm not sure if that would be possible in
this case.

Is the existing behaviour deliberately fatal, or is this worth supplying a patch
for?


Cheers,

N

1. http://github.com/wu-lee/git-cvs
