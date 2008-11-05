From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] gitweb: Use single implementation of export_ok check.
Date: Thu, 6 Nov 2008 01:15:56 +0300
Organization: HOME
Message-ID: <200811060115.57168.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 23:19:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxqiZ-0003dP-Js
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 23:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbYKEWR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 17:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbYKEWR6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 17:17:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:41790 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbYKEWR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 17:17:57 -0500
Received: by fg-out-1718.google.com with SMTP id 19so151293fgg.17
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 14:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ifMKgzxZNleV0ofPg3U2+2jXw16yWGVKR0q+wZGXmUE=;
        b=QcqjoZ+/B7AIV25iPO8CRdC1c8rNMLI0QOiu6GrXkRd0ACn82hkjVJCfAt3gUAWZ7y
         +qbfgBAInPQD6GSaAOGKcIp6aJU+m3JIxF7vJNiixuyg6LdrxkZIGVuFuFdI/Q6BwUda
         nEn5rkDhIrv72qPgldY/wIMA1FPs54BTTeD6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=h/4lPYIsIjHdri61oA7R2LtBd6xgc+IABsRCT9knkWFPkHGmkweAy325xVqCrUweZz
         yM2AroPeLvfCgidKTs3fs4b2UCrKujGR3HNwvkU/Pirf8ghH+GlxlAt+e+1kgDGN/f/E
         PvdsDjFtROzDrIYYbguobdFUf3+aNS7Bz/zRs=
Received: by 10.180.252.8 with SMTP id z8mr428904bkh.158.1225923475237;
        Wed, 05 Nov 2008 14:17:55 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 22sm743873fkr.4.2008.11.05.14.17.51
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 14:17:54 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100191>

GitWeb source contains a special function that implements the
export_ok check, but validate_project still uses a separate copy
of essentially the same code.

This patch makes it use the dedicated function, thus ensuring
that all checks are done through a single code path.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	For reference, here is the function:

	sub check_export_ok {
		my ($dir) = @_;
		return (check_head_link($dir) &&
			(!$export_ok || -e "$dir/$export_ok"));
	}


 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c5254af..172ea6b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -742,8 +742,7 @@ sub validate_project {
 	my $input = shift || return undef;
 	if (!validate_pathname($input) ||
 		!(-d "$projectroot/$input") ||
-		!check_head_link("$projectroot/$input") ||
-		($export_ok && !(-e "$projectroot/$input/$export_ok")) ||
+		!check_export_ok("$projectroot/$input") ||
 		($strict_export && !project_in_list($input))) {
 		return undef;
 	} else {
-- 
tg: (933bb3a..) t/authenticate/unify-exportok (depends on: vanilla/master)
