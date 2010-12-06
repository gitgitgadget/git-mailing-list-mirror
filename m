From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 05/24] gitweb/lib - Regenerate entry if the cache file has size of 0
Date: Tue,  7 Dec 2010 00:10:50 +0100
Message-ID: <1291677069-6559-6-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:20:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkM2-0003kw-RK
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab0LFXUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:20:14 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:54993 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab0LFXUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:20:13 -0500
Received: by ewy10 with SMTP id 10so7585538ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ipBsaVNGET4DjAgVg7w3eXv2WHSEXhaOos7q+ti4lzU=;
        b=O5xQ+kD0zwgQUQ+GUhnpA1BThODDfHrgF1Mqrh23mUWemdG7KBR2Nl6QLQaJesqV9g
         3sR6181Z0TbDA38o+C1Ur4GZdv00LsrgAIpiIfmG5z/52C9p8bforAY/egJeoe/byUon
         q4SfiUIxEaoMSxx2rI9QsRDboFyJfoekChxJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W9nrBvDKdxEVrqhnu4d/x9c6zTbVSVNiItZJf+yfNVwnrBRG2iVt10ay9tViVVEQZM
         anoEbZrn+NEAHcUGd94eQWBfDqLgZ3mHbliU3nUQEOzBafcKitaXz2issYq+G27AwNsf
         8GxXb2/toGoJh0HvOqj0OiicdRHhu+kXkgs8Y=
Received: by 10.213.14.145 with SMTP id g17mr6607013eba.77.1291677115138;
        Mon, 06 Dec 2010 15:11:55 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.11.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:11:54 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163057>

If the file representing cache entry has size 0 (in bytes), the cache
entry is considered invalid, regardless of its freshness, even if cache
expiration is turned off.

[jh: This is a quick, and thankfully easy, check to regenerate the
cache if the resulting file is of size 0.  This *SHOULDN'T* happen,
but it is possible that it could and thus adding the check.]

Based-on-commit-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from previos version of this series.

It is inspired by commit 22eb7af (Gitweb - Regenerate the cache if the
resulting file has size of 0, 2010-09-23) on 'master' branch of
git/warthog9/gitweb.git repository on git.kernel.org

The "gitweb: File based caching layer (from git.kernel.org)" in
"Gitweb caching v7" by J.H. incudes the same test.

 gitweb/lib/GitwebCache/SimpleFileCache.pm |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 790383d..bf74f7c 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -310,6 +310,8 @@ sub is_valid {
 	# get its modification time
 	my $mtime = (stat(_))[9] # _ to reuse stat structure used in -f test
 		or die "Couldn't stat file '$path': $!";
+	# cache entry is invalid if it is size 0 (in bytes)
+	return 0 unless ((stat(_))[7] > 0);
 
 	# expire time can be set to never
 	my $expires_in = $self->get_expires_in();
-- 
1.7.3
