From: Michael G Schwern <schwern@pobox.com>
Subject: Find .pm files automatically (was Re: Fix git-svn tests for SVN
 1.7.5.)
Date: Tue, 17 Jul 2012 16:05:41 -0700
Message-ID: <5005EFC5.8060105@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:06:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrGqM-0000YE-8J
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586Ab2GQXFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:05:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab2GQXFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:05:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA4A48269;
	Tue, 17 Jul 2012 19:05:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=tLU/Gpcnpc7V
	Qq8+pm2WPLShTTA=; b=LrCOf2J8Pxi2Ayt9FXIDTq+OKwP15gqukoM7L2TqsgeM
	PViamNgQ/kjVvQsIvRXUDdDwxAOsczlTGtDA2f/VCrSqi5ZU4ydFGl5iZQqgbIMy
	ZpsBbJv3wV5WL634by91xB3SvvSxH2pnUk4nBcJ7u6cACugyJPFfJ5jucVwb0Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jEXE7P
	zK38/5WsAw6Se5ZBiAGkdpaHdqGkQuFH1FZf26WD+XX0cP7+Dj3PKR4SfLjcbt8s
	LxT5x3ml1soiso5uN0SuC457IWZaBzshYcdBS3DDtxTv8g2XqIhrc+Dp8E9ok4JK
	tDpMyk0O5IJ00HNmAqLh1OATy6+CuU5at9bKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6EFD8268;
	Tue, 17 Jul 2012 19:05:42 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF78D8267; Tue, 17 Jul
 2012 19:05:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120717174446.GA14244@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: EEC660C8-D063-11E1-B343-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201626>

On 2012.7.17 10:44 AM, Jonathan Nieder wrote:
> My advice would be to send five or so of the patches that you would
> like to be reviewed first, inline, one per message, in reply to this
> message so we can start to work on that.  Presumably the patches do
> not regress git-svn's behavior but only make it saner, so even if this
> is not a complete fix it should allow us to get started.  See
> Documentation/SubmittingPatches for more hints.

Ok, here goes.

First patch overhauls perl/Makefile.PL to make it easier to add .pm files,
which I'm going to be doing a lot of.  Instead of having to manually add to
the %pm hash, it scans for .pm files.

It also moves Error.pm into a bundle directory.  This both makes it just
another directory to scan (or not scan), but it also makes it possible to
bundle additional modules in the future.  ExtUtils::MakeMaker uses this
technique itself.

You still have to remember to add them to the other Makefile.

This is available as a branch.
https://github.com/schwern/git/tree/git-svn/easier_modules


>From 47a723a860cded6b16a716ea74c5bc029ee5b0ac Mon Sep 17 00:00:00 2001
From: "Michael G. Schwern" <schwern@pobox.com>
Date: Thu, 12 Jul 2012 00:05:38 -0700
Subject: [PATCH 01/11] Make the process of adding a module less blecherous.

* Scan for .pm files and build %pms rather than having to do it by hand.
* Move the bundled Error into its own directory so we can bundle other modules.

In addition...
* Add all the .pm files to the all dependency in the alternative Makefile
---
 perl/Makefile                                     |  6 ++--
 perl/Makefile.PL                                  | 42 +++++++++++++----------
 perl/{private-Error.pm => bundles/Error/Error.pm} |  0
 perl/bundles/README                               | 10 ++++++
 4 files changed, 36 insertions(+), 22 deletions(-)
 rename perl/{private-Error.pm => bundles/Error/Error.pm} (100%)
 create mode 100644 perl/bundles/README

diff --git a/perl/Makefile b/perl/Makefile
index 6ca7d47..4f25930 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -33,7 +33,7 @@ modules += Git/SVN/Prompt
 modules += Git/SVN/Ra

 $(makfile): ../GIT-CFLAGS Makefile
-	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
+	echo all: bundles/Error/Error.pm $(modules) > $@
 	set -e; \
 	for i in $(modules); \
 	do \
@@ -49,7 +49,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	done
 	echo '	$(RM) blib/lib/Error.pm' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
-	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
+	echo '	cp bundles/Error/Error.pm blib/lib/Error.pm' >> $@
 	echo install: >> $@
 	set -e; \
 	for i in $(modules); \
@@ -66,7 +66,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	done
 	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
-	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
+	echo '	cp bundles/Error/Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
 	echo instlibdir: >> $@
 	echo '	echo $(instdir_SQ)' >> $@
 else
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index b54b04a..000d370 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -2,11 +2,16 @@ use strict;
 use warnings;
 use ExtUtils::MakeMaker;
 use Getopt::Long;
+use File::Find;
+
+# Don't forget to update the perl/Makefile, too.
+# Don't forget to test with NO_PERL_MAKEMAKER=YesPlease

 # Sanity: die at first unknown option
 Getopt::Long::Configure qw/ pass_through /;

-GetOptions("localedir=s" => \my $localedir);
+my $localedir = '';
+GetOptions("localedir=s" => \$localedir);

 sub MY::postamble {
 	return <<'MAKE_FRAG';
@@ -24,27 +29,25 @@ endif
 MAKE_FRAG
 }

-# XXX. When editing this list:
-#
-# * Please update perl/Makefile, too.
-# * Don't forget to test with NO_PERL_MAKEMAKER=YesPlease
-my %pm = (
-	'Git.pm' => '$(INST_LIBDIR)/Git.pm',
-	'Git/I18N.pm' => '$(INST_LIBDIR)/Git/I18N.pm',
-	'Git/SVN/Memoize/YAML.pm' => '$(INST_LIBDIR)/Git/SVN/Memoize/YAML.pm',
-	'Git/SVN/Fetcher.pm' => '$(INST_LIBDIR)/Git/SVN/Fetcher.pm',
-	'Git/SVN/Editor.pm' => '$(INST_LIBDIR)/Git/SVN/Editor.pm',
-	'Git/SVN/Prompt.pm' => '$(INST_LIBDIR)/Git/SVN/Prompt.pm',
-	'Git/SVN/Ra.pm' => '$(INST_LIBDIR)/Git/SVN/Ra.pm',
-);
-
+my @pmlibdirs = ("Git");
 # We come with our own bundled Error.pm. It's not in the set of default
 # Perl modules so install it if it's not available on the system yet.
-eval { require Error };
-if ($@ || $Error::VERSION < 0.15009) {
-	$pm{'private-Error.pm'} = '$(INST_LIBDIR)/Error.pm';
+if ( !eval { require Error } || $Error::VERSION < 0.15009) {
+    push @pmlibdirs, "bundles/Error";
 }

+
+# Find all the .pm files in @pmlibdirs which includes our bundled modules.
+my %pms;
+find sub {
+    return unless /\.pm$/;
+
+    my $inst = $File::Find::name;
+    $inst =~ s{bundles/[^/]+/?}{};
+    $pms{$File::Find::name} = '$(INST_LIBDIR)/'.$inst;
+}, @pmlibdirs;
+
+
 # redirect stdout, otherwise the message "Writing perl.mak for Git"
 # disrupts the output for the target 'instlibdir'
 open STDOUT, ">&STDERR";
@@ -52,8 +55,9 @@ open STDOUT, ">&STDERR";
 WriteMakefile(
 	NAME            => 'Git',
 	VERSION_FROM    => 'Git.pm',
-	PM		=> \%pm,
+	PM              => \%pms,
 	PM_FILTER	=> qq[\$(PERL) -pe "s<\\Q++LOCALEDIR++\\E><$localedir>"],
 	MAKEFILE	=> 'perl.mak',
 	INSTALLSITEMAN3DIR => '$(SITEPREFIX)/share/man/man3'
 );
+
diff --git a/perl/private-Error.pm b/perl/bundles/Error/Error.pm
similarity index 100%
rename from perl/private-Error.pm
rename to perl/bundles/Error/Error.pm
diff --git a/perl/bundles/README b/perl/bundles/README
new file mode 100644
index 0000000..8a9ce39
--- /dev/null
+++ b/perl/bundles/README
@@ -0,0 +1,10 @@
+This is any Perl modules we might want to bundle because Perl doesn't (or didn't)
+ship with them.  Each directory is a distribution containing all the PM files.
+
+For example, if you wanted to bundle URI...
+1) mkdir bundles/URI/
+
+2) build URI & cp -r blib/lib/* into bundles/URI
+
+3) add bundles/URI to @pmlibdirs in the Makefile.PL with the
+   appropriate check for existance and high enough version
-- 
1.7.11.1




-- 
Alligator sandwich, and make it snappy!
