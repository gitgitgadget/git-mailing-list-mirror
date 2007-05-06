From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/6] gitweb: Add parsing of raw combined diff format to parse_difftree_raw_line
Date: Mon,  7 May 2007 01:10:03 +0200
Message-ID: <11784930111140-git-send-email-jnareb@gmail.com>
References: <11784930091585-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 01:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkpne-00082c-QK
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbXEFXFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbXEFXFs
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:05:48 -0400
Received: from qb-out-0506.google.com ([72.14.204.239]:34559 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbXEFXFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:05:46 -0400
Received: by qb-out-0506.google.com with SMTP id a16so3059612qbd
        for <git@vger.kernel.org>; Sun, 06 May 2007 16:05:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IEPJ4FZ8JNWFxnzUj/wJG4zQm8cf0AogRKug+vMBkVeoOiKAKX9jDCqsznkxYywKl8Sl3wWYCrR3J3iaQVPnWKARl6pvyr4PeEzJuKfYjwCnx8/xqRugBURBgX3zu+YKXrd/1PYqHO4x9CzsmsnWQ3cJjAVWI7DJgsvo04Ooygw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mDLaDJm2qEAbweqBq8fXyjcw8TSFMYhmVGCgbbi/SjbvKh8NqDtFleG81+vhKDq/IcoIFKV221KOqGZDXyEdfVeLy0bocCGjgKjap59/gnNt7LrzuU6aW2zuxL/y1vKbgEtir9c6/9AUXE2Rojl8PYzGYxMaPAzeaGwOmh21UPQ=
Received: by 10.65.81.10 with SMTP id i10mr900081qbl.1178492746101;
        Sun, 06 May 2007 16:05:46 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id q14sm4762469qbq.2007.05.06.16.05.44;
        Sun, 06 May 2007 16:05:45 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l46NABRE015908;
	Mon, 7 May 2007 01:10:11 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l46NABWH015907;
	Mon, 7 May 2007 01:10:11 +0200
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <11784930091585-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46386>

Add parsing line of raw combined diff ("git diff-tree -c/-cc" output)
as described in section "diff format for merges" in diff-format.txt
to parse_difftree_raw_line subroutine.

Returned hash (or hashref) has for combined diff 'nparents' key which
holds number of parents in a merge. At keys 'from_mode' and 'from_id'
there are arrayrefs holding modes and ids, respectively. There is no
'similarity' value, and there is only 'to_file' value and no
'from_file' value.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ba5cc43..dfba399 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1495,6 +1495,17 @@ sub parse_difftree_raw_line {
 			$res{'file'} = unquote($7);
 		}
 	}
+	# '::100755 100755 100755 60e79ca1b01bc8b057abe17ddab484699a7f5fdb 94067cc5f73388f33722d52ae02f44692bc07490 94067cc5f73388f33722d52ae02f44692bc07490 MR	git-gui/git-gui.sh'
+	# combined diff (for merge commit)
+	elsif ($line =~ s/^(::+)((?:[0-7]{6} )+)((?:[0-9a-fA-F]{40} )+)([a-zA-Z]+)\t(.*)$//) {
+		$res{'nparents'}  = length($1);
+		$res{'from_mode'} = [ split(' ', $2) ];
+		$res{'to_mode'} = pop @{$res{'from_mode'}};
+		$res{'from_id'} = [ split(' ', $3) ];
+		$res{'to_id'} = pop @{$res{'from_id'}};
+		$res{'status'} = [ split('', $4) ];
+		$res{'to_file'} = unquote($5);
+	}
 	# 'c512b523472485aef4fff9e57b229d9d243c967f'
 	elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
 		$res{'commit'} = $1;
-- 
1.5.1.3
