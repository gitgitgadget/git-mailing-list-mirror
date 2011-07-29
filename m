From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 5/6] gitweb: Highlight matched part of project name when searching projects
Date: Fri, 29 Jul 2011 13:52:58 +0200
Message-ID: <1311940379-9608-6-git-send-email-jnareb@gmail.com>
References: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 13:53:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmldO-0005xQ-Ni
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 13:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636Ab1G2Lxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 07:53:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48460 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab1G2Lxc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 07:53:32 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so2225423fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uRS64NZG/GXj54WNMokZmSHILBdIbjtInG/GIgYDq1o=;
        b=x+3L93hD+nERQSX+tB+b6voOPdH2hlbiQclnhSB6hf2xlgnz9dMKEKZIdOGLjELFA6
         Y1gvpggWoC3tLlCAu+QEDHFZD3rtdA9HKbJ0+FJVhLJTjWX709ledC/Bc2FSnJXHrayK
         X26sCNW/FkvxNIC/6ALBCeVWKih8YeXXhMjLA=
Received: by 10.223.127.195 with SMTP id h3mr1656498fas.135.1311940411425;
        Fri, 29 Jul 2011 04:53:31 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id n27sm1049500faa.4.2011.07.29.04.53.29
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 04:53:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178135>

Use newly introduced esc_html_match_hl() to escape HTML and mark match
with span element with 'match' class.  Currently only 'path' part
(i.e. project name) is highlighted; match might be on the project
description.

The code makes use of the fact that defined $search_regexp means that
there was search going on.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The esc_html_match_hl() subroutine (I really need a better name for
it) should probably be used in more places, everywhere where we do
highlight match in non-shortened text.  It is safe wrt. codes that
need HTML escaping both in non-matched and in matched part, and with
regular expression containing characters that would be escaped, for
example "foo>?" (i.e. "foo|foo>").

 gitweb/gitweb.perl |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9c82d79..692a6bb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1690,6 +1690,30 @@ sub chop_and_escape_str {
 	}
 }
 
+# highlight match (if any), and escape HTML
+sub esc_html_match_hl {
+	my ($str, $regexp) = @_;
+	return esc_html($str) unless defined $regexp;
+
+	my @matches;
+	while ($str =~ /$regexp/g) {
+		push @matches, [$-[0], $+[0]];
+	}
+	return esc_html($str) unless @matches;
+
+	my $out = '';
+	my $pos = 0;
+	for my $m (@matches) {
+		$out .= esc_html(substr $str, $pos, $m->[0] - $pos);
+		$out .= $cgi->span({-class => 'match'},
+		                   esc_html(substr $str, $m->[0], $m->[1] - $m->[0]));
+		$pos = $m->[1];
+	}
+	$out .= esc_html(substr $str, $pos);
+
+	return $out;
+}
+
 ## ----------------------------------------------------------------------
 ## functions returning short strings
 
@@ -5143,7 +5167,9 @@ sub git_project_list_rows {
 			print "</td>\n";
 		}
 		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
-		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
+		                        -class => "list"},
+		                       esc_html_match_hl($pr->{'path'}, $search_regexp)) .
+		      "</td>\n" .
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list", -title => $pr->{'descr_long'}},
 		                        esc_html($pr->{'descr'})) . "</td>\n" .
-- 
1.7.5
