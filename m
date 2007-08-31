From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 10/14] gitweb: display HEAD in heads list when detached
Date: Fri, 31 Aug 2007 13:19:10 +0200
Message-ID: <11885591542097-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 13:21:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4Ys-0002jD-4G
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 13:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbXHaLVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 07:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbXHaLVD
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 07:21:03 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:32010 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716AbXHaLVA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 07:21:00 -0400
Received: by hu-out-0506.google.com with SMTP id 19so593548hue
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 04:20:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OT9mGUimxX3Vpnkx2ogfbIe3DDB1Vota2g1wPrEWjSrmdcH5rafpp0gVbcidvmYJ7115f2896ta05uq5SwEsPjqZoMH6ayv1dTXQbfcfh9LMQxejQ2+nzrCqxmfqcvrxJ87jTpIp0CqrBAWWeD9n85kIpsw0yqJeYfvv3YAQPsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=neIWUMYuQyph0d8/MYJSpb3uL1dTA1rWRMuDYHNTKC6P/gMiB5K/VgFTPr1o7yginGuNfBUDO8jNPsE0qrUbJTQ+rLmO8iURzgUJFxvKsynoqX+bSjN6iIhZnLcTUdSTyFgPlZPZRucqxAtQAoOl1xXFDSLd4vGDrw4+WykTnu0=
Received: by 10.78.185.15 with SMTP id i15mr1140746huf.1188559259061;
        Fri, 31 Aug 2007 04:20:59 -0700 (PDT)
Received: from localhost ( [84.221.55.162])
        by mx.google.com with ESMTPS id 7sm6851482nfv.2007.08.31.04.20.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 04:20:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57158>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 09d9793..e743c3d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2090,6 +2090,27 @@ sub git_get_heads_list {
 	my @refs = map { "refs/$_" } @class ;
 	my @headslist;
 
+	if (grep { $_ eq 'heads' } @class) {
+		my @x = (git_cmd(), 'branch');
+		my @ret = split("\n", qx(@x));
+		if (grep { /^* \(no branch\)$/ } @ret) { ;
+			my %ref_item;
+			@x = (git_cmd(), 'log', '-1', '--pretty=format:%H%n%ct%n%s');
+			my ($hash, $epoch, $title) = split("\n", qx(@x), 3);
+
+			$ref_item{'class'} = 'head';
+			$ref_item{'name'} = 'HEAD';
+			$ref_item{'id'} = $hash;
+			$ref_item{'title'} = $title || '(no commit message)';
+			if ($ref_item{'epoch'} = $epoch) {
+				$ref_item{'age'} = age_string(time - $ref_item{'epoch'});
+			} else {
+				$ref_item{'age'} = "unknown";
+			}
+			push @headslist, \%ref_item;
+		}
+	}
+
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-- 
1.5.2.5
