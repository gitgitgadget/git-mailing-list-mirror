From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Route rest of action subroutines through %actions
Date: Tue, 22 Aug 2006 16:59:20 +0200
Message-ID: <200608221659.20655.jnareb@gmail.com>
References: <200608221651.19629.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 22 17:00:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFXjN-0006mJ-DQ
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 16:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWHVO7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 10:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWHVO7m
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 10:59:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:11134 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932288AbWHVO7i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 10:59:38 -0400
Received: by nf-out-0910.google.com with SMTP id o25so78030nfa
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 07:59:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ig+YLyoGKQSKKB9hakYdgoPDY8gPDbjf1KQRpuNGtsjRDuBiF0VRGvC6Uy95ED+NzsVR6uWaoO+nG5PwpMh+lzjecz3Yra/Hxb63lFKIJFwfEmwLu+zgAExYYdKGh8SjT5YLtnlrzjtOahLakJeF/i9Nz3t+8ey4QPI7wGKbgxw=
Received: by 10.48.48.15 with SMTP id v15mr564770nfv;
        Tue, 22 Aug 2006 07:59:37 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id o9sm639373nfa.2006.08.22.07.59.36;
        Tue, 22 Aug 2006 07:59:37 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608221651.19629.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25858>

Route rest of action subroutines, namely git_project_list and git_opml
(both of which doesn't need $project) through %actions hash.

This has disadvantage that all parameters are read and validated;
earlier git_opml was called as soon as $action was parsed and
validated, git_project_list was called as soon as $project was parsed
and validated.  This has advantage that all action dispatch is grouped
in one place.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is an alternative to (not accepted) patch by Martin Waitz from
in http://permalink.gmane.org/gmane.comp.version-control.git/25535
Message-Id: <11557673281583-git-send-email-tali@admingilde.org>

  gitweb: use action dispatcher for non-project actions, too.


 gitweb/gitweb.perl |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f59213e..e09204d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -155,11 +155,6 @@ if (defined $action) {
 	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
 		die_error(undef, "Invalid action parameter");
 	}
-	# action which does not check rest of parameters
-	if ($action eq "opml") {
-		git_opml();
-		exit;
-	}
 }
 
 our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
@@ -179,9 +174,6 @@ if (defined $project) {
 		die_error(undef, "No such project");
 	}
 	$ENV{'GIT_DIR'} = "$projectroot/$project";
-} else {
-	git_project_list();
-	exit;
 }
 
 our $file_name = $cgi->param('f');
@@ -255,9 +247,16 @@ my %actions = (
 	"tags" => \&git_tags,
 	"tree" => \&git_tree,
 	"snapshot" => \&git_snapshot,
+	# those below don't need $project
+	"opml" => \&git_opml,
+	"project_list" => \&git_project_list,
 );
 
-$action = 'summary' if (!defined($action));
+if (defined $project) {
+	$action ||= 'summary';
+} else {
+	$action ||= 'project_list';
+}
 if (!defined($actions{$action})) {
 	die_error(undef, "Unknown action");
 }
-- 
1.4.1.1
