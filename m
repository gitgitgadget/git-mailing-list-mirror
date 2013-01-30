From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
Subject: [PATCH 6/7] perl/Git.pm: make command pipe work in slurp-mode on Windows
Date: Wed, 30 Jan 2013 15:23:02 -0200
Message-ID: <1359566583-19654-7-git-send-email-gnustavo@cpan.org>
References: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
Cc: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 18:29:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0bTL-00014q-Ub
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163Ab3A3R2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:28:53 -0500
Received: from mail-yh0-f45.google.com ([209.85.213.45]:60226 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756194Ab3A3R2t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:28:49 -0500
Received: by mail-yh0-f45.google.com with SMTP id 24so302417yhr.4
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 09:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:x-gm-message-state;
        bh=HR+0SmUFi9VbtZjkOk/HO/1QsQ3YHCnVRbpL4g9CxmM=;
        b=C4dVSk0zqnGim4d6QSAxQu0ZNlyLbYaoB4d4/HX1dij6UtEtE5ktyfDbk2IRYglgeF
         8P0QAWUHVE8LIoBEKglr8hkp9eE6oUClUcEivxR2AQpurwq7DnLWwSc3DYDgQypsDu5g
         hOi+p2CIJO58oFvl6tRwG0hPzxMmQJmFPzZZ5u0zm8qKpxZCKkhdth5xvJKzQ8QPZal5
         tGoRXR+AWJnEvfmYKVYjo0A8x9yVAv1ZKNsqn+pNZzIq4MD96LByra7GrgybczBTK63V
         Dlgfq6QHCoeA70UwyNdXV7qxJJRxeVIYgEIYW2hxMbx+USRY9N0LOSXkVzFP0pSy4Uhm
         35cA==
X-Received: by 10.236.124.73 with SMTP id w49mr6592791yhh.62.1359566599386;
        Wed, 30 Jan 2013 09:23:19 -0800 (PST)
Received: from gnu.cpqd.com.br (fw-cpqd.cpqd.com.br. [189.112.183.66])
        by mx.google.com with ESMTPS id q11sm1689802anp.13.2013.01.30.09.23.17
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 09:23:18 -0800 (PST)
X-Mailer: git-send-email 1.7.12.464.g83379df.dirty
In-Reply-To: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
X-Gm-Message-State: ALoCoQlOrncyx2MOQJdheBWK2ipsSMG/PD5wbiV7ZOAp5NUOncL1nbR5PGoBt5GAZ8mw+/3Q90e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215038>

From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>

Git::activestate_pipe::READLINE implementation wasn't working when the
pipe was read in slurp-mode (i.e., with $/ undefined).

Now, when in slurp-mode it correctly returns the remaining lines
joined together.

Signed-off-by: Gustavo L. de M. Chaves <gnustavo@cpan.org>
---
 perl/Git.pm | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 2d88b89..fdef024 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1410,8 +1410,10 @@ sub READLINE {
 	return unless @{$self->{data}};
 	if (wantarray) {
 		return splice @{$self->{data}};
-	} else {
+	} elsif (defined $/) {
 		return shift @{$self->{data}};
+	} else {
+		return join('', splice @{$self->{data}});
 	}
 }
 
-- 
1.7.12.464.g83379df.dirty
