From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] send-email: Fix %config_path_settings handling
Date: Fri, 14 Oct 2011 20:49:32 +0200
Message-ID: <201110142049.32734.jnareb@gmail.com>
References: <4E982B27.8050807@drmicha.warpmail.net> <201110141838.19118.jnareb@gmail.com> <7vwrc7zbk2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Cord Seele <cowose@gmail.com>,
	Cord Seele <cowose@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 20:49:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REmoy-0007rv-1r
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 20:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab1JNStX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 14:49:23 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34428 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab1JNStW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 14:49:22 -0400
Received: by ggnb1 with SMTP id b1so695996ggn.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=xUV4RILTuGwhGVdBcIHOAVKG/2G6H9e7LleoIw7X5Uw=;
        b=MawicPwt3MYRb6psI+zUyMfd1NpvvhGbGv8rc/fgB2TYnKuYOrK11tspWR7RF4jVXu
         vp6BlPSb0bl3NcpEUxYl/0p4fmS3gxaS+2mo1+YyFARVRlGmXY5dx8DUJvzwN3Lan3ED
         g+cXNBVQZWLf1zI01E3ehYGQxIZCkDiZfxaLI=
Received: by 10.223.5.139 with SMTP id 11mr5577354fav.21.1318618161568;
        Fri, 14 Oct 2011 11:49:21 -0700 (PDT)
Received: from [192.168.1.13] (abvw122.neoplus.adsl.tpnet.pl. [83.8.220.122])
        by mx.google.com with ESMTPS id f25sm5218692faf.7.2011.10.14.11.49.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 11:49:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwrc7zbk2.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183594>

From: Cord Seele <cowose@gmail.com>

cec5dae (use new Git::config_path() for aliasesfile, 2011-09-30) broke
the expansion of aliases.

This was caused by treating %config_path_settings, newly introduced in
said patch, like %config_bool_settings instead of like %config_settings.
Copy from %config_settings, making it more readable.


Nb. there were a few issues that were responsible for this error:

1. %config_bool_settings and %config_settings despite similar name have
   different semantic.

   %config_bool_settings values are arrays where the first element is
   (reference to) the variable to set, and second element is default
   value... which admittedly is a bit cryptic.  More readable if more
   verbose option would be to use hash reference, e.g.:

        my %config_bool_settings = (
            "thread" => { variable => \$thread, default => 1},
            [...]

   Or something like that.

   %config_settings values are either either reference to scalar variable
   or reference to array.  In second case it means that option (or config
   option) is multi-valued.  BTW. this is similar to what Getopt::Long does.

2. In cec5dae (use new Git::config_path() for aliasesfile, 2011-09-30)
   the setting "aliasesfile" was moved from %config_settings to newly
   introduced %config_path_settings.  But the loop that parses settings
   from %config_path_settings was copy'n'pasted *wrongly* from
   %config_bool_settings instead of from %config_settings.

   It looks like cec5dae author cargo-culted this change...

3. 994d6c6 (send-email: address expansion for common mailers, 2006-05-14)
   didn't add test for alias expansion to t9001-send-email.sh

Signed-off-by: Cord Seele <cowose@gmail.com>
Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:

> Thanks for a detailed write-up. I'd appreciate a final fix in an
> apply-able patch form.

Something like this?

Nb. I was not sure whether to keep Cord authorship...

 git-send-email.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 91607c5..41807b6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -337,8 +337,15 @@ sub read_config {
 	}
 
 	foreach my $setting (keys %config_path_settings) {
-		my $target = $config_path_settings{$setting}->[0];
-		$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
+		my $target = $config_path_settings{$setting};
+		if (ref($target) eq "ARRAY" && !@$target) {
+			# multi-valued and not set
+			my @values = Git::config_path(@repo, "$prefix.$setting");
+			@$target = @values if (@values && defined $values[0]);
+		} elsif (!defined $$target) {
+			# multi-valued and not set
+			$$target = Git::config_path(@repo, "$prefix.$setting");
+		}
 	}
 
 	foreach my $setting (keys %config_settings) {
-- 
1.7.6
