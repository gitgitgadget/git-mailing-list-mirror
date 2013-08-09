From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] contacts: validate hunk length earlier
Date: Fri,  9 Aug 2013 17:39:54 -0400
Message-ID: <1376084396-53617-2-git-send-email-sunshine@sunshineco.com>
References: <1376084396-53617-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 23:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7uQG-0005mE-NC
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031242Ab3HIVkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:40:20 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:38445 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031211Ab3HIVkR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:40:17 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so5136116iea.17
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lE1Pv+HSlwt6V0/+XEMStT+1pxUaK5tVeJi4jchgiHs=;
        b=wlHJGu5TkKBNlhj1G2y15Myk8V4JGVswHc+trr2pDwVBfwybltyQBUDa4wRS0K9DrD
         LY09SIKro+ZWT+65dg5gz6TVKguRo6v51yoNOFZoVTxdoQA0Bk5OnRyfj+XT1uIDVqT9
         L+J3bk+PIhIo4U2joMFQ3GGteb1KgIbHFOpG/ZAvvxuJJ+j3IQK43eYfN3V9YPp0UUga
         SdG7DhV+h2cfeTF0DkJ/sN0fpUhJJzlafPa3UBT2PyovNKPDJvDS0M9YDoX9Wyan1HJL
         o+0ywL+18lh+DDiAQoEx0tytFBF3FekkxSPOrGVBrewWEYazn2M/srfevp6SNHk4SEJB
         Ub8w==
X-Received: by 10.50.11.103 with SMTP id p7mr3381165igb.24.1376084417310;
        Fri, 09 Aug 2013 14:40:17 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id q4sm6156131igp.6.2013.08.09.14.40.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 14:40:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.460.ga591f4a
In-Reply-To: <1376084396-53617-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232035>

Rather than calling get_blame() with a zero-length hunk only to have it
rejected immediately, perform hunk-length validation earlier in order to
avoid calling get_blame() unnecessarily.

This is a preparatory step to simplify later patches which reduce the
number of git-blame invocations by collecting together all lines to
blame within a single file at a particular revision. By validating the
blame range early, the subsequent patch can more easily avoid adding
empty ranges at collection time.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index d80f7d1..4fbb2ef 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -60,8 +60,6 @@ sub import_commits {
 
 sub get_blame {
 	my ($commits, $source, $start, $len, $from) = @_;
-	$len = 1 unless defined($len);
-	return if $len == 0;
 	open my $f, '-|',
 		qw(git blame --porcelain -C), '-L', "$start,+$len",
 		'--since', $since, "$from^", '--', $source or die;
@@ -90,7 +88,8 @@ sub scan_patches {
 		} elsif (/^--- /) {
 			die "Cannot parse hunk source: $_\n";
 		} elsif (/^@@ -(\d+)(?:,(\d+))?/ && $source) {
-			get_blame($commits, $source, $1, $2, $id);
+			my $len = defined($2) ? $2 : 1;
+			get_blame($commits, $source, $1, $len, $id) if $len;
 		}
 	}
 }
-- 
1.8.4.rc2.460.ga591f4a
