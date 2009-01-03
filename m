From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Bazaar's patience diff as GIT_EXTERNAL_DIFF
Date: Sat, 3 Jan 2009 17:24:11 +0100
Message-ID: <20090103162411.GA9234@chistera.yi.org>
References: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain> <20090102105537.GA14691@localhost> <20090102105856.GB14691@localhost> <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain> <alpine.DEB.1.00.0901021918100.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901021050450.5086@localhost.localdomain> <20090102193904.GB9129@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Transfer-Encoding: 8bit
Cc: Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 03 17:25:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ9Jg-00045a-Og
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 17:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758990AbZACQYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 11:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbZACQYP
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 11:24:15 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1912
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758902AbZACQYO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 11:24:14 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id C6AFA801BF8F;
	Sat,  3 Jan 2009 17:24:11 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LJ9IJ-0002SC-4H; Sat, 03 Jan 2009 17:24:11 +0100
Content-Disposition: inline
In-Reply-To: <20090102193904.GB9129@coredump.intra.peff.net>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104472>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Jeff King [Fri, 02 Jan 2009 14:39:04 -0500]:

> If you just want to see the results on some real-world cases (and don't
> care about measuring performance), try installing bzr and using their
> patiencediff test program as a GIT_EXTERNAL_DIFF.

> On Debian, it's:

>   $ sudo apt-get install bzr
>   $ cat >$HOME/patience <<'EOF'
>     #!/bin/sh
>     exec python /usr/share/pyshared/bzrlib/patiencediff.py "$2" "$5"
>     EOF
>   $ chmod 755 patience
>   $ GIT_EXTERNAL_DIFF=$HOME/patience git diff

In case somebody's interested, I have this script lying around that does
that, and knows how to colorize the output using bzrtools, and honoring
color.{diff,ui}. No support for color.diff.<slot>, though.

-- 
Adeodato Simó                                     dato at net.com.org.es
Debian Developer                                  adeodato at debian.org
 
- Oh my God, you're pimping me out for a new roof?
- And windows!
                -- Andrew and Bree Van De Kamp

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git_bzr_patience_diff
Content-Transfer-Encoding: quoted-printable

#! /usr/bin/python

import os
import sys
import stat
import subprocess

=66rom bzrlib.patiencediff import unified_diff, PatienceSequenceMatcher
try:
    from bzrlib.plugins.bzrtools.colordiff import DiffWriter
except ImportError:
    _have_colordiff =3D False
else:
    _have_colordiff =3D True

##

def main():
    path =3D sys.argv[1]
    file1 =3D open(sys.argv[2], 'rb')
    file2 =3D open(sys.argv[5], 'rb')

    if use_color():
        writer =3D DiffWriter(sys.stdout, check_style=3DTrue)
    else:
        writer =3D sys.stdout

    for line in unified_diff(
            file1.readlines(), file2.readlines(),
            path, path, sequencematcher=3DPatienceSequenceMatcher):
        writer.write(line)

##

def use_color():
    if not _have_colordiff:
        return False

    for c in ['color.diff', 'color.ui']:
        p =3D subprocess.Popen(
                ['git', 'config', '--get', c], stdout=3Dsubprocess.PIPE)
        if p.wait() =3D=3D 0:
            when =3D p.stdout.readline().strip()
            break
    else:
        return False

    if when =3D=3D 'always':
        return True
    elif when in ['false', 'never']:
        return False
    elif when in ['true', 'auto']:
        stdout =3D sys.stdout.fileno()
        return (os.isatty(stdout) or
                stat.S_ISFIFO(os.fstat(sys.stdout.fileno()).st_mode))
    else:
        return False

##

if __name__ =3D=3D '__main__':
    sys.exit(main())

--nFreZHaLTZJo0R7j--
