From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/2] Fixes for undefined behaviour
Date: Tue,  2 Apr 2013 20:50:30 +0100
Message-ID: <cover.1364931627.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:51:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7Ef-0005Cr-Ke
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645Ab3DBTuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:50:44 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:57639 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401Ab3DBTun (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:50:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 1677F22CAB;
	Tue,  2 Apr 2013 20:50:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zItQWwxTxlxi; Tue,  2 Apr 2013 20:50:42 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id DFA40230E0;
	Tue,  2 Apr 2013 20:50:37 +0100 (BST)
X-Mailer: git-send-email 1.8.2.540.gf023cfe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219867>

I've been playing with Clang's undefined behaviour sanitizer, which
points out a few potential issues in Git when running the test suite
(it's a runtime analysis that is compiled in by setting suitable
CFLAGS).

These patches fix one issue that I think we need to worry about and one
that's trivial to fix.

The remaining warnings are:

refs.c:2426:17: runtime error: index -1 out of bounds for type 'char [8192]'

  Caused by a loop walking backwards over the reflog which sets its scan
  pointer to be one before the start of the buffer in order to break out
  of the loop.  It seems unlikely that the (stack allocated) buffer will
  be at address zero so I don't think any sane compiler will cause us
  problems here.

tag.c:104:40: runtime error: member access within null pointer of type
'struct commit'

  This does "&lookup_commit(sha1)->object" which ends up being okay
  because "object" is the first item in struct commit.  I'm not sure
  it's worth the churn to change this.

xdiff/xutils.c:308:7: runtime error: load of misaligned address for type
'unsigned long', which requires 8 byte alignment

  This is in the XDL_FAST_HASH code, which should only be used on
  architectures where this is likely to be reasonably fast.  The commit
  introducing this code points at an LKML thread[1] discussing a similar
  implementation in the kernel, which discusses the impact of the
  unaligned access, the conclusion being that it's faster than any
  alternative.

[1] https://lkml.org/lkml/2012/3/2/452

John Keeping (2):
  diffcore-break: don't divide by zero
  bisect: avoid signed integer overflow

 bisect.c         | 2 +-
 diffcore-break.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
1.8.2.540.gf023cfe
