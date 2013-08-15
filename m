From: Christopher Durkin <cjdurkin@gmail.com>
Subject: [PATCH 2/2] gitweb: add plumbing for filename search
Date: Wed, 14 Aug 2013 23:02:39 -0400
Message-ID: <CANzJMBU1JjztDGns+ZCg-K+q6_HO9GNJy5nKC4ODEdGm_eJwPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 05:03:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9nq5-0001M4-7W
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 05:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760027Ab3HODCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 23:02:46 -0400
Received: from mail-vb0-f42.google.com ([209.85.212.42]:35640 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759979Ab3HODCk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 23:02:40 -0400
Received: by mail-vb0-f42.google.com with SMTP id e12so198736vbg.29
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 20:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=dMzZu+usUwR8pvFx5QxWdgiNKWVBuY3BaYwz+WiJpq0=;
        b=Xk9nZ88D1lOslOAU36radVxoApo2MZRpK0z96Mwk6PVc7uSnrOcJlRu0rOgxqy7MuZ
         C4PUnWBYUwBTspuagmFH56ewg0nihJtrCFvu8evJML59Rb2wLDIPgETkJ4zNMH85PvkO
         f7572FTkl9w/5TbIQXJEuqoUXsRg/jZX+kiwTYIIIe0nhd08g5jVJFRJZ+aPEVBydLCR
         mzPV2JBKaIshlXcQyb+HoI6HyybMeDhCF639QBbT3r11vXxKzCYMwTeGB0gAQAaU//h1
         yyKwi/puSZWyf+QnyhaPFylnbEp7BBtbyKJPXaDNq0zNs9tx35Ye+2vKlpZK0kAAngO5
         xHFA==
X-Received: by 10.220.74.69 with SMTP id t5mr12365764vcj.18.1376535759730;
 Wed, 14 Aug 2013 20:02:39 -0700 (PDT)
Received: by 10.58.231.70 with HTTP; Wed, 14 Aug 2013 20:02:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232328>

Add filename search config option and add it to the drop-down.
---
 gitweb/gitweb.perl | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4a7b0a5..087b4cb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -374,6 +374,20 @@ our %feature = (
  'override' => 0,
  'default' => [1]},

+ # Enable the filename search, which will list the files whose
+ # names contain the given string. Enabled by default. Note
+ # that you need to have 'search' feature enabled too.
+
+ # To enable system wide have in $GITWEB_CONFIG
+ # $feature{'filename'}{'default'} = [1];
+ # To have project specific config enable override in $GITWEB_CONFIG
+ # $feature{'filename'}{'override'} = 1;
+ # and in project config gitweb.pickaxe = 0|1;
+ 'filename' => {
+ 'sub' => sub { feature_bool('filename', @_) },
+ 'override' => 0,
+ 'default' => [1]},
+
  # Enable showing size of blobs in a 'tree' view, in a separate
  # column, similar to what 'ls -l' does.  This cost a bit of IO.

@@ -4034,7 +4048,7 @@ sub print_search_form {
       $cgi->input({-name=>"a", -value=>"search", -type=>"hidden"}) . "\n" .
       $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
       $cgi->popup_menu(-name => 'st', -default => 'commit',
-                       -values => ['commit', 'grep', 'author',
'committer', 'pickaxe']) .
+                       -values => ['commit', 'grep', 'author',
'committer', 'pickaxe', 'filename']) .
       $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
       " search:\n",
       $cgi->textfield(-name => "s", -value => $searchtext, -override
=> 1) . "\n" .
@@ -7996,6 +8010,12 @@ sub git_search {
  or die_error(403, "Grep search is disabled");
  }

+ if ($searchtype eq 'filename') {
+                # uses grep on output of git ls-tree, maybe CPU-intensive
+ gitweb_check_feature('filename')
+ or die_error(403, "Filename search is disabled");
+ }
+
  if (!defined $searchtext) {
  die_error(400, "Text field is empty");
  }
@@ -8018,6 +8038,8 @@ sub git_search {
  git_search_changes(%co);
  } elsif ($searchtype eq 'grep') {
  git_search_files(%co);
+ } elsif ($searchtype eq 'filename') {
+        git_search_filenames(%co);
  } else {
  die_error(400, "Unknown search type");
  }
-- 
1.8.3.msysgit.0
