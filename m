From: Tommi Kyntola <tommi.kyntola@ray.fi>
Subject: [PATCH] git-blame: prevent argument parsing segfault
Date: Fri, 16 Feb 2007 09:38:21 +0200
Message-ID: <45D55F6D.5090900@ray.fi>
Reply-To: tommi.kyntola@ray.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 08:46:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHxnu-000086-0g
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 08:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbXBPHqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 02:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXBPHqg
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 02:46:36 -0500
Received: from pontus.edelkey.net ([213.138.147.130]:47601 "EHLO
	pontus.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbXBPHqf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 02:46:35 -0500
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Feb 2007 02:46:35 EST
Received: from raysrv05.ray.fi (213138149030.edelkey.net [213.138.149.30])
	by pontus.edelkey.net (8.13.7/8.13.7) with ESMTP id l1G7cNZn020825
	for <git@vger.kernel.org>; Fri, 16 Feb 2007 09:38:23 +0200
Received: from ts.ray.fi ([192.56.100.161])
          by raysrv05.ray.fi (Lotus Domino Release 6.5.5 HF456)
          with ESMTP id 2007021609382207-45649 ;
          Fri, 16 Feb 2007 09:38:22 +0200 
Received: from [192.56.100.120] by ts.ray.fi (8.9.3+Sun/SMI-SVR4)
	id JAA16137; Fri, 16 Feb 2007 09:38:21 +0200 (EET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
X-MIMETrack: Itemize by SMTP Server on raysrv05/RAY(Release 6.5.5 HF456|May 19, 2006) at
 16.02.2007 09:38:22,
	Serialize by Router on raysrv05/RAY(Release 6.5.5 HF456|May 19, 2006) at
 16.02.2007 09:38:23,
	Serialize complete at 16.02.2007 09:38:23
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39899>


Description:
k@samael /localhome/k/git.git/git/gitweb % git-blame --incremental
zsh: segmentation fault  git blame --incremental

The 3rd branch in builtin-blame.c should also check for lacking
arguments. Running that in top dir avoids the problem because
the 'prefix' is NULL. The --incremental is no to blame here,
it only triggers the segfault and even without that flag it goes
checking argv too far.

I didn't check the pu branch, and I'm sorry if this is a dupe.

cheers,
Tommi "Kynde" Kyntola

diff --git a/builtin-blame.c b/builtin-blame.c
index 7a5665f..6d51b1f 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2211,6 +2211,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
                 }
                 else {
                         /* (3) */
+                       if (argc <= i)
+                               usage(blame_usage);
                         path = add_prefix(prefix, argv[i]);
                         if (i + 1 == argc - 1) {
                                 final_commit_name = argv[i + 1];
