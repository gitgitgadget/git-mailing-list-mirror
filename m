From: Eric Wong <e@80x24.org>
Subject: [RFC/PATCH 0/3] support mboxrd format
Date: Mon, 30 May 2016 23:21:39 +0000
Message-ID: <20160530232142.21098-1-e@80x24.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 01:21:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7WVN-0005D7-Qk
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 01:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161941AbcE3XVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 19:21:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34822 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161857AbcE3XVs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 19:21:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC06E1FE31
	for <git@vger.kernel.org>; Mon, 30 May 2016 23:21:47 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295939>

Sometimes users will copy+paste an entire mbox into a
commit message, leading to bad splits when a patch is
output as an email.

Unlike other mbox-family formats, mboxrd allows reversible
round-tripping while avoiding bad splits for old "mboxo"
readers.

I'm also considering altering the current
"From ${COMMIT} Mon Sep 17 00:00:00 2001" line to something
else so mailsplit (or "am") can autodetect.

Maybe:
	From ${COMMIT}@mboxrd Mon Sep 17 00:00:00 2001
?


We may also want to default to single escaping "From " in
commit messages for --pretty=email to avoid corruption when
somebody copy+pastes an mbox into the commit message.
This is a technically incompatible change, but I think it's
preferable to breaking splitting complete.

In other words, --pretty=email changes to output "mboxo"
for now.

Long term (possibly git 3.0?), maybe mboxrd can become the
default mail format.  IMHO, it should've been since 2005.

ref: http://homepage.ntlworld.com/jonathan.deboynepollard/FGA/mail-mbox-formats.html

Eric Wong (3):
      pretty: support "mboxrd" output format
      mailsplit: support unescaping mboxrd messages
      am: support --patch-format=mboxrd

 Documentation/git-am.txt        |  3 ++-
 Documentation/git-mailsplit.txt |  7 ++++++-
 builtin/am.c                    | 14 ++++++++++---
 builtin/log.c                   |  2 +-
 builtin/mailsplit.c             | 23 +++++++++++++++++++++
 commit.h                        |  6 ++++++
 log-tree.c                      |  4 ++--
 pretty.c                        | 45 +++++++++++++++++++++++++++++++++--------
 t/t4014-format-patch.sh         | 27 +++++++++++++++++++++++++
 t/t4150-am.sh                   | 20 ++++++++++++++++++
 t/t5100-mailinfo.sh             | 13 ++++++++++++
 t/t5100/0001mboxrd              |  4 ++++
 t/t5100/0002mboxrd              |  3 +++
 t/t5100/sample.mboxrd           | 17 ++++++++++++++++
 14 files changed, 172 insertions(+), 16 deletions(-)
