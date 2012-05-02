From: mhagger@alum.mit.edu
Subject: [PATCH] t/Makefile: retain cache t/.prove across prove runs
Date: Wed,  2 May 2012 17:31:52 +0200
Message-ID: <1335972712-20621-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 17:39:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPbeJ-0001lj-3d
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 17:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab2EBPjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 11:39:22 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:49398 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754377Ab2EBPjV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 11:39:21 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 May 2012 11:39:21 EDT
X-AuditID: 1207440f-b7fe16d000000920-c6-4fa15383b368
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id AC.E9.02336.38351AF4; Wed,  2 May 2012 11:32:19 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q42FW29f020010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 May 2012 11:32:18 -0400
X-Mailer: git-send-email 1.7.10
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsUixO6iqNscvNDfYMNJOYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M74feoLe8FygYpH946xNzDO
	5u1i5OSQEDCRuDbtNxOELSZx4d56ti5GLg4hgcuMElt/d7BCOKeZJNY92c0OUsUmICXxsrEH
	zBYRUJOY2HaIBcRmFnCQ2Py5kRHEFhZwkXj6ZQkriM0ioCox9fNXsDgvUPzKpL2sENvkJZ7e
	72ObwMi9gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuiV5uZoleakrpJkaI9/l3MHatlznE
	KMDBqMTDq/Rggb8Qa2JZcWXuIUZJDiYlUd6QoIX+QnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4
	+WWAcrwpiZVVqUX5MClpDhYlcV71Jep+QgLpiSWp2ampBalFMFkZDg4lCd7ZIEMFi1LTUyvS
	MnNKENJMHJwgggtkAw/QBheQQt7igsTc4sx0iKJTjIpS4rzLQBICIImM0jy4AbA4fcUoDvSP
	MG8bSBUPMMbhul8BDWYCGpxvPg9kcEkiQkqqgXHehyOWwutenlNYKWy7Nbb4eu0ql2yXzQZH
	DgfItec9k/C++qileuPP5Elztz9Sz6vsn9R7uleOudjOR1Qkqk84b9LDGbfjzas2Kj7Ws/BZ
	Ijn7/tcn2qw2bOoBxnoxnVpajeszn/qL7zJ7crY2n/NyokPIbO1FUwT8/+d+8T37WWGalA73
	XiWW4oxEQy3mouJEAPd3Xm6uAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196835>

From: Michael Haggerty <mhagger@alum.mit.edu>

prove(1) can write a summary of its test results and timings into a
cache file, t/.prove, then use this information during later runs for
various purposes.  But deleting t/.prove after every test run defeats
this purpose.  So do not delete t/.prove as part of "make
DEFAILT_TEST_TARGET=prove test".  (Continue to delete the file on
"make clean".)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
prove(1) can be told to retain information about test runs, and to use
it for interesting purposes during future invocations.  For example,
it can be told to run tests that failed during the last run:

    GIT_PROVE_OPTS = --state=failed,save

or that have failed recently:

    GIT_PROVE_OPTS = --state=hot,save

or that have been edited since the last run of prove:

    GIT_PROVE_OPTS = --state=fresh,save

It can also run tests in parallel, and start them in order from
slowest to fastest, which, combined with running tests in parallel,
can improve CPU utilization:

    GIT_PROVE_OPTS = --timer --jobs 5 --state=slow,save

(On my 4-core notebook, the latter speeds up the tests by about 10%
compared to running them in parallel in numerical order.)

 t/Makefile |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 6091211..88e289f 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -28,7 +28,7 @@ test: pre-clean $(TEST_LINT)
 
 prove: pre-clean $(TEST_LINT)
 	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
-	$(MAKE) clean
+	$(MAKE) clean-except-prove-cache
 
 $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
@@ -36,9 +36,11 @@ $(T):
 pre-clean:
 	$(RM) -r test-results
 
-clean:
+clean-except-prove-cache:
 	$(RM) -r 'trash directory'.* test-results
 	$(RM) -r valgrind/bin
+
+clean: clean-except-prove-cache
 	$(RM) .prove
 
 test-lint: test-lint-duplicates test-lint-executable
-- 
1.7.10
