From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] svn: allow git-svn to update remotes outside of refs/remotes
Date: Mon,  3 Aug 2009 21:40:39 -0400
Message-ID: <1249350039-7338-4-git-send-email-adambrewster@gmail.com>
References: <1249350039-7338-1-git-send-email-adambrewster@gmail.com>
 <1249350039-7338-2-git-send-email-adambrewster@gmail.com>
 <1249350039-7338-3-git-send-email-adambrewster@gmail.com>
Cc: normalperson@yhbt.net, Adam Brewster <adambrewster@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 03:42:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY92N-0004K0-FB
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 03:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbZHDBlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 21:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754903AbZHDBly
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 21:41:54 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:44654 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbZHDBlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 21:41:50 -0400
Received: by qyk34 with SMTP id 34so3393572qyk.33
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=43iP+JvqD849M4sACunaOGNJ75/oUEIxp5H7XY0Jtvw=;
        b=aAivbX+X7crNyVOVEx3Pxfo4VGKuOG0PAm8OTPM4DnJb+aMbe1xYotH3yod0plnxnw
         05pvOfqrUb4JzM+zl/2Jod9UZiPPPuojufMfuUn13/d3xnTktWudiCPooAZCNIgg3jvM
         C4QYcOsY+AkVYm9R0ZlQGq3DSBCwTQDPRDPB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x+3AsvCdl5fhZMzu3/wecMyyiaVN5vNsIHGpDcH5ELpQiEALWhXCmi6JoAt4rIWfir
         n49OW4OioZ9bIsGFj70Lm8YGSq4qrW3PpCDjU8s54BsYsFBL5KGNTf/T9csBaTPOf0Dc
         6SMnZR/Bkn213eXOye8ZRGrskdbLVjPQtoFRM=
Received: by 10.224.60.139 with SMTP id p11mr5453330qah.38.1249350110861;
        Mon, 03 Aug 2009 18:41:50 -0700 (PDT)
Received: from MBE.internal (c-24-61-131-49.hsd1.nh.comcast.net [24.61.131.49])
        by mx.google.com with ESMTPS id 7sm14136701qwf.38.2009.08.03.18.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Aug 2009 18:41:49 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id BCB1521C828; Mon,  3 Aug 2009 21:40:39 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1249350039-7338-3-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124742>

It may be convenient for some users to store svn remote tracking
branches outside of the refs/remotes/ heirarchy.  [1] and [2] indicate
that there is interest in making this possible.

[1]  http://www.gitready.com/advanced/2009/02/16/convert-git-svn-tag-branches-to-real-tags.html
[2] http://kerneltrap.org/mailarchive/git/2007/8/30/256359
---
 git-svn.perl                     |   75 ++++++++++++++++++++------------------
 t/lib-git-svn.sh                 |    2 +-
 t/t9104-git-svn-follow-parent.sh |   10 +++---
 t/t9107-git-svn-migrate.sh       |   14 +++----
 4 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 51e3f92..4d7175b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -883,7 +883,7 @@ sub cmd_multi_init {
 	}
 	do_git_init_db();
 	if (defined $_trunk) {
-		my $trunk_ref = $_prefix . 'trunk';
+		my $trunk_ref = 'refs/remotes/' . $_prefix . 'trunk';
 		# try both old-style and new-style lookups:
 		my $gs_trunk = eval { Git::SVN->new($trunk_ref) };
 		unless ($gs_trunk) {
@@ -1590,23 +1590,23 @@ sub resolve_local_globs {
 	return unless defined $glob_spec;
 	my $ref = $glob_spec->{ref};
 	my $path = $glob_spec->{path};
-	foreach (command(qw#for-each-ref --format=%(refname) refs/remotes#)) {
-		next unless m#^refs/remotes/$ref->{regex}$#;
+	foreach (command(qw#for-each-ref --format=%(refname) refs/#)) {
+		next unless m#^$ref->{regex}$#;
 		my $p = $1;
 		my $pathname = desanitize_refname($path->full_path($p));
 		my $refname = desanitize_refname($ref->full_path($p));
 		if (my $existing = $fetch->{$pathname}) {
 			if ($existing ne $refname) {
 				die "Refspec conflict:\n",
-				    "existing: refs/remotes/$existing\n",
-				    " globbed: refs/remotes/$refname\n";
+				    "existing: $existing\n",
+				    " globbed: $refname\n";
 			}
-			my $u = (::cmt_metadata("refs/remotes/$refname"))[0];
+			my $u = (::cmt_metadata("$refname"))[0];
 			$u =~ s!^\Q$url\E(/|$)!! or die
-			  "refs/remotes/$refname: '$url' not found in '$u'\n";
+			  "$refname: '$url' not found in '$u'\n";
 			if ($pathname ne $u) {
 				warn "W: Refspec glob conflict ",
-				     "(ref: refs/remotes/$refname):\n",
+				     "(ref: $refname):\n",
 				     "expected path: $pathname\n",
 				     "    real path: $u\n",
 				     "Continuing ahead with $u\n";
@@ -1684,33 +1684,34 @@ sub read_all_remotes {
 	my $use_svm_props = eval { command_oneline(qw/config --bool
 	    svn.useSvmProps/) };
 	$use_svm_props = $use_svm_props eq 'true' if $use_svm_props;
+	my $svn_refspec = qr{\s*/?(.*?)\s*:\s*(.+?)\s*};
 	foreach (grep { s/^svn-remote\.// } command(qw/config -l/)) {
-		if (m!^(.+)\.fetch=\s*(.*)\s*:\s*(.+)\s*$!) {
-			my ($remote, $local_ref, $_remote_ref) = ($1, $2, $3);
-			die("svn-remote.$remote: remote ref '$_remote_ref' "
-			    . "must start with 'refs/remotes/'\n")
-				unless $_remote_ref =~ m{^refs/remotes/(.+)};
-			my $remote_ref = $1;
-			$local_ref =~ s{^/}{};
+		if (m!^(.+)\.fetch=$svn_refspec$!) {
+			my ($remote, $local_ref, $remote_ref) = ($1, $2, $3);
+			die("svn-remote.$remote: remote ref '$remote_ref' "
+			    . "must start with 'refs/'\n")
+				unless $remote_ref =~ m{^refs/};
 			$r->{$remote}->{fetch}->{$local_ref} = $remote_ref;
 			$r->{$remote}->{svm} = {} if $use_svm_props;
 		} elsif (m!^(.+)\.usesvmprops=\s*(.*)\s*$!) {
 			$r->{$1}->{svm} = {};
 		} elsif (m!^(.+)\.url=\s*(.*)\s*$!) {
 			$r->{$1}->{url} = $2;
-		} elsif (m!^(.+)\.(branches|tags)=
-		           (.*):refs/remotes/(.+)\s*$/!x) {
-			my ($p, $g) = ($3, $4);
+		} elsif (m!^(.+)\.(branches|tags)=$svn_refspec$!) {
+			my ($remote, $t, $local_ref, $remote_ref) = ($1, $2, $3, $4);
+			die("svn-remote.$remote: remote ref '$remote_ref' ($t) "
+			    . "must start with 'refs/'\n")
+				unless $remote_ref =~ m{^refs/};
 			my $rs = {
-			    t => $2,
-			    remote => $1,
-			    path => Git::SVN::GlobSpec->new($p),
-			    ref => Git::SVN::GlobSpec->new($g) };
+			    t => $t,
+			    remote => $remote,
+			    path => Git::SVN::GlobSpec->new($local_ref),
+			    ref => Git::SVN::GlobSpec->new($remote_ref) };
 			if (length($rs->{ref}->{right}) != 0) {
 				die "The '*' glob character must be the last ",
-				    "character of '$g'\n";
+				    "character of '$remote_ref'\n";
 			}
-			push @{ $r->{$1}->{$2} }, $rs;
+			push @{ $r->{$remote}->{$t} }, $rs;
 		}
 	}
 
@@ -1818,9 +1819,9 @@ sub init_remote_config {
 		}
 	}
 	my ($xrepo_id, $xpath) = find_ref($self->refname);
-	if (defined $xpath) {
+	if (!$no_write && defined $xpath) {
 		die "svn-remote.$xrepo_id.fetch already set to track ",
-		    "$xpath:refs/remotes/", $self->refname, "\n";
+		    "$xpath:", $self->refname, "\n";
 	}
 	unless ($no_write) {
 		command_noisy('config',
@@ -1895,7 +1896,7 @@ sub find_ref {
 	my ($ref_id) = @_;
 	foreach (command(qw/config -l/)) {
 		next unless m!^svn-remote\.(.+)\.fetch=
-		              \s*(.*)\s*:\s*refs/remotes/(.+)\s*$!x;
+		              \s*/?(.*?)\s*:\s*(.+?)\s*$!x;
 		my ($repo_id, $path, $ref) = ($1, $2, $3);
 		if ($ref eq $ref_id) {
 			$path = '' if ($path =~ m#^\./?#);
@@ -1912,16 +1913,16 @@ sub new {
 		if (!defined $repo_id) {
 			die "Could not find a \"svn-remote.*.fetch\" key ",
 			    "in the repository configuration matching: ",
-			    "refs/remotes/$ref_id\n";
+			    "$ref_id\n";
 		}
 	}
 	my $self = _new($class, $repo_id, $ref_id, $path);
 	if (!defined $self->{path} || !length $self->{path}) {
 		my $fetch = command_oneline('config', '--get',
 		                            "svn-remote.$repo_id.fetch",
-		                            ":refs/remotes/$ref_id\$") or
+		                            ":$ref_id\$") or
 		     die "Failed to read \"svn-remote.$repo_id.fetch\" ",
-		         "\":refs/remotes/$ref_id\$\" in config\n";
+		         "\":$ref_id\$\" in config\n";
 		($self->{path}, undef) = split(/\s*:\s*/, $fetch);
 	}
 	$self->{url} = command_oneline('config', '--get',
@@ -1932,7 +1933,7 @@ sub new {
 }
 
 sub refname {
-	my ($refname) = "refs/remotes/$_[0]->{ref_id}" ;
+	my ($refname) = $_[0]->{ref_id} ;
 
 	# It cannot end with a slash /, we'll throw up on this because
 	# SVN can't have directories with a slash in their name, either:
@@ -3267,12 +3268,12 @@ sub _new {
 	}
 	unless (defined $ref_id && length $ref_id) {
 		$_prefix = '' unless defined($_prefix);
-		$_[2] = $ref_id = $_prefix . $Git::SVN::default_ref_id;
+		$_[2] = $ref_id = 'refs/remotes/' . $_prefix . $Git::SVN::default_ref_id;
 	}
 	$_[1] = $repo_id;
 	my $dir = "$ENV{GIT_DIR}/svn/$ref_id";
 	$_[3] = $path = '' unless (defined $path);
-	mkpath(["$ENV{GIT_DIR}/svn"]);
+	mkpath(["$ENV{GIT_DIR}/svn/$ref_id"]);
 	bless {
 		ref_id => $ref_id, dir => $dir, index => "$dir/index",
 	        path => $path, config => "$ENV{GIT_DIR}/svn/config",
@@ -3301,7 +3302,9 @@ sub rev_db_path {
 sub map_path {
 	my ($self, $uuid) = @_;
 	$uuid ||= $self->ra_uuid;
-	"$self->{map_root}.$uuid";
+	my $map_path = "$self->{map_root}.$uuid";
+	( ! -d $map_path && $map_path =~ m{^refs/remotes/(.*)} && -d $1 ) ?
+		$1 : $map_path;
 }
 
 sub uri_encode {
@@ -5441,7 +5444,7 @@ sub minimize_connections {
 			my $pfx = "svn-remote.$x->{old_repo_id}";
 
 			my $old_fetch = quotemeta("$x->{old_path}:".
-			                          "refs/remotes/$x->{ref_id}");
+			                          "$x->{ref_id}");
 			command_noisy(qw/config --unset/,
 			              "$pfx.fetch", '^'. $old_fetch . '$');
 			delete $r->{$x->{old_repo_id}}->
@@ -5510,7 +5513,7 @@ sub new {
 	my ($class, $glob) = @_;
 	my $re = $glob;
 	$re =~ s!/+$!!g; # no need for trailing slashes
-	$re =~ m!^([^*]*)(\*(?:/\*)*)([^*]*)$!;
+	$re =~ m!^([^*]*)(\*(?:/\*)*)(.*)$!;
 	my $temp = $re;
 	my ($left, $right) = ($1, $3);
 	$re = $2;
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 5654962..fd8631f 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -14,7 +14,7 @@ if ! test_have_prereq PERL; then
 fi
 
 GIT_DIR=$PWD/.git
-GIT_SVN_DIR=$GIT_DIR/svn/git-svn
+GIT_SVN_DIR=$GIT_DIR/svn/refs/remotes/git-svn
 SVN_TREE=$GIT_SVN_DIR/svn-tree
 
 svn >/dev/null 2>&1
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 78610b6..bbfd7f4 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -172,11 +172,11 @@ test_expect_success "follow-parent is atomic" '
 	git update-ref refs/remotes/flunk@18 refs/remotes/stunk~2 &&
 	git update-ref -d refs/remotes/stunk &&
 	git config --unset svn-remote.svn.fetch stunk &&
-	mkdir -p "$GIT_DIR"/svn/flunk@18 &&
-	rev_map=$(cd "$GIT_DIR"/svn/stunk && ls .rev_map*) &&
-	dd if="$GIT_DIR"/svn/stunk/$rev_map \
-	   of="$GIT_DIR"/svn/flunk@18/$rev_map bs=24 count=1 &&
-	rm -rf "$GIT_DIR"/svn/stunk &&
+	mkdir -p "$GIT_DIR"/svn/refs/remotes/flunk@18 &&
+	rev_map=$(cd "$GIT_DIR"/svn/refs/remotes/stunk && ls .rev_map*) &&
+	dd if="$GIT_DIR"/svn/refs/remotes/stunk/$rev_map \
+	   of="$GIT_DIR"/svn/refs/remotes/flunk@18/$rev_map bs=24 count=1 &&
+	rm -rf "$GIT_DIR"/svn/refs/remotes/stunk &&
 	git svn init --minimize-url -i flunk "$svnrepo"/flunk &&
 	git svn fetch -i flunk &&
 	git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 145a367..3a84eb5 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -16,9 +16,7 @@ test_expect_success 'setup old-looking metadata' '
 		cd .. &&
 	git svn init "$svnrepo" &&
 	git svn fetch &&
-	mv "$GIT_DIR"/svn/* "$GIT_DIR"/ &&
-	mv "$GIT_DIR"/svn/.metadata "$GIT_DIR"/ &&
-	rmdir "$GIT_DIR"/svn &&
+	rm -rf "$GIT_DIR"/svn &&
 	git update-ref refs/heads/git-svn-HEAD refs/${remotes_git_svn} &&
 	git update-ref refs/heads/svn-HEAD refs/${remotes_git_svn} &&
 	git update-ref -d refs/${remotes_git_svn} refs/${remotes_git_svn}
@@ -79,7 +77,7 @@ test_expect_success 'migrate --minimize on old inited layout' '
 	rm -rf "$GIT_DIR"/svn &&
 	for i in `cat fetch.out`; do
 		path=`expr $i : "\([^:]*\):.*$"`
-		ref=`expr $i : "[^:]*:refs/remotes/\(.*\)$"`
+		ref=`expr $i : "[^:]*:\(refs/remotes/.*\)$"`
 		if test -z "$ref"; then continue; fi
 		if test -n "$path"; then path="/$path"; fi
 		( mkdir -p "$GIT_DIR"/svn/$ref/info/ &&
@@ -99,16 +97,16 @@ test_expect_success 'migrate --minimize on old inited layout' '
 
 test_expect_success  ".rev_db auto-converted to .rev_map.UUID" '
 	git svn fetch -i trunk &&
-	test -z "$(ls "$GIT_DIR"/svn/trunk/.rev_db.* 2>/dev/null)" &&
-	expect="$(ls "$GIT_DIR"/svn/trunk/.rev_map.*)" &&
+	test -z "$(ls "$GIT_DIR"/svn/refs/remotes/trunk/.rev_db.* 2>/dev/null)" &&
+	expect="$(ls "$GIT_DIR"/svn/refs/remotes/trunk/.rev_map.*)" &&
 	test -n "$expect" &&
 	rev_db="$(echo $expect | sed -e "s,_map,_db,")" &&
 	convert_to_rev_db "$expect" "$rev_db" &&
 	rm -f "$expect" &&
 	test -f "$rev_db" &&
 	git svn fetch -i trunk &&
-	test -z "$(ls "$GIT_DIR"/svn/trunk/.rev_db.* 2>/dev/null)" &&
-	test ! -e "$GIT_DIR"/svn/trunk/.rev_db &&
+	test -z "$(ls "$GIT_DIR"/svn/refs/remotes/trunk/.rev_db.* 2>/dev/null)" &&
+	test ! -e "$GIT_DIR"/svn/refs/remotes/trunk/.rev_db &&
 	test -f "$expect"
 	'
 
-- 
1.6.0.6
