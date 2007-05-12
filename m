From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Test if $from_id and $to_id are defined before comparison
Date: Sat, 12 May 2007 12:42:32 +0200
Message-ID: <200705121242.33156.jnareb@gmail.com>
References: <200705120135.30150.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 13:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmpM3-0002wS-CN
	for gcvg-git@gmane.org; Sat, 12 May 2007 13:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757094AbXELLBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 07:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757322AbXELLBh
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 07:01:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:57123 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094AbXELLBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 07:01:36 -0400
Received: by ug-out-1314.google.com with SMTP id 44so985589uga
        for <git@vger.kernel.org>; Sat, 12 May 2007 04:01:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZvHoabQ+VlyZ6A0sBC1V1McVDfvwKakM37B27e7GiqbI8y43BFYBmOM1MmjdX+15blq/Gyimd7X2QEJyDYNk7vgeFw8F50d9ndv9LJZ3Fbxm5+uqo7f94brMW1ys/ogUoeX9XaKtdVDflVqYCajJ+ZycmTj6jtsCQSQTCQir9nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WVEFuRcu/lABFoagDD4BL8SxGZZ7/urVM6PL3VYSQoxSC7cqNoyLJu9t46aBa8MAx3dM6CjJsjLtr4+eDbm4SGrwQYh/czV9uQ4SPl9juILL2v+eUXk6kmZvht4Zl83kVAzEimijYGh6i5PUqFApwCtqI7CUfVnbFqF4S4LRetE=
Received: by 10.67.11.15 with SMTP id o15mr3533564ugi.1178967695155;
        Sat, 12 May 2007 04:01:35 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id s1sm7707612uge.2007.05.12.04.01.33;
        Sat, 12 May 2007 04:01:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200705120135.30150.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47033>

Get rid of "Use of uninitialized value in string eq at
gitweb/gitweb.perl line 2320" warning caused by the fact that "empty"
patches, consisting only of extended git diff header and with patch
body empty, such as patch for pure rename, does not have "index" line
in extended diff header.  For such patches $from_id and $to_id, filled
from parsing extended diff header, are undefined.  But such patches
cannot be continuation patches.

Test if $from_id and $to_id are defined before comparing them with
$diffinfo.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This also fixes "Use of uninitialized value ..." error/warning, but this
time it is caused by something else than non-existent object (wrong value
of parameter).

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index afa0056..2b39502 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2664,9 +2664,10 @@ sub git_patchset_body {
 		# check if current patch belong to current raw line
 		# and parse raw git-diff line if needed
 		if (defined $diffinfo &&
+		    defined $from_id && defined $to_id &&
 		    from_ids_eq($diffinfo->{'from_id'}, $from_id) &&
 		    $diffinfo->{'to_id'} eq $to_id) {
-			# this is split patch
+			# this is continuation of a split patch
 			print "<div class=\"patch cont\">\n";
 		} else {
 			# advance raw git-diff output if needed
-- 
1.5.1.4
