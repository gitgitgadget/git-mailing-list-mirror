From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH 1/2] Pass through unresolved deltas when writing a pack
Date: Thu, 19 Oct 2006 20:20:40 -0400
Message-ID: <20061020002040.GB7162@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.64.0610190936440.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 02:20:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gai7z-00009w-SW
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 02:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946751AbWJTAUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 20:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946752AbWJTAUp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 20:20:45 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:55768 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1946751AbWJTAUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 20:20:44 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
	(envelope-from <jaharkes@cs.cmu.edu>)
	id 1Gai7t-00071W-0H; Thu, 19 Oct 2006 20:20:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610190936440.3962@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29393>

The resulting pack should be correct if we have the base somewhere else in
the received pack, if we didn't have the base the received pack would be
faulty and can't be unpacked as loose objects either.

The internal pack index information is not updated correctly anymore.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>

---
 builtin-unpack-objects.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index f139308..b95c93c 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -246,7 +246,10 @@ static void unpack_delta_entry(unsigned 
 	}
 
 	if (!has_sha1_file(base_sha1)) {
-		add_delta_to_list(base_sha1, delta_data, delta_size);
+		if (pack_file)
+			write_pack_delta(base_sha1, delta_data, delta_size);
+		else
+			add_delta_to_list(base_sha1, delta_data, delta_size);
 		return;
 	}
 	base = read_sha1_file(base_sha1, type, &base_size);
-- 
1.4.2.1
