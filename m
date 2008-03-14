From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t6000lib.sh: tr portability fix fix
Date: Fri, 14 Mar 2008 15:47:37 -0500
Message-ID: <47DAE469.7080409@nrlssc.navy.mil>
References: <20080312213831.GJ26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: armstrong.whit@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 21:49:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaGpf-0001y4-LO
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 21:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbYCNUsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 16:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbYCNUsL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 16:48:11 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37300 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbYCNUsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 16:48:10 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2EKlcSe004829;
	Fri, 14 Mar 2008 15:47:40 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Mar 2008 15:47:37 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080312213831.GJ26286@coredump.intra.peff.net>
X-OriginalArrivalTime: 14 Mar 2008 20:47:37.0661 (UTC) FILETIME=[A34316D0:01C88614]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15784001
X-TM-AS-Result: : Yes--12.275000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMzc0Ny03MDIz?=
	=?us-ascii?B?NTgtNzA3MjU5LTcwNzQ1MS03MDAxNjAtNzAxMTgyLTcwMDA3NS0x?=
	=?us-ascii?B?MzkwMTAtNzAxNTk0LTcwOTE4NS0xMDU3MDAtNzAwNDg2LTcwMjA0?=
	=?us-ascii?B?NC03MDA3MDEtNzAxMTM4LTcwMTIwMi03MDAxMDQtNzA1MTAyLTE4?=
	=?us-ascii?B?NzAwNS03MTE2NjQtMTA1MjUwLTE4ODAxOS03MDE0NTUtNzA0NTY4?=
	=?us-ascii?B?LTE0ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77280>

Some versions of tr have a problem with character sets which begin with
multiple dashes and attempt to interpret them as long options. Use the
'--' notation to signal the end of command line options.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Jeff King wrote:
> Some versions of tr complain if the number of characters in
> both sets isn't the same. So here we must manually expand
> the dashes in set2.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This almost makes me want to just use sed instead. But quoting that line
> noise would probably make it less readable.

I get the following error on t6002-rev-list-bisect.sh:

*   ok 31: bisection diff --bisect u3 ^U <= 0
*   ok 32: bisection diff --bisect u4 ^U <= 0
*   ok 33: bisection diff --bisect u5 ^U <= 0
tr: unrecognized option `------------------------------'
Try `tr --help' for more information.
* FAIL 34: --bisect l5 ^root
        check_output  "git rev-list $_bisect_option l5 ^root"
tr: unrecognized option `------------------------------'
Try `tr --help' for more information.
* FAIL 35: --bisect l5 ^root ^c3
...


This is tr version 5.2.1.

This patch fixes things. If the dashdash notation is not portable, then
backslashing each dash also works. i.e. '\-\-\-\-.. etc. but as you
mentioned something like that is less readable, but possibly not as bad
as a sed version.

-brandon


 t/t6000lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6000lib.sh b/t/t6000lib.sh
index b69f7c4..aac6a31 100755
--- a/t/t6000lib.sh
+++ b/t/t6000lib.sh
@@ -98,7 +98,7 @@ check_output()
 name_from_description()
 {
         tr "'" '-' |
-		tr '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' \
+		tr -- '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' \
 		   '------------------------------' |
 		tr -s '-' | tr '[A-Z]' '[a-z]' | sed "s/^-*//;s/-*\$//"
 }
-- 
1.5.4.4.481.g5075
