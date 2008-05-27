From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: only display "next" links in logs if there is a
 next page
Date: Tue, 27 May 2008 16:08:04 -0700
Message-ID: <7viqwzz6p7.fsf@gitster.siamese.dyndns.org>
References: <1211927470-21170-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 01:09:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K18Hx-0004SX-AU
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 01:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbYE0XIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbYE0XIO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 19:08:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbYE0XIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 19:08:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BBE2B5F3A;
	Tue, 27 May 2008 19:08:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E78A65F39; Tue, 27 May 2008 19:08:07 -0400 (EDT)
In-Reply-To: <1211927470-21170-1-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Wed, 28 May 2008 00:31:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C733D54C-2C41-11DD-80DB-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83060>

Lea Wiemann <lewiemann@gmail.com> writes:

> There was a bug in the implementation of the "next" links in
> format_paging_nav (for log and shortlog), which caused the next links
> to always be displayed, even if there is no next page.  This fixes it.
>
> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
> ---
>  gitweb/gitweb.perl |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 308fde2..874f53a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2752,7 +2752,7 @@ sub git_print_page_nav {
>  }
>  
>  sub format_paging_nav {
> -	my ($action, $hash, $head, $page, $has_more_pages) = @_;
> +	my ($action, $hash, $head, $page, $has_next_link) = @_;
>  	my $paging_nav;
>  
>  
> @@ -2770,7 +2770,7 @@ sub format_paging_nav {
>  		$paging_nav .= " &sdot; prev";
>  	}
>  
> -	if ($has_more_pages) {
> +	if ($has_next_link) {
>  		$paging_nav .= " &sdot; " .
>  			$cgi->a({-href => href(-replay=>1, page=>$page+1),
>  			         -accesskey => "n", -title => "Alt-n"}, "next");

This looks like a no-op hunk, unless format_paging_nav sub has other uses
of $has_more_pages variable.  But the copies of gitweb I have do not begin
with these lines, but they begin like this:

        sub format_paging_nav {
                my ($action, $hash, $head, $page, $nrevs) = @_;
                my $paging_nav;

On what version is your patch based on?  I checked warthog9's copy and
that also seems to be different.

> @@ -4661,7 +4661,7 @@ sub git_log {
>  
>  	my @commitlist = parse_commits($hash, 101, (100 * $page));
>  
> -	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist > 99);
> +	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
>  
>  	git_header_html();
>  	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
> @@ -5581,7 +5581,7 @@ sub git_shortlog {
>  
>  	my @commitlist = parse_commits($hash, 101, (100 * $page));
>  
> -	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#commitlist > 99);
> +	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#commitlist >= 100);
>  	my $next_link = '';
>  	if ($#commitlist >= 100) {
>  		$next_link =

I am not very good at counting, but the change looks no-op to me.  Either
the last index of the list variable is strictly larger than 99, or it is
100 or greater --- aren't they the same thing?

A bit confused I am...
