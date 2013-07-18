From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v4 1/2] Git.pm: add new temp_is_locked function
Date: Thu, 18 Jul 2013 12:15:28 -0700
Message-ID: <59bf58623f9a0e344af1d2055673b54@f74d39fa044aa309eaea14b9f57fe79>
References: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rothenberger <daveroth@acm.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 21:15:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uztg1-0001zS-7d
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 21:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933658Ab3GRTPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 15:15:42 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:59474 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933119Ab3GRTPl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 15:15:41 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so3492169pbb.20
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fqlV3VIOEGkid2LyTmpAfMdFzV57utklEF47KKFGSYk=;
        b=VA26SWKrv/pz3mipuneCZngO5nrysBJ1KBfRvaWXgTE5cZHt+nx/id1WiPKBEw67+T
         i/5CbJkifb8FWH/pA4hO0m/A8ggVOHgPZzDijkZzShM0iYH0XEFhdeyYEea9JQb5g993
         yHMqUBU9lgV+lqleDUlZAj4A0tcDxVDK9UScE51JvXP/5riwXX3iJD7DaN7gOIibb9Vr
         EvAvWqyLch6Ig2sJs6U4HX1Nw4l1GwQXbhzPx8XWdEfFm1383dXOVhv+U/qlu1D79m/o
         B0ab3Nu/Zs64HXWJMdd4lk29o8M16T/gNQMrLLEvEen/UJXCHfBXdEXOvmpaXSjDdo8Y
         +20Q==
X-Received: by 10.68.182.162 with SMTP id ef2mr13482138pbc.173.1374174940498;
        Thu, 18 Jul 2013 12:15:40 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id sq5sm18223018pab.11.2013.07.18.12.15.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 12:15:39 -0700 (PDT)
In-Reply-To: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230725>

The temp_is_locked function can be used to determine whether
or not a given name previously passed to temp_acquire is
currently locked.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 perl/Git.pm | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 7a252ef..204fdc6 100644
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
-- 
1.8.3
