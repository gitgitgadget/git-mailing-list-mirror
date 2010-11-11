From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 03/11] gitweb: git_get_heads_list accepts an optional list of refs
Date: Thu, 11 Nov 2010 13:26:10 +0100
Message-ID: <1289478378-15604-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:26:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWEh-0000Gr-Kc
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481Ab0KKM0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:26:33 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57901 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462Ab0KKM0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:32 -0500
Received: by mail-ww0-f44.google.com with SMTP id 29so64691wwb.1
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wSevpXxt0+4//ZqUggwpdeCNVWO3N80t5RrgTVpc2xU=;
        b=L6teqG+P9Tn/XDVXzWZ7yIRWv1kMZvfLZ+qxZb/5P4gwPC9ODcAbfVcOD0re06FPtM
         s4M3iWRtbpHZbywwIOLLcDWs3IJBTOhUaxWMYZYu8I8v7hNYtReWC1NcyWyRtxHzC/yu
         9a0qLR9UQNIL9GQ27jpVESeF6zXF2OHK3K2vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TtB5SOofNg86uTKzGXiD6yVSaMbw5C220ryT8FMX7imv+m/dnfZ1KkkWrOVq8ApsXA
         lRT9q2GiDYucOStvT2ewjjOqAUVqCKyDPbYNKVw6li1Bb0VCsgH9eDmFXrVADOnPqHjS
         OWpZRnMq5t4rBPLAGJJMkWaASeWKnAFe1cE/k=
Received: by 10.227.144.200 with SMTP id a8mr728593wbv.193.1289478391542;
        Thu, 11 Nov 2010 04:26:31 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id p4sm1242974wer.5.2010.11.11.04.26.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:30 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161232>

git_get_heads_list(limit, class1, class2, ...) can now be used to retrieve
refs/class1, refs/class2 etc. Defaults to ('heads', 'remotes') or ('heads')
depending on whether the 'remote_heads' feature is enabled or not.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e1787c2..951bb0d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3169,15 +3169,18 @@ sub parse_from_to_diffinfo {
 ## parse to array of hashes functions
 
 sub git_get_heads_list {
-	my $limit = shift;
+	my ($limit, @classes) = @_;
+	unless (@classes) {
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
