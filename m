From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/3] test-terminal: set output terminals to raw mode
Date: Mon, 12 Dec 2011 19:09:14 +0100
Message-ID: <04a77f48dd5d5afebbe625ed25ebecd57b6a8840.1323713230.git.trast@student.ethz.ch>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 19:09:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaAJb-00029C-SS
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 19:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab1LLSJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 13:09:23 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:53412 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417Ab1LLSJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 13:09:21 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 19:09:15 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 19:09:17 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186924>

Not setting them to raw mode causes funny things to happen, such as
\n -> \r\n translation:

  ./test-terminal.perl echo foo | xxd
  0000000: 666f 6f0d 0a                             foo..

(Notice the added 0d.)

To avoid this, set the (pseudo)terminal to raw mode.  Note that the
IO::Pty docs recommend doing it on both master and slave.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/test-terminal.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 87b5a8c..a2bfbe5 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -81,6 +81,10 @@ sub set_default_eof_char {
 my $master_in = new IO::Pty;
 my $master_out = new IO::Pty;
 my $master_err = new IO::Pty;
+$master_out->set_raw();
+$master_err->set_raw();
+$master_out->slave->set_raw();
+$master_err->slave->set_raw();
 set_default_eof_char($master_in->slave);
 my $pid = start_child(\@ARGV, $master_in->slave, $master_out->slave, $master_err->slave);
 close $master_in->slave;
-- 
1.7.8.431.g2abf2
