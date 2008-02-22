From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Better chopping in commit search results
Date: Fri, 22 Feb 2008 17:33:47 +0100
Message-ID: <20080222163035.5942.93410.stgit@localhost.localdomain>
References: <7vbq6kprql.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jean-Baptiste Quenot <jbq@caraldi.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 17:36:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSasI-0003nq-Nh
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 17:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760430AbYBVQek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 11:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760144AbYBVQei
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 11:34:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:36251 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631AbYBVQeb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 11:34:31 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1334850ugc.16
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=5nTFHSmI28wcq25mPru/tY0o+sR41upVDOFmrgzUSPw=;
        b=jHneFc7yG0bMJAmL3dGtM9iQ65w5fNmxmYMI+SCxTvfHqXZOq/2H0m+NF0EzeodX5+KGrEaKrmag0mi4ZAa4y2b2QQaHnBHbX+/D8AzjlHJwX8ZbaYk1xHM9neoqUcV0H7leL+ZTEvDJkpQOTSlfVMd0Nj1vMKageCyw2aULcJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=vPEGJ0LWMKmIkhdOhtpDKXsB4Oae3S9Ry7Qx06ZuhQLXHRbpssA6HmvxoSTgKizbcbsEAdYcK5jafzx/9culUovRVuPxbKMV0HfBduSgh6Uxk7PbaIr6BJ6AIYTF4Fxjul1QmDSPYj0tr7UknXVKmVhR5fWp8kA2GeLTuYBmq3E=
Received: by 10.66.237.14 with SMTP id k14mr2547848ugh.72.1203698069947;
        Fri, 22 Feb 2008 08:34:29 -0800 (PST)
Received: from localhost.localdomain ( [83.8.207.245])
        by mx.google.com with ESMTPS id w40sm584923ugc.45.2008.02.22.08.34.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Feb 2008 08:34:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1MGXlKX005983;
	Fri, 22 Feb 2008 17:33:58 +0100
In-Reply-To: <7vbq6kprql.fsf@gitster.siamese.dyndns.org>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74733>


From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitweb: Better chopping in commit search results

When searching commit messages (commit search), if matched string is
too long, the generated HTML was munged leading to an ill-formed XHTML
document.

Now gitweb chop leading, trailing and matched parts, HTML escapes
those parts, then composes and marks up match info.  HTML output is
never chopped.  Limiting matched info to 80 columns (with slop) is now
done by dividing remaining characters after chopping match equally to
leading and trailing part, not by chopping composed and HTML marked
output.

Noticed-by: Jean-Baptiste Quenot <jbq@caraldi.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is just slightly reworked Junio's patch; probably should be 
marked as from Junio, so I'm trying to send it as it.

Strange that StGit always sends patches (stg mail) as if repo owner
was their author, regardless of path/commit author (I think; unless
"stg edit" cannot change authorship).

 gitweb/gitweb.perl |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8ed6d04..326e27c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3784,18 +3784,24 @@ sub git_search_grep_body {
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      "<td><i>" . $author . "</i></td>\n" .
 		      "<td>" .
-		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list subject"},
-			       chop_and_escape_str($co{'title'}, 50) . "<br/>");
+		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
+		               -class => "list subject"},
+		              chop_and_escape_str($co{'title'}, 50) . "<br/>");
 		my $comment = $co{'comment'};
 		foreach my $line (@$comment) {
 			if ($line =~ m/^(.*)($search_regexp)(.*)$/i) {
-				my $lead = esc_html($1) || "";
-				$lead = chop_str($lead, 30, 10);
-				my $match = esc_html($2) || "";
-				my $trail = esc_html($3) || "";
-				$trail = chop_str($trail, 30, 10);
-				my $text = "$lead<span class=\"match\">$match</span>$trail";
-				print chop_str($text, 80, 5) . "<br/>\n";
+				my ($lead, $match, $trail) = ($1, $2, $3);
+				$match = chop_str($match, 70, 5);       # in case match is very long
+				my $contextlen = (80 - len($match))/2;  # is left for the remainder
+				$contextlen = 30 if ($contextlen > 30); # but not too much
+				$lead  = chop_str($lead,  $contextlen, 10);
+				$trail = chop_str($trail, $contextlen, 10);
+
+				$lead  = esc_html($lead);
+				$match = esc_html($match);
+				$trail = esc_html($trail);
+
+				print "$lead<span class=\"match\">$match</span>$trail<br />";
 			}
 		}
 		print "</td>\n" .
