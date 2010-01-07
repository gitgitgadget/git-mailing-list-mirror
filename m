From: Mike Mueller <mmueller@vigilantsw.com>
Subject: [PATCH] Fix segfault in fast-export
Date: Wed, 6 Jan 2010 22:58:39 -0500
Message-ID: <20100107035839.GM8510@samus.subfocal.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 05:07:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSjeR-0003EO-Sb
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 05:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab0AGEHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 23:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756603Ab0AGEHB
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 23:07:01 -0500
Received: from eastrmmtai108.cox.net ([68.230.240.27]:61928 "EHLO
	eastrmmtai108.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451Ab0AGEHB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 23:07:01 -0500
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2010 23:07:01 EST
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao102.cox.net
          (InterMail vM.8.00.01.00 201-2244-105-20090324) with ESMTP
          id <20100107035840.MCZA13474.eastrmmtao102.cox.net@eastrmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 6 Jan 2010 22:58:40 -0500
Received: from samus ([24.250.30.14])
	by eastrmimpo01.cox.net with bizsmtp
	id STyf1d0050JGoeo02TyfDj; Wed, 06 Jan 2010 22:58:40 -0500
X-VR-Score: -30.00
X-Authority-Analysis: v=1.1 cv=Q0/QIhtFGXcPwKBXdiAKH6RPO1IrUZ7nWfC2VwHFyto=
 c=1 sm=1 a=PToGNBblRHN+nk2D3BzZVA==:17 a=o2MKldYCAAAA:8
 a=MVgZfn3ZttOjugmBJaoA:9 a=IzfDIUsEriM-X2ztfisZOUUgoRMA:4 a=3-SzZg5x5EcA:10
 a=o2kGL_zzVWo3YwyQuhIA:9 a=7eX9pHYSqGrGDdi8iLr8MQCrcrMA:4
 a=PToGNBblRHN+nk2D3BzZVA==:117
X-CM-Score: 0.00
Received: by samus (sSMTP sendmail emulation); Wed, 06 Jan 2010 22:58:39 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136322>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I'm working on a C++ static analyzer (Vigilant Sentry), and git
is one of my test subjects.  In git-1.6.6, I found a crash in the
fast-export command:

The problem is in builtin-fast-export.c, function export_marks:

    f = fopen(file, "w");
    if (!f)
        error("Unable to open marks file %s for writing.", file);
   
    for (i = 0; i < idnums.size; i++) {
        if (deco->base && deco->base->type == 1) {
            mark = ptr_to_mark(deco->decoration);
            if (fprintf(f, ":%"PRIu32" %s\n", mark,
                sha1_to_hex(deco->base->sha1)) < 0) {
                e = 1;
                break;
            }
        }
        deco++;
    }
   
    e |= ferror(f);
    e |= fclose(f);

If fopen() fails, the error message is printed, but the function
doesn't exit.  The subsequent calls to fprintf and/or ferror will
fail because f is NULL.  A simple way to reproduce is to export
to a path you don't have write access to:
   
    $ git fast-export --export-marks=/foo
    error: Unable to open marks file /foo for writing.
    Segmentation fault (core dumped)

I've attached a trivial patch that calls die_errno instead of
error, so the program exits if f is NULL.

Regards,
Mike

-- 
Mike Mueller
mmueller@vigilantsw.com

http://www.vigilantsw.com/

--zYM0uCDKw75PZbzx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="git-fast-export.patch"

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index b0a4029..963e89b 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -503,7 +503,7 @@ static void export_marks(char *file)
 
 	f = fopen(file, "w");
 	if (!f)
-		error("Unable to open marks file %s for writing.", file);
+		die_errno("Unable to open marks file %s for writing", file);
 
 	for (i = 0; i < idnums.size; i++) {
 		if (deco->base && deco->base->type == 1) {

--zYM0uCDKw75PZbzx--
