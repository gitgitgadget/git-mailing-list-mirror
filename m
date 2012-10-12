From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for .gitattributes
Date: Fri, 12 Oct 2012 09:33:00 +0200
Message-ID: <5077C7AC.9010301@viscovery.net>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com> <1349877544-17648-1-git-send-email-pclouds@gmail.com> <1349877544-17648-3-git-send-email-pclouds@gmail.com> <50758477.3030304@viscovery.net> <7vtxu2ayov.fsf@alter.siamese.dyndns.org> <50765CDC.8020509@viscovery.net> <7vpq4p80sn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 09:33:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMZkF-00037W-AD
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 09:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380Ab2JLHdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 03:33:07 -0400
Received: from so.liwest.at ([212.33.55.24]:54662 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab2JLHdG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 03:33:06 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TMZjx-000590-D2; Fri, 12 Oct 2012 09:33:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2466A1660F;
	Fri, 12 Oct 2012 09:33:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vpq4p80sn.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207534>

Am 10/11/2012 17:51, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> I saw EINVAL errors when 'git grep pattern rev' was run on Windows. The
>> reason is that the code attempted to access "rev:dir/.gitattributes" in
>> the worktree, which is an invalid path on Windows due to the colon. The
>> lack of this warning indicates that the attempts to access these files are
>> eliminated.
> 
> It means that whenever we ask for attributes for a tracked file that
> is inside a directory whose name contains a colon, we would get the
> same error on Windows, no?  Perhaps Windows may not let you create
> such a directory in the first place, but you may still get a
> repository of a cross platform project that contains such a path.

Your assessment is correct.

> What I am wondering is if we should do something similar to 8e950da
> (attr: failure to open a .gitattributes file is OK with ENOTDIR,
> 2012-09-13), at least on Windows, for EINVAL.

It might be worth it. We already have a similar special case in
write_or_die.c:maybe_flush_or_die() for Windows, although it is not about
a colon in a path name.

Perhaps like this.

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] attr: do not warn on path with colon on Windows

In the same spirit as commit 8e950dab (attr: failure to open a
.gitattributes file is OK with ENOTDIR), ignore EINVAL errors. On
Windows, a path that contains a colon that is not the one after the
drive letter is not allowed and is reported with errno set to
EINVAL.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 attr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 8010429..ac945ad 100644
--- a/attr.c
+++ b/attr.c
@@ -354,7 +354,15 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 	int lineno = 0;
 
 	if (!fp) {
-		if (errno != ENOENT && errno != ENOTDIR)
+		/*
+		 * If path does not exist, it is not worth mentioning,
+		 * but I/O errors and permission errors are.
+		 *
+		 * On Windows, EINVAL is reported if path contains a colon
+		 * that is not the driver letter separator. Such a path
+		 * cannot exist in the file system and is also uninteresting.
+		 */
+		if (errno != ENOENT && errno != ENOTDIR && errno != EINVAL)
 			warn_on_inaccessible(path);
 		return NULL;
 	}
-- 
1.8.0.rc2.1237.g5522246
