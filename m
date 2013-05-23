From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] git-send-email: another fix for special characters
Date: Thu, 23 May 2013 17:13:52 +0300
Message-ID: <20130523141352.GA21462@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 23 16:13:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfWGs-00038D-JI
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 16:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757592Ab3EWONa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 10:13:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59693 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757549Ab3EWON3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 10:13:29 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NEDTH2016243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 23 May 2013 10:13:29 -0400
Received: from redhat.com (vpn-202-161.tlv.redhat.com [10.35.202.161])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4NEDRkN006197
	for <git@vger.kernel.org>; Thu, 23 May 2013 10:13:28 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225248>

When patch sender's name has special characters,
git send-email did not quote it before matching
against the author name.
As a result suppress_cc = self did not work:
sender is still Cc'd.

Fix by sanitizing before matching to patch author name.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-send-email.perl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c4dc438..a3fed7c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1309,7 +1309,10 @@ foreach my $t (@files) {
 			elsif (/^From:\s+(.*)$/i) {
 				($author, $author_encoding) = unquote_rfc2047($1);
 				next if $suppress_cc{'author'};
-				next if $suppress_cc{'self'} and $author eq $sender;
+				if ($suppress_cc{'self'}) {
+                                    my $sanitized_sender = sanitize_address($sender);
+                                    next if $author eq $sanitized_sender;
+                                }
 				printf("(mbox) Adding cc: %s from line '%s'\n",
 					$1, $_) unless $quiet;
 				push @cc, $1;
-- 
MST
