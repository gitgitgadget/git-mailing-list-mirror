From: Jeffrey Middleton <jefromi@gmail.com>
Subject: stash --patch splitting
Date: Fri, 18 Feb 2011 18:49:20 -0600
Message-ID: <AANLkTimcUi0jKK2AWsw7MHNdHFWbKFSjBixeM0pU74+a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 01:49:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqb19-00026Y-AT
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 01:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab1BSAtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 19:49:42 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62254 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1BSAtl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 19:49:41 -0500
Received: by wyb28 with SMTP id 28so4247830wyb.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 16:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=7+gBh2a13LS/pUOu0yvKu01PjnaF6pgbxv4g+ul/fbI=;
        b=CGGUHSZ1MCEuQ3lXSyX1pG9quiW3PcYcGeVYH5G1jnZRXc38Y5kPBrSHrDNZsPc2iB
         02sjXWWPNxI/BG15cc5tVVNw9+rzrA+l5kUjCTr8DsqiAABdNOU5NiPmmOYYBjlUZ8E/
         mYlUtkAL1wD40+rayqUZJluMjUEwcn0ZMLIYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=GgYA0AzujN6U3r0RSwJWUv1k3BVUG63LkBc6v0fGwDlUlhnZqc5DpWqpXQhb9NKApe
         35zOEqeWeKGT7klf5KsE9TkfflFflkcnLME92ul67XYepWaGh35zxXLp7CLeb74dRi2A
         TkKkA0LoRajE6lHnDTAVkIv7feJnM+KpFAS1k=
Received: by 10.216.178.138 with SMTP id f10mr1155488wem.98.1298076580224;
 Fri, 18 Feb 2011 16:49:40 -0800 (PST)
Received: by 10.216.164.132 with HTTP; Fri, 18 Feb 2011 16:49:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167239>

git stash --patch doesn't appear to play nice with splitting hunks:

	mkdir stash-p &&
	cd stash-p &&
	git init &&
	seq 1 3 > a &&
	git add a &&
	git commit -m "add a" &&
	sed -i 's/[13]/&&/' a &&
	(echo s; echo y; echo n) | git stash -p

That's a file with three lines, a modification to lines 1 and 3, then
an attempt to partially stash, splitting and stashing the modification
to line 1 but not line 3. It looks like the patch generated to roll
back the selected changes is faulty somehow:

	Saved working directory and index state WIP on master: 7cb76e1 add a
	error: patch failed: a:1
	error: a: patch does not apply
	Cannot remove worktree changes

The patch that git-stash attempts to reverse-apply looks sort of reasonable:

	diff --git a/a b/a
	index 01e79c3..88483cf 100644
	--- a/a
	+++ b/a
	@@ -1,3 +1,3 @@
	-1
	+11
	 2
	 3

but it doesn't apply, since the third line is now different in the
work tree. The patch I'd really expect to see would have "33" on the
third line. I've been staring at all the temporary index files
(git-stash.sh:105 and on) and the stash mode in
git-add--interactive.perl and trying to figure out where it goes
wrong, but I don't think I'm going to get it right now. Maybe one of
y'all will immediately see it?


Thanks,
Jeffrey
