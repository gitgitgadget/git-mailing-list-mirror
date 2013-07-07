From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v3 1/2] Git.pm: add new temp_is_locked function
Date: Sat,  6 Jul 2013 21:20:48 -0700
Message-ID: <1373170849-9150-2-git-send-email-mackyle@gmail.com>
References: <1373170849-9150-1-git-send-email-mackyle@gmail.com>
Cc: David Rothenberger <daveroth@acm.org>, Petr Baudis <pasky@ucw.cz>,
	Daniel Shahaf <danielsh@apache.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 06:21:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvgTQ-0003fc-S7
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 06:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab3GGEVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 00:21:18 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43169 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3GGEU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 00:20:58 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so3028945pdi.11
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 21:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=otg6Gh73tWBgkckwG5ZCnzeNwrV3Ve6mtEc7Vv6ECfg=;
        b=TanhScVksNXz26EuLq3HTsP4S7zTLzcu3C2QmW+TK+xDiks6w4R+iYoxuNEsmf6mar
         ifwaAx/nzZszcmqBIQRh4yTAiDqx2aGLSWPvnZ/Ljcg0IwtfJigDOa8xx4wqjG0i8oQO
         lS8BiMXM00RUp8omTleY3yRp/cbH5F06SUJMkIlkP+pO4s9MUn08z7rK8+QGMGgc8l6U
         todXPWIcWahKE2HIET4bON0ZbE4BsdWgIkmJCW7/zxm3QGBxKcQzvkyBGm9CCZ0bRQaI
         yF5AHoaWZmnnsIj5xZOfk6wS0JPpIj5OlVUNjO/JrsuO9dSow0SaRqqiQISL42mtngCx
         eWQg==
X-Received: by 10.68.113.194 with SMTP id ja2mr15844493pbb.65.1373170857542;
        Sat, 06 Jul 2013 21:20:57 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qe10sm15179401pbb.2.2013.07.06.21.20.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 21:20:56 -0700 (PDT)
In-Reply-To: <1373170849-9150-1-git-send-email-mackyle@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229730>

From: "Kyle J. McKay" <mackyle@gmail.com>

The temp_is_locked function can be used to determine whether
or not a given name previously passed to temp_acquire is
currently locked.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 perl/Git.pm | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 7a252ef..0ba15b9 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -61,7 +61,7 @@ require Exporter;
                 remote_refs prompt
                 get_tz_offset
                 credential credential_read credential_write
-                temp_acquire temp_release temp_reset temp_path);
+                temp_acquire temp_is_locked temp_release temp_reset temp_path);
 
 
 =head1 DESCRIPTION
@@ -1206,6 +1206,35 @@ sub temp_acquire {
 	$temp_fd;
 }
 
+=item temp_is_locked ( NAME )
+
+Returns true if the internal lock created by a previous C<temp_acquire()>
+call with C<NAME> is still in effect.
+
+When temp_acquire is called on a C<NAME>, it internally locks the temporary
+file mapped to C<NAME>.  That lock will not be released until C<temp_release()>
+is called with either the original C<NAME> or the L<File::Handle> that was
+returned from the original call to temp_acquire.
+
+Subsequent attempts to call C<temp_acquire()> with the same C<NAME> will fail
+unless there has been an intervening C<temp_release()> call for that C<NAME>
+(or its corresponding L<File::Handle> that was returned by the original
+C<temp_acquire()> call).
+
+If true is returned by C<temp_is_locked()> for a C<NAME>, an attempt to
+C<temp_acquire()> the same C<NAME> will cause an error unless
+C<temp_release> is first called on that C<NAME> (or its corresponding
+L<File::Handle> that was returned by the original C<temp_acquire()> call).
+
+=cut
+
+sub temp_is_locked {
+	my ($self, $name) = _maybe_self(@_);
+	my $temp_fd = \$TEMP_FILEMAP{$name};
+
+	defined $$temp_fd && $$temp_fd->opened && $TEMP_FILES{$$temp_fd}{locked};
+}
+
 =item temp_release ( NAME )
 
 =item temp_release ( FILEHANDLE )
@@ -1248,7 +1277,7 @@ sub _temp_cache {
 
 	my $temp_fd = \$TEMP_FILEMAP{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
-		if ($TEMP_FILES{$$temp_fd}{locked}) {
+		if (temp_is_locked($name)) {
 			throw Error::Simple("Temp file with moniker '" .
 				$name . "' already in use");
 		}
-- 
1.8.3
