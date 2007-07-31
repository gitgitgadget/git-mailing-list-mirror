From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH v2 0/5] Add guards to guilt
Date: Mon, 30 Jul 2007 20:11:16 -0700
Message-ID: <1185851481190-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Tue Jul 31 05:12:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFi9R-0001t4-2g
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 05:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966473AbXGaDLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 23:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965575AbXGaDLp
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 23:11:45 -0400
Received: from smtp-7.smtp.ucla.edu ([169.232.46.138]:51454 "EHLO
	smtp-7.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764635AbXGaDLh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 23:11:37 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.150])
	by smtp-7.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BTLT014825;
	Mon, 30 Jul 2007 20:11:29 -0700
Received: from localhost (adsl-75-26-197-236.dsl.scrm01.sbcglobal.net [75.26.197.236])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BSpb013432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 20:11:29 -0700
Received: by localhost (Postfix, from userid 1000)
	id 87EEA1E80A9; Mon, 30 Jul 2007 20:11:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.46.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54314>


Changes in v2
        - get_series returns guarded series, get_full_series gives
          full series.  Most commands want the guarded series anyway.
        - more options for guilt-select (better hg compatability)
        - rename guilt-guards to guilt-guard (better hg compatability)
        - a couple bug fixes
        - an extra patch that adds a test suite

This series adds Mercurial Queues-like guards to guilt.  It allows you
to assign guards to related patches in the series file to selectively
push patches.

See Chapter 13 of the HG Book for more info.
(http://hgbook.red-bean.com/hgbookch13.html)

Guards are appended as "#+foo" or "#-foo" to the end of the patch name
in the series file, so they are compatible with quilt. The
guard setting and unsetting functions also respect comments on the
patch line, so they aren't mangled when you use guards.

This changes `get_series` to return the guarded series of patches that
will be actually be applied.  `get_full_series` returns the full
series file.

If you change guards on a patch or select a different guard while
patches are applied, some commands might get confused.  See
`guilt-select --pop` and `guilt-select --reapply` to avoid having to
`guilt-pop -a` yourself.

I did everything (maybe?) you suggested except implement a
safe_sed wrapper and a validate_guards function.  The sed stuff is
maybe better for a later patch that covers most sed usage in guilt,
and the validate_guards isn't really necessary given the small number
of times it's called.  If you would prefer either of those to get
done, let me know.

[PATCH 1/5] get_series: Remove comments from end of series lines
       This just strips everything but the patch name from get_series,
       to hide comments or guards on the line.

[PATCH 2/5] guilt-guard: Assign guards to patches in series
       This adds the guilt-guard command and utility functions to
       guilt.  Introduces get_guarded_series, which is removed in
       patch 4.

[PATCH 3/5] guilt-select: Select guards to apply when pushing patches
       This puts selected guards in .git/patch/$branch/guards, and
       adds a $guards_file variable to guilt.

[PATCH 4/5] get_series: return guarded patches only
       Actually distinguish between guarded and non-guarded patches in
       a number of commands by making get_series return the guarded
       series, and introducing get_full_series to return the unguarded
       series.  Lots of changes.
       If anything breaks, it's in this patch.  Hopefully.

[PATCH 5/5] Guards test suite
       Test stuff that uses get_series or get_full_series.
