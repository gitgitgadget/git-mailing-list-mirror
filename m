From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] column.c: Fix an "variable might be used uninitialized" warning
Date: Sat, 17 Mar 2012 18:30:45 +0000
Message-ID: <4F64D855.4010302@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 19:32:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8yQX-0001aw-26
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 19:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431Ab2CQScY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 14:32:24 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:63288 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753760Ab2CQScY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 14:32:24 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1S8yQ9-0004g3-eP; Sat, 17 Mar 2012 18:32:22 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193343>


In particular, gcc complains as follows:

        CC column.o
    column.c: In function 'print_columns':
    column.c:305: warning: 'len' may be used uninitialized \
        in this function

The compiler can determine that the 'len' variable, which is
passed by reference to the largest_block() function, may indeed
not be set. For example, if largest_block() returns zero, then
the 'len' output parameter will not be assigned to, which would
result in the local 'len' variable remaining uninitialised.
This would not lead to 'len' actually being used, however, since
the code checks for this case ('size' will be set to zero) and
will not execute the remainder of the loop body.

In order to suppress the warning, we simply initialise the 'len'
variable to zero.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

Could you please squash this into the relevant commit in your
nd/column series. Thanks!

[gcc v4.1.2 (on Linux) complains, but gcc v3.4.4 and gcc v4.4.0
do *not* complain.]

ATB,
Ramsay Jones

 column.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/column.c b/column.c
index 8214a9b..80183ea 100644
--- a/column.c
+++ b/column.c
@@ -302,7 +302,7 @@ static struct area *find_large_blocks(const struct string_list *list, int *nr_p)
 	memset(&last, 0, sizeof(last));
 
 	for (i = 0; i < list->nr; i++) {
-		int len, size = largest_block(list, i, 0, &len);
+		int len = 0, size = largest_block(list, i, 0, &len);
 		if (!size || len == 1)
 			continue;
 		/* the new found area is overlapped with the old one,
-- 
1.7.9
