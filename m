From: Cord Seele <cowose@googlemail.com>
Subject: [PATCH] fix alias expansion with new Git::config_path()
Date: Fri, 14 Oct 2011 16:25:57 +0200
Message-ID: <20111014142557.GB13680@laptop>
References: <4E982B27.8050807@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 16:26:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REii6-0003Nc-Qw
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 16:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670Ab1JNO0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 10:26:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35589 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab1JNO0A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 10:26:00 -0400
Received: by bkbzt19 with SMTP id zt19so58425bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=HQfwVHtfhQ2kITcpgrEhgnw5b3prTb2oLTP4gnUvNIw=;
        b=H1zGe6ReeJLHqCQnPOWT7HjmD0AgEKefxNdZhqrfxqhE5yKyb4YwhXTfBKezZUWgGX
         hZBubCnSCW959UQM/NKaFIppIvsT8yhXF3SwWkIlP1vbVk8FqeWUV4w8eql5TOP7mAwI
         q76dCm8GXusUAIGKf/voDaxltE8TvMjuLjes0=
Received: by 10.223.65.68 with SMTP id h4mr4249898fai.24.1318602359162;
        Fri, 14 Oct 2011 07:25:59 -0700 (PDT)
Received: from laptop (p5B306939.dip.t-dialin.net. [91.48.105.57])
        by mx.google.com with ESMTPS id n12sm3983149fan.9.2011.10.14.07.25.58
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 07:25:58 -0700 (PDT)
Mail-Followup-To: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <4E982B27.8050807@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183577>

On Fri 14 Oct 2011 14:29:27 +0200, Michael J Gruber <git@drmicha.warpmail.net> wrote:

> cec5dae (use new Git::config_path() for aliasesfile, 2011-09-30)
> 
> broke the expansion of aliases for me:
> 
> ./git-send-email --cc=junio  --dry-run
> 0001-t7800-avoid-arithmetic-expansion-notation.patch
> 0001-t7800-avoid-arithmetic-expansion-notation.patch
> Who should the emails appear to be from? [Michael J Gruber
> <git@drmicha.warpmail.net>]
> Emails will be sent from: Michael J Gruber <git@drmicha.warpmail.net>
> Dry-OK. Log says:
> Sendmail: /home/mjg/bin/msmtp-fastmail-git -i git@vger.kernel.org junio
> git@drmicha.warpmail.net
> From: Michael J Gruber <git@drmicha.warpmail.net>
> To: git@vger.kernel.org
> Cc: junio
> ...
> 
> Happens with both "--cc junio" and "--cc=junio".
> 
> Reverting cec5dae brings my aliases back. Relevant config:
> 
> git config --get-regexp sendemail.alias\*
> sendemail.aliasesfile /home/mjg/git/gitauthors
> sendemail.aliasfiletype mutt
> 
> Can I please have alias expansion back?

The following patch fixes it for me, please give it a try.

Since this fix is simply copy&pasting some code from the config_settings path
someone with better perl understanding might wnat to refactor it
(Junio/Jacob)?

-- Cord


Signed-off-by: Cord Seele <cowose@gmail.com>
---
 git-send-email.perl |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 91607c5..6885dfa 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -337,8 +337,16 @@ sub read_config {
 	}
 
 	foreach my $setting (keys %config_path_settings) {
-		my $target = $config_path_settings{$setting}->[0];
-		$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
+		my $target = $config_path_settings{$setting};
+		if (ref($target) eq "ARRAY") {
+			unless (@$target) {
+				my @values = Git::config_path(@repo, "$prefix.$setting");
+				@$target = @values if (@values && defined $values[0]);
+			}
+		}
+		else {
+			$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
+		}
 	}
 
 	foreach my $setting (keys %config_settings) {
-- 
1.7.6.4
