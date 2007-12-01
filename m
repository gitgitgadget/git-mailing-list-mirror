From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Try harder in parse_tag; perhaps it was given ambiguous name
Date: Sat, 1 Dec 2007 02:47:24 +0100
Message-ID: <200712010247.25107.jnareb@gmail.com>
References: <200712010245.29204.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Guillaume Seguin <guillaume@segu.in>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 02:48:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyHT7-0002EZ-1U
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 02:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759742AbXLABrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 20:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759711AbXLABrs
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 20:47:48 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:3307 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558AbXLABrr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 20:47:47 -0500
Received: by mu-out-0910.google.com with SMTP id i10so385194mue
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 17:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=/d4XSX3YCxEqiGimSDWMKJoogu4eh9jyNKTEpjmMxx0=;
        b=kqvnXEfGgAkTiA/Z+Gn6Xa/cr2aVsn0Dh7+938l1FF2Mkk95W0tbvZiGl3XHbwNRRxtttkspQ17h5MkhSujPTUlpocDYNklUeV2FxdS4yHq7DXn8ddtmoKdjZK8KSjvixPAB0SHcpm7EeBmCrV3J12gRRcUSKCoAN1aNAFLqdUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KzGO8kylWQuqNGJ4G2ib6vv8A8kk77TIJsbIL7lv/+siNVx5c1Zq2LXTFc3GI/Ax4rFf/A8gZqxU51phvf4s0SCnVp5Zra5uQjt5vUIhTcUr3h6IFntuo872C9fp1Xz5I34ijStkXpDgkbPauNNXDhUcGXCTupGpKNfjMKBJM/U=
Received: by 10.86.98.18 with SMTP id v18mr2975795fgb.1196473664135;
        Fri, 30 Nov 2007 17:47:44 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.40])
        by mx.google.com with ESMTPS id b17sm393284fka.2007.11.30.17.47.42
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Nov 2007 17:47:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200712010245.29204.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66671>

If parse_tag was given ambiguous name, i.e. name which is both head
(branch) name and tag name, parse_tag failed because git prefer heads
to tags if there is ambiguity.  Now it tries harder: if git-cat-file
doesn't produce output, try to resolve argument as tag name using
git-show-ref.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This supplements previous patch; while previous modified links to always
use unambiguous name, this one makes 'tag' view work even if passed
ambiguous name which is both name of head and of tag.

 gitweb/gitweb.perl |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6ff4221..0427290 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1876,6 +1876,18 @@ sub parse_tag {
 	my @comment;
 
 	open my $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or return;
+	# try harder in case there is head (branch) with the same name as tag
+	if (eof($fd)) {
+		close $fd or return;
+		my $git_command = git_cmd_str();
+		$tag_id = qx($git_command show-ref --hash --tags $tag_id);
+		return unless $tag_id;
+		open $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or return;
+		if (eof($fd)) {
+			close $fd;
+			return;
+		};
+	}
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
-- 
1.5.3.6
