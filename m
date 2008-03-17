From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Separate @projects population into git_get_projects_details()
Date: Mon, 17 Mar 2008 16:09:28 +0100
Message-ID: <1205766570-13550-2-git-send-email-jnareb@gmail.com>
References: <1205766570-13550-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, "J.H." <warthog19@eaglescrag.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 16:11:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbGym-00070S-Di
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 16:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbYCQPJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 11:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbYCQPJn
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 11:09:43 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:56819 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYCQPJm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 11:09:42 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1875076fkr.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=510Ts0+rpUR4qZqreS4vFK3W78SxgLiAIPskhWl7LsQ=;
        b=pTHQ6iWNXFKM4MBNcbUWzFGbl0RTWZ9oOQcI1xiQqzJQ4aTXOn32oWciv6enwQ4DLNXhy5YEfWIueWyloq/J+GS7mPhNAZ9t36qbZr2tdAy3u5ZYKMV0po8N4Mvkl+VYN11PoXJhQjAwBxnq2kpJJNkB27LGvIRnFmHvpO1lLcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TkQMQCTKzAuHga89COfnN6XJzrvyIJJo8I1GHWtbiFAfCevG1a33gyrKqMBUqe1Hg1ANMyM+lY/GnLhJV7hJ70LYaLYCOxN4GI2GvTMBAg/sdWT1NLwfUTykCttdYdg17fg+0b4vZMJtEJNujrXcd49D0fl5wI4idsYHLiAQJI4=
Received: by 10.78.100.1 with SMTP id x1mr42661952hub.47.1205766581081;
        Mon, 17 Mar 2008 08:09:41 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.232.138])
        by mx.google.com with ESMTPS id o11sm33429074fkf.9.2008.03.17.08.09.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Mar 2008 08:09:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2HF9ci8013574;
	Mon, 17 Mar 2008 16:09:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2HF9Yj0013573;
	Mon, 17 Mar 2008 16:09:34 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1205766570-13550-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77435>

From: Petr Baudis <pasky@suse.cz>

For clarity projects scanning and @projects population is separated to
git_get_projects_details().

This would be required if/when implementing in-gitweb caching of
projects list generation.

Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is first part of patch sent by Petr Baudis; one that could be
applied to have better, more clear code, even as we are rehashing on
_how_ to do caching in gitweb in general, and projects list caching in
particular.

Note: git_get_projects_details() does not do
  return wantarray ? @projects : \@projects
dance.

By the way; it could modify %$projlist directly, and return simply
$projlist.

 gitweb/gitweb.perl |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ec73cb1..90ab894 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3473,10 +3473,10 @@ sub git_patchset_body {
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
-sub git_project_list_body {
-	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
-
-	my ($check_forks) = gitweb_check_feature('forks');
+# fill age, description, owner, forks (last one only if $check_forks)
+# for all projects in $projlist reference; fill projects info
+sub git_get_projects_details {
+	my ($projlist, $check_forks) = @_;
 
 	my @projects;
 	foreach my $pr (@$projlist) {
@@ -3506,6 +3506,15 @@ sub git_project_list_body {
 		}
 		push @projects, $pr;
 	}
+	return @projects;
+}
+
+sub git_project_list_body {
+	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
+
+	my ($check_forks) = gitweb_check_feature('forks');
+
+	my @projects = git_get_projects_details($projlist, $check_forks);
 
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
-- 
1.5.4.3.453.gc1ad83
