From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] git-send-email: Handle quotes when parsing .mailrc files
Date: Wed, 20 May 2009 19:45:53 -0700
Message-ID: <1242873953-21394-1-git-send-email-ebiederm@xmission.com>
Cc: <git@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 04:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6yIe-0001yw-L7
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 04:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbZEUCqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 22:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754316AbZEUCqU
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 22:46:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53924 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbZEUCqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 22:46:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
	by out02.mta.xmission.com with esmtp (Exim 4.62)
	(envelope-from <ebiederm@xmission.com>)
	id 1M6yIW-0003ON-GO; Wed, 20 May 2009 20:46:20 -0600
Received: from [76.21.114.89] (helo=fess.ebiederm.org)
	by in01.mta.xmission.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ebiederm@xmission.com>)
	id 1M6yIW-0003Fn-2O; Wed, 20 May 2009 20:46:20 -0600
Received: from fess.ebiederm.org (localhost [127.0.0.1])
	by fess.ebiederm.org (8.14.3/8.14.3/Debian-4) with ESMTP id n4L2kHsP021427;
	Wed, 20 May 2009 19:46:17 -0700
Received: (from eric@localhost)
	by fess.ebiederm.org (8.14.3/8.14.3/Submit) id n4L2kHHF021426;
	Wed, 20 May 2009 19:46:17 -0700
X-Mailer: git-send-email 1.6.3.1.54.g99dd.dirty
X-XM-SPF: eid=;;;mid=;;;hst=in01.mta.xmission.com;;;ip=76.21.114.89;;;frm=ebiederm@xmission.com;;;spf=neutral
X-SA-Exim-Connect-IP: 76.21.114.89
X-SA-Exim-Rcpt-To: gitster@pobox.com, git@vger.kernel.org, ebiederm@xmission.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_20,
	DCC_CHECK_NEGATIVE,T_TooManySym_01,UNTRUSTED_Relay,XMSubMetaSxObfu_03,
	XMSubMetaSx_00,XM_SPF_Neutral autolearn=disabled version=3.2.5
X-Spam-Combo: *;Junio C Hamano <gitster@pobox.com>
X-Spam-Relay-Country: 
X-Spam-Report: * -1.8 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.7 BAYES_20 BODY: Bayesian spam probability is 5 to 20%
	*      [score: 0.0835]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  2.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
	*  1.6 XMSubMetaSx_00 1+ Sexy Words
	*  0.0 XM_SPF_Neutral SPF-Neutral
	*  0.4 UNTRUSTED_Relay Comes from a non-trusted relay
X-SA-Exim-Version: 4.2.1 (built Thu, 25 Oct 2007 00:26:12 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119649>

It is legal and not uncommon to use quotes in a .mailrc file so
you can include a persons fullname as well as their email alias.
Handle this by using quotewords instead of split when parsing
.mailrc files.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cccbf45..e3408d5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -409,7 +409,7 @@ my %parse_alias = (
 	mailrc => sub { my $fh = shift; while (<$fh>) {
 		if (/^alias\s+(\S+)\s+(.*)$/) {
 			# spaces delimit multiple addresses
-			$aliases{$1} = [ split(/\s+/, $2) ];
+			$aliases{$1} = [ quotewords('\s+', 0, $2) ];
 		}}},
 	pine => sub { my $fh = shift; my $f='\t[^\t]*';
 	        for (my $x = ''; defined($x); $x = $_) {
-- 
1.6.3.1.54.g99dd.dirty
