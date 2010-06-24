From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 18/17] gitweb/lib - Add clear() and size() methods to caching interface
Date: Thu, 24 Jun 2010 09:56:52 +0200
Message-ID: <1277366213-28381-1-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@ucw.cz>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 09:57:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORhJF-0006XQ-O3
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 09:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab0FXH5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 03:57:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58674 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab0FXH5I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 03:57:08 -0400
Received: by fxm3 with SMTP id 3so123089fxm.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=afH4kTlW7Xn5U883jGp3o4XA4WPUDKsDnV/5SGnWCFA=;
        b=pVbiVCQf2D+BRRwFYdhhuw+mtkuu89XdiFI3bWEtl50vOVMyQ1zh6z2p+k34XZoINA
         /shSrjWnQKj4dsHcLyz3PZRsMdhnEXbAIQT+SEZEpr1ZZgW8mqTQsVIxqp1z0LmaMWio
         y9rZXcBJczGw1TSfnQuj837ZoiyUvqbzzQhrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=drZmTeXPv4vN14bjxIERIU3/cxBBT6Mbi5el8xZLNCxIeiTrLuM1QOjKEqF2YIhF2e
         uPO98hCKQuR8uk3BtrcX5AjkVi1gAcGJ3eHGZzz/f+ZvcEmdcrIo2tnwYM1rdonRDkep
         2mJI6g3xWXbgrcKz2SqgQoczvel3z2LhPu790=
Received: by 10.223.101.81 with SMTP id b17mr8873887fao.17.1277366225198;
        Thu, 24 Jun 2010 00:57:05 -0700 (PDT)
Received: from localhost.localdomain (abvz51.neoplus.adsl.tpnet.pl [83.8.223.51])
        by mx.google.com with ESMTPS id r9sm712449faq.1.2010.06.24.00.57.03
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 00:57:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149564>

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
This is new patch, implementing methods that allow for rudimentary
gitweb cache administration.  For now it is only safe removing whole
cache, in the future it could include removing only stale (expired)
entries.

This is "backend" patch.

 gitweb/lib/GitwebCache/SimpleFileCache.pm |   51 ++++++++++++++++++++++++++--
 t/t9503/test_cache_interface.pl           |    1 -
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 9eb4896..457bbe7 100644
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
@@ -202,6 +203,9 @@ sub path_to_namespace {
 	return $self->{'path_to_namespace'};
 }
 
+# $path = $cache->path_to_key($key);
+# $path = $cache->path_to_key($key, \$dir);
+#
 # Take an human readable key, and return file path.
 # Puts dirname of file path in second argument, if it is provided.
 sub path_to_key {
@@ -321,7 +325,7 @@ sub get_size {
 }
 
 # ......................................................................
-# interface methods
+# interface methods dealing with single item
 
 # Removing and expiring
 
@@ -412,6 +416,45 @@ sub compute {
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
index a84faf9..0a18f77 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -35,7 +35,6 @@ SKIP: {
 		unless ($GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT &&
 		        $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH);
 
-	is($cache->get_namespace(), '', "default namespace is ''");
 	cmp_ok($cache->get_root(),  'eq', $GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT,
 		"default cache root is '$GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT'");
 	cmp_ok($cache->get_depth(), '==', $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH,
-- 
1.7.0.1
