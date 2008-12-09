From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()
Date: Tue, 09 Dec 2008 23:48:08 +0100
Message-ID: <20081209224622.28106.89325.stgit@localhost.localdomain>
References: <20081209223703.28106.29198.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 23:49:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LABOT-0003F2-Q3
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 23:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbYLIWsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 17:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754691AbYLIWsM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 17:48:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:41660 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbYLIWsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 17:48:11 -0500
Received: by fg-out-1718.google.com with SMTP id 19so97459fgg.17
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 14:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=X1bqJSKgzZVm4oLxrBlbRcICP4KYxa71Hf1tClOD/t4=;
        b=awPCMb+MB6S9EzS+4DOu/zkQ9VQyMXg8NcvvKQAZREbtWJYbBRAnUuKQqu2ex+NkZ8
         jSBS5fGME6larvskGJqf3wCafzgbI1Rmk1WRmZz/ehvgZsp/NU9bKLmBjXX7ITvwdRB1
         P641ZkuZFrq87c4KBfgsSV4Ng+/RPeyIbR9wo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=svuKMvF8g0WKk3k5SOBW5+UzgWAXmdD5sboqfX1xFGOgryDNBEY5FeIPUKLa9eCDYW
         O4hYpgEWH3Y8Q5kRN/WQBfo9NvluSyGJEaDWgQUlVzSSHT4/WIn3j4sPlO9YUXQhXq19
         +eoSNN51/EJ7DIgHhG0tprTUvG2PPFqxJxFZM=
Received: by 10.86.52.6 with SMTP id z6mr295292fgz.63.1228862888977;
        Tue, 09 Dec 2008 14:48:08 -0800 (PST)
Received: from localhost.localdomain (absh60.neoplus.adsl.tpnet.pl [83.8.127.60])
        by mx.google.com with ESMTPS id l19sm1057966fgb.54.2008.12.09.14.48.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Dec 2008 14:48:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB9Mm8ll028231;
	Tue, 9 Dec 2008 23:48:09 +0100
In-Reply-To: <20081209223703.28106.29198.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102659>

Luben Tuikov changed 'lineno' link from leading to commit which lead
to current version of given block of lines, to leading to parent of
this commit in 244a70e (Blame "linenr" link jumps to previous state at
"orig_lineno").  This supposedly made data mining possible (or just
better).

Unfortunately the implementation in 244a70e used one call for
git-rev-parse to find parent revision per line in file, instead of
using long lived "git cat-file --batch-check" (which might not existed
then), or changing validate_refname to validate_revision and made it
accept <rev>^, <rev>^^, <rev>^^^ etc. syntax.

This patch attempts to migitate issue a bit by caching $parent_commit
info in %metainfo, which makes gitweb to call git-rev-parse only once
per unique commit in blame output.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
That is what I have noticed during browsing git_blame() code.

We can change it to even more effective implementation (like the ones
proposed above in the commit message) later.

Indenting is cause for artifically large diff

 gitweb/gitweb.perl |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1b800f4..916396a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4657,11 +4657,17 @@ HTML
 			              esc_html($rev));
 			print "</td>\n";
 		}
-		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
-			or die_error(500, "Open git-rev-parse failed");
-		my $parent_commit = <$dd>;
-		close $dd;
-		chomp($parent_commit);
+		my $parent_commit;
+		if (!exists $meta->{'parent'}) {
+			open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
+				or die_error(500, "Open git-rev-parse failed");
+			$parent_commit = <$dd>;
+			close $dd;
+			chomp($parent_commit);
+			$meta->{'parent'} = $parent_commit;
+		} else {
+			$parent_commit = $meta->{'parent'};
+		}
 		my $blamed = href(action => 'blame',
 		                  file_name => $meta->{'filename'},
 		                  hash_base => $parent_commit);
