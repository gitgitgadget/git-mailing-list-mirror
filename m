From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv5 18/17] gitweb/lib - Add clear() and size() methods to caching interface
Date: Thu,  7 Oct 2010 00:02:03 +0200
Message-ID: <1286402526-13143-19-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5t-0002Gb-FA
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933266Ab0JFWDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:03:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35042 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932921Ab0JFWDH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:03:07 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49424bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=y+VDmtH/QMGKh/2hoTDr6IxQ7FxzUY8pVatoLzRJAto=;
        b=nLTDDmLlFgM+wWrVxbbagSdo6zs1z4TWHC0Vbp43hQfhD8gNk7OaWZQuJYvucZo40B
         UtzaZFqj9FkrBoQSC4Hog5mbHWLEPSOg++UwdtNm8tGu/n8fizUb+/kV5vGgMrJYYClQ
         uawgN+kapQWU87D7AIaVdJSHfmET4PkZnsbzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F8yDIRZilqQSo/q3szHoteIXfWaqTmHCojMwjfdKwzu7/wwsFzLQj5YCPHThg0f8XJ
         EregyXMkFj1F7gLjMOuztdGvi18C6LSj1bxw4pS6Alk7aYr+1D18Im+/fKMmqA7KF/ub
         BYjLyfUaMCJrELeQ1UQbSHMCAygUXEBbSU800=
Received: by 10.204.127.75 with SMTP id f11mr10313085bks.85.1286402587021;
        Wed, 06 Oct 2010 15:03:07 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.03.05
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:03:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158330>

Add ->size() method, which following Cache::Cache interface returns
estimated total size of all entries in whole cache (in the namsepace
assiciated with give cache instance).  Note that ->get_size($key)
returns size of a single entry!

Add ->clear() method, which removes all entries from the namespace
associated with given cache instance.  For safety it requires
namespace to be set to true value, which means that it cannot be
empty; therefore default namespace is changed to 'gitweb'.

The ->clear() method should be fairly safe, because it first renames
directory (which should be atomic), and only then removes it
(following code from CGI::Driver::File).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The only difference from previous version is that a comment about some
method was moved to earlier commit that introduced it, where it
belongs.

This patch (implementing "backend") together with next patch
(implementing "interface") are meant to provide nice web interface to
safely cleaning (pruning) cache, as described in comments and
documentation (how to do this manually).

 gitweb/lib/GitwebCache/SimpleFileCache.pm |   48 ++++++++++++++++++++++++++--
 t/t9503/test_cache_interface.pl           |    1 -
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 2a3d9cf..8f172cb 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -20,8 +20,9 @@ package GitwebCache::SimpleFileCache;
 use strict;
 use warnings;
 
-use File::Path qw(mkpath);
-use File::Temp qw(tempfile);
+use File::Path qw(mkpath rmtree);
+use File::Temp qw(tempfile mktemp);
+use File::Find qw(find);
 use Digest::MD5 qw(md5_hex);
 
 # by default, the cache nests all entries on the filesystem single
@@ -37,7 +38,7 @@ our $DEFAULT_CACHE_ROOT = "cache";
 # by default we don't use cache namespace (empty namespace);
 # empty namespace does not allow for simple implementation of clear() method.
 #
-our $DEFAULT_NAMESPACE = '';
+our $DEFAULT_NAMESPACE = "gitweb";
 
 # ......................................................................
 # constructor
@@ -334,7 +335,7 @@ sub get_size {
 }
 
 # ......................................................................
-# interface methods
+# interface methods dealing with single item
 
 # Removing and expiring
 
@@ -427,6 +428,45 @@ sub compute {
 	return $data;
 }
 
+# ......................................................................
+# interface methods dealing with whole namespace
+
+# $cache->clear();
+#
+# Remove all entries from the namespace.
+# Namespace must be defined and not empty.
+sub clear {
+	my $self = shift;
+
+	return unless $self->get_namespace();
+
+	my $namespace_dir = $self->path_to_namespace();
+	return if !-d $namespace_dir;
+
+	my $renamed_dir = mktemp($namespace_dir . '.XXXX');
+	rename($namespace_dir, $renamed_dir);
+	rmtree($renamed_dir);
+	die "Couldn't remove '$renamed_dir' directory"
+		if -d $renamed_dir;
+}
+
+# $size = $cache->size();
+#
+# Size of whole names (or whole cache if namespace empty)
+sub size {
+	my $self = shift;
+
+	my $namespace_dir = $self->path_to_namespace();
+	return if !-d $namespace_dir;
+
+	my $total_size = 0;
+	my $add_size = sub { $total_size += -s $_ };
+
+	File::Find::find({ wanted => $add_size, no_chdir => 1 }, $namespace_dir);
+
+	return $total_size;
+}
+
 1;
 __END__
 # end of package GitwebCache::SimpleFileCache;
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 1f876bd..3a903cb 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -34,7 +34,6 @@ SKIP: {
 		unless ($GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT &&
 		        $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH);
 
-	is($cache->get_namespace(), '', "default namespace is ''");
 	cmp_ok($cache->get_root(),  'eq', $GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT,
 		"default cache root is '$GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT'");
 	cmp_ok($cache->get_depth(), '==', $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH,
-- 
1.7.3
