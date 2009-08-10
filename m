From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: squelch harmless variable scoping errors
Date: Mon, 10 Aug 2009 17:05:29 +0200
Message-ID: <200908101705.30521.jnareb@gmail.com>
References: <F203660D-5123-475D-8288-F398EA670002@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:05:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWRb-0005TT-DN
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbZHJPFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbZHJPFm
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:05:42 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:11139 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZHJPFl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:05:41 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1168909qwh.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jqgmcPgEFRueCPuqxgptujBbmFHWkVGlEiON5z5ND3A=;
        b=SVc9s12KeplDJcxW0OCS3+OH5WU0INJPLR6KD8sBDM9wXnNsQOt3Q1y+bx2vPwKpwB
         S/9QW7eVyzZlHyyBhf48uYc+m9HLCTCBg5p6E6ZA4sDpR2hMD/dlpqlCzO/27teleohk
         05tuRnbeDLkA7tBSaHLfTd3c+liBvpPvsrobM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oCTY4O1gVtW7W40MIBTgAXniSZHrDqcC8ZBU/EAEzzpMIXNcb25QMXwNqA+8685y/X
         uAgu6farGpPlPIUGAfyGf9z9SRI8gGnmgqH8sesZGXXxM5qhOEyrVnVDbBqNI+JI01cF
         2JdVR8aqBZSGF8qL5J0Aj3AUf+Fi2E4T66Zis=
Received: by 10.224.37.83 with SMTP id w19mr3186449qad.132.1249916742219;
        Mon, 10 Aug 2009 08:05:42 -0700 (PDT)
Received: from ?192.168.1.13? ([72.14.241.6])
        by mx.google.com with ESMTPS id 23sm2438766ywh.3.2009.08.10.08.05.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 08:05:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <F203660D-5123-475D-8288-F398EA670002@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125455>

On Sat, 8 Aug 2009, Mark A Rada wrote:

> I fiddled around a bit and this solution seems to work, but is a bit  
> odd, as the method is declared obsolete in the Perl documentation
> (v5.8.8). 
> 
> What do you think?

Below there is alternate solution (from asking on #perl channel on
FreeNode).

> --->8---
> This will use the 'vars' method of declaring global variables instead
> of the 'our' method.
> 
> Though 'vars' has been obsoleted, it has the advantage of pre-declaring
> global symbols; this ensures that those symbols will be available to
> routines loaded later, whereas 'our' does not seem to do this.
> 
> The result is that when using mod_perl you will no longer get any
> warnings printed to your error_log.
> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> ---
> gitweb/gitweb.perl |    8 +++++---
> 1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 37120a3..0544aa2 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -57,12 +57,14 @@ if ($path_info) {
> our $GIT = "++GIT_BINDIR++/git";
> 
> # absolute fs-path which will be prepended to the project path
> -#our $projectroot = "/pub/scm";
> -our $projectroot = "++GITWEB_PROJECTROOT++";
> +use vars qw($projectroot);
> +#$projectroot = "/pub/scm";
> +$projectroot = "++GITWEB_PROJECTROOT++";
> 
> # fs traversing limit for getting project list
> # the number is relative to the projectroot
> -our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
> +use vars qw($project_maxdepth);
> +$project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
> 
> # target of the home link on top of all pages
> our $home_link = $my_uri || "/";
> -- 
> 1.6.4

Alternate solution could be (please test that it works as intended),
which is a bit simpler, and do not use obsolete 'use vars' pragma,
which is not BLOCK-scoped like other pragmas like 'use strict'.

diff --git i/gitweb/gitweb.perl w/gitweb/gitweb.perl
index ab0cad2..c0fa53c 100755
--- i/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -2308,6 +2305,7 @@ sub git_get_projects_list {
 			follow_skip => 2, # ignore duplicates
 			dangling_symlinks => 0, # ignore dangling symlinks, silently
 			wanted => sub {
+				our ($project_maxdepth, $projectroot);
 				# skip project-list toplevel, if we get it.
 				return if (m!^[/.]$!);
 				# only directories can be git repositories



-- 
Jakub Narebski

Git User's Survey 2009:
http://tinyurl.com/GitSurvey2009
