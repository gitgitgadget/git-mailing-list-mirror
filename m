From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 12/17] gitweb/lib - No need for File::Temp when locking
Date: Thu,  7 Oct 2010 00:01:57 +0200
Message-ID: <1286402526-13143-13-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5q-0002Gb-4c
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247Ab0JFWDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:03:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53578 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223Ab0JFWDA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:03:00 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49472bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JugK5E1BhkxGwGYNlN/jQKVS9FASZ6QlMnuYN9GPNz0=;
        b=LxeIfL4h9HS71Q6s+WJ8yWje9zeG6NfOHwvB82MRe8FZITfaWCftdLIcuNVHei2XVE
         YQzgZdhyWPeDnV7mct6bUHKYC+qxFE1nChFhhJa6cRRd5jSkB5g+4LSrpbI7OTqR3bny
         hHglCklmq4jTZdBpCMNRiT3niho3NcQfnrxKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rzcIjPXfxo5ZHr4roJwN0xq6UMj7XU7KtmQ3eMuG/YHkl3z9Opv/ULmuHH/HE2/Zgx
         lEWaAj9BERvmUMrATrjw1GNvujj+Pj/d5l1m8ww0OMXqu769cNM54mmbX+8EHDz0dC9Q
         uwRooMcP3eic5IIX9mdxtgbJVITC3wVYyk1ek=
Received: by 10.204.51.67 with SMTP id c3mr10211331bkg.69.1286402573476;
        Wed, 06 Oct 2010 15:02:53 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.51
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158329>

When using locking to ensure that only one process is generating data
and updating cache, there is no need to use File::Temp for temporary
file.  This should improve performance.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was not present in previous v4 version of this series.  It
brings this solution closer to the one in J.H. patch, because with
locking it does not use File::Temp; the locking is safety enough by
itself.

 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index c91c0ee..e69047e 100644
--- a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -38,6 +38,22 @@ sub get_lockname {
 	return $self->path_to_key(@_) . '.lock';
 }
 
+# ----------------------------------------------------------------------
+# "private" utility functions and methods
+
+# take a file path to cache entry, and its directory
+# return filehandle and filename of open temporary file,
+# like File::Temp::tempfile
+sub _tempfile_to_path {
+	my ($file, $dir) = @_;
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
 
-- 
1.7.3
