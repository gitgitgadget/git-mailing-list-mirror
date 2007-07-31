From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Allow for multivalued parameters passed to href subroutine
Date: Tue, 31 Jul 2007 13:19:49 +0200
Message-ID: <1185880790812-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 13:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFplu-0001hb-6C
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 13:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbXGaLUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 07:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755007AbXGaLUI
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 07:20:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37607 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858AbXGaLUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 07:20:06 -0400
Received: by ug-out-1314.google.com with SMTP id j3so62058ugf
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 04:20:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=JqDaofpxrWZQhJp8yFT0HHxN4Gy4oZ8dK92vcNT4j89iFyctczmAXXHiLmDZ5O3cpHQgD41Ut/fD+ouoK2AKVpYa//UAhZCF4+Afib8z28+Pej2ZW5B3LRscnxXHr1Z4wH9jX+W3vvoAyN/IHPkRvp92u5zFn9f41cf3f//QNr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=hgZIx3yZ+yztpJOiodBwrwEEDoYMdlc1PEsc8IhslvVMwGm1qpsYAzt8Wb+gECW6VI7aaFz1gxqTXSZedK4qx7lhqFqascoNoZ6y7sc7zX/UWDYrxhTnTxidpM+2G9wWgdv54Vi/6DzvW538UI+bVFZkL/6efvvKKDQqVPKiBng=
Received: by 10.67.27.16 with SMTP id e16mr500784ugj.1185880804419;
        Tue, 31 Jul 2007 04:20:04 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTPS id c22sm8203563ika.2007.07.31.04.19.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2007 04:19:57 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6VBJqBT031947;
	Tue, 31 Jul 2007 13:19:53 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6VBJoks031946;
	Tue, 31 Jul 2007 13:19:50 +0200
X-Mailer: git-send-email 1.5.3.rc3.28.gd208c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54335>

Make it possible to generate URLs with multivalued parameters in the
href() subroutine, via passing reference to array of values.

Example:
  href(action=>"log", extra_options=>["--no-merges", "--first-parent"])

This also allows for easy passing back (replaying) current value
of, possibly multivalued, extra_options ('opt') parameter, using:

  href(..., extra_options=>\@extra_options)

which would be required when we start using extra_options in gitweb,
and would want to preserve its value.  For example when creating links
to next/previous page of 'log' or 'history' view output, we would want
to preserve '--no-merges' and/or '-first-parent' extra options.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is the same patch as sent earlier, but with more detailed commit
message.  As the previous version made it into git.git, this is just
for archives.

 gitweb/gitweb.perl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8a32899..498b936 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -629,7 +629,13 @@ sub href(%) {
 	for (my $i = 0; $i < @mapping; $i += 2) {
 		my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
 		if (defined $params{$name}) {
-			push @result, $symbol . "=" . esc_param($params{$name});
+			if (ref($params{$name}) eq "ARRAY") {
+				foreach my $par (@{$params{$name}}) {
+					push @result, $symbol . "=" . esc_param($par);
+				}
+			} else {
+				push @result, $symbol . "=" . esc_param($params{$name});
+			}
 		}
 	}
 	$href .= "?" . join(';', @result) if scalar @result;
-- 
1.5.2.4
