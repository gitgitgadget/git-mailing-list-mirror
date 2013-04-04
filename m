From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v2 2/2] t9700: do not close STDERR
Date: Thu, 4 Apr 2013 22:41:42 +0200
Message-ID: <3689abc8e1af4ddbbb7791dd6241996f86e4efa2.1365107899.git.trast@inf.ethz.ch>
References: <20130404011653.GA28492@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>,
	Marcin Owsiany <marcin@owsiany.pl>, Petr Baudis <pasky@ucw.cz>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:42:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqzA-0005dx-GF
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760484Ab3DDUlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:41:46 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:36433 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760200Ab3DDUlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:41:46 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 4 Apr
 2013 22:41:34 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 4 Apr
 2013 22:41:42 +0200
X-Mailer: git-send-email 1.8.2.607.g19d29d3
In-Reply-To: <20130404011653.GA28492@dcvr.yhbt.net>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220096>

Much like the previous patch, this triggered an unrelated bug.
Closing STDERR is not worth it anyway, as we risk writing die() and
such to random files that happen to be subsequently opened on FD 2.
Don't do it.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/t9700/test.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 0d4e366..1140767 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -45,7 +45,8 @@ is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
 # Failure cases for config:
 # Save and restore STDERR; we will probably extract this into a
 # "dies_ok" method and possibly move the STDERR handling to Git.pm.
-open our $tmpstderr, ">&STDERR" or die "cannot save STDERR"; close STDERR;
+open our $tmpstderr, ">&STDERR" or die "cannot save STDERR";
+open STDERR, ">", "/dev/null" or die "cannot redirect STDERR to /dev/null";
 is($r->config("test.dupstring"), "value2", "config: multivar");
 eval { $r->config_bool("test.boolother") };
 ok($@, "config_bool: non-boolean values fail");
-- 
1.8.2.607.g19d29d3
