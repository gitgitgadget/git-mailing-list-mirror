From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2 v2] mergetool--lib: don't call "exit" in setup_tool
Date: Sat, 26 Jan 2013 12:17:21 +0000
Message-ID: <20130126121721.GI7498@serenity.lan>
References: <20130125195446.GA7498@serenity.lan>
 <20130125200807.GB7498@serenity.lan>
 <7vpq0t2f2t.fsf@alter.siamese.dyndns.org>
 <20130125204619.GC7498@serenity.lan>
 <7vlibh2d8a.fsf@alter.siamese.dyndns.org>
 <20130125211601.GD7498@serenity.lan>
 <7vbocd2auo.fsf@alter.siamese.dyndns.org>
 <20130125220222.GE7498@serenity.lan>
 <20130125220359.GF7498@serenity.lan>
 <7vip6k23mk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 13:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz4hk-0001f6-9t
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 13:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab3AZMRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 07:17:30 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:48875 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab3AZMR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 07:17:29 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jan 2013 07:17:29 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id ADE9F866036;
	Sat, 26 Jan 2013 12:17:28 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNOxr+Vhczge; Sat, 26 Jan 2013 12:17:28 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 10EA986600C;
	Sat, 26 Jan 2013 12:17:23 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vip6k23mk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214620>

This will make it easier to use setup_tool in places where we expect
that the selected tool will not support the current mode.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Fri, Jan 25, 2013 at 04:24:03PM -0800, Junio C Hamano wrote:
> Applying this one on top of 1/7 thru 5/7 and 7/7 seems to break
> t7610 rather badly.

Sorry about that.  The 'setup_tool' function should really be called
'setup_builtin_tool' - it isn't necessary when a custom mergetool is
configured and will return 1 when called with an argument that isn't a
builtin tool from $GIT_EXEC_PATH/mergetools.

The change is the second hunk below which now wraps the call to
setup_tool in an if block as well as adding the "|| return".

 git-mergetool--lib.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 4c1e129..8a5eaff 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -67,11 +67,11 @@ setup_tool () {
 	if merge_mode && ! can_merge
 	then
 		echo "error: '$tool' can not be used to resolve merges" >&2
-		exit 1
+		return 1
 	elif diff_mode && ! can_diff
 	then
 		echo "error: '$tool' can only be used to resolve merges" >&2
-		exit 1
+		return 1
 	fi
 	return 0
 }
@@ -100,7 +100,10 @@ run_merge_tool () {
 	status=0
 
 	# Bring tool-specific functions into scope
-	setup_tool "$1"
+	if test -z "$merge_tool_path"
+	then
+		setup_tool "$1" || return
+	fi
 
 	if merge_mode
 	then
-- 
1.8.1.1.367.ga9c3dd4.dirty
