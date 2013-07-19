From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 1/1] Git.pm: revert _temp_cache use of temp_is_locked
Date: Thu, 18 Jul 2013 17:16:16 -0700
Message-ID: <7c02d1e993907797fab2731677a1367@f74d39fa044aa309eaea14b9f57fe79>
References: <3e0c11386c2e091f09c554bf0ba091d@f74d39fa044aa309eaea14b9f57fe79>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 02:16:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzyN5-00041P-IA
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 02:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934820Ab3GSAQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 20:16:28 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:59271 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759509Ab3GSAQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 20:16:27 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so3746118pab.7
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B6kV1ApOXVVXy/zcWXtcATFzs1DMQb/uIfES+547kIU=;
        b=lbc5XPuJPyJUBsbz4bEyGDbslpU3yGWUxXdxHPPdZ3jZ3rbBOo19qLwvXF3xAO7Ype
         PAqTFbmRDxehqSmKOq/5TYJcpQ0KKOujlKCWp5s8esQWayf5K+7dyrPnKzIthBAN6a8y
         8uQWwipHKW6jaSKLbXPsDmzOPIE0SjYjNq/EeHX/aHlSkSkjfErMEDWnJwBJHPk5cYgF
         sSDFmXD0qjTuXR/cuJ9zwX4hJtRkZkC/WnI1W0OzxgacMiQ9dK/H0Wq6XzmkNiQSman8
         M321MyeIiGhZpZux5yRVAFDGNkP7/QzE8+1l0RV2zOt5IGw7fu9+3431NzCuYvEkhcEu
         cS4g==
X-Received: by 10.68.1.226 with SMTP id 2mr14202733pbp.150.1374192986716;
        Thu, 18 Jul 2013 17:16:26 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id mr3sm16136191pbb.27.2013.07.18.17.16.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 17:16:26 -0700 (PDT)
In-Reply-To: <3e0c11386c2e091f09c554bf0ba091d@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230771>

When the temp_is_locked function was introduced, there was
a desire to make _temp_cache use it.  Unfortunately due to the
various tests and logic flow involved changing the _temp_cache
function to use the new temp_is_locked function is problematic
as _temp_cache needs a slightly different test than is provided
by the temp_is_locked function.

This change reverts use of temp_is_locked in the _temp_cache
function and restores the original code that existed there
before the temp_is_locked function was added.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 0ba15b9..204fdc6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1277,7 +1277,7 @@ sub _temp_cache {
 
 	my $temp_fd = \$TEMP_FILEMAP{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
-		if (temp_is_locked($name)) {
+		if ($TEMP_FILES{$$temp_fd}{locked}) {
 			throw Error::Simple("Temp file with moniker '" .
 				$name . "' already in use");
 		}
-- 
1.8.3
