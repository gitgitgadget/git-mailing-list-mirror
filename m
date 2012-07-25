From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 2/3] Don't lose Error.pm if $@ gets clobbered.
Date: Tue, 24 Jul 2012 20:21:10 -0700
Message-ID: <1343186471-1024-3-git-send-email-schwern@pobox.com>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, "Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 25 05:21:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StsAY-0006Hi-RQ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab2GYDVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:21:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57952 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139Ab2GYDVn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:21:43 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so662367pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Az4OEDTKAqdxdQwTSj08vfwv7HeFDREJ5aldiYmI2cQ=;
        b=jFPJR74tXiR3ZnEKv886OViwkYkoFPSovT5BnQBFEPY/ah8zShyDT2X12nZXI95Y0p
         cF2PHFcQr2RrdbiLz9WOAvmOJaiLlSTV0l9E46ivCjEsk/6VfRr+l80TekjJilAybpfW
         u7IdJ208uUEPQ1Zydu3cqY+S+icwwN17/9KUG2TlKfFT3WIFpYbthsuO38YCPoFgV5j6
         2QhNH8ZKCSWP7lCEFdTSMS7SSGqMauCnqCIY/QhoSzf4DTSyMo3i7YXV2rnha5+YufkX
         QH1DB7brRzQUq5UGOBE7ksrQzuLSJs4f8KbL/yzlBAxnNwbdlqWvN4JbntGptthohD1T
         orGw==
Received: by 10.68.231.233 with SMTP id tj9mr49686983pbc.39.1343186502893;
        Tue, 24 Jul 2012 20:21:42 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id hf5sm13423597pbc.4.2012.07.24.20.21.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:21:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343186471-1024-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202107>

From: "Michael G. Schwern" <schwern@pobox.com>

In older Perls, sometimes $@ can become unset between the eval and
checking $@.  Its safer to check the eval directly.

Signed-off-by: Michael G Schwern <schwern@pobox.com>
---
 perl/Makefile.PL | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 87e1f62..887fa1b 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -41,8 +41,7 @@ my %pm = (
 
 # We come with our own bundled Error.pm. It's not in the set of default
 # Perl modules so install it if it's not available on the system yet.
-eval { require Error };
-if ($@ || $Error::VERSION < 0.15009) {
+if ( !eval { require Error } || $Error::VERSION < 0.15009) {
 	$pm{'private-Error.pm'} = '$(INST_LIBDIR)/Error.pm';
 }
 
-- 
1.7.11.1
