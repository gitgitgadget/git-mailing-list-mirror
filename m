From: Brandon Turner <bt@brandonturner.net>
Subject: [PATCH] completion: ignore chpwd_functions when cding
Date: Tue,  7 Oct 2014 22:53:14 -0500
Message-ID: <1412740394-34061-1-git-send-email-bt@brandonturner.net>
Cc: Brandon Turner <bt@brandonturner.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 05:53:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbiJb-0006HO-Ka
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 05:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbaJHDxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 23:53:23 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33370 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbaJHDxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 23:53:22 -0400
Received: by mail-oi0-f50.google.com with SMTP id i138so6242102oig.37
        for <git@vger.kernel.org>; Tue, 07 Oct 2014 20:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brandonturner.net; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EBKb3Ku/6I8e3CP06VkXmKxhrHZPin3Qoki9Gyrt9NU=;
        b=gCEOJNKqVPrRl8RS5zIul9TsUFq3nKPTeOt2R9abHw3zidvz8qzQ99jjkCJeWgw8+Z
         uwkH0zTFNmkOkQN1QNXnu9+xAbPRoI2IYthgPZaO8abAr4brX5gMhkjPVfxWXzx72jN9
         itUw47cH68A9CutPuGmaEYToFIgBp1/Z0RaSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EBKb3Ku/6I8e3CP06VkXmKxhrHZPin3Qoki9Gyrt9NU=;
        b=IXLmsCgWkXHtLbFjVuIKIPcMLHCj7R+UK/kvxCXuQ5uI2F3yE6reMITQg30mfEw8EU
         7SiYcUBESiUmgLgsE1xk4D4VFqD6GWnYg6MT+rl3Jyh5g4oHrEC/H5TGtngF7rY0uAT1
         bHP7Ttqwf24ZsOuvN2sOGpfVJFCK2s7m0tgE8M6NWo46Tri5gvaViEqsCL+/6t5nkji2
         3SIX15uH7cthMWPMRuJczQHtIHU4WF/ydCapf7BG6oQKjK3IeDKCt4tjCADZTUZZECAc
         afZRdjM5rxfs2SAPhJn55urTAcqr9dWPhe0QyXKtuZ3/DTjtiJgyyZSarTTd140AGG+O
         wgKg==
X-Gm-Message-State: ALoCoQl8IYYuEQ30oqHtHpztyHXT5+6N74vodCWKjEj7W2VMm0WOhFS7++8hkDgN9iT4dAqG+V0H
X-Received: by 10.60.220.169 with SMTP id px9mr8837611oec.67.1412740401662;
        Tue, 07 Oct 2014 20:53:21 -0700 (PDT)
Received: from aus-mac-1035.bltweb.net (172-2-69-149.lightspeed.austtx.sbcglobal.net. [172.2.69.149])
        by mx.google.com with ESMTPSA id cq6sm13270298oeb.5.2014.10.07.20.53.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 20:53:21 -0700 (PDT)
X-Mailer: git-send-email 2.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Software, such as RVM (ruby version manager), may set chpwd functions
that result in an endless loop when cding.  chpwd functions should be
ignored.

Signed-off-by: Brandon Turner <bt@brandonturner.net>
---
For an example of this bug, see:
https://github.com/wayneeseguin/rvm/issues/3076

 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 06bf262..996de31 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -283,7 +283,8 @@ __git_ls_files_helper ()
 {
 	(
 		test -n "${CDPATH+set}" && unset CDPATH
-		cd "$1"
+		(( ${#chpwd_functions} )) && chpwd_functions=()
+		builtin cd "$1"
 		if [ "$2" == "--committable" ]; then
 			git diff-index --name-only --relative HEAD
 		else
-- 
2.1.2
