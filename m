From: "Ray Chuan" <rctay89@gmail.com>
Subject: [PATCH] Git.pm: release hash and blob handles
Date: Sun, 12 Oct 2008 03:29:28 +0800
Message-ID: <be6fef0d0810111229u60c28671w1afd952200c6fa23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 11 21:30:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KokAn-0002UX-5z
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 21:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706AbYJKT3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 15:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbYJKT3b
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 15:29:31 -0400
Received: from ti-out-0910.google.com ([209.85.142.189]:30182 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467AbYJKT3a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 15:29:30 -0400
Received: by ti-out-0910.google.com with SMTP id b6so549836tic.23
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=6xM2TVjx5vRD107WegKw+CHZNuGIiMbKAZUwnzwe4jg=;
        b=vGMSQV5Vcop4Dugbb+XC5Rn3OsXgV7Iti6YES8m6lQycul2g0Ta+8qqWvErJoS+UZG
         DvYv/h7L3+lJ+ozwqoCRJ7B58PHcYD87kOXoP7vntidVBcUq219s4i5IlIH2UHHLxXZg
         9BXOiRwUNexLU/f1ABTXVLMiLLidsRy88Kpp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ZcN7Bc8pcL6qfCLdAOJBo2DCp2WO2HrrlbnZyms5GDxkSAFIP5JtXzYm+DGkj9wKyD
         WAW8MSyXalJVMvNb9Kxmd75FpFRr4D2waZyY1FhboyXRwBV6WqA3tMVZWyNJ/hG72mPm
         Az69tfEhZVNqlk1SozgErMhW6pTwforJVC+Xo=
Received: by 10.110.43.20 with SMTP id q20mr3331697tiq.15.1223753368621;
        Sat, 11 Oct 2008 12:29:28 -0700 (PDT)
Received: by 10.110.61.9 with HTTP; Sat, 11 Oct 2008 12:29:28 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97988>

the methods

 * hash_and_insert_object
 * cat_blob

use bidirectional pipes to pull/push data from the various git
utilities, but they don't close them after this is complete. this
denies Git's subsequent attempts to use these resources, leading to
failure.

a simple, reproducible test case can be seen at
http://rctay.spaces.live.com/blog/cns!59D3BFCD027B09E5!792.entry.

Signed-off-by: Tay Ray Chuan <rctay89 <at> gmail.com>
---
 perl/Git.pm |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 6aab712..7e17f38 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -821,6 +821,7 @@ sub hash_and_insert_object {
 		throw Error::Simple("in pipe went bad");
 	}

+	$self->_close_hash_and_insert_object();
 	return $hash;
 }

@@ -910,6 +911,7 @@ sub cat_blob {
 		throw Error::Simple("couldn't write to passed in filehandle");
 	}

+	$self->_close_cat_blob();
 	return $size;
 }

--
1.6.0.2
