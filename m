From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hg-to-git: handle an empty dir in hg by combining git commits
Date: Tue, 04 Dec 2007 23:01:24 -0800
Message-ID: <7veje11v7f.fsf@gitster.siamese.dyndns.org>
References: <4751A0FB.6090705@gmail.com>
	<7vd4tq41zt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stelian@popies.net, git@vger.kernel.org
To: Mark Drago <markdrago@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 08:02:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzoGe-0000Bi-8P
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 08:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbXLEHBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 02:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbXLEHBb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 02:01:31 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47476 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXLEHBa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 02:01:30 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C386E2F0;
	Wed,  5 Dec 2007 02:01:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 43B6D99FF2;
	Wed,  5 Dec 2007 02:01:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67113>

Junio C Hamano <gitster@pobox.com> writes:

> Mark Drago <markdrago@gmail.com> writes:
>
>> This patch will detect that there are no changes to commit (using git-status),
>> and will not perform the commit, but will instead combine the log messages of
>> that (non-)commit with the next commit.
>
> I think a better approach would be to implement --no-tree-change-is-ok
> option to git-commit, strictly for use by foreign scm interface scripts
> like yours.  It does not usually make sense to record a commit that has
> the exact same tree as its sole parent commit and that is why git-commit
> prevents you from making that mistake, but when data from foreign scm is
> involved, it is a different story.  We are equipped to represent such a
> (perhaps insane, perhaps by mistake, or perhaps done on purpose) change
> and it is better to represent it bypassing the safety valve for native
> use.

So I did "git commit --allow-empty".  With that, perhaps the following
will fix the issue?

I won't be commiting this myself until I hear a positive Ack.

---
 contrib/hg-to-git/hg-to-git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 7a1c3e4..9befb92 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -211,7 +211,7 @@ for cset in range(int(tip) + 1):
     os.system('git-ls-files -x .hg --deleted | git-update-index --remove --stdin')
 
     # commit
-    os.system(getgitenv(user, date) + 'git-commit -a -F %s' % filecomment)
+    os.system(getgitenv(user, date) + 'git commit --allow-empty -a -F %s' % filecomment)
     os.unlink(filecomment)
 
     # tag
