From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
Subject: [PATCH 4/7] perl/Git.pm: escape external command's arguments on Windows
Date: Wed, 30 Jan 2013 15:23:00 -0200
Message-ID: <1359566583-19654-5-git-send-email-gnustavo@cpan.org>
References: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
Cc: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 18:29:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0bTD-0000zL-98
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316Ab3A3R2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:28:48 -0500
Received: from mail-ye0-f173.google.com ([209.85.213.173]:54210 "EHLO
	mail-ye0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756194Ab3A3R2q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:28:46 -0500
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2013 12:28:46 EST
Received: by mail-ye0-f173.google.com with SMTP id l5so305589yen.18
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 09:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:x-gm-message-state;
        bh=wFLkuItjyeX+Y9E2eA3S3SMqTMkROSU/sq7BbFIOuzI=;
        b=oZ3QCJzLt8ajt07jz8lBHgJaozOJS7KiZmmw7Hf/HRCTVCzst4nRUmYupe77AzqhyH
         xgkUAagxdDqub4n8f7BJRzq50L4vFoq4APaNpeEnNjyfTk3t07avXXD/dbdVB4zuzWDf
         SqxPMN9AUPZgwpIMhI9eHAIUAo2hnhXtEc8s77w9Gu+bN2QUXg3rYmmd7L8Hq3V/tRE4
         zwnPcxu2fSv+WtO+jea/amsLhFdQ42nh5hfGCkcqzQKkkylkLarKdHvm5XJZ+HAV481i
         KmAzbmRyWt2LLGgkXd26FE7Da4XAgcZMO0mk9wXu669VtrKZE64ziVG6+9U2t6wfdaP+
         zz6A==
X-Received: by 10.236.180.231 with SMTP id j67mr6622306yhm.31.1359566595505;
        Wed, 30 Jan 2013 09:23:15 -0800 (PST)
Received: from gnu.cpqd.com.br (fw-cpqd.cpqd.com.br. [189.112.183.66])
        by mx.google.com with ESMTPS id q11sm1689802anp.13.2013.01.30.09.23.13
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 09:23:14 -0800 (PST)
X-Mailer: git-send-email 1.7.12.464.g83379df.dirty
In-Reply-To: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
X-Gm-Message-State: ALoCoQnVeYGDCTW9tVj1aniocrnZMgpZyq9gQ3olTQLsZhjuIWgO03SxQ+5+RT1YLrcq5LARxk07
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215037>

From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>

On Windows, the external git commands are invoked using backticks by
Git::activestate_pipe::TIEHANDLE, but there was no attempt to properly
quote their arguments. This caused problems with all but the simplest
command invokations.

The arguments are now surrounded by quotes and internal quotes are
doubled. This is not a complete quoting solution but takes care of
some of the most common problems on Windows.

Signed-off-by: Gustavo L. de M. Chaves <gnustavo@cpan.org>
---
 perl/Git.pm | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index ef3134b..42c3971 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1398,12 +1398,10 @@ use strict;
 
 sub TIEHANDLE {
 	my ($class, @params) = @_;
-	# FIXME: This is probably horrible idea and the thing will explode
-	# at the moment you give it arguments that require some quoting,
-	# but I have no ActiveState clue... --pasky
-	# Let's just hope ActiveState Perl does at least the quoting
-	# correctly.
-	my @data = qx{git @params};
+	# FIXME: The quoting done below is not completely right but it
+	# should take care of the most common cases.
+	my @escaped_params = map { "\"$_\"" } map { s/"/""/g; $_ } @params;
+	my @data = qx{git @escaped_params};
 	bless { i => 0, data => \@data, exit => $? }, $class;
 }
 
-- 
1.7.12.464.g83379df.dirty
