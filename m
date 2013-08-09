From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] contacts: reduce git-blame invocations
Date: Fri,  9 Aug 2013 17:39:56 -0400
Message-ID: <1376084396-53617-4-git-send-email-sunshine@sunshineco.com>
References: <1376084396-53617-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 23:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7uQH-0005mE-7r
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031245Ab3HIVkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:40:23 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40359 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031211Ab3HIVkV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:40:21 -0400
Received: by mail-ie0-f177.google.com with SMTP id a11so4787039iee.8
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=koyiKp8k7YbTLMld159nezO1ByLe4+UDHrB5g3eLtQo=;
        b=YPpm7vEjqb5eObEwqUCIYIJLk/P5h0F06DabY5Rok/BvGkFPA7YgljwYtN6l8UWBCw
         xkz8TkLSWRUqwbsag0SSA285bRoiLV0k95zLEzcFANxlFBwDG7hA6g/7DGjcKtEYl9If
         XjSedto0ethOXflbZdcpHcQFajPdTzSV+YlJd+DeF/DI/uJIGqQGyEwBsVBKV7jRd5Ip
         uMMSeoiU4VPXicXel2FB5XUMwcTIUtA5MULH3t194q9Y5fOzb9l0R+MsJTdHvUhqsaqE
         2KEDm4voY3UnPGXqDbXL5r7fQ0laW1VAM5LdZf44FpYMJkHOK9BhRRuzM/s1TZsFJRDX
         y9lQ==
X-Received: by 10.43.118.136 with SMTP id fq8mr5391093icc.101.1376084420864;
        Fri, 09 Aug 2013 14:40:20 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id q4sm6156131igp.6.2013.08.09.14.40.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 14:40:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.460.ga591f4a
In-Reply-To: <1376084396-53617-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232036>

git-contacts invokes git-blame once for each patch hunk it encounters.
No attempt is made to consolidate invocations for multiple hunks
referencing the same file at the same revision. This can become
expensive quickly.

Reduce the number of git-blame invocations by taking advantage of the
ability to specify multiple -L ranges for a single invocation.

Without this patch, on a randomly chosen range of commits:

  % time git-contacts 25fba78d36be6297^..23c339c0f262aad2 >/dev/null
  real  0m6.142s
  user  0m5.429s
  sys   0m0.356s

With this patch:

  % time git-contacts 25fba78d36be6297^..23c339c0f262aad2 >/dev/null
  real  0m2.285s
  user  0m2.093s
  sys   0m0.165s

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index b4d3526..fb6429b 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -59,9 +59,11 @@ sub import_commits {
 }
 
 sub get_blame {
-	my ($commits, $source, $start, $len, $from) = @_;
+	my ($commits, $source, $from, $ranges) = @_;
+	return unless @$ranges;
 	open my $f, '-|',
-		qw(git blame --porcelain -C), '-L', "$start,+$len",
+		qw(git blame --porcelain -C),
+		map({"-L$_->[0],+$_->[1]"} @$ranges),
 		'--since', $since, "$from^", '--', $source or die;
 	while (<$f>) {
 		if (/^([0-9a-f]{40}) \d+ \d+ \d+$/) {
@@ -78,10 +80,7 @@ sub blame_sources {
 	my ($sources, $commits) = @_;
 	for my $s (keys %$sources) {
 		for my $id (keys %{$sources->{$s}}) {
-			for my $range (@{$sources->{$s}{$id}}) {
-				get_blame($commits, $s,
-					  $range->[0], $range->[1], $id);
-			}
+			get_blame($commits, $s, $id, $sources->{$s}{$id});
 		}
 	}
 }
-- 
1.8.4.rc2.460.ga591f4a
