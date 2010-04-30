From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Silence 'Variable VAR may be unavailable' warnings
Date: Fri, 30 Apr 2010 18:30:31 +0200
Message-ID: <20100430162934.11548.7015.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 21:04:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7vW3-0004r3-Iz
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702Ab0D3TEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:04:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37304 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758256Ab0D3RBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 13:01:19 -0400
Received: by fxm10 with SMTP id 10so400465fxm.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=UQCIdWlyRPyWLjuCn3Bm45KvNSmvC+HSz0MGm6Kn/aw=;
        b=GjchHKJbvG1s6hF6DXB7Bo+Z0IoDyoC6QbtRM/6tUoXf0CUMrIHhkFgfg3Ko+dykOS
         ij0QB1aII3QaNGzxR7ePx9PFQC73OV1hDhnMlPaQQ1O+g+/k+6skR6nhd9+Bv8p2zDNu
         9XmhW/WNh84kHFFUm6W7t4giEAT3Tb5ZORwkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=gSxthNvSNYmZzCosBXuwX6Z3igmX/dFh66QojIjbqhBjhHfbFA/4t4nW78pKVKEAlg
         9xsVsRFMAw0oFwlWEinYnP/0I3aPJaNPBZYSoL61ODheoCuDOL0J55+oBQ0VQTMHO192
         FFOhlv+6rxUIjOo66V+Rf/VMdX7cT3mnE9KkQ=
Received: by 10.102.16.14 with SMTP id 14mr6403807mup.136.1272645059325;
        Fri, 30 Apr 2010 09:30:59 -0700 (PDT)
Received: from localhost.localdomain (abvb223.neoplus.adsl.tpnet.pl [83.8.199.223])
        by mx.google.com with ESMTPS id y2sm9711553mug.51.2010.04.30.09.30.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Apr 2010 09:30:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3UGUVOl011590;
	Fri, 30 Apr 2010 18:30:41 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146046>

When $projects_list points to a directory, and git_get_projects_list
scans this directory for repositories, there can be generated the
following warnings (for persistent services like mod_perl or plackup):

  Variable "$project_maxdepth" may be unavailable at gitweb.cgi line 2443.
  Variable "$projectroot" may be unavailable at gitweb.cgi line 2451.

Those are false positives; silence those warnings by explicitely
declaring $project_maxdepth and $projectroot with 'our', as global
variables, in anonymous subrotine passed to File::Find::find.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Those warnings do not appear when run as simple CGI script, so test
suite could not catch them.

 gitweb/gitweb.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7d9b660..d6cbfa9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2433,6 +2433,9 @@ sub git_get_projects_list {
 			follow_skip => 2, # ignore duplicates
 			dangling_symlinks => 0, # ignore dangling symlinks, silently
 			wanted => sub {
+				# global variables
+				our $project_maxdepth;
+				our $projectroot;
 				# skip project-list toplevel, if we get it.
 				return if (m!^[/.]$!);
 				# only directories can be git repositories
