From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 02/12] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Fri, 24 Sep 2010 18:02:37 +0200
Message-ID: <1285344167-8518-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAkG-0005n3-Hb
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab0IXQDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:03:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43140 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab0IXQDL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:03:11 -0400
Received: by wyb28 with SMTP id 28so2050910wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SMEjPw592KV4wQ5Q6OwOA9LBxUC6teB+/18AJcHIOKU=;
        b=KLLk1PtKX3brEfbFgO2Eu7AWPSLFnWnaSuTihljMo+gquI/MEtde+pVXTI2U61ASqq
         iCYPe0KYm8wEZffCM+WsovS40FzRZUJCeSclcitK9i4fk4vI4RU1TmxuEaU5qqH6A5xJ
         jMady+b+ZC102BKIEstDPnuUlOREV4i+NmwuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vbVNzcXQmztc1xVAi0X15WOaGGN2BU3JH6mi0J5GYuFMMasUgFnXaoH/+gNzyL4P0I
         uYb9dzk6s+IoPHbmC8/fh391F/3oSpcHLYtLRxoi2VAYUvq6YtAdkPKnXJBa2pGhG8N3
         k4zFV1UNf9/3yqqUPCGd9lWRZyqkC6DSFV8xQ=
Received: by 10.227.141.141 with SMTP id m13mr2989902wbu.152.1285344190292;
        Fri, 24 Sep 2010 09:03:10 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id g9sm1923913wbh.13.2010.09.24.09.03.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:03:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157004>

git_get_heads_list(limit, class1, class2, ...) can now be used to retrieve
refs/class1, refs/class2 etc. Defaults to ('heads') or ('heads', 'remotes')
depending on the remote_heads option.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f09fcee..27c455e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3155,15 +3155,18 @@ sub parse_from_to_diffinfo {
 ## parse to array of hashes functions
 
 sub git_get_heads_list {
-	my $limit = shift;
+	my ($limit, @classes) = @_;
+	unless (defined @classes) {
+		my $remote_heads = gitweb_check_feature('remote_heads');
+		@classes = ('heads', $remote_heads ? 'remotes' : ());
+	}
+	my @patterns = map { "refs/$_" } @classes;
 	my @headslist;
 
-	my $remote_heads = gitweb_check_feature('remote_heads');
-
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads', ($remote_heads ? 'refs/remotes' : ())
+		@patterns
 		or return;
 	while (my $line = <$fd>) {
 		my %ref_item;
-- 
1.7.3.68.g6ec8
