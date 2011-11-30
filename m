From: John Twilley <mathuin@gmail.com>
Subject: BUG: "--work-tree blah" does not imply "--git-dir blah/.git" or fix
 misleading error message
Date: Wed, 30 Nov 2011 09:43:08 -0800
Message-ID: <CAEUMa-cA8qPjJuPBREE1RqhgwmcZG7x1MjBYkxa3i+ZSAnMPOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 18:43:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVoBg-0001GT-0I
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 18:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab1K3RnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 12:43:12 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57446 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab1K3RnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 12:43:09 -0500
Received: by iage36 with SMTP id e36so1081907iag.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 09:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gfKw6q16Uy7q0ptt8jGT/OH/kd8ixz/Ffbtwv4tq1L4=;
        b=swSBvw9929i67lkoWea7LetBTaN5YHNirq1vb6CMkM9v0D+j8YUpCuNJxH8G4bp1xz
         LzAogoWczkCCwozLbWD62+5MrAqAxCeFq1xBwjZjGS5RQG0CMLTblClMOd7WP7HZTMsX
         IpPz7dPDn8J+2LXqHqoIp2YVs2J9h/xmAba0Y=
Received: by 10.50.169.33 with SMTP id ab1mr3817330igc.0.1322674989225; Wed,
 30 Nov 2011 09:43:09 -0800 (PST)
Received: by 10.231.42.21 with HTTP; Wed, 30 Nov 2011 09:43:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186130>

Today someone asked me if there was a way to run git against a
directory other than the current directory.  I looked at the output of
--help and ran this:

$ git --work-tree blah status

I got the following output:

fatal: Not a git repository (or any parent up to mount parent /home)
Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).

I mistakenly thought the error message meant that blah was not a git
repository.  What it meant was that there was no .git in the current
directory or any parent directory up to /home.

This command worked as expected:

$ git --work-tree blah --git-dir blah/.git status

The documentation is somewhat fuzzy about what constitutes a git
repository.  The gittutorial describes the git repository as .git when
talking about "git init" while the Git User's Manual describes the git
repository as the working tree and the special top-level directory
named .git when talking about "git clone".

It's clear (to me at least) that --work-tree should be used to
identify the root of the working tree when not inside the working
tree.  I expected that the git directory would be automatically set to
.git in the root of the working tree, as that would match the
documentation.  Instead, the current directory and its parents were
checked -- which could provide dangerously misleading information to
the user.

I think that one of two things should be done:  either the --git-dir
default should be changed when the --work-tree option is set, or the
error message cited above should be changed to explicitly identify the
directory being tested as a potential git repository.  I personally
believe the first option is superior because it fulfills the
expectations of average users (folks who read git's documentation
instead of its source code) while permitting flexibility to those who
wish to refer to the current directory or some other directory for
their --git-dir value.  If the current behavior is somehow not a bug
but instead a critical and significant feature which if changed would
cause more harm than good, please consider the second option.

Jack.
--
mathuin at gmail dot com
