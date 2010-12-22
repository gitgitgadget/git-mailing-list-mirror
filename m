From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 3/9] gitweb: Introduce %actions_info,
	gathering information about actions
Date: Thu, 23 Dec 2010 00:55:52 +0100
Message-ID: <20101222235552.7998.76918.stgit@localhost.localdomain>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:56:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYY7-0007Q5-Ve
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab0LVX4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:56:35 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53074 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab0LVX4d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:56:33 -0500
Received: by fxm20 with SMTP id 20so6639191fxm.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=kmdSPpBumMPGgxFkxq1T9KuTrHN/UHQpfgyCRlPPJAA=;
        b=am9hTcVkvq0nhWeM9u6j0EsY9nGCr7bQhFM+NXGv2rv6vXmjzjppXB5+ghTSAO3shx
         vR6yO3vWXizmR2RP/gmxsVjeXB6hL3RPmU+8GjTwP/t2aqEn97NavCi1foo3/o8Zp+Kb
         ejpWto4Vh8xGN5+s7PUb+ouUFsykjfzVNXnoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=R4Yr5wI2lI0oZTYbvihy4alEfmG6nq48SdXxY78SYKH1+Dm9DFi581JgWEAwihAN63
         9rIdHmO0woCm9FdOHgtHgJ0QQuJXOGxaZg3pA4WM6sBAuO/tfRyMN2elgCBZ5MGJ3SNH
         1J2JUnWhTr/KDVOw0CXzQvmnTKNshJLj7S5s8=
Received: by 10.223.83.133 with SMTP id f5mr2007530fal.101.1293062191995;
        Wed, 22 Dec 2010 15:56:31 -0800 (PST)
Received: from localhost.localdomain (abvw91.neoplus.adsl.tpnet.pl [83.8.220.91])
        by mx.google.com with ESMTPS id a2sm1855918faw.46.2010.12.22.15.56.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 15:56:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBMNtq72008121;
	Thu, 23 Dec 2010 00:56:02 +0100
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164104>



Currently it only contains information about output format, and is not
used anywhere.  It will be used to check whether current action
produces HTML output, and therefore is displaying HTML-based progress
info about (re)generating cache makes sense.

It can contain information about allowed extra options, whether to
display link to feed (Atom or RSS), etc. in easier and faster way than
listing all matching or all non-matching actions at appropriate place.


Currently not used; will be used in next commit, to check if action
produces HTML output and therefore we can use HTML-specific progress
indicator.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/gitweb.perl |   57 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 53 insertions(+), 4 deletions(-)


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c7a1892..e50654b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -749,6 +749,54 @@ our %allowed_options = (
 	"--no-merges" => [ qw(rss atom log shortlog history) ],
 );
 
+# action => {
+# 	# what is the output format (content-type) of action
+# 	'output_format' => ('html' | 'text' | 'feed' | 'binary' | undef),
+# 	# does action require $project parameter to work
+# 	'needs_project' => (boolean | undef),
+# 	# log-like action, can start with arbitrary ref or revision
+# 	'log_like' => (boolean | undef),
+# 	# has no specific feed, or should lik to OPML / generic project feed
+# 	'no_feed' => (boolean | undef),
+# 	# allowed options to be passed ussing 'opt' parameter
+# 	'allowed_options' => { 'option_1' => 1 [, ... ] },
+# }
+our %actions_info = ();
+sub evaluate_actions_info {
+	our %actions_info;
+	our (%actions);
+
+	# unless explicitely stated otherwise, default output format is html
+	# most actions needs $project parameter
+	foreach my $action (keys %actions) {
+		$actions_info{$action}{'output_format'} = 'html';
+		$actions_info{$action}{'needs_project'} = 1;
+	}
+	# list all exceptions; undef means variable format (no definite format)
+	$actions_info{$_}{'output_format'} = 'text'
+		foreach qw(commitdiff_plain patch patches project_index blame_data);
+	$actions_info{$_}{'output_format'} = 'feed'
+		foreach qw(rss atom opml); # there are different types (document formats) of XML
+	$actions_info{$_}{'output_format'} = undef
+		foreach qw(blob_plain object);
+	$actions_info{'snapshot'}{'output_format'} = 'binary';
+
+	$actions_info{$_}{'needs_project'} = 0
+		foreach qw(opml project_list project_index);
+
+	$actions_info{$_}{'log_like'} = 1
+		foreach qw(log shortlog history);
+
+	$actions_info{$_}{'no_feed'} = 1
+		foreach qw(tags heads forks tag search);
+
+	foreach my $opt (keys %allowed_options) {
+		foreach my $act (@{$allowed_options{$opt}}) {
+			$actions_info{$act}{'allowed_options'}{$opt} = 1;
+		}
+	}
+}
+
 # fill %input_params with the CGI parameters. All values except for 'opt'
 # should be single values, but opt can be an array. We should probably
 # build an array of parameters that can be multi-valued, but since for the time
@@ -980,7 +1028,7 @@ sub evaluate_and_validate_params {
 		if (not exists $allowed_options{$opt}) {
 			die_error(400, "Invalid option parameter");
 		}
-		if (not grep(/^$action$/, @{$allowed_options{$opt}})) {
+		if (!$actions_info{$action}{'allowed_options'}{$opt}) {
 			die_error(400, "Invalid option parameter for this action");
 		}
 	}
@@ -1061,7 +1109,7 @@ sub dispatch {
 	if (!defined($actions{$action})) {
 		die_error(400, "Unknown action");
 	}
-	if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
+	if ($actions_info{$action}{'needs_project'} &&
 	    !$project) {
 		die_error(400, "Project needed");
 	}
@@ -1142,6 +1190,7 @@ sub evaluate_argv {
 
 sub run {
 	evaluate_argv();
+	evaluate_actions_info();
 
 	$first_request = 1;
 	$pre_listen_hook->()
@@ -1803,7 +1852,7 @@ sub format_ref_marker {
 
 			if ($indirect) {
 				$dest_action = "tag" unless $action eq "tag";
-			} elsif ($action =~ /^(history|(short)?log)$/) {
+			} elsif ($actions_info{$action}{'log_like'}) {
 				$dest_action = $action;
 			}
 
@@ -2277,7 +2326,7 @@ sub get_feed_info {
 	return unless (defined $project);
 	# some views should link to OPML, or to generic project feed,
 	# or don't have specific feed yet (so they should use generic)
-	return if ($action =~ /^(?:tags|heads|forks|tag|search)$/x);
+	return if ($actions_info{$action}{'no_feed'});
 
 	my $branch;
 	# branches refs uses 'refs/heads/' prefix (fullname) to differentiate
