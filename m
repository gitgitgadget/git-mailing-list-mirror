From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 13/24] gitweb/lib - No need for File::Temp when locking
Date: Tue,  7 Dec 2010 00:10:58 +0100
Message-ID: <1291677069-6559-14-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkEr-0000Cr-7f
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab0LFXMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:42 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:50271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab0LFXMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:14 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7581892ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1pJSJbEvG796g8j3W39HNShdOs2zGSLQuwXbpdEl9Aw=;
        b=I9al12yOtO6plUBFdDhgUtBxjOpCW90DKyw8BVeHQzAYDGTYXmW4CPdso40WtC+Wmu
         pPe0ZV/2jLobwGxzFe7IQAsNokNM0szk7KMID6iX3RKRIzbM7hRyvwPM2l4IyCi2h1RB
         4ySlyd2xwj8RumbC4l4ptCAzNYO2W/p/5RS5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HkS9yLJ1CQPeJXxCR5ek9g3xlB+2033rExz2bFjhBStJzZBhlJhGMfqkKWoR7HST99
         Ta1wk18cgHh2Uf8xUcLO59Tm+NwIjiqy+z6DOrsz/59lCK966AZPmftVr3nUSS9By096
         /cQlo5EVjRScIBhPQcrQIiv5khfov+CYX6+2g=
Received: by 10.14.48.12 with SMTP id u12mr437545eeb.34.1291677133617;
        Mon, 06 Dec 2010 15:12:13 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:12 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163044>

When using locking to ensure that only one process is generating data
and updating cache, there is no need to use File::Temp for temporary
file.  This should improve performance.

The _tempfile_to_path subroutine got promoted to _tempfile_to_path
method, because we want to choose correct one dynamically, based on
the type of object (polymorphism).

Idea-inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
In previous version of this patch _tempfile_to_path was subroutine
rather than method... which mans that GitwebCache::SimpleFileCache
version was being picked up because that is the package where methods
that use it are.

"Gitweb caching v7" either writes directly to cache entry file, or
uses file with name based on original cache entry as temporary output
file; the latter is just like GitwebCache::FileCacheWithLocking does
it after this patch.

 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   16 ++++++++++++++++
 gitweb/lib/GitwebCache/SimpleFileCache.pm      |    6 +++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index 1ea0e60..4d8114d 100644
--- a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -46,6 +46,22 @@ sub get_lockname {
 	return $lockfile;
 }
 
+# ----------------------------------------------------------------------
+# "private" utility functions and methods
+
+# take a file path to cache entry, and its directory
+# return filehandle and filename of open temporary file,
+# like File::Temp::tempfile
+sub _tempfile_to_path {
+	my ($self, $file, $dir) = @_;
+
+	my $tempname = "$file.tmp";
+	open my $temp_fh, '>', $tempname
+		or die "Couldn't open temporary file '$tempname' for writing: $!";
+
+	return ($temp_fh, $tempname);
+}
+
 # ......................................................................
 # interface methods
 
diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 12af44f..aeb91d4 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -288,7 +288,7 @@ sub write_fh {
 # return filehandle and filename of open temporary file,
 # like File::Temp::tempfile
 sub _tempfile_to_path {
-	my ($file, $dir) = @_;
+	my ($self, $file, $dir) = @_;
 
 	# tempfile will croak() if there is an error
 	return tempfile("${file}_XXXXX",
@@ -324,7 +324,7 @@ sub store {
 	}
 
 	# generate a temporary file
-	my ($temp_fh, $tempname) = _tempfile_to_path($file, $dir);
+	my ($temp_fh, $tempname) = $self->_tempfile_to_path($file, $dir);
 	chmod 0666, $tempname
 		or warn "Couldn't change permissions to 0666 / -rw-rw-rw- for '$tempname': $!";
 
@@ -466,7 +466,7 @@ sub set_coderef_fh {
 	}
 
 	# generate a temporary file
-	my ($fh, $tempfile) = _tempfile_to_path($path, $dir);
+	my ($fh, $tempfile) = $self->_tempfile_to_path($path, $dir);
 
 	# code writes to filehandle or file
 	$code->($fh, $tempfile);
-- 
1.7.3
