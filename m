From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/5] xdiff: replace emit_func() with type-safe
Date: Wed, 09 May 2012 22:19:10 +0200
Message-ID: <4FAAD13E.8030806@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:19:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDMP-0003Rq-6o
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761022Ab2EIUTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 16:19:31 -0400
Received: from india601.server4you.de ([85.25.151.105]:59432 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760996Ab2EIUT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 16:19:28 -0400
Received: from [192.168.2.105] (p4FFD8B75.dip.t-dialin.net [79.253.139.117])
	by india601.server4you.de (Postfix) with ESMTPSA id 1119A2F803C;
	Wed,  9 May 2012 22:19:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197502>

Commit ef2e62fe added the ability to bypass the creation of textual diffs
and to access diff data directly, through the added emit_func member of
xdemitconf_t.  This function pointer has a type of "void (*)()", because
"int (*)(xdfenv_t *, xdchange_t *, xdemitcb_t *, xdemitconf_t const *)"
(its real type) would be difficult to export due to the many internal
types in that signature.

This feature is currently used twice in git blame, through the function
xdi_diff_hunks().  Both cases only need to know which lines are affected
by the different hunks of a diff, i.e. the numbers shown in hunk headers
of unified diffs.

This patch series adds a simpler mechanism to accommodate these two
callers, in a type-safe way, without exporting too many internal types
of libxdiff.  The last patch removes the old functions.

  xdiff: add hunk_func()
  blame: use hunk_func(), part 1
  blame: use hunk_func(), part 2
  blame: factor out helper for calling xdi_diff()
  xdiff: remove emit_func() and xdi_diff_hunks()

 builtin/blame.c   |   53 +++++++++++++++++++++++++++++++----------------------
 xdiff-interface.c |   44 --------------------------------------------
 xdiff-interface.h |    4 ----
 xdiff/xdiff.h     |    6 +++++-
 xdiff/xdiffi.c    |   17 +++++++++++++++--
 5 files changed, 51 insertions(+), 73 deletions(-)

-- 
1.7.10.1
