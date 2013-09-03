From: "Uli Heller" <uli.heller@daemons-point.com>
Subject: [PATCH] git-svn: Fix termination issues for remote svn connections
Date: Tue, 3 Sep 2013 09:35:29 +0200 (CEST)
Message-ID: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 09:36:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGl9c-0001cu-6G
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab3ICHfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:35:36 -0400
Received: from daemons-point.com ([213.133.97.207]:59802 "EHLO
	daemons-point.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298Ab3ICHfc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:35:32 -0400
Received: from port-83-236-132-106.static.qsc.de ([83.236.132.106] helo=qscmail.daemons-point.com)
	by daemons-point.com with esmtp (Exim 4.76)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VGl98-00080i-IH
	for git@vger.kernel.org; Tue, 03 Sep 2013 09:35:30 +0200
Received: from [127.0.0.1] (helo=83.236.132.106)
	by qscmail.daemons-point.com with esmtp (Exim 4.60)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VGl97-0004a3-HK
	for git@vger.kernel.org; Tue, 03 Sep 2013 09:35:29 +0200
Received: from 188.105.69.59
        (SquirrelMail authenticated user uli)
        by 83.236.132.106 with HTTP;
        Tue, 3 Sep 2013 09:35:29 +0200 (CEST)
User-Agent: SquirrelMail/1.4.17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233701>

When using git-svn in combination with serf-1.2.1 core dumps are
created on termination. This is caused by a bug in serf, a fix for
the bug exists (see https://code.google.com/p/serf/source/detail?r=2146).
Nevertheless, I think it makes sense to fix the issue within the
git perl module Ra.pm, too. The change frees the private copy of
the remote access object on termination which prevents the error
from happening.

Note: Since subversion-1.8.0 and later do require serf-1.2.1 or later,
the core dumps typically do show up when upgrading to a recent version
of subversion.

Credits: Jonathan Lambrechts for proposing a fix to Ra.pm.
Evgeny Kotkov and Ivan Zhakov for fixing the issue in serf and
pointing me to that fix.
---
 perl/Git/SVN/Ra.pm | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 75ecc42..78dd346 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -32,6 +32,11 @@ BEGIN {
 	}
 }

+END {
+	$RA = undef;
+	$ra_invalid = 1;
+}
+
 sub _auth_providers () {
 	my @rv = (
 	  SVN::Client::get_simple_provider(),
-- 
1.8.4
