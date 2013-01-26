From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2 v3] mergetool--lib: don't call "exit" in setup_tool
Date: Sat, 26 Jan 2013 13:50:23 +0000
Message-ID: <20130126135023.GJ7498@serenity.lan>
References: <20130125200807.GB7498@serenity.lan>
 <7vpq0t2f2t.fsf@alter.siamese.dyndns.org>
 <20130125204619.GC7498@serenity.lan>
 <7vlibh2d8a.fsf@alter.siamese.dyndns.org>
 <20130125211601.GD7498@serenity.lan>
 <7vbocd2auo.fsf@alter.siamese.dyndns.org>
 <20130125220222.GE7498@serenity.lan>
 <20130125220359.GF7498@serenity.lan>
 <7vip6k23mk.fsf@alter.siamese.dyndns.org>
 <20130126121721.GI7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 14:59:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz6I8-0004Yu-NV
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 14:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab3AZN7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 08:59:11 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:47448 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab3AZN7J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 08:59:09 -0500
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jan 2013 08:59:09 EST
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 31603230C0;
	Sat, 26 Jan 2013 13:50:31 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gNBbcH87r1ik; Sat, 26 Jan 2013 13:50:30 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 1F30E22F18;
	Sat, 26 Jan 2013 13:50:30 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 0D9CC161E20D;
	Sat, 26 Jan 2013 13:50:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FcZwGVZAnwHp; Sat, 26 Jan 2013 13:50:29 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A5871161E3A4;
	Sat, 26 Jan 2013 13:50:25 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130126121721.GI7498@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214624>

This will make it easier to use setup_tool in places where we expect
that the selected tool will not support the current mode.

We need to introduce a new return code for setup_tool to differentiate
between the case of "the selected tool is invalid" and "the selected
tool is not a built-in" since we must call setup_tool when a custom
'merge.<tool>.path' is configured for a built-in tool but avoid failing
when the configured tool is not a built-in.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
> On Fri, Jan 25, 2013 at 04:24:03PM -0800, Junio C Hamano wrote:
> > Applying this one on top of 1/7 thru 5/7 and 7/7 seems to break
> > t7610 rather badly.
> 
> Sorry about that.  The 'setup_tool' function should really be called
> 'setup_builtin_tool' - it isn't necessary when a custom mergetool is
> configured and will return 1 when called with an argument that isn't a
> builtin tool from $GIT_EXEC_PATH/mergetools.
> 
> The change is the second hunk below which now wraps the call to
> setup_tool in an if block as well as adding the "|| return".

Now that I've run the entire test suite, that still wasn't correct since
it did not correctly handle the case where the user overrides the path
for one of the built-in mergetools.

 git-mergetool--lib.sh | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 4c1e129..dd4f088 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -58,7 +58,11 @@ setup_tool () {
 	. "$mergetools/defaults"
 	if ! test -f "$mergetools/$tool"
 	then
-		return 1
+		# Use a special return code for this case since we want to
+		# source "defaults" even when an explicit tool path is
+		# configured since the user can use that to override the
+		# default path in the scriptlet.
+		return 2
 	fi
 
 	# Load the redefined functions
@@ -67,11 +71,11 @@ setup_tool () {
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
@@ -101,6 +105,19 @@ run_merge_tool () {
 
 	# Bring tool-specific functions into scope
 	setup_tool "$1"
+	exitcode=$?
+	case $exitcode in
+	0)
+		:
+		;;
+	2)
+		# The configured tool is not a built-in tool.
+		test -n "$merge_tool_path" || return 1
+		;;
+	*)
+		return $exitcode
+		;;
+	esac
 
 	if merge_mode
 	then
-- 
1.8.1
