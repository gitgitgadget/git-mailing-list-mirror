From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Git 1.7.6: Sparse checkouts do not work with directory exclusions
Date: Mon, 19 Sep 2011 16:03:34 -0600
Message-ID: <4E77BC36.7060005@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 00:02:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5lvS-00081s-HK
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 00:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686Ab1ISWCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 18:02:50 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:58972 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab1ISWCt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 18:02:49 -0400
Received: (qmail 8625 invoked by uid 399); 19 Sep 2011 16:02:44 -0600
Received: from unknown (HELO ?192.168.1.10?) (jjensen@workspacewhiz.com@50.8.110.77)
  by hsmail.qwknetllc.com with ESMTPAM; 19 Sep 2011 16:02:44 -0600
X-Originating-IP: 50.8.110.77
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181712>

Sometime after Git 1.7.3.2, sparse checkouts stopped working for me.  My 
sparse-checkout file looks something like:

*
!DirA/
!DirB/
DirC/

I have restored some lines of code that were removed in November 2010.  
This resolves the sparse checkout issue for me, but my guess is the 
solution is not implemented properly.

Can anyone confirm the issue and describe why those lines were removed?

Thanks.

Josh

---
  dir.c |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 6e4494e..3f057b6 100644
--- a/dir.c
+++ b/dir.c
@@ -507,7 +507,10 @@ int excluded_from_list(const char *pathname,
              int to_exclude = x->to_exclude;

              if (x->flags & EXC_FLAG_MUSTBEDIR) {
-                if (*dtype == DT_UNKNOWN)
+                if (!prefixcmp(pathname, exclude) &&
+                    pathname[x->patternlen] == '/')
+                    return to_exclude;
+                else if (*dtype == DT_UNKNOWN)
                      *dtype = get_dtype(NULL, pathname, pathlen);
                  if (*dtype != DT_DIR)
                      continue;
-- 
1.7.6.msysgit.1
