X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Show '...' links in "summary" view only if there are more items
Date: Tue, 19 Dec 2006 12:14:57 +0100
Message-ID: <200612191214.58474.jnareb@gmail.com>
References: <20061218224327.GG16029@localhost> <7vbqm0vkd6.fsf@assigned-by-dhcp.cox.net> <200612190159.24173.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 11:12:40 +0000 (UTC)
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WihlzOsYqCq5XlOUbVaVY7qKjf8l9aIIkR7mdn4oCtP226eTA42uxzIhpss2Nwg7PXrB8h3HJWwM0zHbZfgVSRiUSDNcvKy677LYF0bdnyCWFKVU1hiOc+0kk5BRegzkpuvPXEia0rP/WidRNcZ16IYG9RYarfNoqYuLuA9LARc=
User-Agent: KMail/1.9.3
In-Reply-To: <200612190159.24173.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34823>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwctY-0001Tc-VS for gcvg-git@gmane.org; Tue, 19 Dec
 2006 12:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752282AbWLSLM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 06:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbWLSLM0
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 06:12:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:31108 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752282AbWLSLMZ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 06:12:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1783166uga for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 03:12:24 -0800 (PST)
Received: by 10.67.19.17 with SMTP id w17mr8333308ugi.1166526743676; Tue, 19
 Dec 2006 03:12:23 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id l33sm8943522ugc.2006.12.19.03.12.23; Tue, 19 Dec
 2006 03:12:23 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Show "..." links in "summary" view to shortlog, heads (if there are
any), and tags (if there are any) only if there are more items to show
than shown already.

This means that "..." link is shown below shortened shortlog if there
are more than 16 commits, "..." link below shortened heads list if
there are more than 16 heads refs (16 branches), "..." link below
shortened tags list if there are more than 16 tags.

Added some comments.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

Jakub Narebski wrote:
> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> Actually, that is needed to implement checking if we have more than
>>> the number of commits to show to add '...' at the end only if there
>>> are some commits which we don't show.
[...]
>> By the way, I wonder how that $extra is omitted when $revlist is
>> longer than $to; it should be a trivial fix but it seems to me
>> that it is always spitted out with the current code.
> 
> We should check if we want to omit $extra, either in caller or
> in callee, the *_body subroutine itself.

And now it is done.

Slightly tested: on my clone (copy) of git repository, which more than
16 commits, more than 16 heads (most temporary, and no longer worked on,
few tracking branches) and more than 16 heads show all "..." as it should.
Test of freshly created repository shown no "..." for commits (only one
commit), no "..." for heads (only one default head 'master'), and no
tags list (no tags at all).

By the way, I have _NOT_ applied Robert Fitzsimons patch, but they
(this patch and Robert patch) should be not in conflict if we remove
last chunk of Robert's patch (this changing --count=17 to --count=15
in git_summary).

 gitweb/gitweb.perl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4059894..73877f2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2915,8 +2915,9 @@ sub git_summary {
 	my $owner = git_get_project_owner($project);
 
 	my $refs = git_get_references();
-	my @taglist  = git_get_tags_list(15);
-	my @headlist = git_get_heads_list(15);
+	# we need to request one more than 16 (0..15) to check if those 16 are all
+	my @taglist  = git_get_tags_list(17);
+	my @headlist = git_get_heads_list(17);
 	my @forklist;
 	my ($check_forks) = gitweb_check_feature('forks');
 
@@ -2952,6 +2953,7 @@ sub git_summary {
 		}
 	}
 
+	# we need to request one more than 16 (0..15) to check if those 16 are all
 	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
 		git_get_head_hash($project), "--"
 		or die_error(undef, "Open git-rev-list failed");
@@ -2959,17 +2961,20 @@ sub git_summary {
 	close $fd;
 	git_print_header_div('shortlog');
 	git_shortlog_body(\@revlist, 0, 15, $refs,
+	                  $#revlist <=  15 ? undef :
 	                  $cgi->a({-href => href(action=>"shortlog")}, "..."));
 
 	if (@taglist) {
 		git_print_header_div('tags');
 		git_tags_body(\@taglist, 0, 15,
+		              $#taglist <=  15 ? undef :
 		              $cgi->a({-href => href(action=>"tags")}, "..."));
 	}
 
 	if (@headlist) {
 		git_print_header_div('heads');
 		git_heads_body(\@headlist, $head, 0, 15,
+		               $#headlist <= 15 ? undef :
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
-- 
