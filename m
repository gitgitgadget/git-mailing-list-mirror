From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: don't use pathinfo for global actions
Date: Fri,  2 Jan 2009 12:34:40 +0100
Message-ID: <1230896080-22801-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Devin Doucette <devin@doucette.cc>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 13:11:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIis6-0000HB-TI
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 13:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436AbZABMJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 07:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757428AbZABMJt
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 07:09:49 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:45996 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384AbZABMJs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 07:09:48 -0500
Received: by mu-out-0910.google.com with SMTP id g7so2480939muf.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2009 04:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=k+lSkc3ihoEiMeq8Oi3GkBe5t2uBnqe8fySYTkJ9jGg=;
        b=I9McpBJvxkHrXhBgM7xi35QVpt1VOONTdgCs5zXEmu1fviFuwm+p8PwAjHjr1tzBAK
         NzjUlz/hxDG+oLsDTpBdr6UIjRh7tvSOw5QLxjVm5UxTkWnAmFO/nHZp9+3JoHTyUK+3
         1EEFaVQfV5Js3gM7ATpLyxz1bC2MvS/Y+VlE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qCck9k8MYeesVE/KVZwQy53uirWquBpzYA+o/DOBYgQGVFNZ4Q/0tLThOi1j2dnLTP
         OXb4/aiFA9D6qMNC/LxR/voSA0dIFWYWkTLyGfSYhdBU32zdgp/ohbDCX1SVECUlJj5s
         Lc9096qdICVab7SCpxIEnG2ybNG/XXbBUEqPI=
Received: by 10.103.182.3 with SMTP id j3mr6331170mup.113.1230898185504;
        Fri, 02 Jan 2009 04:09:45 -0800 (PST)
Received: from localhost ([78.15.6.169])
        by mx.google.com with ESMTPS id 7sm26894497mup.10.2009.01.02.04.09.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jan 2009 04:09:45 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104375>

With PATH_INFO urls, actions for the projects list (e.g. opml,
project_index) were being put in the URL right after the base. The
resulting URL is not properly parsed by gitweb itself, since it expects
a project name as first component of the URL.

Accepting global actions in use_pathinfo is not a very robust solution
due to possible present and future conflicts between project names and
global actions, therefore we just refuse to create PATH_INFO URLs when
the project is not defined.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 99f71b4..fa7d8ad 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -830,7 +830,7 @@ sub href (%) {
 	}
 
 	my $use_pathinfo = gitweb_check_feature('pathinfo');
-	if ($use_pathinfo) {
+	if ($use_pathinfo and defined $params{'project'}) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action
@@ -845,7 +845,7 @@ sub href (%) {
 		$href =~ s,/$,,;
 
 		# Then add the project name, if present
-		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
+		$href .= "/".esc_url($params{'project'});
 		delete $params{'project'};
 
 		# since we destructively absorb parameters, we keep this
-- 
1.5.6.5
