From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] builtin-mailinfo.c: check error status from rewind and
 ftruncate
Date: Mon, 28 Sep 2009 23:40:08 -0700
Message-ID: <1254206409-13256-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 08:40:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsWNu-0004DM-TT
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 08:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbZI2GkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 02:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbZI2GkM
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 02:40:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbZI2GkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 02:40:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CDD845FFF
	for <git@vger.kernel.org>; Tue, 29 Sep 2009 02:40:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=qlTK8D4nnB0P4bGzowXtX5vqd0s
	=; b=ahJ2TrS8DlDoHBfm29/MXYc/07bFSph5HhR56Ig+paS3zWTmw+mEEGI91EE
	qceWzEjmQLk5FZwxUNeTDcu1PKGcfzPET/a6W84JWqZ/8WpMtxRqPdY1QD+WpTT/
	qTW2QALYBUyZfjTgelGMRgh2GQROXg6f6fsP8ITwNErhNocY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=OMDykZYasYxT4cL2LxMP4eqN1KzQB
	jLVG18a3Si4M2A95npABTA2AOwWFaWfhh/DtrNdpEBKVsTzu9zyJnjhF0JkZXbQZ
	Bmr2qcIBlQuQg/iQ++cOlOWa7yQGOozVHkMx8tFQdavEcR9ZZ/RtJX21tkvK6qs8
	WzlkIU88Gz/5fg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3949345FFE
	for <git@vger.kernel.org>; Tue, 29 Sep 2009 02:40:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C368345FFC for
 <git@vger.kernel.org>; Tue, 29 Sep 2009 02:40:10 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc2.53.g740c
X-Pobox-Relay-ID: EFA4AA30-ACC2-11DE-8D27-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129284>

A recent "cut at scissors" implementation rewinds and truncates the output
file to store the message when it sees a scissors mark, but it did not
check if these library calls succeeded.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mailinfo.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index d498b1c..3306d9e 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -785,8 +785,10 @@ static int handle_commit_msg(struct strbuf *line)
 
 	if (use_scissors && is_scissors_line(line)) {
 		int i;
-		rewind(cmitmsg);
-		ftruncate(fileno(cmitmsg), 0);
+		if (rewind(cmitmsg))
+			die_errno("Could not rewind output message file");
+		if (ftruncate(fileno(cmitmsg), 0))
+			die_errno("Could not truncate output message file at scissors");
 		still_looking = 1;
 
 		/*
-- 
1.6.3
