From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [TopGit PATCH/RFC fixup] suppress "cannot overwrite existing file"
 error
Date: Tue, 12 Aug 2008 13:21:13 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808121317110.18832@harper.uchicago.edu>
References: <Pine.GSO.4.62.0808121309000.18832@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pasky@suse.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 20:22:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSyVc-0007Pq-Og
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 20:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYHLSVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 14:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbYHLSVQ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 14:21:16 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:49648 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYHLSVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 14:21:16 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7CILCRc015580;
	Tue, 12 Aug 2008 13:21:13 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7CILD8h019369;
	Tue, 12 Aug 2008 13:21:13 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0808121309000.18832@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92126>

We had been using sh -C ": >filename" to atomically create a file,
but this has the unfortunate side effect of producing an error
message if the file already exists.  So suppress the error.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
	Here's a fix to a mistake in the patch I just sent.  If the
	patch was meant for application, I would be suggesting
	squashing this change in.  Sorry for the noise.

 tg.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tg.sh b/tg.sh
index c31256f..65375d6 100644
--- a/tg.sh
+++ b/tg.sh
@@ -85,14 +85,14 @@ branch_contains()
 # nonzero status on failure
 temp_filename()
 {
-	set -C && umask 077
+	umask 077
 	prefix=$1
 	i=0
 	suffix=$(awk 'BEGIN { srand(); rand(); print int(rand()*99999) }')
 	while test $i -lt 256
 	do
 		tmp=$prefix$suffix
-		: >"$tmp" && break
+		sh -C -c ': >"$tmp"' 2>/dev/null && break
 		i=$(($i+1))
 		suffix=$(($suffix+1))
 	done
-- 
1.6.0.rc2.531.g79a96
