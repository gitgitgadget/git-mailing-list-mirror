From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Read repo config using 'git config -z -l'
Date: Sat,  3 Nov 2007 00:41:19 +0100
Message-ID: <1194046880-29941-3-git-send-email-jnareb@gmail.com>
References: <1194046880-29941-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 00:39:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io66y-000709-No
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 00:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434AbXKBXiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 19:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbXKBXix
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 19:38:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:23264 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172AbXKBXit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 19:38:49 -0400
Received: by ug-out-1314.google.com with SMTP id z38so694637ugc
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uPy+Ss/lIWh2VMFo9PKtzacUHWTuZ8U+cJLUODFQQGE=;
        b=ZGioKnlxuFEDG2+Kmt/AGou/c7LCpN42B4x/xpuvjVlPVkPoFf97zZwWYqSAmNLVfOEX4i88EBx3jiwPlcIe/42zwbTp9aftsgCtxDosshv3GT/dG930YqGPnF6004qiThETZaSc7HkRz3WYunQGAQ1LpklxO1aeiryru5mv8cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=poHgxisUCbTfsl4BFdK1ljFUsgWD/lGSKqFcA0N9uGX4cG7ORJ4r4VRIWI3P2ClTsmgoz84kkSRtYXRnE6r3itkhQqMyfgh4vNrFPolp574UpYaN8o2+FeRbEcX9akhDY0ywGUb9rAhOVR8s94AE1G+D17p8O+viOb0mrtlOlCw=
Received: by 10.67.19.17 with SMTP id w17mr1541925ugi.1194046727516;
        Fri, 02 Nov 2007 16:38:47 -0700 (PDT)
Received: from roke.D-201 ( [83.8.198.10])
        by mx.google.com with ESMTPS id j1sm9163975ugf.2007.11.02.16.38.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Nov 2007 16:38:45 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA2NfNh5029964;
	Sat, 3 Nov 2007 00:41:23 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA2NfMDS029963;
	Sat, 3 Nov 2007 00:41:22 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1194046880-29941-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63191>

Change git_get_project_config to run git-config only once per
repository, without changing its signature (its calling convention).
This means for example that it returns 'true' or 'false' when called
with second argument '--bool', and not true or false value.

Instead of calling 'git config [<type>] --get gitweb.<key>' once for
each config variable, call 'git config -z -l' only once, parsing and
saving its output to %config variable.  This makes possible to add new
per repository configuration without paying cost of forking once per
variable checked.  We can now allow repository description and
repository URLs to be stored in config file without badly affecting
gitweb performance.

For now only configuration variables for 'gitweb' section are stored.

Multiple values for single configuration variable are stored as
anonymous array reference; configuration variable with no value is
stored as undef.

Converting configuration variable values to boolean or integer value
are done in Perl.  Results differ from git-config in the fact that no
conversion error is ever raised.  For boolean values no value, 'true'
(any case) and 'false' (any case) are considered true, numbers are
true if not zero; all other values (even invalid for bool) are
considered false.  For integer values value suffix of 'k', 'm', or 'g'
following decimal number will cause the value to be multiplied by
1024, 1048576, or 1073741824; other values are returned as-is, only
whitespace stripped.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This makes use of commit 2275d502114c71045af991697048191fed88aac4
  "config: Add --null/-z option for null-delimted output"
by Frank Lichtenheld. The --null/-z option to git-config was created
among others with gitweb in mind, if I remember correctly.

In the future we would most probably want to move this to Git.pm, and
use Git.pm in gitweb.

 gitweb/gitweb.perl |  115 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 827f977..f54455b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1432,20 +1432,121 @@ sub git_get_type {
 	return $type;
 }
 
+# repository configuration
+our $config_file = '';
+our %config;
+
+# store multiple values for single key as anonymous array reference
+# single values stored directly in the hash, not as [ <value> ]
+sub hash_set_multi {
+	my ($hash, $key, $value) = @_;
+
+	if (!exists $hash->{$key}) {
+		$hash->{$key} = $value;
+	} elsif (!ref $hash->{$key}) {
+		$hash->{$key} = [ $hash->{$key}, $value ];
+	} else {
+		push @{$hash->{$key}}, $value;
+	}
+}
+
+# return hash of git project configuration
+# optionally limited to some section, e.g. 'gitweb'
+sub git_parse_project_config {
+	my $section_regexp = shift;
+	my %config;
+
+	local $/ = "\0";
+
+	open my $fh, "-|", git_cmd(), "config", '-z', '-l',
+		or return;
+
+	while (my $keyval = <$fh>) {
+		chomp $keyval;
+		my ($key, $value) = split(/\n/, $keyval, 2);
+
+		hash_set_multi(\%config, $key, $value)
+			if (!defined $section_regexp || $key =~ /^(?:$section_regexp)\./o);
+	}
+	close $fh;
+
+	return %config;
+}
+
+# convert config value to boolean, 'true' or 'false'
+# no value, number > 0, 'true' and 'yes' values are true
+# rest of values are treated as false (never as error)
+sub config_to_bool {
+	my $val = shift;
+
+	# strip leading and trailing whitespace
+	$val =~ s/^\s+//;
+	$val =~ s/\s+$//;
+
+	return (!defined $val ||               # section.key
+	        ($val =~ /^\d+$/ && $val) ||   # section.key = 1
+	        ($val =~ /^(?:true|yes)$/i));  # section.key = true
+}
+
+# convert config value to simple decimal number
+# an optional value suffix of 'k', 'm', or 'g' will cause the value
+# to be multiplied by 1024, 1048576, or 1073741824
+sub config_to_int {
+	my $val = shift;
+
+	# strip leading and trailing whitespace
+	$val =~ s/^\s+//;
+	$val =~ s/\s+$//;
+
+	if (my ($num, $unit) = ($val =~ /^([0-9]*)([kmg])$/i)) {
+		$unit = lc($unit);
+		# unknown unit is treated as 1
+		return $num * ($unit eq 'g' ? 1073741824 :
+		               $unit eq 'm' ?    1048576 :
+		               $unit eq 'k' ?       1024 : 1);
+	}
+	return $val;
+}
+
+# convert config value to array reference, if needed
+sub config_to_multi {
+	my $val = shift;
+
+	return ref($val) ? $val : [ $val ];
+}
+
 sub git_get_project_config {
 	my ($key, $type) = @_;
 
+	# key sanity check
 	return unless ($key);
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
-	my @x = (git_cmd(), 'config');
-	if (defined $type) { push @x, $type; }
-	push @x, "--get";
-	push @x, "gitweb.$key";
-	my $val = qx(@x);
-	chomp $val;
-	return ($val);
+	# type sanity check
+	if (defined $type) {
+		$type =~ s/^--//;
+		$type = undef
+			unless ($type eq 'bool' || $type eq 'int');
+	}
+
+	# get config
+	if (!defined $config_file ||
+	    $config_file ne "$git_dir/config") {
+		%config = git_parse_project_config('gitweb');
+		$config_file = "$git_dir/config";
+	}
+
+	# ensure given type
+	if (!defined $type) {
+		return $config{"gitweb.$key"};
+	} elsif ($type eq 'bool') {
+		# backward compatibility: 'git config --bool' returns true/false
+		return config_to_bool($config{"gitweb.$key"}) ? 'true' : 'false';
+	} elsif ($type eq 'int') {
+		return config_to_int($config{"gitweb.$key"});
+	}
+	return $config{"gitweb.$key"};
 }
 
 # get hash of given path at given ref
-- 
1.5.3.5
