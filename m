From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Check and document the options to prevent mistakes.
Date: Wed, 21 Jun 2006 07:17:31 -0600
Message-ID: <m164iu8x78.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 21 15:17:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft2aZ-0002vD-AG
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 15:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWFUNRn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 09:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWFUNRm
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 09:17:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24478 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751559AbWFUNRm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 09:17:42 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5LDHWkl009110;
	Wed, 21 Jun 2006 07:17:32 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5LDHVsr009109;
	Wed, 21 Jun 2006 07:17:31 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22270>


When multiple recipients are given to git-send-email on the same
--cc line the code does not properly handle it.

Full and proper parsing of the email addresses so I can detect
which commas mean a new email address is more than I care to implement.

In particular this email address: "bibo,mao" <bibo.mao@intel.com>
must not be treated as two email addresses.

So this patch simply treats all commas in recipient lists as
an error and fails if one is given.

At the same time it documents that git-send-email wants multiple
instances of --cc specified on the command line if you want to
cc multiple recipients.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

---

 Documentation/git-send-email.txt |    9 +++++++++
 git-send-email.perl              |   14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ad1b9cf..481b3f5 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -24,9 +24,16 @@ OPTIONS
 -------
 The options available are:
 
+--bcc::
+	Specify a "Bcc:" value for each email.
+
+	The --bcc option must be repeated for each user you want on the bcc list.
+
 --cc::
 	Specify a starting "Cc:" value for each email.
 
+	The --cc option must be repeated for each user you want on the cc list.
+
 --chain-reply-to, --no-chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
@@ -76,6 +83,8 @@ The options available are:
 	Generally, this will be the upstream maintainer of the
 	project involved.
 
+	The --to option must be repeated for each user you want on the to list.
+
 
 Author
 ------
diff --git a/git-send-email.perl b/git-send-email.perl
index 7b1cca7..c5d9e73 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -65,6 +65,20 @@ my $rc = GetOptions("from=s" => \$from,
 		    "no-signed-off-cc|no-signed-off-by-cc" => \$no_signed_off_cc,
 	 );
 
+# Verify the user input
+
+foreach my $entry (@to) {
+	die "Comma in --to entry: $entry'\n" unless $entry !~ m/,/;
+}
+
+foreach my $entry (@initial_cc) {
+	die "Comma in --cc entry: $entry'\n" unless $entry !~ m/,/;
+}
+
+foreach my $entry (@bcclist) {
+	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
+}
+
 # Now, let's fill any that aren't set in with defaults:
 
 sub gitvar {
