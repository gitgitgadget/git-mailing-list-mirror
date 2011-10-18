From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Refactor diff body line classification
Date: Tue, 18 Oct 2011 20:26:21 +0200
Message-ID: <201110182026.22610.jnareb@gmail.com>
References: <CAFo4x0LP4fXgSNAnss_WRLo-TH_qe=esYn7P+=iS6t87tdzcbw@mail.gmail.com> <m38voj72xy.fsf@localhost.localdomain> <7v62jnl3ef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 20:26:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGEN2-0003Bt-EX
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 20:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab1JRS0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 14:26:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64445 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab1JRS0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 14:26:30 -0400
Received: by eye27 with SMTP id 27so843449eye.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=JE4cKGLN+crpatnfU42Vh7ozIH/OIQQs27K5bQS5qPo=;
        b=Wyz+naVqbmqGu1oZib/JbotAGvYxC6n5f2n3m5TOxVHjVr3HHT50IywAmaxQRufxXB
         MxJ1mR8TQXHr9LcuPheToXnMh3yihHqR2Ojtj3agIiDYlRKPsW1b02MPjFNyYaNZ7C84
         P7/AFEbX5rsb1x+3whkomBY0Kic8p//cFzyrY=
Received: by 10.213.112.212 with SMTP id x20mr474919ebp.117.1318962388844;
        Tue, 18 Oct 2011 11:26:28 -0700 (PDT)
Received: from [192.168.1.13] (abvu235.neoplus.adsl.tpnet.pl. [83.8.218.235])
        by mx.google.com with ESMTPS id a49sm8267136eea.2.2011.10.18.11.26.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Oct 2011 11:26:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v62jnl3ef.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183895>

Simplify classification of diff line body in format_diff_line(),
replacing two if-elsif chains (one for ordinary diff and one for
combined diff of a merge commit) with regexp match.  Refactor this
code into diff_line_class() function.

While at it:

* Fix an artifact in that $diff_class included leading space to be
  able to compose classes like this "class=\"diff$diff_class\"', even
  when $diff_class was an empty string.  This made code unnecessary
  ugly: $diff_class is now just class name or an empty string.

* Introduce "ctx" class for context lines ($diff_class was set to ""
  in this case before this commit).

Idea and initial code by Junio C Hamano, polish and testing by Jakub
Narebski.  Inspired by patch adding side-by-side diff by Kato Kazuyoshi,
which required $diff_class to be name of class without extra space.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Kato Kazuyoshi wrote:

>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl 
>>> index 85d64b2..095adda 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -2235,28 +2235,30 @@ sub format_diff_line {
>>>              # combined diff
>>>              my $prefix = substr($line, 0, scalar @{$from->{'href'}});
>>>              if ($line =~ m/^\@{3}/) {
>>> -                    $diff_class = " chunk_header";
>>> +                    $diff_class = "chunk_header";
>>>              } elsif ($line =~ m/^\\/) {
>>> -                    $diff_class = " incomplete";
>>> +                    $diff_class = "incomplete";
>>>              } elsif ($prefix =~ tr/+/+/) {
>>> -                    $diff_class = " add";
>>> +                    $diff_class = "add";
>>>              } elsif ($prefix =~ tr/-/-/) {
>>> -                    $diff_class = " rem";
>>> +                    $diff_class = "rem";
>>>              }
>>
>> Hmmm... that reminds me: this if-elsif chain is a bit ugly, but would
>> be hard to replace without given ... when, I think.
> 
> I wasn't reading the existing context line, but now that you mention it,
> they are not just ugly but are borderline of being incorrect (e.g. it does
> not catch a broken hunk-header that begins with "@@@@" for a two-way
> merge).
> 
> Assuming that $from->{'href'} has all the parents (i.e. 2 for two-way
> merge), shouldn't the code be more like this?
> 
>         # combined diff
>         my $num_sign = @{$from->{'href'}} + 1;
>         my @cc_classifier = (
>                 ["\@{$num_sign} ", "chunk_header"],
>                 ['\\', "incomplete"],
>                 [" {$num_sign}", ""],
>                 ["[+ ]{$num_sign}", "add"],
>                 ["[- ]{$num_sign}", "rem"],
>         );
>         for my $cls (@cc_classifier) {
>                 if ($line =~ /^$cls->[0]$/) {
>                         $diff_class = $cls->[1];
>                         last;
>                 }
>         }
> 
> Also don't we want to use "context" or something for the css class for the
> context lines, instead of assuming that we won't want to paint it in any
> special color?

How about this?

Kato Kazuyoshi, this should replace your

  [PATCH/RFC 1/2] gitweb: change format_diff_line() to remove leading SP from $diff_class

 gitweb/gitweb.perl |   67 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b0eaad7..b3284d4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2247,40 +2247,47 @@ sub format_diff_cc_simplified {
 	return $result;
 }
 
+sub diff_line_class {
+	my ($line, $from, $to) = @_;
+
+	# ordinary diff
+	my $num_sign = 1;
+	# combined diff
+	if ($from && $to && ref($from->{'href'}) eq "ARRAY") {
+		$num_sign = scalar @{$from->{'href'}};
+	}
+
+	my @diff_line_classifier = (
+		{ regexp => qr/^\@\@{$num_sign} /, class => "chunk_header"},
+		{ regexp => qr/^\\/,               class => "incomplete"  },
+		{ regexp => qr/^ {$num_sign}/,     class => "ctx" },
+		# classifier for context must come before classifier add/rem,
+		# or we would have to use more complicated regexp, for example
+		# qr/(?= {0,$m}\+)[+ ]{$num_sign}/, where $m = $num_sign - 1;
+		{ regexp => qr/^[+ ]{$num_sign}/,   class => "add" },
+		{ regexp => qr/^[- ]{$num_sign}/,   class => "rem" },
+	);
+	for my $clsfy (@diff_line_classifier) {
+		return $clsfy->{'class'}
+			if ($line =~ $clsfy->{'regexp'});
+	}
+
+	# fallback
+	return "";
+}
+
 # format patch (diff) line (not to be used for diff headers)
 sub format_diff_line {
 	my $line = shift;
 	my ($from, $to) = @_;
-	my $diff_class = "";
 
-	chomp $line;
+	my $diff_class = diff_line_class($line, $from, $to);
+	my $diff_classes = "diff";
+	$diff_classes .= " $diff_class" if ($diff_class);
 
-	if ($from && $to && ref($from->{'href'}) eq "ARRAY") {
-		# combined diff
-		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
-		if ($line =~ m/^\@{3}/) {
-			$diff_class = " chunk_header";
-		} elsif ($line =~ m/^\\/) {
-			$diff_class = " incomplete";
-		} elsif ($prefix =~ tr/+/+/) {
-			$diff_class = " add";
-		} elsif ($prefix =~ tr/-/-/) {
-			$diff_class = " rem";
-		}
-	} else {
-		# assume ordinary diff
-		my $char = substr($line, 0, 1);
-		if ($char eq '+') {
-			$diff_class = " add";
-		} elsif ($char eq '-') {
-			$diff_class = " rem";
-		} elsif ($char eq '@') {
-			$diff_class = " chunk_header";
-		} elsif ($char eq "\\") {
-			$diff_class = " incomplete";
-		}
-	}
+	chomp $line;
 	$line = untabify($line);
+
 	if ($from && $to && $line =~ m/^\@{2} /) {
 		my ($from_text, $from_start, $from_lines, $to_text, $to_start, $to_lines, $section) =
 			$line =~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2}(.*)$/;
@@ -2298,7 +2305,7 @@ sub format_diff_line {
 		}
 		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
 		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
-		return "<div class=\"diff$diff_class\">$line</div>\n";
+		return "<div class=\"$diff_classes\">$line</div>\n";
 	} elsif ($from && $to && $line =~ m/^\@{3}/) {
 		my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
 		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $to_nlines);
@@ -2331,9 +2338,9 @@ sub format_diff_line {
 		}
 		$line .= " $prefix</span>" .
 		         "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
-		return "<div class=\"diff$diff_class\">$line</div>\n";
+		return "<div class=\"$diff_classes\">$line</div>\n";
 	}
-	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
+	return "<div class=\"$diff_classes\">" . esc_html($line, -nbsp=>1) . "</div>\n";
 }
 
 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ _zip_)",
-- 
1.7.6
