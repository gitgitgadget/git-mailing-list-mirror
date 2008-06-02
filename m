From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix "next" link on bottom of page
Date: Mon, 02 Jun 2008 11:54:41 +0200
Message-ID: <20080602095348.16843.24351.stgit@localhost.localdomain>
References: <m3y75s1a9v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Gerrit Pape <pape@smarden.org>,
	Kai Blin <kai.blin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 11:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K36lW-0008Gn-0n
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 11:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbYFBJyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 05:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbYFBJyw
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 05:54:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:54189 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYFBJyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 05:54:51 -0400
Received: by nf-out-0910.google.com with SMTP id d3so396939nfc.21
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=cVYWchWaN0tFPDhJ8/gmc7N+meAzqBhezlN/DJTNgoA=;
        b=so3hdDAQWt0Oa9vWghJZMk40r5h0FRm78qj13ps8Y5dRdjzvJQxTXCcK/zKRMJbZvO0wlP808Cwk7xKQiAwy5ZeR49Zgmzh+ymThVYOvp1SFe8FVhT3meOxGfzwtwqVvW0mlb4CfbmxGYo5qahjD6WJWxt0NVLcGB666zZloPzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=BJoFEpSa/sMmPXHP2TWAe5dgEa7j+XaLa3njVMTjPzsBhr5HhYj3RF4w4EcjW2tOmcpTvClIe117c/WSzDHmk72t/H1wfZul+vFuVUxD+gsnWmwRv5ZcKwUZfhipxEAfF4Igt3j9skqkXQimGO4XhvT+mdxaxFmL8+hCqG4oKJE=
Received: by 10.210.63.5 with SMTP id l5mr2446857eba.85.1212400487877;
        Mon, 02 Jun 2008 02:54:47 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.195.117])
        by mx.google.com with ESMTPS id c4sm27766158nfi.13.2008.06.02.02.54.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 02:54:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m529sfoF016880;
	Mon, 2 Jun 2008 11:54:42 +0200
In-Reply-To: <m3y75s1a9v.fsf@localhost.localdomain>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83505>

Fix search form generation to not modify $cgi->param(...)'s.

In git_header_html() we used to use $cgi->hidden(-name => "a") etc. to
generate hidden fields; unfortunately to use this form it is required
to modify $cgi->param("a") etc., which makes href(-replay,...) use
wrong replay values.  This for example made the "next" link on the
bottom of the page has a=search instead of a=$action, and thus fails to
get you to the next page.

Because in CGI the value of a hidden field is "sticky", there is no
way to modify it short of modifying $cgi->param(...).  Therefore it
got replaced by generating <input type="hidden" ...> element [semi]
directly.

Alternate solution would be for href(-replay,...) to use values saved
in global variables, such as $action etc., instead of (re)reading them
from $cgi->param($symbol).

The bad link was reported by Kai Blin through
  http://bugs.debian.org/481902

Reported-by: Kai Blin <kai.blin@gmail.com>
Noticed-by: Gerrit Pape <pape@smarden.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski <jnareb@gmail.com> wrote:
> Gerrit Pape <pape@smarden.org> writes:
> 
>> When viewing a gitweb repository commit log, the "next" link at the top
>> of the page works as expected, the "next" link on the bottom of the page
>> has a=search instead of a=log and thus fails to get you to the next
>> page.  This commit replaces the bottom "next" link with the same links
>> as shown at the top of the page.
> 
>> -		print $cgi->a({-href => href(-replay=>1, page=>$page+1),
>> -			       -accesskey => "n", -title => "Alt-n"}, "next");
> 
> Should not happen: href(-replay=>1, ...) should have the same value
> of 'a' parameter as the page it is in, so it should be 'log' not 'search'.

This bug was caused by the fact that git_header_html() modified
parameters in $cgi->param(...) when generating search form, and
href(-replay, ...) uses paramemeters values from $cgi, not saved in
variables (although it could).

This fixes mentioned bug, not only in the case of 'log' view, but in
all cases (although it is possible that this bug doesn't occur for
other pages).

[I'm sorry if I have send this patch twice.]

 gitweb/gitweb.perl |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dd0f0ac..50cde3b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2622,7 +2622,7 @@ EOF
 	print "</div>\n";
 
 	my ($have_search) = gitweb_check_feature('search');
-	if ((defined $project) && ($have_search)) {
+	if (defined $project && $have_search) {
 		if (!defined $searchtext) {
 			$searchtext = "";
 		}
@@ -2638,16 +2638,13 @@ EOF
 		my ($use_pathinfo) = gitweb_check_feature('pathinfo');
 		if ($use_pathinfo) {
 			$action .= "/".esc_url($project);
-		} else {
-			$cgi->param("p", $project);
 		}
-		$cgi->param("a", "search");
-		$cgi->param("h", $search_hash);
 		print $cgi->startform(-method => "get", -action => $action) .
 		      "<div class=\"search\">\n" .
-		      (!$use_pathinfo && $cgi->hidden(-name => "p") . "\n") .
-		      $cgi->hidden(-name => "a") . "\n" .
-		      $cgi->hidden(-name => "h") . "\n" .
+		      (!$use_pathinfo &&
+		      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .
+		      $cgi->input({-name=>"a", -value=>"search", -type=>"hidden"}) . "\n" .
+		      $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
 		      $cgi->popup_menu(-name => 'st', -default => 'commit',
 		                       -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .
 		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
