From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Thu,  2 Feb 2012 14:32:15 -0500
Message-ID: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 02 20:32:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2OQ-0006YP-50
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165Ab2BBTcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:32:21 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:59217 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007Ab2BBTcV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:32:21 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:49222 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Rt2OJ-0003Cn-RM; Thu, 02 Feb 2012 14:32:19 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Rt2OJ-0006ZE-QI; Thu, 02 Feb 2012 14:32:19 -0500
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189680>

Solaris' /bin/sh was making the IFS setting permanent instead of
temporary when using it to slurp in credentials in the generated
'dump' script of the 'setup helper scripts' test in t0300-credentials.

The stderr file that was being compared to expected-stderr contained the
following stray line from the credential helper run:

warning: invalid credential line: username foo

To avoid this bug, capture the original IFS and force it to be reset
after its use is no longer required.  For now, this is lighter weight
than altering which shell these scripts use as their shebang.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 t/t0300-credentials.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 885af8f..1be3fe2 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -8,10 +8,12 @@ test_expect_success 'setup helper scripts' '
 	cat >dump <<-\EOF &&
 	whoami=`echo $0 | sed s/.*git-credential-//`
 	echo >&2 "$whoami: $*"
+	OIFS=$IFS
 	while IFS== read key value; do
 		echo >&2 "$whoami: $key=$value"
 		eval "$key=$value"
 	done
+	IFS=$OIFS
 	EOF
 
 	cat >git-credential-useless <<-\EOF &&
-- 
1.7.8.3
