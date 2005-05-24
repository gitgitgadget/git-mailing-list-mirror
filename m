From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 06:58:40 +0200
Message-ID: <20050524045840.GI12141@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org> <1116615600.12975.33.camel@dhcp-188> <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com> <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org> <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
X-From: git-owner@vger.kernel.org Tue May 24 06:57:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaRTm-0005RH-9N
	for gcvg-git@gmane.org; Tue, 24 May 2005 06:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVEXE6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 00:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVEXE6s
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 00:58:48 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:11970 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261257AbVEXE6m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 00:58:42 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4O4weS8022979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 24 May 2005 04:58:41 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4O4wego022978
	for git@vger.kernel.org; Tue, 24 May 2005 06:58:40 +0200 (CEST)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

> 	WARNING: Invalid PatchSet 775, Tag syslinux-2_12-pre7:
> 	    memdisk/init32.asm:1.3=after, memdisk/Makefile:1.26=before. Treated as 'before'
> 	WARNING: Invalid PatchSet 775, Tag syslinux-2_12-pre7:
> 	    memdisk/init32.asm:1.3=after, memdisk/e820test.c:1.7=before. Treated as 'before'
> 	...

actually I think this is the broken upstream version. It can't parse
dates right. Just look at the exported patches and see if them all from
1970. However the debian package has a patch in which solves it:

maybe you should try with the attached patch or with the version that
comes with debian sarge. I also reported this problem a while back to
the original author.

	Thomas

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cvsps_2.0rc1-5.diff"

--- cvsps-2.0rc1.orig/util.c
+++ cvsps-2.0rc1/util.c
@@ -13,6 +13,7 @@
 #include <time.h>
 #include <errno.h>
 #include <signal.h>
+#include <regex.h>
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/types.h>
@@ -140,24 +141,51 @@
     return *res;
 }
 
+static int get_int_substr(const char * str, const regmatch_t * p)
+{
+    char buff[256];
+    memcpy(buff, str + p->rm_so, p->rm_eo - p->rm_so);
+    buff[p->rm_eo - p->rm_so] = 0;
+    return atoi(buff);
+}
+
 void convert_date(time_t * t, const char * dte)
 {
-    /* HACK: this routine parses two formats,
-     * 1) 'cvslog' format YYYY/MM/DD HH:MM:SS
-     * 2) time_t formatted as %d
-     */
-       
-    if (strchr(dte, '/'))
+    static regex_t date_re;
+    static int init_re;
+
+#define MAX_MATCH 16
+    size_t nmatch = MAX_MATCH;
+    regmatch_t match[MAX_MATCH];
+
+    if (!init_re) 
+    {
+	if (regcomp(&date_re, "([0-9]{4})[-/]([0-9]{2})[-/]([0-9]{2}) ([0-9]{2}):([0-9]{2}):([0-9]{2})", REG_EXTENDED)) 
+	{
+	    fprintf(stderr, "FATAL: date regex compilation error\n");
+	    exit(1);
+	}
+	init_re = 1;
+    }
+    
+    if (regexec(&date_re, dte, nmatch, match, 0) == 0)
     {
+	regmatch_t * pm = match;
 	struct tm tm;
+
+	/* first regmatch_t is match location of entire re */
+	pm++;
 	
-	memset(&tm, 0, sizeof(tm));
-	sscanf(dte, "%d/%d/%d %d:%d:%d", 
-	       &tm.tm_year, &tm.tm_mon, &tm.tm_mday, 
-	       &tm.tm_hour, &tm.tm_min, &tm.tm_sec);
-	
+	tm.tm_year = get_int_substr(dte, pm++);
+	tm.tm_mon  = get_int_substr(dte, pm++);
+	tm.tm_mday = get_int_substr(dte, pm++);
+	tm.tm_hour = get_int_substr(dte, pm++);
+	tm.tm_min  = get_int_substr(dte, pm++);
+	tm.tm_sec  = get_int_substr(dte, pm++);
+
 	tm.tm_year -= 1900;
 	tm.tm_mon--;
+	tm.tm_isdst = 0;
 	
 	*t = mktime(&tm);
     }

--OXfL5xGRrasGEqWY--
