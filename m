From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Separate generating 'sort by' table header
Date: Tue, 10 Jun 2008 19:21:44 +0200
Message-ID: <200806101921.45017.jnareb@gmail.com>
References: <200806101919.24242.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 19:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K67Ym-0003bB-7T
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 19:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbYFJRWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 13:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757424AbYFJRWI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 13:22:08 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:16813 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757398AbYFJRWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 13:22:06 -0400
Received: by gv-out-0910.google.com with SMTP id e6so645899gvc.37
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1j7PSBl8e9VwSAYwWh0y310FgLT++I5qgQ4Rt5Q8+Zw=;
        b=c8zmRClievXN/zj9e2JoI2MbV55yeDGYjAFFFTojLMIp88Tv6ALU5+94ci3jnMHMtI
         QQY0a7koynWDxHMcUHhr4UuRPNV7q8AwLufpBmNbrrv25ll/li1A3npXyYEpQc7od4ma
         KgWpuMnWkcwPq0vlX9DoULJaorlRU8xQ+Uoqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nETvtfeViDiWODTbCC+TbZ79UAGEgEk1y5R+AwJ3EYYqvFh8qAiGrMRaDhccleLkXk
         2nSzAZlou/E5pG8Bxl+oPICRW9qQo9txQVnWAhORwgFlyF13eGgDNSnB5/1PI5Jtaef3
         IS6mHP/s3ACUnD6FZm2IBiXDyYh9+9gSWKbLU=
Received: by 10.103.175.9 with SMTP id c9mr3555002mup.15.1213118524543;
        Tue, 10 Jun 2008 10:22:04 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.192.165])
        by mx.google.com with ESMTPS id y2sm8498768mug.1.2008.06.10.10.22.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 10:22:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200806101919.24242.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84526>

Extract generating table header cell, for tables which can be sorted
by its columns, into print_sort_th_str() and print_sort_th_num()
subroutines, and print_sort_th() driver subroutine.

This avoids repetition, and should make further improvements (like
JavaScript sorting) easier.  The subroutine uses now "replay" link,
so it is generic enough to be able to use it for other tables which
can be sorted by column, like for example 'heads' and 'tags' view
(sort by name, or sort by age).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
For further code reusing, and current code clarity.

 gitweb/gitweb.perl |   76 ++++++++++++++++++++++++++-------------------------
 1 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d7a9809..c7882f2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3598,6 +3598,36 @@ sub fill_project_list_info {
 	return @projects;
 }
 
+# print 'sort by' <th> element, either sorting by $key if $name eq $order
+# (changing $list), or generating 'sort by $name' replay link otherwise
+sub print_sort_th {
+	my ($str_sort, $name, $order, $key, $header, $list) = @_;
+	$key    ||= $name;
+	$header ||= ucfirst($name);
+
+	if ($order eq $name) {
+		if ($str_sort) {
+			@$list = sort {$a->{$key} cmp $b->{$key}} @$list;
+		} else {
+			@$list = sort {$a->{$key} <=> $b->{$key}} @$list;
+		}
+		print "<th>$header</th>\n";
+	} else {
+		print "<th>" .
+		      $cgi->a({-href => href(-replay=>1, order=>$name),
+		               -class => "header"}, $header) .
+		      "</th>\n";
+	}
+}
+
+sub print_sort_th_str {
+	print_sort_th(1, @_);
+}
+
+sub print_sort_th_num {
+	print_sort_th(0, @_);
+}
+
 sub git_project_list_body {
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
@@ -3614,43 +3644,15 @@ sub git_project_list_body {
 		if ($check_forks) {
 			print "<th></th>\n";
 		}
-		if ($order eq "project") {
-			@projects = sort {$a->{'path'} cmp $b->{'path'}} @projects;
-			print "<th>Project</th>\n";
-		} else {
-			print "<th>" .
-			      $cgi->a({-href => href(project=>undef, order=>'project'),
-			               -class => "header"}, "Project") .
-			      "</th>\n";
-		}
-		if ($order eq "descr") {
-			@projects = sort {$a->{'descr'} cmp $b->{'descr'}} @projects;
-			print "<th>Description</th>\n";
-		} else {
-			print "<th>" .
-			      $cgi->a({-href => href(project=>undef, order=>'descr'),
-			               -class => "header"}, "Description") .
-			      "</th>\n";
-		}
-		if ($order eq "owner") {
-			@projects = sort {$a->{'owner'} cmp $b->{'owner'}} @projects;
-			print "<th>Owner</th>\n";
-		} else {
-			print "<th>" .
-			      $cgi->a({-href => href(project=>undef, order=>'owner'),
-			               -class => "header"}, "Owner") .
-			      "</th>\n";
-		}
-		if ($order eq "age") {
-			@projects = sort {$a->{'age'} <=> $b->{'age'}} @projects;
-			print "<th>Last Change</th>\n";
-		} else {
-			print "<th>" .
-			      $cgi->a({-href => href(project=>undef, order=>'age'),
-			               -class => "header"}, "Last Change") .
-			      "</th>\n";
-		}
-		print "<th></th>\n" .
+		print_sort_th_str('project', $order, 'path',
+		                  'Project', \@projects);
+		print_sort_th_str('descr', $order, 'descr_long',
+		                  'Description', \@projects);
+		print_sort_th_str('owner', $order, 'owner',
+		                  'Owner', \@projects);
+		print_sort_th_num('age', $order, 'age',
+		                  'Last Change', \@projects);
+		print "<th></th>\n" . # for links
 		      "</tr>\n";
 	}
 	my $alternate = 1;
-- 
1.5.5.3
