From: Matthew Daley <mattjd@gmail.com>
Subject: [PATCH] gitweb: Sort projects with undefined ages last
Date: Mon, 10 Dec 2012 17:34:21 +1300
Message-ID: <1355114061-4652-1-git-send-email-mattjd@gmail.com>
Cc: Matthew Daley <mattjd@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 05:34:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Thv4P-0007cX-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 05:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637Ab2LJEeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 23:34:04 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:52695 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab2LJEeC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 23:34:02 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1065620dak.19
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 20:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fG+EwPF5NS+GsbfHkMoQid2jVc4ItD5OJNxnBK8bfNI=;
        b=Ozp39GZfJqjX6/37CDNHoJ44g0yHXKwS979pF2+KK64J79KaZHzrsGmc3QIIpl7O7D
         zXJbrQuewXksyNy/sFc0fn3TbMbYC8tTFInPVlYfkJdefSIFO1zMolIsK+wnQ94ugg8O
         nLf+aMDE35leuys+TvOQVBPTpAE3zjgvcMGEQLgHyznNcEhxPwhZ2k57ZjmeM9nzN91N
         d6S2571K9fDTCtWEpZ9UfoD6oYBR3fP5vUgbRSOttzfmanOS006Od8hFu85SBofmkqve
         OArACKfTVBzepB2EpWwRyBW5rWzxanCAC6EzwIizEcbZbEDZKI2rn753/7GmqeoC9mUA
         nnwQ==
Received: by 10.68.237.6 with SMTP id uy6mr35402602pbc.147.1355114040290;
        Sun, 09 Dec 2012 20:34:00 -0800 (PST)
Received: from morphism.xen.prgmr.com (morphism.xen.prgmr.com. [71.19.145.114])
        by mx.google.com with ESMTPS id uh9sm11130221pbc.5.2012.12.09.20.33.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Dec 2012 20:33:59 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211248>

Sorting gitweb's project list by age ('Last Change') currently shows
projects with undefined ages at the head of the list. This results in a
less useful result when there are a number of projects that are missing
or otherwise faulty and one is trying to see what projects have been
updated recently.

Fix by sorting these projects with undefined ages at the bottom of the
list when sorting by age.

Signed-off-by: Matthew Daley <mattjd@gmail.com>
---
I realize this might be a bit bikesheddy, but it does improve the listing
in the given use case. For an example of the problem, see ie.
http://git.kernel.org/?o=age or http://repo.or.cz/w?a=project_list;o=age .

I'm also not a Perl native, so any advice on making the patch good Perl is
appreciated.

 gitweb/gitweb.perl |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0f207f2..21da1b5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5541,7 +5541,9 @@ sub sort_projects_list {
 	if ($oi->{'type'} eq 'str') {
 		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @$projlist;
 	} else {
-		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @$projlist;
+		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}}
+		            grep {defined $_->{$oi->{'key'}}} @$projlist;
+		push @projects, grep {!defined $_->{$oi->{'key'}}} @$projlist;
 	}
 
 	return @projects;
-- 
1.7.10.4
