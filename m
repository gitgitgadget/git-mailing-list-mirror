From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 06/17] gitweb/lib - Benchmarking GitwebCache::SimpleFileCache (in t/9603/)
Date: Mon, 14 Jun 2010 18:08:18 +0200
Message-ID: <1276531710-22945-7-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:09:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCDg-0001Wt-Bf
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab0FNQI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:08:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44776 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab0FNQIq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:46 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649600fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3dEX6gjYcEyadH8tnqq831ojlb4+ODYCt2kFfOUCyLs=;
        b=Ngsr8hYeQjJ7O0/yJ0KwfN8Zww7hFOJZhky3lSpCcUJj2IKMYQi+nPKqwncgq26jXG
         IKFZkkpytbYCrowXeDh4m7fBQNpiFWXTP9tQOq4Rud905rTLPICeiWNPoyDCnycdTUeV
         Sl7yfJM85EyfOp/T2AGwZNA68YNGscDlTZRsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KQSCQ3CExbE1GgMebj0GgW/p5OFO3j0JpXAF0TSD0vEJZD9vQh6wQ/BAaKkRFHNN3E
         94aFdQPNEES64OIwXhJIxNzQBPEm4NM+0b9oirWV+7SF+MqApHcfg/n+qDYNPtmg5BqY
         T9jjL++EhWQxler3RJRE3p8tFGJbdyef+O0/s=
Received: by 10.223.92.152 with SMTP id r24mr5643164fam.74.1276531725451;
        Mon, 14 Jun 2010 09:08:45 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149103>

Add t/t9503/benchmark_caching_interface.pl, which benchmarks 'set' and
'get' methods from GitwebCache::SimpleFileCache, and compares them
against Cache::FileCache, Cache::MemoryCache, CHI with 'File' driver,
Cache::FastMmap if they are available.

Includes example benchmark results.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 t/t9503/benchmark_caching_interface.pl |  132 ++++++++++++++++++++++++++++++++
 1 files changed, 132 insertions(+), 0 deletions(-)
 create mode 100755 t/t9503/benchmark_caching_interface.pl

diff --git a/t/t9503/benchmark_caching_interface.pl b/t/t9503/benchmark_caching_interface.pl
new file mode 100755
index 0000000..5a46077
--- /dev/null
+++ b/t/t9503/benchmark_caching_interface.pl
@@ -0,0 +1,132 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use File::Spec;
+use File::Path;
+use Benchmark qw(:all);
+
+# benchmark source version
+sub __DIR__ () {
+	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
+}
+use lib __DIR__."/../../gitweb/lib";
+use GitwebCache::SimpleFileCache;
+
+my $key = 'http://localhost/cgi-bin/gitweb.cgi?p=git/git.git;a=blob_plain;f=lorem.txt;hb=HEAD';
+my $value = <<'EOF';
+Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
+eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
+minim veniam, quis nostrud exercitation ullamco laboris nisi ut
+aliquip ex ea commodo consequat. Duis aute irure dolor in
+reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
+pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
+culpa qui officia deserunt mollit anim id est laborum.
+EOF
+
+my $cache_root = __DIR__.'/cache';
+my %cache_options = (
+	'cache_root' => $cache_root, # Cache::FileCache compatibile
+	'root_dir'   => $cache_root, # CHI::Driver::File compatibile
+	'cache_depth' => 1, # Cache::FileCache compatibile
+	'depth'       => 1, # CHI::Driver::File compatibile
+	'default_expires_in' => 24*60*60, # Cache::Cache compatibile
+	'expires_in'         => 24*60*60, # CHI compatibile
+	'expire_time'        => 24*60*60, # Cache::FastMmap compatibile
+);
+
+mkdir($cache_root);
+
+my @caches;
+push @caches, GitwebCache::SimpleFileCache->new({
+	'namespace' => 'GitwebCache-SimpleFileCache',
+	%cache_options,
+});
+
+if (eval { require Cache::FileCache; 1; }) {
+	push @caches, Cache::FileCache->new({
+		'namespace' => 'Cache-FileCache',
+		%cache_options,
+	});
+}
+
+if (eval { require Cache::MemoryCache; 1; }) {
+	push @caches, Cache::MemoryCache->new({
+		'namespace' => 'Cache-MemoryCache',
+		%cache_options,
+	});
+}
+if (eval { require CHI; 1; }) {
+	push @caches, CHI->new(
+		'driver' => 'File',
+		'namespace' => 'CHI-Driver-File',
+		%cache_options,
+	);
+}
+if (eval { require Cache::FastMmap; 1 }) {
+	push @caches, Cache::FastMmap->new(
+		'share_file' => $cache_root.'/Cache-FastMmap',
+		'init_file' => 1,
+		'raw_values' => 1,
+		%cache_options,
+	);
+}
+
+my %caches;
+my $count = -10;
+
+print '$cache->set($key, $value)'."\n";
+for my $cache (@caches) {
+	my $name = ref($cache);
+	$name = 'GitwebCache' if ($name =~ /^GitwebCache/);
+	$caches{$name} = sub { $cache->set($key, $value); };
+}
+
+my $result_set = timethese($count, { %caches });
+cmpthese($result_set);
+
+print "\n";
+
+print '$cache->get($key)'."\n";
+for my $cache (@caches) {
+	my $name = ref($cache);
+	$name = 'GitwebCache' if ($name =~ /^GitwebCache/);
+	$caches{$name} = sub { $cache->get($key); };
+}
+
+my $result_get = timethese($count, { %caches });
+cmpthese($result_get);
+
+rmtree($cache_root);
+
+1;
+__END__
+## EXAMPLE OUTPUT ##
+#
+# $cache->set($key, $value)
+# Benchmark: running Cache::FastMmap, Cache::FileCache, Cache::MemoryCache, GitwebCache
+#   for at least 10 CPU seconds...
+# Cache::FastMmap:    11 wallclock secs ( 8.46 usr +  2.17 sys = 10.63 CPU) @ 15710.25/s (n=167000)
+# Cache::FileCache:   15 wallclock secs ( 8.43 usr +  2.25 sys = 10.68 CPU) @ 356.27/s   (n=3805)
+# Cache::MemoryCache: 13 wallclock secs ( 9.91 usr +  0.09 sys = 10.00 CPU) @ 3306.20/s  (n=33062)
+# GitwebCache:        29 wallclock secs ( 7.02 usr +  3.47 sys = 10.49 CPU) @ 605.91/s   (n=6356)
+#                       Rate Cache::FileCache GitwebCache Cache::MemoryCache Cache::FastMmap
+# Cache::FileCache     356/s               --        -41%               -89%            -98%
+# GitwebCache          606/s              70%          --               -82%            -96%
+# Cache::MemoryCache  3306/s             828%        446%                 --            -79%
+# Cache::FastMmap    15710/s            4310%       2493%               375%              --
+#
+# $cache->get($key)
+# Benchmark: running Cache::FastMmap, Cache::FileCache, Cache::MemoryCache, GitwebCache
+#   for at least 10 CPU seconds...
+# Cache::FastMmap:    13 wallclock secs ( 7.32 usr +  2.83 sys = 10.15 CPU) @ 24260.59/s (n=246245)
+# Cache::FileCache:   12 wallclock secs ( 9.22 usr +  1.30 sys = 10.52 CPU) @ 972.62/s   (n=10232)
+# Cache::MemoryCache: 14 wallclock secs ( 9.89 usr +  0.12 sys = 10.01 CPU) @ 3679.52/s  (n=36832)
+# GitwebCache:        20 wallclock secs ( 8.16 usr +  2.36 sys = 10.52 CPU) @ 4401.05/s  (n=46299)
+#                       Rate Cache::FileCache Cache::MemoryCache GitwebCache Cache::FastMmap
+# Cache::FileCache     973/s               --               -74%        -78%            -96%
+# Cache::MemoryCache  3680/s             278%                 --        -16%            -85%
+# GitwebCache         4401/s             352%                20%          --            -82%
+# Cache::FastMmap    24261/s            2394%               559%        451%              --
-- 
1.7.0.1
