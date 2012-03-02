From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (BUGFIX)] gitweb: Fix fixed string (non-regexp) project search
Date: Fri, 2 Mar 2012 23:34:24 +0100
Message-ID: <201203022334.25544.jnareb@gmail.com>
References: <20120228183919.26435.86795.stgit@localhost.localdomain> <4F512327.3050504@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Mar 02 23:34:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3b3f-0006So-P2
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 23:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930Ab2CBWee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 17:34:34 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62258 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964842Ab2CBWed (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 17:34:33 -0500
Received: by eekc41 with SMTP id c41so781852eek.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 14:34:31 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.25.68 as permitted sender) client-ip=10.213.25.68;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.25.68 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.25.68])
        by 10.213.25.68 with SMTP id y4mr126907ebb.281.1330727671785 (num_hops = 1);
        Fri, 02 Mar 2012 14:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=6MfGXnaydN66MHKa5/kXbD3YOaqOIjmpGcljWVriNx4=;
        b=ClnqdXJNVPhCfyWpyM9MhI5VtV3wBDh0t0rJiXoDzS9dBK9Ph3RyjKlIYN7QRfLZ2u
         LGIy35r810vRL2ewb94NqKbImkCsdrZvVUdE53i+yIeGmyD8fx8RGsgqedQ58zqVakxk
         6TRVM3E2ILIpXUKfAfg5SPoIDIksD3xIrS0Qheh+o8XAcPtd65389BmBZ3icvN26iTtr
         pUeFRCUJt/V/ImulEJCUGt3suJ0qYG10zLbohDKsz4yxNKIsDg9GxQSbiLAguZ6PH5GM
         zPuwazibHRg5ml21q947d42LsUQTVgqDhWwImEVHLbIIUyei5Rhhic52vHNxVA25VeOD
         3CoA==
Received: by 10.213.25.68 with SMTP id y4mr96928ebb.281.1330727671615;
        Fri, 02 Mar 2012 14:34:31 -0800 (PST)
Received: from [192.168.1.13] (abvt148.neoplus.adsl.tpnet.pl. [83.8.217.148])
        by mx.google.com with ESMTPS id u9sm25575493eem.11.2012.03.02.14.34.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 14:34:30 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4F512327.3050504@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192069>

Use $search_regexp, where regex metacharacters are quoted, for
searching projects list, rather than $searchtext, which contains
original search term.

Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I think this bug was here from the very beginning of adding project
search, i.e. from  v1.6.0.2-446-g0d1d154 (gitweb: Support for simple
project search form, 2008-10-03)  which was present since 1.6.1

On Fri, 2 Mar 2012, Ramsay Jones wrote:
> Jakub Narebski wrote:

> > When using regexp search ('sr' parameter / $search_use_regexp variable
> > is true), check first that regexp is valid.
> > 
> > Without this patch we would get an error from Perl during search (if
> > searching is performed by gitweb), or highlighting matches substring
> > (if applicable), if user provided invalid regexp... which means broken
> > HTML, with error page (including HTTP headers) generated after gitweb
> > already produced some output.
> > 
> > Add test that illustrates such error: for example for regexp "*\.git"
> > we would get the following error:
> > 
> >   Quantifier follows nothing in regex; marked by <-- HERE in m/* <-- HERE \.git/
> >   at /var/www/cgi-bin/gitweb.cgi line 3084.
> > 
> > Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > See "Re: gitweb: (potential) problems with new installation"
> > http://thread.gmane.org/gmane.comp.version-control.git/191746
> 
> This patch solves the problem for me when using a regex search
> (re checkbox checked), but *not* for a non-regex search.
> 
> If you have a leading '*' or '+', in the non-regex case, then you
> still get the above complaint (and xml error page etc.), although
> the line number has changed slightly from that given above.

Ramsay, please provide those line number in the future, together with
line and if possible some context.

The line is different because it is different bug: this is about not
using quotemeta'ed string for search for fixed-string search.

 gitweb/gitweb.perl |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 22ad279..7398be1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3072,16 +3072,16 @@ sub filter_forks_from_projects_list {
 # for 'descr_long' and 'ctags' to be filled
 sub search_projects_list {
 	my ($projlist, %opts) = @_;
-	my $tagfilter  = $opts{'tagfilter'};
-	my $searchtext = $opts{'searchtext'};
+	my $tagfilter = $opts{'tagfilter'};
+	my $search_re = $opts{'search_regexp'};
 
 	return @$projlist
-		unless ($tagfilter || $searchtext);
+		unless ($tagfilter || $search_re);
 
 	# searching projects require filling to be run before it;
 	fill_project_list_info($projlist,
-	                       $tagfilter  ? 'ctags' : (),
-	                       $searchtext ? ('path', 'descr') : ());
+	                       $tagfilter ? 'ctags' : (),
+	                       $search_re ? ('path', 'descr') : ());
 	my @projects;
  PROJECT:
 	foreach my $pr (@$projlist) {
@@ -3092,10 +3092,10 @@ sub search_projects_list {
 				grep { lc($_) eq lc($tagfilter) } keys %{$pr->{'ctags'}};
 		}
 
-		if ($searchtext) {
+		if ($search_re) {
 			next unless
-				$pr->{'path'} =~ /$searchtext/ ||
-				$pr->{'descr_long'} =~ /$searchtext/;
+				$pr->{'path'} =~ /$search_re/ ||
+				$pr->{'descr_long'} =~ /$search_re/;
 		}
 
 		push @projects, $pr;
@@ -5498,9 +5498,9 @@ sub git_project_list_body {
 		if ($check_forks);
 	# search_projects_list pre-fills required info
 	@projects = search_projects_list(\@projects,
-	                                 'searchtext' => $searchtext,
-	                                 'tagfilter'  => $tagfilter)
-		if ($tagfilter || $searchtext);
+	                                 'search_regexp' => $search_regexp,
+	                                 'tagfilter' => $tagfilter)
+		if ($tagfilter || $search_regexp);
 	# fill the rest
 	@projects = fill_project_list_info(\@projects);
 
-- 
1.7.9
