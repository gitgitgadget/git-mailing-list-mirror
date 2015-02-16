From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 2/3] request-pull: use "git tag --points-at" to detect local tags
Date: Mon, 16 Feb 2015 19:16:07 +0100
Message-ID: <1424110568-29479-3-git-send-email-bonzini@gnu.org>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 19:16:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNQDj-0008Dp-EQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 19:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbbBPSQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 13:16:25 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:51339 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069AbbBPSQW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 13:16:22 -0500
Received: by mail-wi0-f169.google.com with SMTP id em10so26859169wid.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HJnVmuurb5oNv/mX7dcMQZormCePnavFzbor1kr5bQI=;
        b=R8aOO76tMUu05FwcV3NicBpmv7wd1DkYnyQ7qVBCm79ejsb9o05kLLvo+4sd8ZHczy
         pqbL7lskTLcLZlqVEPTjC6DvNr6Fbb8nt4TNcepYkOKvhLRdWxFeIlgkpLr39I9Gsi+t
         AK54+rW20gNFoezwCKohnZ/bFrdpQxDyNXbLrEomaJ/UZcb1EbbK/mWNZHFOAoYGiotO
         9H6szy0WRkyYkpdCpO9enzqFXmdVS2gcHLg7qa1+1WAddDLdhJPfdFTUkwbR5zJCbv1r
         pQtyo/rz0PeWRVBZ6UkeIej2ad4OiSaNWGcws5KiyUKNpysaDpgnhUMsu9fTf/V2Km/O
         VW4g==
X-Received: by 10.180.35.33 with SMTP id e1mr47999542wij.49.1424110580964;
        Mon, 16 Feb 2015 10:16:20 -0800 (PST)
Received: from donizetti.redhat.com (net-93-66-73-217.cust.vodafonedsl.it. [93.66.73.217])
        by mx.google.com with ESMTPSA id et4sm23920115wjd.15.2015.02.16.10.16.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2015 10:16:20 -0800 (PST)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263908>

From: Paolo Bonzini <pbonzini@redhat.com>

If the third argument is not passed, "git show-ref --tags HEAD" will
never return anything and git-request-pull will never detect a tag
name.

Instead, "git tag --points-at" can find it.  Use it if "git show-ref"
fails.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 git-request-pull.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index d5500fd..a507006 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -58,6 +58,7 @@ pretty_remote=${remote#refs/}
 pretty_remote=${pretty_remote#heads/}
 head=$(git symbolic-ref -q "$local")
 head=${head:-$(git show-ref --heads --tags "$local" | cut -d' ' -f2)}
+head=${head:-$(git tag --points-at "$local" | sed 's,^,refs/tags/,')}
 head=${head:-$(git rev-parse --quiet --verify "$local")}
 
 # None of the above? Bad.
-- 
2.3.0
