From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 23/24] gitweb/lib - Add clear() and size() methods to caching interface
Date: Tue,  7 Dec 2010 00:11:08 +0100
Message-ID: <1291677069-6559-24-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkEr-0000Cr-O6
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab0LFXMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:49 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:64271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab0LFXMj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:39 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7581974ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6N1w6+uTb49fEDAyPwNh0zgk8oMxfMkkmjoQ5wMS3r8=;
        b=tRQZyWzujZqI7GA2vdsgzUK5d+ySQXDT5tDpDgWh2T7DJPoHKvuPWX7CiucikIXWDx
         XBNnHcf+JnSnMkEvfkA3Le6PGKu+F+wL9vI+Z1LzQKPwwq2F68dewl9M3xXsggt8T2st
         uVuwqYVcD2ZKAKeSiMGKVx1z1lKC6CmwimnKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nY/tsEV4l0V+Q1yFETRWfjCsZYm/A88MnQNqdGDbh47lBzCC/In8BEOr7ebkP48z7S
         cd0t42RDAcZ4fvWXedxsKNtKPyGvP4heqFGWQ5dsHCBXFKej7R7JZ6Xkd9CAfftDRstx
         sLJpw2QS/8+VDQCDiDHSh0N9MIBSN6UzG4If4=
Received: by 10.213.4.67 with SMTP id 3mr2384432ebq.4.1291677158922;
        Mon, 06 Dec 2010 15:12:38 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:38 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163046>

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
This patch is unchanged from previous version of this series.

This patch (implementing "backend") together with next patch
(implementing "interface") are meant to provide nice web interface to
safely cleaning (pruning) cache, as described in comments and
documentation (how to do this manually).

This is less an RFC than next patch, but without next patch it is of
very limited use.

 gitweb/lib/GitwebCache/SimpleFileCache.pm |   48 ++++++++++++++++++++++++++--
 t/t9503/test_cache_interface.pl           |    1 -
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 8d0a6d9..cd489f8 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -21,8 +21,9 @@ use strict;
 use warnings;
 
 use Carp;
-use File::Path qw(mkpath);
-use File::Temp qw(tempfile);
+use File::Path qw(mkpath rmtree);
+use File::Temp qw(tempfile mktemp);
+use File::Find qw(find);
 use Digest::MD5 qw(md5_hex);
 
 # by default, the cache nests all entries on the filesystem single
@@ -38,7 +39,7 @@ our $DEFAULT_CACHE_ROOT = "cache";
 # by default we don't use cache namespace (empty namespace);
 # empty namespace does not allow for simple implementation of clear() method.
 #
-our $DEFAULT_NAMESPACE = '';
+our $DEFAULT_NAMESPACE = "gitweb";
 
 # ......................................................................
 # constructor
@@ -393,7 +394,7 @@ sub get_size {
 
 
 # ......................................................................
-# interface methods
+# interface methods dealing with single item
 
 # Removing and expiring
 
@@ -547,6 +548,45 @@ sub compute_fh {
 	return ($fh, $filename);
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
+	my $add_size = sub { $total_size += -s $File::Find::name };
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
index 28a5c5e..031c895 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -46,7 +46,6 @@ SKIP: {
 		unless ($GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT &&
 		        $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH);
 
-	is($cache->get_namespace(), '', "default namespace is ''");
 	cmp_ok($cache->get_root(),  'eq', $GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT,
 		"default cache root is '$GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT'");
 	cmp_ok($cache->get_depth(), '==', $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH,
-- 
1.7.3
