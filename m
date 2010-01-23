From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/2] git-svn: allow UUID to be manually remapped via rewriteUUID
Date: Sat, 23 Jan 2010 03:30:00 -0500
Message-ID: <1264235401-44051-2-git-send-email-jaysoffian@gmail.com>
References: <1264235401-44051-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 09:30:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYbOC-00057F-0w
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 09:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab0AWIae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 03:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526Ab0AWIae
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 03:30:34 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:52726 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab0AWIad (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 03:30:33 -0500
Received: by yxe17 with SMTP id 17so1663755yxe.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 00:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2GQ7v7PatwRZ0nYGnVxAY6lD7UVDKJknqnPoiKC2M90=;
        b=cSp0hgsT4SmzAyJLlcytPbKpOfF5o0UBp9A7YvzC8T+oBGLgF0h+KgzJRqVT4HfZsu
         1PPtwNhkuqjh8NOs8j7McgxWhdFdfH5yV/8ViAmMzyPcu+7eBUETD10iDcPH0rnKV2aA
         Ndl7sQ7cPSEI0uFZHxiCt+Fj09Jc5CD1GhGU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G5NTzSMFPGrnPIGBQt2Q16JrMe14LE+gW+qn6cXnlEY6QVAX66Pocvksm+wlnRcUWL
         yJZ4jMlWTwrUVFgiYnDdSGNxZd6rYTW7puHJn8oshL7Ox7tnNz44Cw4AtjSjaAGckmvj
         6w4mcZCu9T7WYxpIm/D3B/EKpeyLX7WDDKAdU=
Received: by 10.101.141.4 with SMTP id t4mr5183935ann.137.1264235432381;
        Sat, 23 Jan 2010 00:30:32 -0800 (PST)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id 16sm1755017gxk.3.2010.01.23.00.30.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 00:30:31 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.515.g288caf
In-Reply-To: <1264235401-44051-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137815>

In certain situations it may be necessary to manually remap an svn
repostitory UUID. For example:

                  o--- [git-svn clone]
                 /
[origin svn repo]
                 \
                  o--- [svnsync clone]

Imagine that only "git-svn clone" and "svnsync clone" are made available
to external users. Furthur, "git-svn clone" contains only trunk, and for
reasons unknown, "svnsync clone" is missing the revision properties that
normally provide the origin svn repo's UUID.

A git user who has cloned the "git-svn clone" repo now wishes to use
git-svn to pull in the missing branches from the "synsync clone" repo.
In order for git-svn to get the history correct for those branches,
it needs to know the origin svn repo's UUID. Hence rewriteUUID.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-svn.txt       |   15 ++++++--
 git-svn.perl                    |   33 ++++++++++++++---
 t/t9153-git-svn-rewrite-uuid.sh |   25 +++++++++++++
 t/t9153/svn.dump                |   75 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+), 8 deletions(-)
 create mode 100755 t/t9153-git-svn-rewrite-uuid.sh
 create mode 100644 t/t9153/svn.dump

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4cdca0d..98fe439 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -62,6 +62,8 @@ COMMANDS
 	Set the 'useSvnsyncProps' option in the [svn-remote] config.
 --rewrite-root=<URL>;;
 	Set the 'rewriteRoot' option in the [svn-remote] config.
+--rewrite-uuid=<UUID>;;
+	Set the 'rewriteUUID' option in the [svn-remote] config.
 --username=<USER>;;
 	For transports that SVN handles authentication for (http,
 	https, and plain svn), specify the username.  For other
@@ -616,6 +618,12 @@ svn-remote.<name>.rewriteRoot::
 	the repository with a public http:// or svn:// URL in the
 	metadata so users of it will see the public URL.
 
+svn-remote.<name>.rewriteUUID::
+	Similar to the useSvmProps option; this is for users who need
+	to remap the UUID manually. This may be useful in situations
+	where the original UUID is not available via either useSvmProps
+	or useSvnsyncProps.
+
 svn.brokenSymlinkWorkaround::
 	This disables potentially expensive checks to workaround
 	broken symlinks checked into SVN by broken clients.  Set this
@@ -625,13 +633,14 @@ svn.brokenSymlinkWorkaround::
 	revision fetched.  If unset, 'git svn' assumes this option to
 	be "true".
 
-Since the noMetadata, rewriteRoot, useSvnsyncProps and useSvmProps
+Since the noMetadata, rewriteRoot, rewriteUUID, useSvnsyncProps and useSvmProps
 options all affect the metadata generated and used by 'git svn'; they
 *must* be set in the configuration file before any history is imported
 and these settings should never be changed once they are set.
 
-Additionally, only one of these four options can be used per-svn-remote
-section because they affect the 'git-svn-id:' metadata line.
+Additionally, only one of these options can be used per svn-remote
+section because they affect the 'git-svn-id:' metadata line, except
+for rewriteRoot and rewriteUUID which can be used together.
 
 
 BASIC EXAMPLES
diff --git a/git-svn.perl b/git-svn.perl
index 650c9e5..1fab210 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -115,6 +115,7 @@ my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
 		  'use-svm-props' => sub { $icv{useSvmProps} = 1 },
 		  'use-svnsync-props' => sub { $icv{useSvnsyncProps} = 1 },
 		  'rewrite-root=s' => sub { $icv{rewriteRoot} = $_[1] },
+		  'rewrite-uuid=s' => sub { $icv{rewriteUUID} = $_[1] },
                   %remote_opts );
 my %cmt_opts = ( 'edit|e' => \$_edit,
 		'rmdir' => \$SVN::Git::Editor::_rmdir,
@@ -2189,6 +2190,10 @@ sub svnsync {
 		die "Can't have both 'useSvnsyncProps' and 'rewriteRoot' ",
 		    "options set!\n";
 	}
+	if ($self->rewrite_uuid) {
+		die "Can't have both 'useSvnsyncProps' and 'rewriteUUID' ",
+		    "options set!\n";
+	}
 
 	my $svnsync;
 	# see if we have it in our config, first:
@@ -2470,6 +2475,20 @@ sub rewrite_root {
 	$self->{-rewrite_root} = $rwr;
 }
 
+sub rewrite_uuid {
+	my ($self) = @_;
+	return $self->{-rewrite_uuid} if exists $self->{-rewrite_uuid};
+	my $k = "svn-remote.$self->{repo_id}.rewriteUUID";
+	my $rwid = eval { command_oneline(qw/config --get/, $k) };
+	if ($rwid) {
+		$rwid =~ s#/+$##;
+		if ($rwid !~ m#^[a-f0-9]{8}-(?:[a-f0-9]{4}-){3}[a-f0-9]{12}$#) {
+			die "$rwid is not a valid UUID (key: $k)\n";
+		}
+	}
+	$self->{-rewrite_uuid} = $rwid;
+}
+
 sub metadata_url {
 	my ($self) = @_;
 	($self->rewrite_root || $self->{url}) .
@@ -3253,6 +3272,10 @@ sub make_log_entry {
 			die "Can't have both 'useSvmProps' and 'rewriteRoot' ",
 			    "options set!\n";
 		}
+		if ($self->rewrite_uuid) {
+			die "Can't have both 'useSvmProps' and 'rewriteUUID' ",
+			    "options set!\n";
+		}
 		my ($uuid, $r) = $headrev =~ m{^([a-f\d\-]{30,}):(\d+)$}i;
 		# we don't want "SVM: initializing mirror for junk" ...
 		return undef if $r == 0;
@@ -3283,10 +3306,10 @@ sub make_log_entry {
 	} else {
 		my $url = $self->metadata_url;
 		remove_username($url);
-		$log_entry{metadata} = "$url\@$rev " .
-		                       $self->ra->get_uuid;
-		$email ||= "$author\@" . $self->ra->get_uuid;
-		$commit_email ||= "$author\@" . $self->ra->get_uuid;
+		my $uuid = $self->rewrite_uuid || $self->ra->get_uuid;
+		$log_entry{metadata} = "$url\@$rev " . $uuid;
+		$email ||= "$author\@" . $uuid;
+		$commit_email ||= "$author\@" . $uuid;
 	}
 	$log_entry{name} = $name;
 	$log_entry{email} = $email;
@@ -3368,7 +3391,7 @@ sub rebuild {
 				'--');
 	my $metadata_url = $self->metadata_url;
 	remove_username($metadata_url);
-	my $svn_uuid = $self->ra_uuid;
+	my $svn_uuid = $self->rewrite_uuid || $self->ra_uuid;
 	my $c;
 	while (<$log>) {
 		if ( m{^commit ($::sha1)$} ) {
diff --git a/t/t9153-git-svn-rewrite-uuid.sh b/t/t9153-git-svn-rewrite-uuid.sh
new file mode 100755
index 0000000..88a2cfa
--- /dev/null
+++ b/t/t9153-git-svn-rewrite-uuid.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jay Soffian
+#
+
+test_description='git svn --rewrite-uuid test'
+
+. ./lib-git-svn.sh
+
+uuid=6cc8ada4-5932-4b4a-8242-3534ed8a3232
+
+test_expect_success 'load svn repo' "
+	svnadmin load -q '$rawsvnrepo' < '$TEST_DIRECTORY/t9153/svn.dump' &&
+	git svn init --minimize-url --rewrite-uuid='$uuid' '$svnrepo' &&
+	git svn fetch
+	"
+
+test_expect_success 'verify uuid' "
+	git cat-file commit refs/remotes/git-svn~0 | \
+	   grep '^${git_svn_id}: .*@2 $uuid$' &&
+	git cat-file commit refs/remotes/git-svn~1 | \
+	   grep '^${git_svn_id}: .*@1 $uuid$'
+	"
+
+test_done
diff --git a/t/t9153/svn.dump b/t/t9153/svn.dump
new file mode 100644
index 0000000..0ddfe70
--- /dev/null
+++ b/t/t9153/svn.dump
@@ -0,0 +1,75 @@
+SVN-fs-dump-format-version: 2
+
+UUID: b4885626-c94f-4a6c-b179-00c030fc68e8
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2010-01-23T06:41:03.908576Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 109
+Content-length: 109
+
+K 7
+svn:log
+V 11
+initial foo
+K 10
+svn:author
+V 3
+jay
+K 8
+svn:date
+V 27
+2010-01-23T06:41:48.353776Z
+PROPS-END
+
+Node-path: foo
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 4
+Text-content-md5: d3b07384d113edec49eaa6238ad5ff00
+Text-content-sha1: f1d2d2f924e986ac86fdf7b36c94bcdf32beec15
+Content-length: 14
+
+PROPS-END
+foo
+
+
+Revision-number: 2
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 12
+now with bar
+K 10
+svn:author
+V 3
+jay
+K 8
+svn:date
+V 27
+2010-01-23T06:42:14.214640Z
+PROPS-END
+
+Node-path: foo
+Node-kind: file
+Node-action: change
+Text-content-length: 8
+Text-content-md5: f47c75614087a8dd938ba4acff252494
+Text-content-sha1: 4e48e2c9a3d2ca8a708cb0cc545700544efb5021
+Content-length: 8
+
+foo
+bar
+
+
-- 
1.6.6.1.515.g288caf
