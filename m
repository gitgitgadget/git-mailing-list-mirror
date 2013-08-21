From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 1/2] git-send-email: add optional 'choices' parameter to the ask sub
Date: Wed, 21 Aug 2013 19:04:21 +0000
Message-ID: <1377111862-13199-2-git-send-email-rv@rasmusvillemoes.dk>
References: <1376701126-5759-1-git-send-email-rv@rasmusvillemoes.dk>
 <1377111862-13199-1-git-send-email-rv@rasmusvillemoes.dk>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: gitster@pobox.com, sandals@crustytoothpaste.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 21:05:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCDiT-00020u-Tb
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 21:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab3HUTFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 15:05:07 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:56026 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab3HUTFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 15:05:06 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so474452eaj.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 12:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3pbxd31fIBab6AfdwLoBc2li2Lp1jpI8LEPFJxxEMuc=;
        b=pJS7EpgQi93yUsyiE71dw7PDh1AvUXi3IEf9FORjPyXeNO0imKITWzR5R1TVauNk/t
         k/h7ERrDnJk+4ykLMhXg4r1Mp3V7QkNOuSlT7fanyeeTKni3m/G2gKMKMLAUBpE7fdOt
         eFp9m7/y3I5/Lj14pTX4KUMhrMUsiUL4KgagYR1Iy+0B+elwKzg7fDDs+Ek27KKB1459
         gix/UknHB8Xs5qymAKjhlHmJT4QXa2AJM9QN7+mpijFoOmeRY2pVloLSJlbcy9GjWm0u
         qaLB6JCndYxejthkPA6tjsx302ccKWqsc0ZsmLK1Jjgx2SvSR0Pf4ALIQAsgPF5NSk6l
         OHJw==
X-Gm-Message-State: ALoCoQlEAk27G1rblRZ6YNWJZa9nn7jNotbYb2c1Kdhtcr5FQUkbLLG7G3ICl9SinUVG/Sn9YfUR
X-Received: by 10.15.75.137 with SMTP id l9mr301094eey.88.1377111905446;
        Wed, 21 Aug 2013 12:05:05 -0700 (PDT)
Received: from villemoes-sl500.decode.is (wildmoose.dk. [83.169.18.19])
        by mx.google.com with ESMTPSA id b45sm11933719eef.4.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 12:05:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.2.g61bff3f
In-Reply-To: <1377111862-13199-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232716>

Make it possible for callers of ask() to provide a list of
choices. Entering an appropriate integer chooses from that list,
otherwise the input is treated as usual.

Each choice can either be a single string, which is used both for the
prompt and for the return value, or a two-element array ref, where the
zeroth element is the choice and the first is used for the prompt.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 git-send-email.perl |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2162478..ac3b02d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -680,11 +680,18 @@ sub ask {
 	my $valid_re = $arg{valid_re};
 	my $default = $arg{default};
 	my $confirm_only = $arg{confirm_only};
+	my $choices = $arg{choices} || [];
 	my $resp;
 	my $i = 0;
 	return defined $default ? $default : undef
 		unless defined $term->IN and defined fileno($term->IN) and
 		       defined $term->OUT and defined fileno($term->OUT);
+	for (@$choices) {
+		printf "(%d) %s\n", $i++, ref($_) eq 'ARRAY' ? $_->[1] : $_;
+	}
+	printf "Enter 0-%d to choose from the above list\n", $i-1
+		if (@$choices);
+	$i = 0;
 	while ($i++ < 10) {
 		$resp = $term->readline($prompt);
 		if (!defined $resp) { # EOF
@@ -694,6 +701,10 @@ sub ask {
 		if ($resp eq '' and defined $default) {
 			return $default;
 		}
+		if (@$choices && $resp =~ m/^[0-9]+$/ && $resp < @$choices) {
+			my $c = $choices->[$resp];
+			return ref($c) eq 'ARRAY' ? $c->[0] : $c;
+		}
 		if (!defined $valid_re or $resp =~ /$valid_re/) {
 			return $resp;
 		}
-- 
1.7.9.5
