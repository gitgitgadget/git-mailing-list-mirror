From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 4/8] gitweb: Introduce esc_html_hl_regions
Date: Wed, 15 Feb 2012 21:38:48 +0100
Message-ID: <1329338332-30358-5-git-send-email-jnareb@gmail.com>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 21:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxlfp-0006XA-2A
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 21:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497Ab2BOUli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 15:41:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51356 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab2BOUle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 15:41:34 -0500
Received: by eaah12 with SMTP id h12so496802eaa.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 12:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uQ2opVt0wZNCXuNrR1p9dI+6oeBxV5k/RVw1HwMRiIY=;
        b=Eap4ZY0nj7woUNKRVnZvItcmO10OClm7if8xBG8/cdEIiIArp37Il0vkBIQ0YKiYTQ
         nvAq5UW91W7kpzrB3C1LtR+DbYf9bqimdJjfiMu0gG1Y3Yc4b0C+cO1S5nzsiiYa/gCR
         PZrcjJ8V+o8HExAU82G+14wHuqD7WAttJ1u5o=
Received: by 10.14.100.134 with SMTP id z6mr1535986eef.124.1329338492180;
        Wed, 15 Feb 2012 12:41:32 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id c16sm14922307eei.1.2012.02.15.12.41.30
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 12:41:31 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190857>

The esc_html_hl_regions() subroutine added in this commit is meant to
highlight in a given string a list of regions (given as a list of
[ beg, end ] pairs of positions in string), using HTML <span> element
with given class.

It is to be used in next commit for highlighting matched part in
project search.

Implementation and enhancement notes:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Currently esc_html_hl_regions() subroutine doesn't accept any
  parameters, like esc_html() does.  We might want for example to
  pass  nbsp=>1  to it.

  It can easily be done with the following code:

    my %opts = grep { ref($_) ne "ARRAY" } @sel;
    @sel     = grep { ref($_) eq "ARRAY" } @sel;

  This allow adding parameters after or before regions, e.g.:

    esc_html_hl_regions("foo bar", "mark", [ 0, 3 ], -nbsp => 1);

* esc_html_hl_regions() escapes like esc_html(); if we wanted to
  highlight with esc_path(), we could pass subroutine reference
  to now named esc_gen_hl_regions().

    esc_html_hl_regions("foo bar", "mark", \&esc_path, [ 0, 3 ]);

  Note that this way we can handle -nbsp=>1 case automatically,
  e.g.

    esc_html_hl_regions("foo bar", "mark",
                        sub { esc_html(@_, -nbsp=>1) },
                        [ 0, 3 ]);

* Alternate solution for highlighting region of a string would be to
  use the idea that strings are to be HTML-escaped, and references to
  scalars are HTML (like in the idea for generic committags).

  This would require modifying gitweb code or esc_html to get list of
  fragments, e.g.:

    esc_html(\'<span class="mark">', 'foo', \'</span>', ' bar',
             { -nbsp => 1 });

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This commit is here only for the notes in the commit message,
otherwise it could have been squashed with the next commit.

Note that we actually end up using first enhancement in notes section
of the above commit message.

This patch is new; it was not present in v1

 gitweb/gitweb.perl |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cc2bd6d..8dcd54b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1715,6 +1715,33 @@ sub chop_and_escape_str {
 	}
 }
 
+# Highlight selected fragments of string, using given CSS class,
+# and escape HTML.  It is assumed that fragments do not overlap.
+# Regions are passed as list of pairs (array references).
+#
+# Example: esc_html_hl_regions("foobar", "mark", [ 0, 3 ]) returns
+# '<span class="mark">foo</span>bar'
+sub esc_html_hl_regions {
+	my ($str, $css_class, @sel) = @_;
+	return esc_html($str) unless @sel;
+
+	my $out = '';
+	my $pos = 0;
+
+	for my $s (@sel) {
+		$out .= esc_html(substr($str, $pos, $s->[0] - $pos))
+			if ($s->[0] - $pos > 0);
+		$out .= $cgi->span({-class => $css_class},
+		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0])));
+
+		$pos = $s->[1];
+	}
+	$out .= esc_html(substr($str, $pos))
+		if ($pos < length($str));
+
+	return $out;
+}
+
 ## ----------------------------------------------------------------------
 ## functions returning short strings
 
-- 
1.7.9
