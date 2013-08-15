From: Christopher Durkin <cjdurkin@gmail.com>
Subject: [PATCH 1/2] gitweb: add filename search function
Date: Wed, 14 Aug 2013 23:02:38 -0400
Message-ID: <CANzJMBWDgtjbNwPLjoKniwy5xCGKyz0yBFiMBfdGJMi5Q=W4+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 05:03:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9nq4-0001M4-Ip
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 05:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759997Ab3HODCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 23:02:40 -0400
Received: from mail-vb0-f45.google.com ([209.85.212.45]:62748 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758610Ab3HODCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 23:02:39 -0400
Received: by mail-vb0-f45.google.com with SMTP id e15so196679vbg.4
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 20:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=V2THTT87xQCef+VIkPMosX7LHqUVNCTCDOU0H3rQWBc=;
        b=qLM/zEai3ZR1CgEPVVytg4sbu04IQrSNGxSZJQdLAw20QyRpQc2KdKaNJf3aDEg48q
         tGwzz/TgFZc5C6Bn0BTUVU3NnxBSIpCs79UDhfLuyytRfhi/GR5hVKX3gfdHNJX+BJAh
         XfJMv0FlQnHKM6P2NelaLPUBMH85Zpp/SY4vAFn3hNVxmmFJjgLb2K9zU1eh/DzeVZe/
         TIZhwGaqDQ5Xue2nlEOWboeEH2irmnTOujd/gfxuHVnKiBOewIX0g9+/f3SwIn17PhGI
         z0gyi/R1fZySkLD8klaP1HXjgDEh04jLeqJ4MhyxmTF/YG86DeKrlV5aO3+kiZAPMrET
         3MKQ==
X-Received: by 10.220.169.203 with SMTP id a11mr4020526vcz.26.1376535758827;
 Wed, 14 Aug 2013 20:02:38 -0700 (PDT)
Received: by 10.58.231.70 with HTTP; Wed, 14 Aug 2013 20:02:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232327>

Add another item to the search drop-down (author/committer/etc)
to search for file names instead of file content. Output is similar
to the grep contents output, with each entry linking to the file.
---
 gitweb/gitweb.perl | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f429f75..4a7b0a5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6360,6 +6360,65 @@ sub git_search_grep_body {
  print "</table>\n";
 }

+sub git_search_filenames {
+    my %co = @_;
+    local $/ = "\n";
+    my $match_limit = 1000;
+
+    open my $fd, "-|", git_cmd(), 'ls-tree', '--name-only',
'--full-name', '-r',
+      $co{'tree'} or die_error(500, "Open git-ls-tree failed");
+
+    git_header_html();
+
+    git_print_page_nav('','', $hash,$co{'tree'},$hash);
+    git_print_header_div('commit', esc_html($co{'title'}), $hash);
+
+    print "<table class=\"filename_search\">\n";
+    my $matches = 0;
+    my $alternate = 1;
+    my $file_href;
+
+    while (my $filename = <$fd>) {
+        chomp $filename;
+
+        if ($matches > $match_limit) {
+            print "<div class=\"diff nodifferences\">Too many
matches, listing trimmed</div>\n";
+            last;
+        }
+
+        if ($search_use_regexp) {
+            next unless ($filename =~ /$searchtext/);
+        } else {
+            next unless index($filename,$searchtext) >= 0;
+        }
+
+        $matches++;
+        $file_href = href(action=>"blob", hash_base=>$co{'id'},
+                          file_name=>$filename);
+
+ if ($alternate) {
+    print "<tr class=\"dark\">\n";
+ } else {
+    print "<tr class=\"light\">\n";
+ }
+ $alternate ^= 1;
+
+        print "<td class=\"list\">".
+            $cgi->a({-href => $file_href, -class => "list"},
esc_path($filename));
+ print "</td>\n";
+ print "</tr>\n";
+    }
+
+    if ($matches == 0) {
+        print "<div class=\"diff nodifferences\">No matches found</div>\n";
+    }
+    close $fd;
+
+    print "</table>\n";
+
+    git_footer_html();
+}
+
 ## ======================================================================
 ## ======================================================================
 ## actions
-- 
1.8.3.msysgit.0
