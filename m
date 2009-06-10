From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 4/6] send-email: fix threaded mails without chain-reply-to
Date: Wed, 10 Jun 2009 00:17:11 -0700
Message-ID: <7vd49ctv60.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<1244410857-920-4-git-send-email-markus.heidelberg@web.de>
	<7vhbyo1vr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:17:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEI3i-0008Os-OT
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 09:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbZFJHRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 03:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbZFJHRK
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 03:17:10 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51040 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbZFJHRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 03:17:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610071712.VVYW20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 10 Jun 2009 03:17:12 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 27HB1c0044aMwMQ047HBJV; Wed, 10 Jun 2009 03:17:11 -0400
X-VR-Score: -62.00
X-Authority-Analysis: v=1.0 c=1 a=H0ChLV_sMVsA:10 a=MLYtUXVIeLgA:10
 a=ybZZDoGAAAAA:8 a=vuFWmiVyIIijmioKV8MA:9 a=Z44Z3fId-2IKngdyI6AAhGnnWOAA:4
 a=MCAouRVjatsA:10 a=5KVauyKsRKMA:10 a=qIVjreYYsbEA:10 a=oFWLcQE7vYWZRgZd:21
 a=3IOr3-TIzdM3Mxd0:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121257>

From: Markus Heidelberg <markus.heidelberg@web.de>
Date: Sun, 7 Jun 2009 23:40:54 +0200

An earlier commit 15da108 ("send-email: 'References:' should only
reference what is sent", 2009-04-13) broke logic to set up threading
information for the next message by rewriting "!" to "not" without
understanding the precedence rules of the language.

Namely,

    ! defined $reply_to || length($reply_to) == 0

was changed to

    not defined $reply_to || length($reply_to) == 0

which is

    not (defined $reply_to || length($reply_to) == 0)

and different from what was intended, which is

    (not defined $reply_to) || (length($reply_to) == 0)

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Applies on top of 15da108 to fix the breakage there.

 git-send-email.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 43f956b..c55b045 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1135,7 +1135,8 @@ foreach my $t (@files) {
 	my $message_was_sent = send_message();
 
 	# set up for the next message
-	if ($message_was_sent and $chain_reply_to || not defined $reply_to || length($reply_to) == 0) {
+	if ($message_was_sent &&
+		($chain_reply_to || !defined $reply_to || length($reply_to) == 0)) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
-- 
1.6.3.2.214.gf4f78e
