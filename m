From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] git-instaweb: Change how gitweb.psgi is made runnable as
	standalone app
Date: Sat, 26 Feb 2011 23:32:33 +0100
Message-ID: <20110226223142.5944.31865.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 23:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtShV-0006DC-AZ
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 23:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152Ab1BZWdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 17:33:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51404 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1BZWdL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 17:33:11 -0500
Received: by bwz15 with SMTP id 15so2834236bwz.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 14:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:cc:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=1kkm2Vwjaj3KOwlqV5u6qft//JpdEAxgyuh1Qj1J3Ok=;
        b=AregSTVQw40C57bqUImcUG/XkNEWj6U/tgiHRIgU0WXA5tDxiiTx2I56X1wUI11VT5
         KDvWL9ynYy1kNWPpF1pEcNgzV2Q/fqG5vy27NO6qOBuzn6qF50pwYHlZf41HfTFhO6qs
         zNPeCHnZAaquG5I+5JOp/TnfOuq+PNMxzaj68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=ZNq5kB4M+Aax9O5itxJhOgsCsaeewfKvRc5lqKjaFXYAnp575icEHHhTe+AYL1zMAq
         0GnpDun7iAyL6friYSdQhd2lX05bu13hYmZDpyHANu44EL0G7bgWp1xraOw2LJPbqKCL
         eOK3WGPDmqFAn23AlyPEeWCm25SJPdwDwet3g=
Received: by 10.204.99.207 with SMTP id v15mr3338680bkn.206.1298759588123;
        Sat, 26 Feb 2011 14:33:08 -0800 (PST)
Received: from localhost.localdomain (abvw99.neoplus.adsl.tpnet.pl [83.8.220.99])
        by mx.google.com with ESMTPS id j11sm1412354bka.12.2011.02.26.14.33.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 14:33:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1QMWYGZ005978;
	Sat, 26 Feb 2011 23:32:45 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167997>

According to blog post "FindBin, __FILE__, $0 and PSGI woes"

  http://bulknews.typepad.com/blog/2011/02/findbin-__file__-0-and-psgi-woes.html

by Tatsuhiko Miyagawa, using 'if (__FILE__ eq $0)' in .psgi code
(to check if script was run from command line), is not supposed to work
since Plack 0.9971.

Replace it with one of proposed solutions; while at it return $app
explicitely, rather than implicitely by being a last expression.

This affects 'plackup' web server.


While at it cleanup whitespace.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 git-instaweb.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 10fcebb..86892f7 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -558,12 +558,14 @@ my \$app = builder {
 
 # make it runnable as standalone app,
 # like it would be run via 'plackup' utility
-if (__FILE__ eq \$0) {
+if (caller) {
+	return \$app;
+} else {
 	require Plack::Runner;
 
 	my \$runner = Plack::Runner->new();
 	\$runner->parse_options(qw(--env deployment --port $port),
-			       "$local" ? qw(--host 127.0.0.1) : ());
+	                        "$local" ? qw(--host 127.0.0.1) : ());
 	\$runner->run(\$app);
 }
 __END__
