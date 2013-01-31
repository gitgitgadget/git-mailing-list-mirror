From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/5] msvc: git-daemon: Fix linker "unresolved external" errors
Date: Thu, 31 Jan 2013 18:30:14 +0000
Message-ID: <510AB836.5090209@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:39:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0z2E-00077k-C5
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286Ab3AaSi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:38:27 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:48853 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752877Ab3AaSiX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:38:23 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 77B4B18C713;
	Thu, 31 Jan 2013 18:38:22 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])	by mdfmta005.tch.inty.net (Postfix) with ESMTP id B475818C712;	Thu, 31 Jan 2013 18:38:21 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tch.inty.net (Postfix) with ESMTP;	Thu, 31 Jan 2013 18:38:20 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215145>


In particular, while linking git-daemon.exe, the linker complains
that the external symbols _inet_pton and _inet_ntop are unresolved.
Commit a666b472 ("daemon: opt-out on features that require posix",
04-11-2010) addressed this problem for MinGW by configuring the
use of the internal 'compat' versions of these function.

Although the MSVC header <WS2tcpip.h> contains the prototypes for
the inet_pton and inet_ntop functions, they are only visible for
Windows API versions from 0x0600 (Windows Vista) or later. (In
addition, on Windows XP, ws2_32.dll does not export these symbols).

In order to fix the linker errors, we also configure the MSVC build
to use the internal compat versions of these functions by setting
the NO_INET_{PTON,NTOP} build variables.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index bea34f0..7e52f3c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -344,6 +344,8 @@ ifeq ($(uname_S),Windows)
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	NO_INET_PTON = YesPlease
+	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
-- 
1.8.1
