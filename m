From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Use config file for repository description and URLs
Date: Sat,  3 Nov 2007 00:41:20 +0100
Message-ID: <1194046880-29941-4-git-send-email-jnareb@gmail.com>
References: <1194046880-29941-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 00:39:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io66y-000709-2u
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 00:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbXKBXiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 19:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755391AbXKBXiw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 19:38:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:23981 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399AbXKBXis (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 19:38:48 -0400
Received: by ug-out-1314.google.com with SMTP id z38so694636ugc
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BZx66ikIiVdlSFfMRL9XOB6KWuKGFyFt9FETYiQLiMc=;
        b=rfXtwizKq4Aod3aTTVOTwG+4S1DU6YXYjVNDd+KkVttjjkZ508i8lP6qgWCd+qoZuok495fOvDJ4LQsQP0ot2i42+IrS7aDvnlndCoeohXcdWU2PKy/lpVWOhGxvTHSjKk9a1HPb3LYHFsOT7GzJQGreZxGEg21BjnCrzDNDej8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lRFLLIjUqQT8hGGNC5iKNNUISlUccvzyRWprZVNlbVOtAAObmQwjoHUFRsBkNWyE6rMkpaCfoiJujdlHYu1R5kg3R5S9GYsHOVip9LgloODkG22LGHkQsL8Re/ySRn5YV6igrihssJqc5Dy/YD35uSEYLKIiHX3KqKr0eRuvHJk=
Received: by 10.66.249.11 with SMTP id w11mr227201ugh.1194046726914;
        Fri, 02 Nov 2007 16:38:46 -0700 (PDT)
Received: from roke.D-201 ( [83.8.198.10])
        by mx.google.com with ESMTPS id 32sm9206025ugf.2007.11.02.16.38.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Nov 2007 16:38:45 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA2NfNMR029968;
	Sat, 3 Nov 2007 00:41:23 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA2NfNgi029967;
	Sat, 3 Nov 2007 00:41:23 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1194046880-29941-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63190>

Allow to use configuration variable gitweb.description for repository
description if there is no $GIT_DIR/description file, and multivalued
configuration variable gitweb.url for URLs of a project (to clone or
fetch from) if there is no $GIT_DIR/cloneurl file.

While repository description is shown in the projects list page, so it
is better to use file and not config variable for performance, it is I
think better to use gitweb.url for URLs (as it is shown only on
project summary page).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl                     |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f54455b..7cac629 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1606,7 +1606,9 @@ sub git_get_path_by_hash {
 sub git_get_project_description {
 	my $path = shift;
 
-	open my $fd, "$projectroot/$path/description" or return undef;
+	$git_dir = "$projectroot/$path";
+	open my $fd, "$projectroot/$path/description"
+		or return git_get_project_config('description');
 	my $descr = <$fd>;
 	close $fd;
 	if (defined $descr) {
@@ -1618,7 +1620,11 @@ sub git_get_project_description {
 sub git_get_project_url_list {
 	my $path = shift;
 
-	open my $fd, "$projectroot/$path/cloneurl" or return;
+	$git_dir = "$projectroot/$path";
+	open my $fd, "$projectroot/$path/cloneurl"
+		or return wantarray ?
+		@{ config_to_multi(git_get_project_config('url')) } :
+		   config_to_multi(git_get_project_config('url'));
 	my @git_project_url_list = map { chomp; $_ } <$fd>;
 	close $fd;
 
-- 
1.5.3.5
