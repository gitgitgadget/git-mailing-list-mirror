From: Matteo Bertini <naufraghi@develer.com>
Subject: [PATCH/RFC 0/4] Add option to enable filters in git-svn
Date: Tue, 31 May 2016 17:07:45 +0200
Message-ID: <20160531150749.24840-1-naufraghi@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matteo Bertini <naufraghi@develer.com>, normalperson@yhbt.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 17:15:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7lNm-0002Hr-Oa
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbcEaPOv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 11:14:51 -0400
Received: from neo.develer.net ([2.228.72.10]:39510 "EHLO neo.develer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376AbcEaPOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 11:14:44 -0400
Received: from odello.trilan (odello.trilan [10.3.15.118])
	(Authenticated sender: naufraghi)
	by neo.develer.net (Postfix) with ESMTPSA id AE3E35E311E;
	Tue, 31 May 2016 17:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=develer.com;
	s=gongolo; t=1464707277;
	bh=yXM916HjijZoPH6+YN2XG/m3AZx8O4xQcFn/pQF5dEA=;
	h=From:To:Cc:Subject:Date:From;
	b=AcJTDSz4gN8OAVtFgVrT/pqGH+MJOSoElwod3nS2toHiyyJzMhXTaf3cZhAqK00UR
	 gaoy+WWo3Chr7A37LzWa6EtRvTMY9ao1jAzcJ5f61i7nknZGy++rkxtV8vdmMD0EeK
	 7diXzXsF6J94SeiEamcJRuxsWjsMT25pNnCen/tI=
X-Mailer: git-send-email 2.9.0.rc0.39.gb9f310b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295983>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This is a RFC for a patch that allows to enable filters in the reposito=
ries
created/managed by git-svn.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Example scenario
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The usage scenario I=E2=80=99m facing is the migration of a large SVN r=
epository to a
git repository, with big files being transparently handled through git-=
lfs

To recap, these migrations are usually handled through a transitioning =
repo
created by git-svn, which is then pushed to a remote git server; this s=
erver
acts as a read-only mirror for a while, until the main SVN server is sh=
ut down.
=46or large repos, the process can take several weeks to adjust the mig=
ration
scripts, branch mapping, authorship, etc., and it=E2=80=99s also common=
 to update the
mirror incrementally.


Without this patch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Without this patch, the migration needs to be setup with a pipeline wit=
h:

* incremental git svn fetch,
* bfg-repo-cleaner with =E2=80=94convert-to-git-lfs option (which puts =
invalid
  .gitattributes files, see https://github.com/rtyley/bfg-repo-cleaner/=
issues/143)
* git-filter-branch (to put in place the correct .gitattributes files)

A minimal change in the pipeline results in unrelated branches after
the rebases.

Each deviation from the svn sources must be committed back or saved
as patch and reapplied after the rebase.


With this patch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Everything is much simpler: filters can be triggered during the fetch, =
so that
git-lfs already runs while the repository is fetched.
At the end of the process, the local git repository is already in its f=
inal
form, and no further git-filter-branch/rebases is required.

The transitioning git repo can diverge partially from the svn source
thanks to git svn rebase.


Details
=3D=3D=3D=3D=3D=3D=3D

In the current implementation git-svn uses the hash-object command
with the --no-filters option. There is no gain in removing that option
because the git-svn uses temporary file names.

In this patch hash-object accepts a new format for the streaming input,
files and paths, tab separated. git-svn can provide the real path
to hash-object and thanks to that we can enable the filters.


Status
=3D=3D=3D=3D=3D=3D

The patch is in RFC, no new test where written (yet), just runned for
regressions (https://travis-ci.org/naufraghi/git/builds/134170350).

I'd like to gain some feedback before spending more time on the
feature, mainly:

 * feature comments,
 * coding comments (neither Perl or C are my main languages),
 * user interface (option names, config placements) comments.

Best,
Matteo


Matteo Bertini (4):
  hash-object.c: Allow distinct file/path in stdin mode too.
  Git.pm: Add $path and $enable_filters arguments to
    hash_and_insert_object.
  SVN/Fetcher.pm: Add svn-remote.<id>.enable-filters to enable the
    filters.
  git-svn.perl: Add git svn init --enable-filters option.

 builtin/hash-object.c   | 29 +++++++++++++++++++++++++++--
 git-svn.perl            |  4 ++++
 perl/Git.pm             | 19 +++++++++++++------
 perl/Git/SVN/Fetcher.pm | 16 ++++++++++++----
 4 files changed, 56 insertions(+), 12 deletions(-)

--=20
2.9.0.rc0.39.gb9f310b.dirty
