From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] contacts: introduce --since and --min-percent
Date: Fri, 16 Jan 2015 16:23:59 -0500
Message-ID: <1421443439-54809-1-git-send-email-artagnon@gmail.com>
References: <1421441933-54183-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 22:24:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCENK-00047A-H7
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 22:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757210AbbAPVYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 16:24:08 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:58575 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756354AbbAPVYH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 16:24:07 -0500
Received: by mail-qg0-f54.google.com with SMTP id z60so9825876qgd.13
        for <git@vger.kernel.org>; Fri, 16 Jan 2015 13:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RY8G/7teJqlWkjNVwshzKV7GEVLn/mWFS9g82umr8lI=;
        b=TWYC0jl7wSbR1QiN8rWCNW+KqeO6H0aq1+9AVqBgM1zIrcRIolHdd923lW0r2SXz+u
         Q9hUNjkaNF7R0J+aNCw6QNU4h9WVQwLvUyUbph4ciWeWXixd66e/Zshax+v6+TaYumpr
         524ttt5XjkcU5jXZ1qBO47lj544oUN0i0q1lG4Bt7dsywUa8Uc+Sbc2hMuHwzJaVbBra
         lLwX6nlg+hl+P8M3wU/q2ZOCOqQ2rqmKCuJ5fr5aWTGtlxutLbcMUm2N3PB2F+1lSxWS
         bmksupJ7Kc9/X5cKa1PPHD3JE89Pc+1wLwfWqwUD/Hl76WthpT8q635Xyj0LrO+Ugu/J
         LlJQ==
X-Received: by 10.140.21.229 with SMTP id 92mr17175102qgl.33.1421443446725;
        Fri, 16 Jan 2015 13:24:06 -0800 (PST)
Received: from localhost.localdomain (cpe-66-65-144-82.nyc.res.rr.com. [66.65.144.82])
        by mx.google.com with ESMTPSA id j6sm5194906qai.34.2015.01.16.13.24.05
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jan 2015 13:24:05 -0800 (PST)
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421441933-54183-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262576>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/contacts/git-contacts     |  4 ++++
 contrib/contacts/git-contacts.txt | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index dbe2abf..5dde920 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -8,6 +8,7 @@
 use strict;
 use warnings;
 use IPC::Open2;
+use Getopt::Long qw(:config gnu_getopt no_ignore_case auto_abbrev);
 
 my $since = '5-years-ago';
 my $min_percent = 10;
@@ -158,6 +159,9 @@ sub mailmap_contacts {
 	return \%mapped;
 }
 
+my $rv = GetOptions('since=s' => \$since, 'min-percent=i' => \$min_percent);
+exit 1 if (!$rv);
+
 if (!@ARGV) {
 	die "No input revisions or patch files\n";
 }
diff --git a/contrib/contacts/git-contacts.txt b/contrib/contacts/git-contacts.txt
index dd914d1..a50c97f 100644
--- a/contrib/contacts/git-contacts.txt
+++ b/contrib/contacts/git-contacts.txt
@@ -31,6 +31,16 @@ discuss proposed changes, or for finding the list of recipients to Cc: when
 submitting a patch series via `git send-email`. For the latter case, `git
 contacts` can be used as the argument to `git send-email`'s `--cc-cmd` option.
 
+OPTIONS
+-------
+
+--min-percent::
+	The minimum threshold of blame percentage that a person must
+	exceed in order to be reported.
+
+--since::
+        Depth of history to dig.
+
 
 DISCUSSION
 ----------
@@ -83,10 +93,8 @@ $ git send-email --cc-cmd='git contacts' feature/*.patch
 LIMITATIONS
 -----------
 
-Several conditions controlling a person's significance are currently
-hard-coded, such as minimum participation level (10%), blame date-limiting (5
-years), and `-C` level for detecting moved and copied lines (a single `-C`). In
-the future, these conditions may become configurable.
+The `-C` level for detecting moved and copied lines (a single `-C`) is
+hard-coded. In the future, this may become configurable.
 
 
 GIT
-- 
2.2.1
