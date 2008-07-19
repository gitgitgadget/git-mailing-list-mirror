From: Paul Talacko <gnuruandstuff@yahoo.co.uk>
Subject: PATCH: git-svn -- apply autoprop properties to an upstream svn repository
Date: Sat, 19 Jul 2008 07:22:20 +0000 (GMT)
Message-ID: <525224.5527.qm@web27802.mail.ukl.yahoo.com>
Reply-To: gnuruandstuff@yahoo.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 09:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK6mp-00015U-Qr
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 09:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYGSHWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 03:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbYGSHWX
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 03:22:23 -0400
Received: from web27802.mail.ukl.yahoo.com ([217.146.182.7]:32010 "HELO
	web27802.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751212AbYGSHWW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 03:22:22 -0400
Received: (qmail 7547 invoked by uid 60001); 19 Jul 2008 07:22:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=wBUb/ftZtTzhk3W21Xs97ZfbuU8DkRKUXdJ+1wR5hw/MQjpqJJ4zbrDhrvFFBWONGLSh8BxOgDSPk3NIOLyvV8XXZEYwG7kvbkjCSGIApG/QYCJDVgqavKM5rbtiU8oLKfPpKwHg8TJppXiGBbBJe+eFKX6nvwn1Fk0Cpb7DmjU=;
Received: from [195.70.154.229] by web27802.mail.ukl.yahoo.com via HTTP; Sat, 19 Jul 2008 07:22:20 GMT
X-Mailer: YahooMailWebService/0.7.218
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89102>

Hello,

As suggested a few days ago, there has been some interest git-svn being able to set properties on upstream svn repositories  This is, for example, necessary for committing new files to subversion repositories hosted on sourceforge where svn:mime-type and svn:eol-style properties have to be set for a commit to succeed.

So, here's a patch that reads the standard subversion config file and applies the "auto-props" to new files being committed to the upstream  repository.  This file is normally in ~/.subversion/config or /etc/subversion/config but this can be overridden with the --config-dir option.

In this patch, I've decided that to keep it consistent with the svn command line tool, that is that git-svn should read the config file by default, but respect the enable-auto-props config option set in that config file.

Also, to keep it consistent with the svn command line tool, the patch includes two new command line options --auto-props and --no-auto-props which both override the enable-auto-props config file option.

The code borrows from SVK::XD, in particular the regexp.  All the SVK code is released under the GPL.

I have also included a test file.

diff --git a/git-svn.perl b/git-svn.perl
index a366c89..df06220 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -128,6 +128,8 @@ my %cmd = (
 			  'dry-run|n' => \$_dry_run,
 			  'fetch-all|all' => \$_fetch_all,
 			  'no-rebase' => \$_no_rebase,
+                          'auto-props' => \$SVN::Git::Editor::_auto_props,
+                          'no-auto-props' => \$SVN::Git::Editor::_no_auto_props,
 			%cmt_opts, %fc_opts } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
@@ -448,8 +450,8 @@ sub cmd_dcommit {
 			                log => get_commit_entry($d)->{log},
 			                ra => Git::SVN::Ra->new($gs->full_url),
 			                config => SVN::Core::config_get_config(
-			                        $Git::SVN::Ra::config_dir
-			                ),
+				                $Git::SVN::Ra::config_dir
+					),
 			                tree_a => "$d~1",
 			                tree_b => $d,
 			                editor_cb => sub {
@@ -3276,7 +3278,7 @@ sub close_edit {
 }
 
 package SVN::Git::Editor;
-use vars qw/@ISA $_rmdir $_cp_similarity $_find_copies_harder $_rename_limit/;
+use vars qw/@ISA $_rmdir $_cp_similarity $_find_copies_harder $_rename_limit $_auto_props $_no_auto_props/;
 use strict;
 use warnings;
 use Carp qw/croak/;
@@ -3309,6 +3311,8 @@ sub new {
 	$self->{rm} = { };
 	$self->{path_prefix} = length $self->{svn_path} ?
 	                       "$self->{svn_path}/" : '';
+	$self->{config} = $opts->{ra}->{config};
+        croak "--auto-props and --no-auto-props are mutually exclusive." if $_auto_props && $_no_auto_props;
 	return $self;
 }
 
@@ -3497,6 +3501,86 @@ sub ensure_path {
 	return $bat->{$c};
 }
 
+sub apply_properties {
+    my ( $self, $fbat, $m ) = @_;
+    my $config       = $self->{config}->{config}; 
+    my $svn_auto_prop = {};
+    return if $_no_auto_props;
+    return if ( ! $_auto_props ) && ( ! $config->get_bool ('miscellany', 'enable-auto-props', 0) );
+
+    my $file = $m->{ file_b };
+
+    $config->enumerate(
+        'auto-props',
+        sub {
+            $svn_auto_prop->{ compile_apr_fnmatch( $_[0] ) } = $_[1];
+            1;
+        }
+    );
+    my ( $filebase ) = File::Basename::fileparse( $file );
+	while (my ($pattern, $value) = each %$svn_auto_prop ) {
+	    next unless $filebase =~ m/$pattern/;
+	    for (split (/\s*;\s*/, $value)) {
+		my ($propname, $propvalue) = split (/\s*=\s*/, $_, 2);
+		$self->change_file_prop($fbat, $propname, $propvalue); 
+	    }
+	}
+
+}
+
+
+## Thanks to SVK::XD and the folks Best Practical Solutions, who in
+## turn based this on Barrie Slaymaker's Regexp::Shellish
+sub compile_apr_fnmatch {
+    my $re = shift;
+
+    $re =~ s@
+             (  \\.
+             |  \[                       # character class
+                   [!^]?                 # maybe negation (^ and ! are both supported)
+                   (?: (?:\\.|[^\\\]])   # one item
+                     (?: -               # possibly followed by a dash and another
+                       (?:\\.|[^\\\]]))? # item
+                   )*                    # 0 or more entries (zero case will be checked specially below)
+                (\]?)                    # if this ] doesn't match, that means we fell off end of string!
+             |  .
+            )
+             @
+               if ( $1 eq '?' ) {
+                   '.' ;
+               } elsif ( $1 eq '*' ) {
+                   '.*' ;
+               } elsif ( substr($1, 0, 1) eq '[') {
+                   if ($1 eq '[]') { # should never match
+                       '[^\s\S]';
+                   } elsif ($1 eq '[!]' or $1 eq '[^]') { # 0-length match
+                       '';
+                   } else {
+                       my $temp = $1;
+                       my $failed = $2 eq '';
+                       if ($failed) {
+                           '[^\s\S]';
+                       } else {
+                           $temp =~ s/(\\.|.)/$1 eq '-' ? '-' : quotemeta(substr($1, -1))/ges;
+                           # the previous step puts in backslashes at beginning and end; remove them
+                           $temp =~ s/^\\\[/[/;
+                           $temp =~ s/\\\]$/]/;
+                           # if it started with [^ or [!, it now starts with [\^ or [\!; fix.
+                           $temp =~ s/^\[     # literal [
+                                       \\     # literal backslash
+                                       [!^]   # literal ! or ^
+                                     /[^/x;
+                           $temp;
+                       }
+                   }
+               } else {
+                   quotemeta(substr( $1, -1 ) ); # ie, either quote it, or if it's \x, quote x
+               }
+    @gexs ;
+
+    return qr/\A$re\Z/s;
+}
+
 sub A {
 	my ($self, $m) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
@@ -3505,6 +3589,7 @@ sub A {
 					undef, -1);
 	print "\tA\t$m->{file_b}\n" unless $::_q;
 	$self->chg_file($fbat, $m);
+	$self->apply_properties( $fbat, $m );
 	$self->close_file($fbat,undef,$self->{pool});
 }
 
diff --git a/t/t9124-git-svn-autoprops.sh b/t/t9124-git-svn-autoprops.sh
new file mode 100644
index 0000000..ed78c2d
--- /dev/null
+++ b/t/t9124-git-svn-autoprops.sh
@@ -0,0 +1,123 @@
+#!/bin/sh
+#
+
+
+
+test_description='git-svn dcommit sets autoprops on files'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'make svn repo' '
+    mkdir import &&
+    cd import &&
+    echo first > firstfile &&
+    svn import -m "Import for autoprops test" . "$svnrepo" > /dev/null &&
+    cd ..  &&
+    git svn init "$svnrepo" &&
+    git svn fetch
+'
+
+
+mkdir config
+cat > config/config <<EOF 
+[miscellany]
+enable-auto-props = yes
+[auto-props]
+*pm =  file-type = perl
+*html = svn:mime-type = text/html; encoding = special
+*bar = private = thingy
+EOF
+
+
+
+test_expect_success 'set svn properties on files' '
+        cd "$gittestrepo" &&
+        echo "blah" > a.pm &&
+        echo "foo" > b.html &&
+        echo "data" > foobar &&
+        git add a.pm b.html foobar &&
+        git commit -m files &&
+        git svn dcommit --config-dir=config
+        '
+
+test_expect_success 'export our properties to an svn repo' '
+
+        mkdir testsvnrepo &&
+        cd testsvnrepo &&
+        svn checkout "$svnrepo" &&
+        cd svnrepo
+        '
+
+test_expect_success 'test properties' '
+        test perl = `svn propget file-type a.pm` &&
+        test thingy = `svn propget private foobar` &&
+        test text/html = `svn propget svn:mime-type b.html` &&
+        test special = `svn propget encoding b.html`
+
+        '
+
+cd ../..
+
+test_expect_success 'no-props overrides config file' '
+        touch overriden-b.html &&
+        git add overriden-b.html &&
+        git commit -m "overriden-b" &&
+        git svn dcommit --no-auto-props --config-dir=config &&
+        cd testsvnrepo &&
+        svn checkout "$svnrepo" &&
+        cd svnrepo &&
+        test -z `svn propget file-type overriden-b.html`
+'
+
+cd ../..
+
+cat > config/config <<EOF 
+[miscellany]
+enable-auto-props = no
+[auto-props]
+*pm =  file-type = perl
+*html = svn:mime-type = text/html; encoding = special
+*bar = private = thingy
+EOF
+
+
+test_expect_success 'test when enable-auto-props is no' '
+        echo "blah" > a_no_props.pm &&
+        echo "foo" > b_no_props.html &&
+        echo "data" > foobar_no_props &&
+        chmod +x foobar_no_props &&
+        git add a_no_props.pm b_no_props.html foobar_no_props &&
+        git commit -m "No props files" &&
+        git svn dcommit --config-dir=config &&
+        cd testsvnrepo &&
+        svn checkout "$svnrepo"  &&
+        cd svnrepo &&
+        test -z `svn propget file-type a_no_props.pm` &&
+        test -z `svn propget private foobar_no_props`  &&
+        test -z `svn propget svn:mime-type b_no_props.html` &&
+        test -z `svn propget encoding b_no_props.html`
+        '
+
+cd ../..
+
+test_expect_success 'auto-props overrides config file' '
+        touch overriden-auto.pm &&
+        git add overriden-auto.pm &&
+        git commit -m "overriden-auto" &&
+        git svn dcommit --auto-props --config-dir=config &&
+        cd testsvnrepo &&
+        svn checkout "$svnrepo" &&
+        cd svnrepo &&
+        test perl = `svn propget file-type overriden-auto.pm`
+'
+cd ../..
+
+test_expect_success 'auto-props and no-auto-props are exclusive' '
+        touch afile &&
+        git add afile &&
+        git commit -m afile &&
+        test_must_fail git svn dcommit --auto-props --no-auto-props
+'
+
+test_done
+



      __________________________________________________________
Not happy with your email address?.
Get the one you really want - millions of new email addresses available now at Yahoo! http://uk.docs.yahoo.com/ymail/new.html
