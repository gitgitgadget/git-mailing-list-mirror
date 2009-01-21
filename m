From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2 v2] Add valgrind support in test scripts
Date: Wed, 21 Jan 2009 23:38:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
 <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de>
 <20090121215318.GA9107@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 23:39:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPljU-00046f-Ih
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbZAUWiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbZAUWiK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:38:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:56036 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753277AbZAUWiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 17:38:09 -0500
Received: (qmail invoked by alias); 21 Jan 2009 22:38:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 21 Jan 2009 23:38:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AOxZ6G8eAb4DcXmDnwYURUaTa+yVxxyTQzVotPm
	Ien/vbEvyyGCm6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090121215318.GA9107@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106692>

Hi,

On Wed, 21 Jan 2009, Jeff King wrote:

> Actually, I am wrong. There is a stripped-down readlink that has shipped 
> with FreeBSD (since 4.10) and NetBSD (since 1.6). So while readlink 
> isn't portable, I think it should generally work on platforms supported 
> by valgrind.

A pity.  I was already working on this patch:

-- snipsnap --
[PATCH] valgrind tests: provide a "readlink" function for systems which lack it

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 07e657e..c2199e7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -487,7 +487,24 @@ then
 	PATH=$TEST_DIRECTORY/..:$PATH
 	GIT_EXEC_PATH=$TEST_DIRECTORY/..
 else
+	readlink -h 2> /dev/null
+	if test $? = 127
+	then
+		readlink () {
+			ls -l "$1" |
+			sed -e "s/-> \(.*\)$/\1/g"
+			# cannot use s/.* -> //, because of
+			# ln -s "a -> b" "c -> d"
+		}
+	fi
+
 	make_symlink () {
+		case "$1" in
+		*" -> "*)
+			die "You must be kidding me ($1)."
+		;;
+		esac
+
 		test -h "$2" &&
 		test "$1" = "$(readlink "$2")" || {
 			# be super paranoid
-- 
1.6.1.442.g112f5
