From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Move evaluate_gitweb_config out of run_request
Date: Mon, 05 Jul 2010 20:52:43 +0200
Message-ID: <20100705185136.30020.97751.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 20:53:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVqnE-0001wR-T3
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 20:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab0GESxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 14:53:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60603 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab0GESxT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 14:53:19 -0400
Received: by wyf23 with SMTP id 23so2535760wyf.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=QV6vAAT1PuZSW02SgEkykTjoorMpH++mpeiyZwbqPMM=;
        b=OF0EnGsMDNqxjlNn+0Q39qiKyVWbFPmJC5lm4An2M46eArWljk+E66rqVQlThOsk5g
         pt8hSeGsU8TydOIvlJLMhwSwGxhKjaZGxu/XiHfaJ6V+gFi9ayELRlclpxuN7rkDRUFu
         3IfNz0w7w3nyMOfmHligN+iud8CRcttjScSKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=ltBopn7cSnF9GlNTyUQHk8GB2fBJZfy5662VOgtz+egttFnpsojvw2KU0J0lNIbdl0
         9YcAfbkUID0Xx/vkv2HHVjtSrQU8yZXW21siJ7ByNx3K6l2QUiEAMzNw58m05C2ElRft
         SLq0nOV8tJt4mAQ0AZ0RQbCY9v4beNId+8xVE=
Received: by 10.227.133.81 with SMTP id e17mr3683687wbt.73.1278355998495;
        Mon, 05 Jul 2010 11:53:18 -0700 (PDT)
Received: from localhost.localdomain (abvy158.neoplus.adsl.tpnet.pl [83.8.222.158])
        by mx.google.com with ESMTPS id p29sm34252575wbc.1.2010.07.05.11.53.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Jul 2010 11:53:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o65IqiEd030060
	for <git@vger.kernel.org>; Mon, 5 Jul 2010 20:52:56 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150286>

Move evaluate_gitweb_config() and evaluate_git_version() out of
run_request() to run(), making them not run one for each request.  
This changes how git behaves in FastCGI case.

This change makes it impossible to have config which changes with
request, but I don't think anyone relied on such (hidden action)
behavior.

While at it, reset timer and number of git commands at beginning of
run_request() in new reset_timer() subroutine.  This fixes case when
gitweb was run using FastCGI interface: time is reported for request,
and not for single run of gitweb script.  This changes slightly
behavior in non-FastCGI case: the number of git commands reported is
1 less (running `git --version` one per gitweb is not counted now).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It joins bugfix (for FastCGI case) with improvements (probably better
performance for FastCGI case)

 gitweb/gitweb.perl |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9446376..1f611d2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1027,18 +1027,18 @@ sub dispatch {
 	$actions{$action}->();
 }
 
-sub run_request {
+sub reset_timer {
 	our $t0 = [Time::HiRes::gettimeofday()]
 		if defined $t0;
+	our $number_of_git_cmds = 0;
+}
+
+sub run_request {
+	reset_timer();
 
 	evaluate_uri();
-	evaluate_gitweb_config();
-	evaluate_git_version();
 	check_loadavg();
 
-	# $projectroot and $projects_list might be set in gitweb config file
-	$projects_list ||= $projectroot;
-
 	evaluate_query_params();
 	evaluate_path_info();
 	evaluate_and_validate_params();
@@ -1086,6 +1086,11 @@ sub evaluate_argv {
 
 sub run {
 	evaluate_argv();
+	evaluate_gitweb_config();
+	evaluate_git_version();
+
+	# $projectroot and $projects_list might be set in gitweb config file
+	$projects_list ||= $projectroot;
 
 	$pre_listen_hook->()
 		if $pre_listen_hook;
