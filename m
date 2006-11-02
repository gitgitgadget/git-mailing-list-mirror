X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: [PATCH] sanitize --abbrev option for describe
Date: Thu, 02 Nov 2006 02:15:30 +0100
Message-ID: <eibgqu$rsh$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050209050802000609000207"
NNTP-Posting-Date: Thu, 2 Nov 2006 01:15:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 61
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30678>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfRBB-0007Q2-Mw for gcvg-git@gmane.org; Thu, 02 Nov
 2006 02:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423093AbWKBBPe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 20:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423096AbWKBBPe
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 20:15:34 -0500
Received: from main.gmane.org ([80.91.229.2]:29928 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423093AbWKBBPe (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 20:15:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfRAz-0007OJ-BD for git@vger.kernel.org; Thu, 02 Nov 2006 02:15:25 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 02 Nov 2006 02:15:25 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 02 Nov 2006 02:15:25
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------050209050802000609000207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

the --abbrev option doesn't allow a 40 digit SHA1 output.

The following patch fixes this, and uses a IMHO more logical way to 
compute the abbrev parameter, so --abbrev=52 will still yield a 40 digit 
SHA1.


-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

--------------050209050802000609000207
Content-Type: text/plain;
 name="ps"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ps"

commit 62ab49fb3a050cb2a4c96fa0ab8064742544369b
Author: Han-Wen Nienhuys <hanwen@lilypond.org>
Date:   Thu Nov 2 02:12:11 2006 +0100

    use constant variable for storing "--abbrev=".  Use 40 and
    MINIMUM_ABBREV as bounds for --abbrev= argument.

diff --git a/describe.c b/describe.c
index ab192f8..973520c 100644
--- a/describe.c
+++ b/describe.c
@@ -141,6 +141,7 @@ static void describe(const char *arg, in
 
 int main(int argc, char **argv)
 {
+	char const *abbrev_option = "--abbrev=";
 	int i;
 
 	for (i = 1; i < argc; i++) {
@@ -152,10 +153,10 @@ int main(int argc, char **argv)
 			all = 1;
 		else if (!strcmp(arg, "--tags"))
 			tags = 1;
-		else if (!strncmp(arg, "--abbrev=", 9)) {
-			abbrev = strtoul(arg + 9, NULL, 10);
-			if (abbrev < MINIMUM_ABBREV || 40 < abbrev)
-				abbrev = DEFAULT_ABBREV;
+		else if (!strncmp(arg, abbrev_option, strlen (abbrev_option))) {
+			abbrev = strtoul(arg + strlen (abbrev_option), NULL, 10);
+			abbrev = MAX(MINIMUM_ABBREV, abbrev);
+			abbrev = MIN(40, abbrev);
 		}
 		else
 			usage(describe_usage);

--------------050209050802000609000207--
