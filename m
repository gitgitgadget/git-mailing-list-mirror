From: Alexander Tomlinson <alex@aivor.com>
Subject: is git-p4 compatible with p4/linux?
Date: Tue, 16 Apr 2013 23:31:36 -0500
Message-ID: <7BF81DF9-941D-400B-8304-6DA5F5C82D4F@aivor.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 17 06:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USK1u-0006vi-UR
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 06:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab3DQEba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 00:31:30 -0400
Received: from smtp-out2.electric.net ([72.35.23.33]:65519 "EHLO
	smtp-out2.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187Ab3DQEba (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 00:31:30 -0400
Received: from 1USK1o-0006Mq-UE by bean.electric.net with emc1-ok (Exim 4.77)
	(envelope-from <alex@aivor.com>)
	id 1USK1o-0006NE-Uj
	for git@vger.kernel.org; Tue, 16 Apr 2013 21:31:28 -0700
Received: by emcmailer; Tue, 16 Apr 2013 21:31:28 -0700
Received: from [10.86.10.82] (helo=fuseout2b.electric.net)
	by bean.electric.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <alex@aivor.com>)
	id 1USK1o-0006Mq-UE
	for git@vger.kernel.org; Tue, 16 Apr 2013 21:31:28 -0700
Received: from mailanyone.net
	by fuseout2b.electric.net with esmtpsa (TLSv1:AES128-SHA:128)
	(MailAnyone extSMTP aivort)
	id 1USK1o-0002Of-3H
	for git@vger.kernel.org; Tue, 16 Apr 2013 21:31:28 -0700
X-Mailer: Apple Mail (2.1503)
X-Outbound-IP: 10.86.10.82
X-Env-From: alex@aivor.com
X-PolicySMART: 1102869
X-Virus-Status: Scanned by VirusSMART (c)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221500>

git-p4.py (1.8.2.1.418.gaec3f77) has at least two behaviors that
seem to be incompatible with the version of p4 that I recently
downloaded from perforce.com (P4/LINUX26X86_64/2013.1/610569).

TLDR: Is git-p4 written for an old version of p4 CLI with different
behavior?  Or for a windows or mac release of p4?  Or am I missing
something?

First issue
-----------

git-p4 assumes the output of 'p4 print' adds a newline to the
target.  To work around this, git-p4.py strips the last char from
symlinks as shown in the following snippet:

    if type_base =3D=3D "symlink":
        git_mode =3D "120000"
        # p4 print on a symlink contains "target\n"; remove the newline
        data =3D ''.join(contents)
        contents =3D [data[:-1]]

But my 'p4 print' does not output the newline:

    $ ls -l pcre
    lrwxrwxrwx 1 user group 12 Apr 16 10:27 pcre -> ../libs/pcre

    $ p4 print -q pcre | od -t x1a
    0000000  2e  2e  2f  6c  69  62  73  2f  70  63  72  65
             .   .   /   l   i   b   s   /   p   c   r   e
    0000014

If I use 'git p4 clone' the above file shows up in git as a
symlink to '../libs/pcr'.  I had another symlink whose target had
a strlen of 1 and the 'git p4 clone' failed b/c after stripping
the last char the result was an empty string.

Second issue
------------

git-p4 uses 'p4 print -q -o o FILE' to print a file to stdout.
At least that is how I interpret this snippet:

    text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])

However, p4/Linux prints to stdout by default and '-o -' will save
the output in a file named '-'.

My git and p4 versions:

    $ git --version
    git version 1.8.2.1.418.gaec3f77

    $ p4 -V
    Perforce - The Fast Software Configuration Management System.
    Copyright 1995-2013 Perforce Software.  All rights reserved.
    This product includes software developed by the OpenSSL Project
    for use in the OpenSSL Toolkit (http://www.openssl.org/)
    See 'p4 help legal' for full OpenSSL license information
    Version of OpenSSL Libraries: OpenSSL 1.0.1c 10 May 2012
    Rev. P4/LINUX26X86_64/2013.1/610569 (2013/03/19).

--Alex
