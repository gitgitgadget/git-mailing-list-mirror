From: Jonathan Nieder <jrnieder@gmail.com>
Subject: log -L crash (Re: [PATCH V5 13/17] Add parent rewriting to line
 history browser)
Date: Mon, 30 Aug 2010 12:10:07 -0500
Message-ID: <20100830171007.GC21441@burratino>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
 <1281539022-31616-14-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	gitster@pobox.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 19:12:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq7to-0003V3-I1
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 19:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055Ab0H3RLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 13:11:54 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52958 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab0H3RLy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 13:11:54 -0400
Received: by pwi3 with SMTP id 3so80876pwi.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mGkpckTWtXD9XafPEpQAdcuhVzEaUV/+OSpejeAy8gw=;
        b=cWDsumtfzjoUueSv0UND19gPLe2n91CnepaRBLx53J8q8FoR20MLuwmzMA+VgrVf/w
         WY9/DlVOA/0ud6FgXgS5EFVbFgmTyvBAunQwPAWsSPHsDpOZ8SkNW+yr0+4gtDDohbes
         RH5dac/sxMqFcpJ/NhlpYc8/Uyv3VV2SXhBTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MnKrZ4O5E/tD45q4+cOw+7aTH/eKslBYvbFYSOLLNMFeON0X2iBxOPHxjqxyxsUNZK
         nKdRPQXBds3kx2Nd6IeobV+/rEIBtWTx/jprWgwXpE7ySn+qBhex1cRCXpBEUWBu0aDh
         91tM5jj4FocWhquUfA2doZ4mPCQhykgE4bh44=
Received: by 10.142.203.16 with SMTP id a16mr2760958wfg.253.1283188313550;
        Mon, 30 Aug 2010 10:11:53 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id j34sm2490743vcs.28.2010.08.30.10.11.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 10:11:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281539022-31616-14-git-send-email-struggleyb.nku@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154832>

Hi Bo et al,

The following test fails (segfaults) for me.  It bisects to 83361f5
(Add parent rewriting to line history browser, 2010-08-11).  Notes
from --valgrind:

	Invalid read of size 4
	   at assign_parents_range (line.c:1069)
	   by cmd_line_log_walk (line.c:1403)
	   by cmd_log (log.c:619)
	   by handle_internal_command (git.c:270)
	   by main (git.c:470)
	 Address 0x432a90c is 4 bytes inside a block of size 8 free'd
	   at free (vg_replace_malloc.c:366)
	   by assign_range_to_parent (line.c:964)
	   by assign_parents_range (line.c:1036)
	   by cmd_line_log_walk (line.c:1403)
	   by cmd_log (log.c:619)
	   by handle_internal_command (git.c:270)
	   by main (git.c:470)
 
	Invalid read of size 4
	   at assign_parents_range (line.c:1041)
	   by cmd_line_log_walk (line.c:1403)
	   by cmd_log (log.c:619)
	   by handle_internal_command (git.c:270)
	   by main (git.c:470)
	 Address 0x0 is not stack'd, malloc'd or (recently) free'd

	Process terminating with default action of signal 11 (SIGSEGV): dumping core
	 Access not within mapped region at address 0x0
	   at assign_parents_range (line.c:1041)
	   by cmd_line_log_walk (line.c:1403)
	   by cmd_log (log.c:619)
	   by handle_internal_command (git.c:270)
	   by main (git.c:470)
	 If you believe this happened as a result of a stack
	 overflow in your program's main thread (unlikely but
	 possible), you can try to increase the size of the
	 main thread stack using the --main-stacksize= flag.
	 The main thread stack size used in this run was 8388608.

Ideas?

diff --git a/t/t0011-crash.sh b/t/t0011-crash.sh
index e69de29..5cb3ef3 100644
--- a/t/t0011-crash.sh
+++ b/t/t0011-crash.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+test_description=crash
+. ./test-lib.sh
+
+test_expect_success "doesn't crash" '
+	GIT_DIR="$TEST_DIRECTORY"/../.git \
+		git log -L "/while (1) {/,/}/" git.c
+'
+
+test_done
-- 
