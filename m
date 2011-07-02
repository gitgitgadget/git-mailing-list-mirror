From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH] git svn : hook before 'git svn dcommit'
Date: Sat, 02 Jul 2011 14:48:03 +0200
Message-ID: <4E0F1383.8080804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 02 14:48:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QczcP-00017g-MR
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 14:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab1GBMsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 08:48:13 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:45607 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab1GBMsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 08:48:12 -0400
Received: by fxd18 with SMTP id 18so3961551fxd.11
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=LKx9uF0cCGyTezeTRAlQmmuKLWZyYoi3BG7ruIQBXlw=;
        b=bk4aFH72p9i1iZ9t/oiSZLBl5+lDNll0onxFHSg90J7Sm1XIsbbNhbMlpasTH5MVU4
         5biPxcbEy5Y7t2tN6KvxH6NsjKum14HgGW8QjGGswa7Ed+H+MN/B6YbyT6f0iYhGAVSH
         y1AAnFcwfsEOAnpk5VeZLCRhKKp6+fBGyJxho=
Received: by 10.223.24.134 with SMTP id v6mr6422359fab.146.1309610890903;
        Sat, 02 Jul 2011 05:48:10 -0700 (PDT)
Received: from [192.168.0.10] (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id o23sm3059579faa.33.2011.07.02.05.48.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Jul 2011 05:48:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176558>

The 'pre-svn-dcommit' hook si called before 'git svn dcommit', which aborts
if return value is not zero.
---
  git-svn.perl |   19 +++++++++++++++++++
  1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 89f83fd..e70afae 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -396,6 +396,23 @@ sub init_subdir {
         $_repository = Git->repository(Repository => $ENV{GIT_DIR});
  }

+sub pre_svn_dcommit_hook {
+       my $hook = "$ENV{GIT_DIR}/hooks/pre-svn-dcommit";
+       return 0 if ! -e $hook || ! -x $hook;
+
+       system($hook);
+       if ($? == -1) {
+               print "[pre_svn_dcommit_hook] failed to execute $hook: 
$!\n";
+               return 1;
+       } elsif ($? & 127) {
+               printf "[pre_svn_dcommit_hook] child died with signal 
%d, %s coredump\n",
+               ($? & 127),  ($? & 128) ? 'with' : 'without';
+               return 1;
+       } else {
+               return $? >> 8;
+       }
+}
+
  sub cmd_clone {
         my ($url, $path) = @_;
         if (!defined $path &&
@@ -518,6 +535,8 @@ sub cmd_dcommit {
                 command(['checkout', $head], STDERR => 0);
         }

+       return if pre_svn_dcommit_hook();
+
         my @refs;
         my ($url, $rev, $uuid, $gs) = working_head_info('HEAD', \@refs);
         unless ($gs) {
-- 
