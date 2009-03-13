From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] test-lib: write test results to
	test-results/<basename>-<pid>
Date: Fri, 13 Mar 2009 18:20:02 +0100
Message-ID: <20090313172002.GA16232@neumann>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>
	<3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <alturin@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 13 18:21:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiB4p-0001e4-Iv
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 18:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbZCMRUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 13:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756057AbZCMRUJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 13:20:09 -0400
Received: from francis.fzi.de ([141.21.7.5]:20691 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755724AbZCMRUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 13:20:07 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Mar 2009 18:20:01 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 13 Mar 2009 17:20:01.0191 (UTC) FILETIME=[F0FD9B70:01C9A3FF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113211>

Hi,


On Fri, Mar 13, 2009 at 05:36:13PM +0100, Johannes Schindelin wrote:
> On Fri, 13 Mar 2009, Johannes Schindelin wrote:
>=20
> > The earlier code meant to attempt to strip everything except the te=
st
> > number, but only stripped the part starting with the last dash.
> >=20
> > However, there is no reason why we should not use the whole basenam=
e.

I agree.

> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >=20
> > 	Even if this is not strictly necessary after Hannes' test cleanup,=
=20
> > 	it would still be nice.
>
> Just to clarify: it fixes the issue that these two tests share the sa=
me=20
> file in test-results/: t5521-pull-options.sh  t5521-pull-symlink.sh
>=20
> As a consequence, one's results overwrite the other one's.

The pid of the test process makes the name of the test result file
unique for each test, even in the mentioned case, e.g. it would be
something like t5521-pull-12345 and t5521-pull-23456.  However, after
Hannes' patch there is no need for keeping that pid around because the
test result file names would be unique for each test anyway.

Moreover, if we would remove the pif from the test result file name,
we could also remove the 'pre-clean' target from 't/Makefile'.  With
the pid appended, we need that 'pre-clean' target to clean up all
leftovers from the previous run.  Without the pid each test will
always write to the same test result file, so we could actually just
overwrite the cruft from the last run.

Something like the patch below.  Thoughts?


Best,
G=E1bor

---
 t/Makefile    |    7 ++-----
 t/test-lib.sh |    4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 0d65ced..2e6e205 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -14,14 +14,11 @@ SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
 T =3D $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN =3D $(wildcard t91[0-9][0-9]-*.sh)
=20
-all: pre-clean $(T) aggregate-results clean
+all: $(T) aggregate-results clean
=20
 $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=3D.git/config '$(SHELL_PATH_SQ)' $@ $(=
GIT_TEST_OPTS)
=20
-pre-clean:
-	$(RM) -r test-results
-
 clean:
 	$(RM) -r 'trash directory' test-results
=20
@@ -33,5 +30,5 @@ full-svn-test:
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=3D1 LC_ALL=3DC
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=3D0 LC_ALL=3Den_US.UTF-8
=20
-.PHONY: pre-clean $(T) aggregate-results clean
+.PHONY: $(T) aggregate-results clean
 .NOTPARALLEL:
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0bd24d5..d82c784 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -418,9 +418,9 @@ test_done () {
 	trap - exit
 	test_results_dir=3D"$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
-	test_results_path=3D"$test_results_dir/${0%.sh}-$$"
+	test_results_path=3D"$test_results_dir/${0%.sh}"
=20
-	echo "total $test_count" >> $test_results_path
+	echo "total $test_count" > $test_results_path
 	echo "success $test_success" >> $test_results_path
 	echo "fixed $test_fixed" >> $test_results_path
 	echo "broken $test_broken" >> $test_results_path
