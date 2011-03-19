From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH -1/3] gitweb: Always call parse_date with timezone parameter
Date: Sat, 19 Mar 2011 23:18:44 +0100
Message-ID: <201103192318.45925.jnareb@gmail.com>
References: <4f21902cf5f72b30a96465cf911d13aa@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 23:18:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q14U1-0001r8-R3
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 23:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601Ab1CSWSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 18:18:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64788 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187Ab1CSWSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 18:18:48 -0400
Received: by wya21 with SMTP id 21so4823094wya.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=rtcY+zj0R0Vx+b32bHmHCm31TSvDFiWYmvcNBSaTJpc=;
        b=NxOKUJIremiaFNtdg22XqJfSyi7XwkbgQXn9txrO/yR2/G9+u9QHlBGX/cQ7RAEWzy
         6XfmhAHm3CNfVIP5e1i8YboGxOF0pU9asMberEYPmyTnJ5CvrwlxyN6oJal8TPueEonF
         YSUBMbHJx8a19WWYDATlu3RwmtdCIxy8AcCDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q2cfXvD3K8aYnMij6ucLRo7CKTEJio0g82Z5pPOT0T9L0Oep3kSpMFrO24Wf1VJloO
         j43eOZVqeHQ1C+r4Oat4U7IwSCgi9V+QGA8StepKQvM+tD9IbcoRskspy5tPs8PlZBhv
         U5maekJhb7I3iG1l+tMVc9qdCQdmBIrkhTtmA=
Received: by 10.227.59.134 with SMTP id l6mr2584802wbh.34.1300573127538;
        Sat, 19 Mar 2011 15:18:47 -0700 (PDT)
Received: from [192.168.1.13] (abrz59.neoplus.adsl.tpnet.pl [83.8.119.59])
        by mx.google.com with ESMTPS id bs4sm145289wbb.18.2011.03.19.15.18.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 15:18:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4f21902cf5f72b30a96465cf911d13aa@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169471>

Timezone is required to correctly set local time, which would be needed
for future 'localtime' feature.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b04ab8c..0f89ed2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4906,7 +4906,7 @@ sub git_log_body {
 		next if !%co;
 		my $commit = $co{'id'};
 		my $ref = format_ref_marker($refs, $commit);
-		my %ad = parse_date($co{'author_epoch'});
+		my %ad = parse_date($co{'author_epoch'}, $co{'athor_tz'});
 		git_print_header_div('commit',
 		               "<span class=\"age\">$co{'age_string'}</span>" .
 		               esc_html($co{'title'}) . $ref,
@@ -7064,7 +7064,7 @@ sub git_feed {
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
 		my $latest_epoch = $latest_commit{'committer_epoch'};
-		%latest_date   = parse_date($latest_epoch);
+		%latest_date   = parse_date($latest_epoch, $latest_commit{'comitter_tz'});
 		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
 		if (defined $if_modified) {
 			my $since;
@@ -7195,7 +7195,7 @@ XML
 		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
 			last;
 		}
-		my %cd = parse_date($co{'author_epoch'});
+		my %cd = parse_date($co{'author_epoch'}, $co{'author_tz'});
 
 		# get list of changed files
 		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-- 
1.7.3
