From: Andrew Wheeler <awheeler@motorola.com>
Subject: [ BUG ] push --force-with-lease status output signals a
 "fast-fowarded" push when the ref is force-updated
Date: Fri, 22 Jan 2016 15:47:58 -0600
Message-ID: <CAE=k0mv_Ouq=GbB-qWyRn9Js406Y0XwntyCp95JfOq3NGy+JzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 22:48:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMjZA-0006YO-0N
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 22:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbcAVVsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 16:48:20 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33717 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbcAVVsT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 16:48:19 -0500
Received: by mail-vk0-f54.google.com with SMTP id e64so48881328vkg.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=motorola-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=9fPUN8HJVwbWdW0kW66nD6X8EuEPLVVSkIN7fz9mqxE=;
        b=VT3fTLLQDPSmI0wRZclZbK2FjbMBGAvy8GRQLtPWwLhd76Ryvx0bTFpffbfg6abokq
         PIeI7ifgumulBBK5Rx/w4xoUOuAx0sr1V1kf5wu6eyfixUzhpRYRDz2ZJ7M9+ExO6Uux
         KmcfUUuaNBEBsEBXtK1sHBy85qbmItt8JJcmlpC9SebjL/ImmNR39uP3wnjSyubKFWGQ
         VZyFGicjCFVgBs467SGP+B52mAjgU3ex1JLr7csIOM6UeAZLjoeBSZBR7YdCJAkXRM1r
         4OxH8oRBskIhhfuo3xeyaWzgh/jOy/I61xPlirpEvXcB2AN99tLDkQV6eC97sLNAzGed
         oSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=9fPUN8HJVwbWdW0kW66nD6X8EuEPLVVSkIN7fz9mqxE=;
        b=C0kG5EM7OdjKxLNYJrz7/uDEwDiqi66qnZdqd2+OZQinTYrTXqsZE6aj7GKSSOYRn7
         04jc+7DVzA9REUNRakBdU2c0iNtcSLsp0rxwl481g8pJq/PrGDIzOcE7JcoG6KYcUpUQ
         8OfxJKGDchDQhmXYC1hjxbcvaZDcW9HUfwpsCiR/loBBQn90dEH5/7rvHdE0YeRIclhB
         +3viUVSNQ96TakA321wKwQHkHpUS/PBtLBbQwYHgX0YtjVIApJoeoPBGHI084LzZ7RmR
         U4zlgN3ZGe+BkCgNffYZr+V4DbZe9XCffzBaAi0E0HR28ms5/ex1HOttyl7rjAQ1KWQX
         ms+Q==
X-Gm-Message-State: AG10YOQHt1FuvEfe8K1zTKqgyVxGKoEbGYMc+DVUPAypxxM26j8F/CHa9gHTiz7ZYLqhOe25R2UPldFRBsAio4fd
X-Received: by 10.31.108.15 with SMTP id h15mr3479554vkc.24.1453499297858;
 Fri, 22 Jan 2016 13:48:17 -0800 (PST)
Received: by 10.103.84.77 with HTTP; Fri, 22 Jan 2016 13:47:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284593>

When using push --force the output reports if the reference(s) was
force-updated:

$ git push --force origin origin/master^:master
Total 0 (delta 0), reused 0 (delta 0)
To /home/thf876/gittest/m
 + cc44495...8302fcb origin/master^ -> master (forced update)


But when using push --force-with-lease the output reports that the
reference was "fast-forward" updated, even if the branch was
force-updated:

$ git push --force-with-lease origin origin/master^:master
Total 0 (delta 0), reused 0 (delta 0)
To /home/thf876/gittest/m
   a454b7f..cc44495  origin/master^ -> master

The main problem seems to be that ref.forced_update is never set in
remote.c.  I have a patch below that works-around the problem, but it
may be not the right approach.



commit 81d8b713ee83161dbd7eb3dafd22718d1fa992a1
Author: Andrew Wheeler <awheeler@motorola.com>
Date:   Tue Jan 19 15:23:32 2016 -0600

    push --force-with-lease: Fix ref status reporting

    The --force--with-lease push option leads to less
    detailed status information than --force. In particular,
    the output indicates that a reference was fast-forwarded,
    even when it was force-updated.

    Modify the --force-with-lease ref status logic to leverage
    the --force ref status logic when the "lease" conditions
    are met.

    Signed-off-by: Andrew Wheeler <awheeler@motorola.com>

diff --git a/remote.c b/remote.c
index 9d34b5a..bad6213 100644
--- a/remote.c
+++ b/remote.c
@@ -1545,11 +1545,8 @@ void set_ref_status_for_push(struct ref
*remote_refs, int send_mirror,
                }

                /*
-                * Bypass the usual "must fast-forward" check but
-                * replace it with a weaker "the old value must be
-                * this value we observed".  If the remote ref has
-                * moved and is now different from what we expect,
-                * reject any push.
+                * If the remote ref has moved and is now different
+                * from what we expect, reject any push.
                 *
                 * It also is an error if the user told us to check
                 * with the remote-tracking branch to find the value
@@ -1560,10 +1557,14 @@ void set_ref_status_for_push(struct ref
*remote_refs, int send_mirror,
                        if (ref->expect_old_no_trackback ||
                            oidcmp(&ref->old_oid, &ref->old_oid_expect))
                                reject_reason = REF_STATUS_REJECT_STALE;
+                       else
+                               /* If the ref isn't stale then force
the update. */
+                               force_ref_update = 1;
                }

                /*
-                * The usual "must fast-forward" rules.
+                * If the update isn't already rejected then check
+                * the usual "must fast-forward" rules.
                 *
                 * Decide whether an individual refspec A:B can be
                 * pushed.  The push will succeed if any of the
@@ -1580,9 +1581,10 @@ void set_ref_status_for_push(struct ref
*remote_refs, int send_mirror,
                 *
                 * (4) it is forced using the +A:B notation, or by
                 *     passing the --force argument
+                *
                 */

-               else if (!ref->deletion && !is_null_oid(&ref->old_oid)) {
+               if (!reject_reason && !ref->deletion &&
!is_null_oid(&ref->old_oid)) {
                        if (starts_with(ref->name, "refs/tags/"))
                                reject_reason =
REF_STATUS_REJECT_ALREADY_EXISTS;
                        else if (!has_object_file(&ref->old_oid))
thf876@slug:~/git$
