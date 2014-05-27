From: worley@alum.mit.edu (Dale R. Worley)
Subject: Git chokes on large file
Date: Tue, 27 May 2014 12:47:13 -0400
Message-ID: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 18:53:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpKcv-0007nd-Vp
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 18:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbaE0QxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 12:53:22 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:37654
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751594AbaE0QxV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2014 12:53:21 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 May 2014 12:53:21 EDT
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id 74lX1o0050xGWP8564nFlp; Tue, 27 May 2014 16:47:15 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta12.westchester.pa.mail.comcast.net with comcast
	id 74nE1o0171KKtkw3Y4nFJX; Tue, 27 May 2014 16:47:15 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s4RGlEiv024597
	for <git@vger.kernel.org>; Tue, 27 May 2014 12:47:14 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s4RGlDJc024596;
	Tue, 27 May 2014 12:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401209235;
	bh=RFKrCVpq9sQaztWFJpbUUcWOKdVRbFNgHcoYDDMrrLQ=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=vl96+O1m8FE1k2w9IQJwVz7kohYgmXz0nujsXie9u3nCNt7OrQyn4prVFUXieZBMJ
	 mGu0ilVialXkV/UZRgOGub7Q2TlvjMw+jTRMtlghGCvWBoTjZe6ZPazvz9WpVOIGWx
	 h8lWFXMxADDPXM3YRVx83s/3TMj9TpvI1jp3+GIgv/ykZ8V4A1RFygjKsi7JrizmOx
	 NsCk0Qz2BWDb0oNahyjbO2UQ5w9gmKMnR/AJEl0PtO2W54DD9Oy2YXrodNjf6JJ7a7
	 o6w33gQ/pGEbfob6iRqzfzHpD48KarJlInJcmyAYdZN4XOR2DkcrL48Neo0jUzwxMA
	 j5d+4SLmd7wsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250175>

I've discovered a problem using Git.  It's not clear to me what the
"correct" behavior should be, but it seems to me that Git is failing
in an undesirable way.

The problem arises when trying to handle a very large file.  For
example:

    $ git --version
    git version 1.8.3.1
    $ mkdir $$
    $ cd $$
    $ git init
    Initialized empty Git repository in /common/not-replicated/worley/temp/5627/.git/
    $ truncate --size=20G big_file
    $ ls -l
    total 0
    -rw-rw-r--. 1 worley worley 21474836480 May 27 11:59 big_file
    $ time git add big_file

    real	4m48.752s
    user	4m31.295s
    sys	0m16.747s
    $

At this point, either 'git fsck' or 'git commit' fails:

    $ git fsck --full --strict
    notice: HEAD points to an unborn branch (master)
    Checking object directories: 100% (256/256), done.
    fatal: Out of memory, malloc failed (tried to allocate 21474836481 bytes)

    $ git commit -m Test.
    [master (root-commit) 3df3655] Test.
    fatal: Out of memory, malloc failed (tried to allocate 21474836481 bytes)

The central problem is that one can accidentally add a file that
leaves the repository in a "broken" state, where various normal
commands simply don't work.  The most worrying aspect is that "git
fsck" fails -- of all the commands, the one that verifies the validity
of the repository (and diagnoses errors) should be the most robust!

Even doing a 'git reset' does not put the repository in a state where
'git fsck' will complete:

    $ git reset
    $ git fsck --full --strict
    notice: HEAD points to an unborn branch (master)
    Checking object directories: 100% (256/256), done.
    fatal: Out of memory, malloc failed (tried to allocate 21474836481 bytes)

Dale
