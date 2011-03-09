From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/1] gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)
Date: Wed, 9 Mar 2011 15:04:59 +0100
Message-ID: <201103091505.03045.jnareb@gmail.com>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek> <20110303081904.GM22310@pengutronix.de> <201103071900.16126.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, admin@repo.or.cz
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 15:05:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxK10-0007AK-Pv
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 15:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520Ab1CIOFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 09:05:20 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab1CIOFT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 09:05:19 -0500
Received: by bwz15 with SMTP id 15so679045bwz.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 06:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=HkoZaSOliTDu35X35raxDB4zobXxYTpIKNuPmn5j37c=;
        b=kyqTWr68bmJ9+z7OvKJF5FhcJ29aJaKpZ8FpGSk9U3h4hJ4ISdB/PZ5dAFVKaCxLuH
         S/qup4pJoOgeDBfH6uXaQOJx8xHW4xuUALEIiz+s4bqiJFYnuRA0OfLXgcEugU8OurjN
         rn3GD4P1eyeImh0VXob+LABWGSbVCGH2qKM8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=D6jX0959ugZNjFN3oCPUdBrGwl247GLc7l6fibwCkjKHuBQM2IxOfEX7T5P1cetg1z
         +N5xMuMPXxXdrh2t/1PnpOu/hJHU0Cg/mjY11MZ/bZa1yJvv4U3GmUrKKmgNqV2JzD3N
         d3SY4iYIEx8URrBrWO7IXZhwNyuGiukOEtwZg=
Received: by 10.204.20.147 with SMTP id f19mr5645790bkb.163.1299679517845;
        Wed, 09 Mar 2011 06:05:17 -0800 (PST)
Received: from [192.168.1.13] (abwi112.neoplus.adsl.tpnet.pl [83.8.232.112])
        by mx.google.com with ESMTPS id b6sm1321717bkb.10.2011.03.09.06.05.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 06:05:15 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201103071900.16126.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168731>

It might have been hard to discover that current view is limited to
projects with given content tag (ctag), as it was distinquished only
in gitweb URL.  Mark matched contents tag in the tag cloud using
"match" class, for easier discovery.

This commit introduces a bit of further code duplication in
git_populate_project_tagcloud().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4d80818..7ba8a72 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2645,6 +2645,7 @@ sub git_populate_project_tagcloud {
 	}
 
 	my $cloud;
+	my $matched = $cgi->param('by_tag');
 	if (eval { require HTML::TagCloud; 1; }) {
 		$cloud = HTML::TagCloud->new;
 		foreach my $ctag (sort keys %ctags_lc) {
@@ -2654,17 +2655,22 @@ sub git_populate_project_tagcloud {
 			$title =~ s/ /&nbsp;/g;
 			$title =~ s/^/&nbsp;/g;
 			$title =~ s/$/&nbsp;/g;
+			if (defined $matched && $matched eq $ctag) {
+				$title = qq(<span class="match">$title</span>);
+			}
 			$cloud->add($title, href(project=>undef, ctag=>$ctag),
 			            $ctags_lc{$ctag}->{count});
 		}
 	} else {
 		$cloud = {};
 		foreach my $ctag (keys %ctags_lc) {
-			my $title = $ctags_lc{$ctag}->{topname};
+			my $title = esc_html($ctags_lc{$ctag}->{topname}, -nbsp=>1);
+			if (defined $matched && $matched eq $ctag) {
+				$title = qq(<span class="match">$title</span>);
+			}
 			$cloud->{$ctag}{count} = $ctags_lc{$ctag}->{count};
 			$cloud->{$ctag}{ctag} =
-				$cgi->a({-href=>href(project=>undef, ctag=>$ctag)},
-			          esc_html($title, -nbsp=>1));
+				$cgi->a({-href=>href(project=>undef, ctag=>$ctag)}, $title);
 		}
 	}
 	return $cloud;
-- 
1.7.3
