From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/6] gitweb: Improve "next" link in commitdiff view
Date: Fri, 08 Jun 2007 13:26:31 +0200
Message-ID: <20070608112502.3594.68102.stgit@roke.D-201>
References: <20070608112337.3594.93976.stgit@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 13:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwcWq-0001j5-Ig
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 13:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967747AbXFHLVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 07:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967875AbXFHLVJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 07:21:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:49659 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967747AbXFHLVH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 07:21:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so929520ugf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 04:21:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=FISLCRkeFs7Cn9tWo0VIp48bUMa1nfM8kkONNQ5sJxkVSnPjgBJ3PpCo0T0PC/Z+HYpAnOs2lO55ATIIUs8eLsKAoodEb/GVKXSGmwXwCsvalFhOYave7XUBVEGvDr/smE5eDX4yCWvAnEmnmTxFR01BltP6xx+4ENu6cyGFbAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=SEazTbrKBEcpwcIMlrJ++I9HOBOITVWFN5kdZV9EhTikkGTLP+7gyGfI9s/PjkJuJ86t+0k0SD5XY9ueQxVp9sf9A+uutxOZxLxoMmtsuVD5IOGxMaR9pybYM/CLWowUHLdTJUjyiR50lQl78mKIPpUFgVLxB4A9L8MgBlguJCc=
Received: by 10.82.112.3 with SMTP id k3mr5171644buc.1181301666242;
        Fri, 08 Jun 2007 04:21:06 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id i4sm664328nfh.2007.06.08.04.21.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2007 04:21:05 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l58BQVwj003641;
	Fri, 8 Jun 2007 13:26:31 +0200
In-Reply-To: <20070608112337.3594.93976.stgit@roke.D-201>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49465>

Check if 'hp' (hash_parent) parameter to 'commitdiff' view is one of
'h' (hash) commit parents, i.e. if commitdiff is of the form
"<commit>^<n> <commit>", and mark it as such in the bottom part of
navigation bar. The "next" link in commitdiff view was introduced
in commit 151602df00b8e5c5b4a8193f59a94b85f9b5aebc

If 'hb' is n-th parent of 'h', show the following at the bottom
of navigation bar:
  (from parent n: _commit_)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is sort of companion to previous commit, meaning thatI'd like to
see if I came from link to diff to one of parents in a merge commit.
Purely decoration, but I think it is nice.

 gitweb/gitweb.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e2d5222..4561d4e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4479,7 +4479,14 @@ sub git_commitdiff {
 				$hash_parent_short = substr($hash_parent, 0, 7);
 			}
 			$formats_nav .=
-				' (from: ' .
+				' (from';
+			for (my $i = 0; $i < @{$co{'parents'}}; $i++) {
+				if ($co{'parents'}[$i] eq $hash_parent) {
+					$formats_nav .= ' parent ' . ($i+1);
+					last;
+				}
+			}
+			$formats_nav .= ': ' .
 				$cgi->a({-href => href(action=>"commitdiff",
 				                       hash=>$hash_parent)},
 				        esc_html($hash_parent_short)) .
