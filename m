From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email creates duplicate Message-Id's
Date: Mon, 17 Sep 2007 13:22:05 -0700
Message-ID: <7vejgxyrde.fsf@gitster.siamese.dyndns.org>
References: <11900179463203-git-send-email-avi@qumranet.com>
	<20070917155901.GP18232@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avi Kivity <avi@qumranet.com>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758093AbXIQUWi@vger.kernel.org Mon Sep 17 22:23:10 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758093AbXIQUWi@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXN7d-0007Iz-AZ
	for glk-linux-kernel-3@gmane.org; Mon, 17 Sep 2007 22:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093AbXIQUWi (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 17 Sep 2007 16:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757120AbXIQUWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Sep 2007 16:22:18 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756929AbXIQUWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Sep 2007 16:22:17 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 42D38136DEA;
	Mon, 17 Sep 2007 16:22:29 -0400 (EDT)
In-Reply-To: <20070917155901.GP18232@stusta.de> (Adrian Bunk's message of
	"Mon, 17 Sep 2007 17:59:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58479>

Adrian Bunk <bunk@kernel.org> writes:

> The following might be a bug in git-send-email (git maintainers Cc'ed
> and KVM list removed from Cc): 
>
> Patch 54 got the same Message-Id as patch 61 and patch 89 got the same 
> Message-Id as patch 104.
> ...
> The emails are:
> http://marc.info/?l=linux-kernel&m=119002061330270&w=2
> http://marc.info/?l=linux-kernel&m=119002059626434&w=2
> http://marc.info/?l=linux-kernel&m=119002060011801&w=2
> http://marc.info/?l=linux-kernel&m=119002060318915&w=2

The old code generated rand(4200) for each message and appended
it to the timestamp.  I do not know where the original author
got 4200 from, but I think if you send many messages within a
single second it is possible to get collisions.

I guess something like this patch is an improvement?  It
generates a single prefix from timestamp and random, and appends
a number that is incremented for each message.

---
diff --git a/git-send-email.perl b/git-send-email.perl
index dd7560b..e250732 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -477,10 +477,18 @@ sub extract_valid_address {
 
 # We'll setup a template for the message id, using the "from" address:
 
+my ($message_id_stamp, $message_id_serial);
 sub make_message_id
 {
-	my $date = time;
-	my $pseudo_rand = int (rand(4200));
+	my $uniq;
+	if (!defined $message_id_stamp) {
+		$message_id_stamp = sprintf("%s-%s", time, int(rand(4200)));
+		$message_id_serial = 0;
+	}
+	$message_id_serial++;
+
+	$uniq = "$message_id_stamp-$message_id_serial";
+
 	my $du_part;
 	for ($sender, $repocommitter, $repoauthor) {
 		$du_part = extract_valid_address(sanitize_address($_));
@@ -490,8 +498,8 @@ sub make_message_id
 		use Sys::Hostname qw();
 		$du_part = 'user@' . Sys::Hostname::hostname();
 	}
-	my $message_id_template = "<%s-git-send-email-$du_part>";
-	$message_id = sprintf $message_id_template, "$date$pseudo_rand";
+	my $message_id_template = "<%s-git-send-email-%s>";
+	$message_id = sprintf($message_id_template, $uniq, $du_part);
 	#print "new message id = $message_id\n"; # Was useful for debugging
 }
 
