From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 3/2 (squash!)] git-send-email: Warn about rejected automatically added  recipients
Date: Fri, 6 May 2011 13:22:23 +0200
Message-ID: <201105061322.24736.jnareb@gmail.com>
References: <20110415034251.GC19621@sigill.intra.peff.net> <20110504213535.GB27779@sigill.intra.peff.net> <201105051601.46012.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 06 13:22:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIJ7X-00056A-Ne
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 13:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005Ab1EFLWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 07:22:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35646 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab1EFLWg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 07:22:36 -0400
Received: by fxm17 with SMTP id 17so2217966fxm.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 04:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=EwjE9RI1eu9VDc8RFeV+dltV1PMsSYTq9C5xGVOeT8I=;
        b=VK8HUblAppewjK1Nck4Ycg/5d4FNjQ6Xp35pufVUGYV8d6dCUPRbEsEXn2U53JFM6L
         UXwHez4Zv9ifaWElA8AX6Lyy8azcr502HY1Zj4hnmQHmpumyMCuQjCrtc/LrrEgpyLno
         GgTRsXYlj0a7S0pgqkf5ZejdCF2WdI1rFQNbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=g8bS3ZHkp8qj8XoYrr70ur+tFrYujRn+4Ko4XV7gcQm7AlLNlyBsW6j0ywVLwPRlyx
         4ykQVoMsn9MWwUv7+toBR5r14/ZzGp+fHzClt+sTRKs9/NlifW5dlrEM7OT8ZQValvT6
         xYBNGqN4WbCfISMlZMkYL0URWSzglrlc9pfZM=
Received: by 10.223.53.85 with SMTP id l21mr2094434fag.26.1304680954845;
        Fri, 06 May 2011 04:22:34 -0700 (PDT)
Received: from [192.168.1.13] (aeho239.neoplus.adsl.tpnet.pl [79.186.196.239])
        by mx.google.com with ESMTPS id l1sm1963173bkl.1.2011.05.06.04.22.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 May 2011 04:22:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201105051601.46012.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172970>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Thu, 5 May 2011, Jakub Narebski wrote:
> On Wed, 4 May 2011, Jeff King wrote:
>> On Wed, May 04, 2011 at 06:12:08PM +0200, Jakub Narebski wrote:
>>> On Fri, 15 Apr 2011, Jeff King wrote:

>>>> [...] You could probably remember which recipients are "important"
>>>> (i.e., given on the command line) and which were pulled automatically
>>>> from the commit information, and then feed each recipient individually.
>>>> If important ones fail, abort the message. If an unimportant one fails,
>>>> send the message anyway, but remember the bad address and report the
>>>> error at the end.
> 
> It does not warn about bad addresses from body, and there are no tests yet!

Now it does warn, though I don't know if we should warn after each message,
or all together at the end, and if we should warn only about _new_ addresses.

Still no tests, and no idea how to write one...

Also if it is to be standalone commit, it needs better commit message.
But if it is to squashed with previous, it doesn't ;-)

 git-send-email.perl |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e758fd9..b8d4fb9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1136,11 +1136,20 @@ X-Mailer: git-send-email $gitversion
 
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
-		$smtp->to( @recipients_extra, { Notify => ['NEVER'], SkipBad => 1 });
+		my @good_recips =
+			$smtp->to( @recipients_extra, { Notify => ['NEVER'], SkipBad => 1 });
 		$smtp->data or die $smtp->message;
 		$smtp->datasend("$header\n$message") or die $smtp->message;
 		$smtp->dataend() or die $smtp->message;
 		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
+
+		%seen = ();
+		unique_email_list(\%seen, @good_recips);
+		# bad recipients are those not seen on list of good recipients
+		my @bad_recips = unique_email_list(\%seen, @recipients_extra);
+		@bad_recips and
+			warn "W: The following addresses added from body were rejected:\n\t".
+				join("\n\t", @bad_recips)."\n";
 	}
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
-- 
1.7.5
