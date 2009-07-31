From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: fix 'Use of uninitialized value' error in href()
Date: Fri, 31 Jul 2009 08:48:49 +0200
Message-ID: <1249022929-21037-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <200907310824.42953.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 08:48:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWluv-0005ps-B7
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 08:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbZGaGsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 02:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZGaGsT
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 02:48:19 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:43830 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbZGaGsE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 02:48:04 -0400
Received: by bwz19 with SMTP id 19so1022299bwz.37
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=h+hfLdIcR+ID7/tCH4qQpIwJVXFOe7TiiC1M6E1xymg=;
        b=T4nYdTWXDVQZmbs8cxvTsIpKMQWIkOL3n9Dzp8cVdM1iA0/sASiabsxPWQlJ3tlthb
         tVjLPWRMfmdopB7HejZLZ7v4yX4Vx457rS4TXWN4BlEUQ62ZYpG1O/GZLj5m3aML+OYt
         mLJSp5OirZQzYr2cEy3KhISFY70reXit2YPHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ajTvIEFIdiq2UDdOo2Mhl/V0w4F2b6nisFuj0TV9ByVlZ4wLi3Ca/1lRoPTeSQmGvT
         6FCscaRSmWDteb1L/TmfpdgGvsqhBfgKwHe8CTYi8ia5HSQoUKbTKCGGQNCl+GIkFiv2
         3hY0HY/64bxizIYX1qJ066/S30mRBjAVM0Wh4=
Received: by 10.204.53.72 with SMTP id l8mr1578825bkg.171.1249022883216;
        Thu, 30 Jul 2009 23:48:03 -0700 (PDT)
Received: from localhost (host-78-15-19-142.cust-adsl.tiscali.it [78.15.19.142])
        by mx.google.com with ESMTPS id 18sm2506559fks.40.2009.07.30.23.48.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Jul 2009 23:48:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <200907310824.42953.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124507>

Equality between file_parent and file_name was being checked without a
preliminary check for existence of the parameters.

Fix by wrapping the equality check in appropriate if (defined ...),
rearranging the lines to prevent excessive length.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

The funny thing is that I seem to get the error for something as simple
as a commit view (_any_ commit view, for the matter), but I wasn't able
to reproduce it from the shell, which is why I'm not adding a testcase.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fbd5ff..37120a3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -940,10 +940,13 @@ sub href {
 			if (defined $params{'hash_parent_base'}) {
 				$href .= esc_url($params{'hash_parent_base'});
 				# skip the file_parent if it's the same as the file_name
-				delete $params{'file_parent'} if $params{'file_parent'} eq $params{'file_name'};
-				if (defined $params{'file_parent'} && $params{'file_parent'} !~ /\.\./) {
-					$href .= ":/".esc_url($params{'file_parent'});
-					delete $params{'file_parent'};
+				if (defined $params{'file_parent'}) {
+					if (defined $params{'file_name'} && $params{'file_parent'} eq $params{'file_name'}) {
+						delete $params{'file_parent'};
+					} elsif ($params{'file_parent'} !~ /\.\./) {
+						$href .= ":/".esc_url($params{'file_parent'});
+						delete $params{'file_parent'};
+					}
 				}
 				$href .= "..";
 				delete $params{'hash_parent'};
-- 
1.6.3.rc1.192.gdbfcb
