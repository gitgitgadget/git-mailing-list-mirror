From: =?UTF-8?Q?Hinrik_=C3=96rn_Sigur=C3=B0sson?= <hinrik.sig@gmail.com>
Subject: COMMIT_EDITMSG not updated after pre-commit hook
Date: Sun, 3 May 2009 23:20:04 +0000
Message-ID: <6e4c323b0905031620m48769dbdp52684d6b470ebea3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 01:20:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0kz3-0002gs-H2
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 01:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673AbZECXUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 19:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755829AbZECXUH
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 19:20:07 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:40309 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768AbZECXUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 19:20:05 -0400
Received: by fxm2 with SMTP id 2so3380726fxm.37
        for <git@vger.kernel.org>; Sun, 03 May 2009 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=hUdhEqc/wiJ93mTPutRL3N71qVhLKnRFV+etjarjLNU=;
        b=c3OQp7P09cVGBAWd6eVqAmPbj+0OReeahQEr+gp9FewArn8orzVa86lGbk3LrQzMYz
         2b+t7/pw3OKjqphGWxqONjn/HxXfzHmD1OxyJ5+znhp/hgsBg8743x1hCOumk150HYKL
         ZFvSNItOlaTPOPcKiiD8/cSDLicJZzwquUj84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=EhuRSce1ifvgdLy/HvslftRK/ssRULk2IsxsD8KsbhWkJAQjye4Bk2GfKkdgtKa9QJ
         jQ9uCiIBtXAGX3ju4M12LqBYgwzlGCJy3LupnkmNZ+B6jxyPsmReQ1o+OgaQC43Mrlmg
         L2f/q1JtyWUx1MgXvoJztToOFB3s+9S0xb2hc=
Received: by 10.223.109.198 with SMTP id k6mr1837681fap.46.1241392804286; Sun, 
	03 May 2009 16:20:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118195>

I have a pre-commit hook which extracts documentation from file $foo
if it has pending changes to be committed. The hook creates/updates
the documentation file and calls "git add" on it.

When I do "git commit", the COMMIT_EDITMSG delivered to my editor
notes that this documentation file has been created/updated, but not
that its changes have been added to the index. However, if I go ahead
with the commit, I can see that the doc file changes were indeed
committed.

Here is a simplified test case:

$ cat .git/hooks/pre-commit
#!/usr/bin/env perl
use strict;
use warnings;

my $old = qx"git rev-parse HEAD:foo 2>/dev/null";
my $new = qx"git rev-parse :foo 2>/dev/null";

if (($? >> 8) != 0 || $old ne $new) {
    system "cat source > dest";
    system "git add dest";
}

$ ls
source

$ echo 123 >> source

$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   source
#
no changes added to commit (use "git add" and/or "git commit -a")

$ git commit -a
Test commit
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   source
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       dest
[master 535ed7f] Test commit
 2 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 dest

$ git status
# On branch master
nothing to commit (working directory clean)
