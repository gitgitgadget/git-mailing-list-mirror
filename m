From: Michael Weber <michaelw@foldr.org>
Subject: [PATCH] svn-git: Use binmode for reading/writing binary rev maps
Date: Fri, 18 Apr 2008 15:12:04 +0200
Organization: foldr.org, Folding Right since 1996
Message-ID: <20080418131204.GA53634@roadkill.foldr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 14:47:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmqcU-0003bX-Oj
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 15:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbYDRN03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 09:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbYDRN03
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 09:26:29 -0400
Received: from lambda.foldr.org ([88.198.49.16]:53722 "EHLO mail.foldr.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750724AbYDRN02 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 09:26:28 -0400
X-Greylist: delayed 858 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Apr 2008 09:26:27 EDT
Received: from roadkill.foldr.org (zilver015187.mobiel.utwente.nl [130.89.15.187])
	by mail.foldr.org (8.14.2/8.14.2/Debian-3) with ESMTP id m3IDC4xC015060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 18 Apr 2008 15:12:06 +0200
Received: by roadkill.foldr.org (Postfix, from userid 501)
	id DB45A801997; Fri, 18 Apr 2008 15:12:04 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-GPG-Fingerprint: 1024D/F65C68CD: BF52 F4F7 5CAF 5349 1F47  A989 EA4A CD5C F65C 68CD
X-Accept-Language: en de
X-Scanned-By: milter-spamc/1.12.383 .383 (mail.foldr.org [88.198.102.118]); Fri, 18 Apr 2008 15:12:07 +0200
X-Spam-Status: NO, hits=-1.40 required=5.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79882>

Otherwise, there is a possible interaction with UTF-8 locales in
combination with PERL_UNICODE, resulting in "inconsistent size: 40" or
"read:"-type errors.

See also:
perldoc -f binmode
<http://perldoc.perl.org/perl581delta.html#UTF-8-no-longer-default-under-UTF-8-locales>

Signed-off-by: Michael Weber <michaelw@foldr.org>
---
 git-svn.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b864b54..3d80b23 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2519,6 +2519,7 @@ sub rebuild_from_rev_db {
 	my ($self, $path) = @_;
 	my $r = -1;
 	open my $fh, '<', $path or croak "open: $!";
+	binmode $fh or croak "binmode: $!";
 	while (<$fh>) {
 		length($_) == 41 or croak "inconsistent size in ($_) != 41";
 		chomp($_);
@@ -2616,6 +2617,7 @@ sub rebuild {
 sub _rev_map_set {
 	my ($fh, $rev, $commit) = @_;
 
+	binmode $fh or croak "binmode: $!";
 	my $size = (stat($fh))[7];
 	($size % 24) == 0 or croak "inconsistent size: $size";
 
@@ -2719,6 +2721,7 @@ sub rev_map_max {
 	my $map_path = $self->map_path;
 	stat $map_path or return $want_commit ? (0, undef) : 0;
 	sysopen(my $fh, $map_path, O_RDONLY) or croak "open: $!";
+	binmode $fh or croak "binmode: $!";
 	my $size = (stat($fh))[7];
 	($size % 24) == 0 or croak "inconsistent size: $size";
 
@@ -2751,6 +2754,7 @@ sub rev_map_get {
 	return undef unless -e $map_path;
 
 	sysopen(my $fh, $map_path, O_RDONLY) or croak "open: $!";
+	binmode $fh or croak "binmode: $!";
 	my $size = (stat($fh))[7];
 	($size % 24) == 0 or croak "inconsistent size: $size";
 
-- 
1.5.5.69.ga0a105
