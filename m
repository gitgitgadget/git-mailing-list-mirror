From: "Vallon, Justin" <Justin.Vallon@deshaw.com>
Subject: RE: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Date: Tue, 4 Jan 2011 09:43:12 -0500
Message-ID: <982E526FA742C94E9AC26DA766FD07090A3399@NYCMBX3.winmail.deshaw.com>
References: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
 <7vsjxjyce6.fsf@alter.siamese.dyndns.org>
 <20101227080343.GA15026@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'Robin H. Johnson'" <robbat2@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 04 15:46:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa89M-0006JY-AS
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 15:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab1ADOqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 09:46:06 -0500
Received: from master.nyc.deshaw.com ([149.77.10.1]:50045 "EHLO
	master.nyc.deshaw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab1ADOqF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 09:46:05 -0500
Received: from winmail.deshaw.com ([149.77.72.51])
 by master.nyc.deshaw.com (8.13.8+Sun/8.13.7/2.0.kim.desco.357) with ESMTP id p04EjCIR005229;
 Tue, 4 Jan 2011 09:45:13 -0500 (EST)
Received: from NYCMBX3.winmail.deshaw.com ([149.77.72.43]) by
 mailnychts1.winmail.deshaw.com ([149.77.72.51]) with mapi; Tue, 4 Jan 2011
 09:45:12 -0500
Thread-Topic: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Thread-Index: AculnJxNjQZg4nlmTNyz4+rx5QpT7QGgEP4g
In-Reply-To: <20101227080343.GA15026@orbis-terrarum.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164494>

 # "exec" commands are ran with the user shell by default, but this may
 # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
 # to create a file. Unseting SHELL avoids such non-portable behavior

Perl's exec and system do not use SHELL (as far as perlfunc states).  It uses /bin/sh -c "$cmd", or a platform-dependent equivalent.

$SHELL is typically only used when a program wants to invoke a user-shell (ie: editor shell-escape, xterm, typescript, screen).

How was SHELL=/bin/false causing problems?  Is git using $SHELL?

-- 
-Justin


-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of Robin H. Johnson
Sent: Monday, December 27, 2010 3:04 AM
To: Junio C Hamano; git@vger.kernel.org
Subject: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false

If the user's shell in NSS passwd is /bin/false (eg as found during Gentoo's
package building), the git-rebase exec tests will fail, because they call
$SHELL around the command, and in the existing testcase, $SHELL was not being
cleared sufficently.

This lead to false positive failures of t3404 on systems where the package
build user was locked down as noted above.

Signed-off-by: "Robin H. Johnson" <robbat2@gentoo.org>
X-Gentoo-Bug: 349083
X-Gentoo-Bug-URL: http://bugs.gentoo.org/show_bug.cgi?id=349083
---
 t/t3404-rebase-interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d3a3bd2..7d8147b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -71,8 +71,9 @@ test_expect_success 'setup' '
 # "exec" commands are ran with the user shell by default, but this may
 # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
 # to create a file. Unseting SHELL avoids such non-portable behavior
-# in tests.
+# in tests. It must be exported for it to take effect where needed.
 SHELL=
+export SHELL
 
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
