From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Fix an "variable might be used uninitialized" gcc warning
Date: Fri, 16 Dec 2011 22:44:38 +0000
Message-ID: <4EEBC9D6.6010204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 23:58:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbgjf-0001mR-To
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760931Ab1LPW6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 17:58:35 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:44063 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760864Ab1LPW6d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 17:58:33 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1RbgjX-0006rU-ZG; Fri, 16 Dec 2011 22:58:32 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187331>


In particular, gcc issues the following warning:

        CC builtin/checkout.o
    builtin/checkout.c: In function `cmd_checkout':
    builtin/checkout.c:160: warning: 'mode' might be used uninitialized \
        in this function

However, the analysis performed by gcc is too conservative, in this
case, since the mode variable will not be used uninitialised. Note that,
if the mode variable is not set in the loop, then "threeway[1]" will
also still be set to the null SHA1. This will then result in control
leaving the function, almost directly after the loop, well before the
potential use in the call to make_cache_entry().

In order to suppress the warning, we initialise the mode variable to
zero in it's declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Just in case you haven't found the time to apply your own patch!

[Note that only 2 out of the 3 versions of gcc I use issues this
warning]

ATB,
Ramsay Jones

 builtin/checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 787d468..f1984d9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -157,7 +157,7 @@ static int checkout_merged(int pos, struct checkout *state)
 	unsigned char sha1[20];
 	mmbuffer_t result_buf;
 	unsigned char threeway[3][20];
-	unsigned mode;
+	unsigned mode = 0;
 
 	memset(threeway, 0, sizeof(threeway));
 	while (pos < active_nr) {
-- 
1.7.8
