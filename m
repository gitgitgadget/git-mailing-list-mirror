From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: commit 'git-send-email: add support for TLS via Net::SMTP::SSL' causes warnings
Date: Thu, 26 Jun 2008 23:03:21 +0200
Message-ID: <200806262303.23269.trast@student.ethz.ch>
References: <DF091369-1771-4405-8705-BDBC59C7E48A@sb.org> <200806262248.02866.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <Kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 23:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBydT-00080T-8X
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 23:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbYFZVDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 17:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754675AbYFZVDJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 17:03:09 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:30139 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359AbYFZVDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 17:03:08 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 26 Jun 2008 23:03:06 +0200
Received: from [192.168.0.2] ([84.75.156.10]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 26 Jun 2008 23:03:05 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200806262248.02866.trast@student.ethz.ch>
Content-Disposition: inline
X-OriginalArrivalTime: 26 Jun 2008 21:03:06.0074 (UTC) FILETIME=[0799ABA0:01C8D7D0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86487>

I wrote:
> 
> and thanks for the fix

Well, actually at second glance your fix is wrong.  Putting it in
read_config() means it will be executed the first time around already,
when we read the identity's settings.  So with the patch,
$smtp_encryption is set to '' during identity parsing, and any value
set in the global [sendemail] section never takes effect.

Let's do the following instead.  Sorry for all the noise.

-- 8< --
git-send-email: prevent undefined variable warnings if no encryption is set

With the previous patch, not configuring any encryption (either on or
off) would leave $smtp_encryption undefined.  We simply set it to the
empty string in that case.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-send-email.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 7630720..edb12c2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -313,6 +313,9 @@ foreach my $setting (values %config_bool_settings) {
 	${$setting->[0]} = $setting->[1] unless (defined (${$setting->[0]}));
 }
 
+# 'default' encryption is none -- this only prevents a warning
+$smtp_encryption = '' unless (defined $smtp_encryption);
+
 # Set CC suppressions
 my(%suppress_cc);
 if (@suppress_cc) {
-- 
1.5.6.1.187.g35a8
