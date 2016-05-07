From: Richard Braun <rbraun@sceen.net>
Subject: [PATCH] gitweb: fix link to parent diff with pathinfo
Date: Sat,  7 May 2016 02:11:42 +0200
Message-ID: <1462579902-18907-1-git-send-email-rbraun@sceen.net>
References: <xmqqmvo225fg.fsf@gitster.mtv.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 02:11:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aypqa-0004Vt-LG
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 02:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758935AbcEGALq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 20:11:46 -0400
Received: from shattrath.sceen.net ([151.80.19.218]:37973 "EHLO mail.sceen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756722AbcEGALq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 20:11:46 -0400
Received: by mail.sceen.net (Postfix, from userid 1000)
	id 7FD894033D; Sat,  7 May 2016 02:11:42 +0200 (CEST)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <xmqqmvo225fg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293870>

Gitweb, when used with PATH_INFO, shows a link to parent diff
like http://somedomain/somerepo.git/commitdiff/somehash?hp=parenthash.
That link reports "400 - Invalid hash parameter".

As I understand it, it should instead directly point to the parent diff,
i.e. turn it into http://somedomain/somerepo.git/commitdiff/parenthash,
and delete 'hash_parent' element from the %params hash once we used it,
otherwise the '?hp=parenthash' string is appended.

Signed-off-by: Richard Braun <rbraun@sceen.net>
---
 gitweb/gitweb.perl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05d7910..f7f7936 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1423,7 +1423,12 @@ sub href {
 			delete $params{'hash'};
 			delete $params{'hash_base'};
 		} elsif (defined $params{'hash'}) {
-			$href .= esc_path_info($params{'hash'});
+			if (defined $params{'hash_parent'}) {
+				$href .= esc_path_info($params{'hash_parent'});
+				delete $params{'hash_parent'};
+			} else {
+				$href .= esc_path_info($params{'hash'});
+			}
 			delete $params{'hash'};
 		}
 
-- 
2.1.4
