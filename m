From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v4 07/10] send-email: reduce dependancies impact on parse_address_line
Date: Wed, 17 Jun 2015 16:18:37 +0200
Message-ID: <1434550720-24130-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 16:20:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ECp-0007a4-TR
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 16:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbbFQOTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 10:19:22 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:56945 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756687AbbFQOTG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 10:19:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9B39528CB;
	Wed, 17 Jun 2015 16:19:05 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03LSpKBkE-5o; Wed, 17 Jun 2015 16:19:05 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 8294326E8;
	Wed, 17 Jun 2015 16:19:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 7D45320DD;
	Wed, 17 Jun 2015 16:19:05 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XhssPyPFeFHS; Wed, 17 Jun 2015 16:19:05 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-475-169.w90-52.abo.wanadoo.fr [90.52.146.169])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 91ABC20D1;
	Wed, 17 Jun 2015 16:19:04 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271845>

parse_address_line had not the same behavior whether the user had
Mail::Address or not. Teach parse_address_line to behave like
Mail::Address.

When the user input is correct, this implementation behaves
exactly like Mail::Address except when there are quotes
inside the name:

  "Jane Do"e <jdoe@example.com>

In this case the result of parse_address_line is:

  With M::A : "Jane Do" e <jdoe@example.com>
  Without   : "Jane Do e" <jdoe@example.com>

When the user input is not correct, the behavior is also mostly
the same.

Unlike Mail::Address, this doesn't parse groups and recursive
commentaries.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 git-send-email.perl | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a0cd7ff..a1f6c18 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -477,9 +477,59 @@ foreach my $entry (@bcclist) {
 sub parse_address_line {
 	if ($have_mail_address) {
 		return map { $_->format } Mail::Address->parse($_[0]);
-	} else {
-		return split_addrs($_[0]);
 	}
+
+	my $commentrgx=qr/\((?:[^)]*)\)/;
+	my $quotergx=qr/"(?:[^\"\\]|\\.)*"/;
+	my $wordrgx=qr/(?:[^]["\s()<>:;@\\,.]|\\.)+/;
+	my $tokenrgx = qr/(?:$quotergx|$wordrgx|$commentrgx|\S)/;
+
+	my @tokens = map { $_ =~ /\s*($tokenrgx)\s*/g } @_;
+	push @tokens, ",";
+
+	my (@addr_list, @phrase, @address, @comment, @buffer) = ();
+	foreach my $token (@tokens) {
+	    if ($token =~ /^[,;]$/) {
+		if (@address) {
+		    push @address, @buffer;
+		} else {
+		    push @phrase, @buffer;
+		}
+
+		my $str_phrase = join ' ', @phrase;
+		my $str_address = join '', @address;
+		my $str_comment = join ' ', @comment;
+
+		if ($str_phrase =~ /[][()<>:;@\\,.\000-\037\177]/) {
+		    $str_phrase =~ s/(^|[^\\])"/$1/g;
+		    $str_phrase = qq["$str_phrase"];
+		}
+
+		if ($str_address ne "" && $str_phrase ne "") {
+		    $str_address = qq[<$str_address>];
+		}
+
+		my $str_mailbox = "$str_phrase $str_address $str_comment";
+		$str_mailbox =~ s/^\s*|\s*$//g;
+		push @addr_list, $str_mailbox if ($str_mailbox);
+
+		@phrase = @address = @comment = @buffer = ();
+	    } elsif ($token =~ /^\(/) {
+		push @comment, $token;
+	    } elsif ($token eq "<") {
+		push @phrase, (splice @address), (splice @buffer);
+	    } elsif ($token eq ">") {
+		push @address, (splice @buffer);
+	    } elsif ($token eq "@") {
+		push @address, (splice @buffer), "@";
+	    } elsif ($token eq ".") {
+		push @address, (splice @buffer), ".";
+	    } else {
+		push @buffer, $token;
+	    }
+	}
+
+	return @addr_list;
 }
 
 sub split_addrs {
-- 
1.9.1
