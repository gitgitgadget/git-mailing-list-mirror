From: Uli Heller <uli.heller@daemons-point.com>
Subject: [PATCH v2] git-svn: Fix termination issues for remote svn   connections
Date: Mon, 09 Sep 2013 08:01:34 +0200
Message-ID: <522D643E.2000901@daemons-point.com>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106> <xmqqli3bhzop.fsf@gitster.dls.corp.google.com> <A46AD76E-56FA-4555-8811-6141284300DD@gmail.com> <07b9b270090d6b42515c5dc3dfb8ab4f.squirrel@83.236.132.106> <9D2EC674-887A-479B-B8FB-3EFEAC391435@gmail.com> <f2fe486a6ca0bf40be4489bfe888d517.squirrel@83.236.132.106> <xmqqa9jpzyvo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 08:01:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIuXt-0002d4-GS
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 08:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab3IIGBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 02:01:42 -0400
Received: from daemons-point.com ([213.133.97.207]:59866 "EHLO
	daemons-point.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab3IIGBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 02:01:41 -0400
Received: from port-83-236-132-106.static.qsc.de ([83.236.132.106] helo=qscmail.daemons-point.com)
	by daemons-point.com with esmtp (Exim 4.76)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VIuXY-0001eP-0t; Mon, 09 Sep 2013 08:01:36 +0200
Received: from localhost ([127.0.0.1])
	by qscmail.daemons-point.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <uli.heller@daemons-point.com>)
	id 1VIuXX-0005UQ-BO; Mon, 09 Sep 2013 08:01:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqa9jpzyvo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234313>

 From a763550fc59b756580f9b162839d2737c27f2fe3 Mon Sep 17 00:00:00 2001
From: Uli Heller <uli.heller@daemons-point.com>
Date: Tue, 3 Sep 2013 09:14:03 +0200
Subject: [PATCH] git-svn: Fix termination issues for remote svn connections

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
Junio C Hamano for proposing a great code comment.
Kyle J. McKay for testing against latest serf (1.3.1).
... and various others - thanks!
---
  perl/Git/SVN/Ra.pm | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 75ecc42..a7b0119 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -32,6 +32,14 @@ BEGIN {
         }
  }

+# serf has a bug that leads to a coredump upon termination if the
+# remote access object is left around (not fixed yet in serf 1.3.1).
+# Explicitly free it to work around the issue.
+END {
+       $RA = undef;
+       $ra_invalid = 1;
+}
+
  sub _auth_providers () {
         my @rv = (
           SVN::Client::get_simple_provider(),
-- 
1.8.4
