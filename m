From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] gitweb: Show project's git URL on summary page
Date: Tue, 15 Aug 2006 11:43:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608151139280.29668@chino.corp.google.com>
References: <200608152003.05693.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 20:43:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD3tE-0002q8-Bj
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 20:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWHOSnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 14:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWHOSnS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 14:43:18 -0400
Received: from smtp-out.google.com ([216.239.45.12]:13332 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965113AbWHOSnQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 14:43:16 -0400
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id k7FIhCe8013335;
	Tue, 15 Aug 2006 11:43:12 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=ZNj9PMF4fkuEMMgcYz16fIv1n0TFM8qQLLOkKR7zR3BMZFRVRhUD/usKqHyIwNKLG
	4Y4aIae3vv6UjqwHUW6XQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps76.corp.google.com with ESMTP id k7FIh63e018135;
	Tue, 15 Aug 2006 11:43:06 -0700
Received: by localhost (Postfix, from userid 24081)
	id 1212187D71; Tue, 15 Aug 2006 11:43:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id B973287D70;
	Tue, 15 Aug 2006 11:43:04 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608152003.05693.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25473>

On Tue, 15 Aug 2006, Jakub Narebski wrote:
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ab28caa..6dcf6a2 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -51,6 +51,10 @@ our $logo = "++GITWEB_LOGO++";
>  # source of projects list
>  our $projects_list = "++GITWEB_LIST++";
>  
> +# list of git base URLs used for URL to where fetch project from,
> +# i.e. full URL is "$git_base_url/$project"
> +our @git_base_url_list = ("++GIT_BASE_URL++");
> +
>  # default blob_plain mimetype and default charset for text/plain blob
>  our $default_blob_plain_mimetype = 'text/plain';
>  our $default_text_plain_charset  = undef;
> @@ -1665,8 +1669,18 @@ sub git_summary {
>  	print "<table cellspacing=\"0\">\n" .
>  	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
>  	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
> -	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
> -	      "</table>\n";
> +	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
> +	my $is_first_url = 1;
> +	foreach my $git_base_url (@git_base_url_list) {
> +		next unless $git_base_url; # skip empty/zerolength URLs
> +		print "<tr><td>";
> +		if ($is_first_url) {
> +			print "URL";
> +			$is_first_url = 0;
> +		}
> +		print "</td><td>$git_base_url/$project</td></tr>\n";
> +	}
> +	print "</table>\n";
>  
>  	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_get_head_hash($project)
>  		or die_error(undef, "Open git-rev-list failed");
> 

Isn't it faster to do this (over 1.4.2):

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b5b89de..82b246d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -53,6 +53,7 @@ our $logo = "++GITWEB_LOGO++";
 
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
+our @git_base_url_list = ("++GIT_BASE_URL++");
 
 # default blob_plain mimetype and default charset for text/plain blob
 our $default_blob_plain_mimetype = 'text/plain';
@@ -1668,8 +1669,14 @@ sub git_summary {
 	print "<table cellspacing=\"0\">\n" .
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
-	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
-	      "</table>\n";
+	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+	my $url_tag = "URL";
+	foreach my $git_base_url (@git_base_url_list) {
+		next unless $git_base_url;
+		print "<tr><td>$url_tag</td><td>$git_base_url/$project</td></tr>\n";
+		$url_tag = "";
+	}
+	print "</table>\n";
 
 	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_get_head_hash($project)
 		or die_error(undef, "Open git-rev-list failed");
--

All the series of prints in this script could also probably more elegantly be 
written in the form:

print <<"(END HTML)";
	<table cellspacing="0">
		...
	</table>
	<tr><td>last change</td><td>$cd{'rfc2822'}</td><tr>
	...
(END HTML)

and then all the escape characters around quotes aren't needed.

		David
