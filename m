From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v2 1/2] Git.pm: add new temp_is_locked function
Date: Sat,  6 Jul 2013 20:39:56 -0700
Message-ID: <1373168397-7360-2-git-send-email-mackyle@gmail.com>
References: <1373168397-7360-1-git-send-email-mackyle@gmail.com>
Cc: David Rothenberger <daveroth@acm.org>, Petr Baudis <pasky@ucw.cz>,
	Daniel Shahaf <danielsh@apache.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 05:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvfq2-0002xF-Ub
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 05:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab3GGDkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 23:40:16 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:46397 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab3GGDkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 23:40:06 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so3025409pdi.21
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 20:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dsrjF1qj2EkX4IQatSF3rFnBJo0LpU9IkXM5+H3MHTU=;
        b=RP5XR7YIxrjdnhdJkoJfPDIAK7Ey9NoRmzczNJvPqaEd1wXpk7AnYcPB++oYmuLeq5
         Bo1+ier9klfBB/ffp53Fy8igHl9PspMiaHrqwhv+nZdswWeenkfYTKh4GYkXmzhqzeqm
         2rCaCmCDnKOyEq+bM335sZ8PVGtetZK4ThmrFehQMtErchV6qC3TeLcJ3F7VvRpp3lwg
         p/4lj5G3T8kgjyrP0Q9bRiwjZGRVtJwhsNdgMC31YfwPqCCO4Rk46wTKG7mqVOhb1EfC
         k2IzqYbCup3FIt4JS1MpVjsPuq11J84PodAPE5VHhxFGi3GWazIkpx8Pa0BgPZAOKNWA
         Zipg==
X-Received: by 10.66.228.7 with SMTP id se7mr17297745pac.62.1373168405719;
        Sat, 06 Jul 2013 20:40:05 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wg6sm15027459pbc.3.2013.07.06.20.40.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 20:40:05 -0700 (PDT)
In-Reply-To: <1373168397-7360-1-git-send-email-mackyle@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229722>

From: "Kyle J. McKay" <mackyle@gmail.com>

The temp_is_locked function can be used to determine whether
or not a given name previously passed to temp_acquire is
currently locked.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 perl/Git.pm | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 7a252ef..74d9a73 100644
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
@@ -1247,11 +1276,9 @@ sub _temp_cache {
 	_verify_require();
 
 	my $temp_fd = \$TEMP_FILEMAP{$name};
-	if (defined $$temp_fd and $$temp_fd->opened) {
-		if ($TEMP_FILES{$$temp_fd}{locked}) {
-			throw Error::Simple("Temp file with moniker '" .
-				$name . "' already in use");
-		}
+	if (temp_is_locked($name)) {
+		throw Error::Simple("Temp file with moniker '" .
+			$name . "' already in use");
 	} else {
 		if (defined $$temp_fd) {
 			# then we're here because of a closed handle.
-- 
1.8.3
