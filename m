From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix handling of non-ASCII characters in inserted
 HTML files
Date: Tue, 02 Dec 2008 19:55:13 -0800
Message-ID: <7v63m1j4ke.fsf@gitster.siamese.dyndns.org>
References: <200811171140.45884.jnareb@gmail.com>
 <20081201175741.11133.82393.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tatsuki Sugiura <sugi@nemui.org>,
	Gerrit Pape <pape@smarden.org>, Recai Oktas <roktas@debian.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 04:56:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ir0-0004IM-Qy
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 04:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbYLCDzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 22:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYLCDzX
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 22:55:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYLCDzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 22:55:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 088598325A;
	Tue,  2 Dec 2008 22:55:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ADF1483259; Tue,
  2 Dec 2008 22:55:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3550E8BC-C0EE-11DD-9B5B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102209>

Jakub Narebski <jnareb@gmail.com> writes:

> Use new insert_file() subroutine to insert HTML chunks from external
> files: $site_header, $home_text (by default indextext.html),
> $site_footer, and $projectroot/$project/REAME.html.
>
> All non-ASCII chars of those files will be broken by Perl IO layer
> without decoding to utf8, so insert_file() does to_utf8() on each
> printed line; alternate solution would be to open those files with
> "binmode $fh, ':utf8'", or even all files with "use open qw(:std :utf8)".
>
> Note that inserting README.html lost one of checks for simplicity.
>
> Noticed-by: Tatsuki Sugiura <sugi@nemui.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This is more complete solution that the one provided by Tatsuki Sugiura
> in original patch
>
>   [PATCH] gitweb: fix encode handling for site_{header,footer}
>   Msg-Id: <87vdumbxgc.wl@vaj-k-334-sugi.local.valinux.co.jp>
>   http://thread.gmane.org/gmane.comp.version-control.git/101199

It may be more complete but it is obviously untested.  Please help me
trust you better with your future patches.  Because I personally do not
run gitweb myself, I really need a trustworthy lieutenant(s) in the area.

[Wed Dec  3 01:52:07 2008] gitweb.perl: Global symbol "$fd" requires explicit package name at /git.git/t/../gitweb/gitweb.perl line 4500.
[Wed Dec  3 01:52:07 2008] gitweb.perl: Execution of /git.git/t/../gitweb/gitweb.perl aborted due to compilation errors.

> but it is in principle the same solution.
>
> I think this one as it is a bugfix should go in git 1.6.1

Trading a gitweb with a small bug with a gitweb that does not even pass
its test script does not feel like a good change to me.

I think the breakage is the "close $fd" at the end of this hunk:

> @@ -4472,13 +4475,11 @@ sub git_summary {
>  	print "</table>\n";
>  
>  	if (-s "$projectroot/$project/README.html") {
> -		if (open my $fd, "$projectroot/$project/README.html") {
> -			print "<div class=\"title\">readme</div>\n" .
> -			      "<div class=\"readme\">\n";
> -			print $_ while (<$fd>);
> -			print "\n</div>\n"; # class="readme"
> -			close $fd;
> -		}
> +		print "<div class=\"title\">readme</div>\n" .
> +		      "<div class=\"readme\">\n";
> +		insert_file("$projectroot/$project/README.html");
> +		print "\n</div>\n"; # class="readme"
> +		close $fd;
>  	}
>  
>  	# we need to request one more than 16 (0..15) to check if

I'll queue it to 'pu', with the "close $fd" removed, for now.
