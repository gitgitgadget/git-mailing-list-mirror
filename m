From: Yoshihiro Sugi <sugi1982@gmail.com>
Subject: Re: [PATCH] contrib/diff-highlight: multibyte characters diff
Date: Fri, 14 Feb 2014 04:14:16 +0900
Message-ID: <1392318856-55920-1-git-send-email-sugi1982@gmail.com>
References: <20140212205948.GA4453@sigill.intra.peff.net>
Cc: Yoshihiro Sugi <sugi1982@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 13 20:14:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE1kL-0006Tn-LV
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 20:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbaBMTOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 14:14:50 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:48081 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaBMTOt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 14:14:49 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so11186459pbc.18
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h4UQxviCvmCqwDY0XGcEKkSttb2j9tXJ3MeWdiD38I0=;
        b=iA9a2Q/YTbIHUmiqXKw4HVoqnGgwVTdqLBOosFmDlM/iVLp0AUDeVcGsBMK6HiSl7B
         oCSgAjfWE3OEwas5Pog+q2+PQRYWxkYnvd+G88i3aNt0y9dogVP3T5rMSwM1fwtF1TjU
         wag4JZUkDey3KgKyg9bvO46AjpKh1P+0S2hlABJobjCr3RM2IA6YPeFs0nFIODAQIJ5K
         l/P6ABPK/CBil9dketj2dIu0BRNS1erE5itvX2wBeO/D82oUk1UjKnWCOjljem1okGcW
         pOHVaZ/nBhowDOarPcz+lVA62mkZx24KotgiJ1uqIYRZmauclr3LTdlLEAQWqK8PMVz2
         P3uw==
X-Received: by 10.68.164.4 with SMTP id ym4mr3684586pbb.53.1392318888613;
        Thu, 13 Feb 2014 11:14:48 -0800 (PST)
Received: from localhost.localdomain (i60-34-32-137.s42.a013.ap.plala.or.jp. [60.34.32.137])
        by mx.google.com with ESMTPSA id ja8sm9192930pbd.3.2014.02.13.11.14.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Feb 2014 11:14:47 -0800 (PST)
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <20140212205948.GA4453@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242073>

Thanks for reviewing.
as you wrote, diff content may not be utf8 at all. and we don't know that the user's terminal watns is utf8.
I think your trying utf8 decode and fall back approach is better than my patch, and do work well.

is using "$@" for catching error like the patch below?
According to perldoc Encode.pm, encode/decode with "FB_CROAK" may destroy original string. We should probabry use "LEAVE_SRC" on decode_utf8's second argument.

---
 contrib/diff-highlight/diff-highlight | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index c4404d4..0743851 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -2,6 +2,7 @@
 
 use warnings FATAL => 'all';
 use strict;
+use Encode qw(decode_utf8 encode_utf8);
 
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
@@ -73,13 +74,23 @@ sub show_hunk {
 
 	my @queue;
 	for (my $i = 0; $i < @$a; $i++) {
-		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
-		print $rm;
-		push @queue, $add;
+		my ($a_dec, $encode_rm) = decode($a->[$i]);
+		my ($b_dec, $encode_add) = decode($b->[$i]);
+		my ($rm, $add) = highlight_pair($a_dec, $b_dec);
+		print $encode_rm->($rm);
+		push @queue, $encode_add->($add);
 	}
 	print @queue;
 }
 
+sub decode {
+	my $orig = shift;
+	my $decoded = eval { decode_utf8($orig, Encode::FB_CROAK | Encode::LEAVE_SRC) };
+	return $@ ?
+	       ($orig, sub { shift }) :
+	       ($decoded, sub { encode_utf8(shift) });
+}
+
 sub highlight_pair {
 	my @a = split_line(shift);
 	my @b = split_line(shift);
-- 
1.8.5.3
