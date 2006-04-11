From: Dennis Stosberg <dennis@stosberg.net>
Subject: t5501-old-fetch-and-upload.sh fails with NO_PYTHON=1
Date: Tue, 11 Apr 2006 19:05:08 +0200
Message-ID: <20060411170508.G14ba7e47@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 11 19:05:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTMIq-0002SI-TT
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 19:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWDKRFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 13:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWDKRFP
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 13:05:15 -0400
Received: from ncs.stosberg.net ([217.195.44.246]:51642 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751372AbWDKRFO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Apr 2006 13:05:14 -0400
Received: from leonov (p213.54.77.13.tisdip.tiscali.de [213.54.77.13])
	by ncs.stosberg.net (Postfix) with ESMTP id D95C3AEBA0EE
	for <git@vger.kernel.org>; Tue, 11 Apr 2006 19:05:02 +0200 (CEST)
Received: by leonov (Postfix, from userid 500)
	id B8C17EE74A; Tue, 11 Apr 2006 19:05:08 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
X-ICQ: 63537718
X-PGP-Key: 94951CAB
User-Agent: mutt-ng/devel-r796 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18614>

Hello,

t/t5501-old-fetch-and-upload.sh fails on Solaris 9 with NO_PYTHON=1.
The test doesn't work correctly on Linux with NO_PYTHON=1, too, but it
doesn't cause a failure there.

When NO_PYTHON=1 is set, t/Makefile passes "--no-python" to the test as
an argument.  That causes the $list variable to be set to "--no-python"
instead of "fetch upload".  Since that string does not identify a
program to be tested, $pgm remains unset.

On Linux the return code of "which $pgm" is 1 in that case, which
causes the test to do nothing and exit without failure.  In contrast,
the return code of "which" without any argument is 0 on Solaris, so
the test is being run and fails.

I have attached a simple fix, but is this test still useful at all?

Regards,
Dennis

diff --git a/t/t5501-old-fetch-and-upload.sh b/t/t5501-old-fetch-and-upload.sh
index 596c88b..df69d97 100755
--- a/t/t5501-old-fetch-and-upload.sh
+++ b/t/t5501-old-fetch-and-upload.sh
@@ -13,10 +13,11 @@ tmp=`pwd`/.tmp$$
 
 retval=0
 
-if [ -z "$1" ]; then
+tests=`echo "$@"| sed -e 's/--[a-zA-Z\-]*//g'`
+if [ -z "$tests" ]; then
 	list="fetch upload"
 else
-	list="$@"
+	list="$tests"
 fi
 
 for i in $list; do
