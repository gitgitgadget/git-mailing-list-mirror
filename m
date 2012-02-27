From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 1/4] gitweb: Introduce esc_html_match_hl and esc_html_hl_regions
Date: Mon, 27 Feb 2012 02:55:19 +0100
Message-ID: <1330307722-25351-2-git-send-email-jnareb@gmail.com>
References: <1330307722-25351-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 02:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1pp2-0007tu-HD
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 02:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab2B0B4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 20:56:03 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63475 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab2B0Bze (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 20:55:34 -0500
Received: by eekc41 with SMTP id c41so561041eek.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 17:55:33 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.136.209 as permitted sender) client-ip=10.14.136.209;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.136.209 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.136.209])
        by 10.14.136.209 with SMTP id w57mr5712939eei.19.1330307733391 (num_hops = 1);
        Sun, 26 Feb 2012 17:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=o3xnBwvDM0LgHqyGQICewZ6bxMalxmnPVfDDNFVs2lU=;
        b=I6P3wb+GjdTvbfHJ2u2v7Zxw6P1535c5ZQvT2vQBlNQmMbO1gGIjbDiG6DsxtNV/rj
         54fonpCaI24rXhsCrdlW+4iEKP7zn3TxHuX6mI2Ac+9m18STe/2Hbv+r8dpimAd3tx3G
         KCXXfMKgmP67gHj/w0VY+BKbfiB23lL7CwPxY=
Received: by 10.14.136.209 with SMTP id w57mr4283394eei.19.1330307733328;
        Sun, 26 Feb 2012 17:55:33 -0800 (PST)
Received: from localhost.localdomain (abvv154.neoplus.adsl.tpnet.pl. [83.8.219.154])
        by mx.google.com with ESMTPS id n17sm52112996eei.3.2012.02.26.17.55.32
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 17:55:33 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330307722-25351-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191597>

The esc_html_match_hl() subroutine added in this commit will be used
to highlight *all* matches of given regexp, using 'match' class.
Ultimately it is to be used in all match highlighting, starting
with project search, which does not have it yet.

It uses the esc_html_hl_regions() subroutine, which is meant to
highlight in a given string a list of regions (given as a list of
[ beg, end ] pairs of positions in string), using HTML <span> element
with given class.  It could probably be used in other places that
do highlighting of part of ready line, like highlighting of changes
in a diff (diff refinement highlighting).


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

  or

    esc_html([\'<span class="mark">', 'foo', \'</span>', ' bar'],
             -nbsp=>1);

  esc_html_match_hl() could be then simple wrapper around "match
  formatter", e.g.

    esc_html([ render_match_hl($str, $regexp) ], -nbsp=>1);


Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This commit is here mainly for the notes in the commit message,
otherwise it could have been squashed with the next commit.  Having
it as a separate commit might help with reviewing.

Changes from v2 (patch was not present in v1):
* Patch includes esc_html_match_hl() subroutine (the interface), and
  not only the esc_html_hl_regions() "engine".

* Slightly expanded "Implementation and enhancement notes" section in
  the commit message.

* Added not about possible future use of esc_html_hl_regions()
  in commit message

 gitweb/gitweb.perl |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4ceb1a6..b790f67 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1715,6 +1715,47 @@ sub chop_and_escape_str {
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
+	return esc_html_hl_regions($str, 'match', @matches);
+}
+
 ## ----------------------------------------------------------------------
 ## functions returning short strings
 
-- 
1.7.9
