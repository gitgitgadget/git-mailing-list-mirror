From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH 4/5] Adding SUMMARY lines to hunks.
Date: Thu, 27 Nov 2008 21:10:28 +0000
Message-ID: <492F0CC4.7050805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5o9d-0004dt-8h
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYK0VKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752795AbYK0VKf
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:10:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:55687 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYK0VKd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:10:33 -0500
Received: by nf-out-0910.google.com with SMTP id d3so627488nfc.21
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 13:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=DkyQr8p8OrW9WMrFkqvzlUsHGocl/Z/Te4CtkAVHxU0=;
        b=hV9TzPrwwJEmyhMwvCEW90nOn5rBwPooJAIVpW9py3Lm6kD2fOBTkoHX3bBNkN0bHM
         zgua/oaUg9l+WaMHxj13uYmHO7W94snIHF4P41bOdg6CllICntZLeL5Udv/Xo8T0fXkN
         K11cX3KBpxSXj+R1Qs15prfhgKoWk1CcScqZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=A8b6Y6WAMs9THHPsG7NeNLNYAE0G61QwQeChumDtRUXaVzupkFFfGHi66vMXradxOV
         jgeBkPtFOYYQU0Sg2REuxFuuZvNgAmFGJXsvOmbdPo/GpUOnYl9F8azbBbB3nARE+vIq
         k3uwUfVzTliQEkYwt5kpHgWsu/myHEQHXPgNs=
Received: by 10.210.54.19 with SMTP id c19mr7973846eba.24.1227820232611;
        Thu, 27 Nov 2008 13:10:32 -0800 (PST)
Received: from clam.local (5ace135b.bb.sky.com [90.206.19.91])
        by mx.google.com with ESMTPS id i6sm225458gve.26.2008.11.27.13.10.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 13:10:31 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101828>



The idea is to add a command to allow the hunks to be listed
with a brief summary of each, with an option to determine
what the summary will entail.  The current thought is
to be able to display the line summary, the first new
line, and the first removed line.
---
  git-add--interactive.perl |   27 ++++++++++++++++++++++++++-
  1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 0d51cb2..ae785e2 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -553,7 +553,20 @@ sub parse_diff {

  	for (my $i = 0; $i < @diff; $i++) {
  		if ($diff[$i] =~ /^@@ /) {
-			push @hunk, { TEXT => [], DISPLAY => [] };
+			push @hunk,
+			{ TEXT => [], DISPLAY => [],
+				SUMMARY => {
+					 LINE => $diff[$i],
+					 NEW => undef,
+					 OLD => undef
+				}
+			};
+		}
+		if ($diff[$i] =~ /^\+/ and not $hunk[-1]{SUMMARY}{NEW}) {
+			$hunk[-1]{SUMMARY}{NEW} = $diff[$i];
+		}
+		if ($diff[$i] =~ /^-/ and not $hunk[-1]{SUMMARY}{OLD}) {
+			$hunk[-1]{SUMMARY}{OLD} = $diff[$i];
  		}
  		push @{$hunk[-1]{TEXT}}, $diff[$i];
  		push @{$hunk[-1]{DISPLAY}},
@@ -613,6 +626,11 @@ sub split_hunk {
  		my $this = +{
  			TEXT => [],
  			DISPLAY => [],
+			SUMMARY => {
+				 LINE => undef,
+				 NEW => undef,
+				 OLD => undef
+			},
  			OLD => $o_ofs,
  			NEW => $n_ofs,
  			OCNT => 0,
@@ -658,6 +676,12 @@ sub split_hunk {
  				push @split, $this;
  				redo OUTER;
  			}
+			if ($line =~ /\+/ and not $this->{SUMMARY}{NEW}) {
+				$this->{SUMMARY}{NEW} = $line;
+			}
+			if ($line =~ /-/ and not $this->{SUMMARY}{OLD}) {
+				$this->{SUMMARY}{OLD} = $line;
+			}
  			push @{$this->{TEXT}}, $line;
  			push @{$this->{DISPLAY}}, $display;
  			$this->{ADDDEL}++;
@@ -685,6 +709,7 @@ sub split_hunk {
  			    (($n_cnt != 1) ? ",$n_cnt" : '') .
  			    " @@\n");
  		my $display_head = $head;
+		$hunk->{SUMMARY}{LINE} = $head;
  		unshift @{$hunk->{TEXT}}, $head;
  		if ($diff_use_color) {
  			$display_head = colored($fraginfo_color, $head);
-- 
1.6.0.4.782.geea74.dirty


-- 
William Pursell
