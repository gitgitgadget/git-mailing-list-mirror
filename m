From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 05/17] gitweb/lib - Regenerate entry if the cache file has size of 0
Date: Thu,  7 Oct 2010 00:01:50 +0200
Message-ID: <1286402526-13143-6-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5j-0002Gb-Tx
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759936Ab0JFWCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:02:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53578 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab0JFWCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:39 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49472bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eNJJJ7XOYN44pONYZddE/66xs57tVJ0mCFNsuu/d/Co=;
        b=By9ydnn9080M/tXc5MzP51jCQhojksDpAc2L/Ru/Zpe2tUZNzNhWlkMMBT67SAzPBR
         VTHzE8v8F+BxEJdtvqp7hzbfZskCmPGQo0QSkNbSKxa10Q4U4DoUjhQ8TyY9F/eIFNo8
         yisrnKs+ag1txHWg/XeS9KWhnnAg7rVFnbKHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Mr1W4EZhwC7ai01lMhxKAco9Q9i5U0WOrRhYLK7VJD3qIQZuGglbNmgTjpg/i47yrV
         i5CEM20KFDiMAHikvML44HPrDAvPkf7g7yk/1V4IroAxWiEJg3ybfNaOBmuQAnRB4sRi
         o/qJNIGXhsSynDAB56stXbkvVRDmgPbrt69vY=
Received: by 10.204.72.209 with SMTP id n17mr10322892bkj.52.1286402557674;
        Wed, 06 Oct 2010 15:02:37 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158315>

If the file representing cache entry has size 0 (in bytes), the cache
entry is considered invalid, regardless of its freshness, even if cache
expiration is turned off.

[jh: This is a quick, and thankfully easy, check to regenerate the
cache if the resulting file is of size 0.  This *SHOULDN'T* happen,
but it is possible that it could and thus adding the check.]

Based-on-commit-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new and wasn't present in previous version of this
series.

It is inspired by commit 22eb7af (Gitweb - Regenerate the cache if the
resulting file has size of 0, 2010-09-23) on 'master' branch of
git/warthog9/gitweb.git repository on git.kernel.org

 gitweb/lib/GitwebCache/SimpleFileCache.pm |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 74d7246..6833699 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -295,6 +295,8 @@ sub is_valid {
 	# get its modification time
 	my $mtime = (stat(_))[9] # _ to reuse stat structure used in -f test
 		or die "Couldn't stat file '$path': $!";
+	# cache entry is invalid if it is size 0 (in bytes)
+	return 0 unless ((stat(_))[7] > 0);
 
 	# expire time can be set to never
 	my $expires_in = $self->get_expires_in();
-- 
1.7.3
