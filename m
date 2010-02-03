From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH] gitweb: Simplify (and fix) chop_str
Date: Wed, 03 Feb 2010 10:25:08 -0800
Message-ID: <4B69BF84.8010400@eaglescrag.net>
References: <1265147814-13284-1-git-send-email-warthog9@eaglescrag.net> <m3mxzr9pcz.fsf@localhost.localdomain> <4B68BB4D.20105@eaglescrag.net> <201002031228.31324.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:26:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcjvK-0004po-Bc
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840Ab0BCSZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 13:25:52 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:34949 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab0BCSZv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 13:25:51 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o13IP8Sb025512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 3 Feb 2010 10:25:08 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <201002031228.31324.jnareb@gmail.com>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 03 Feb 2010 10:25:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138854>

This looks good to me.

- John 'Warthog9' Hawley

On 02/03/2010 03:28 AM, Jakub Narebski wrote:
> From: John 'Warthog9' Hawley <warthog9@kernel.org>
> 
> The chop_str subroutine is meant to be used on strings (such as commit
> description / title) *before* HTML escaping, which means before
> applying esc_html or equivalent.
> 
> Therefore get rid of the failed attempt to always remove full HTML
> entities (like e.g. &amp; or &nbsp;).  It is not necessary (HTML
> entities gets added later), and it can cause chop_str to chop a string
> incorrectly.
> 
> Specifically:
> 
>      API & protocol: support option to force written data immediately to disk
> 
> from http://git.kernel.org/?p=daemon/distsrv/chunkd.git;a=commit;h=3b02f749df2cb1288f345a689d85e7061f507e54
> 
> The short version of the title gets chopped to
> 
>      API ...
> 
> where it should be
> 
>      API & protocol: support option to force written data...
> 
> Noticed-by: John 'Warthog9' Hawley <warthog9@kernel.org>
> Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> I have retained J.H. authorship of this patch.  I have rewritten
> commit message, added signoffs, and removed all instances of failed
> attempt of removing HTML entities whole, even though only one of them
> is used.
> 
>  gitweb/gitweb.perl |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d0c3ff2..1f6978a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1330,7 +1330,6 @@ sub chop_str {
>  		$str =~ m/^(.*?)($begre)$/;
>  		my ($lead, $body) = ($1, $2);
>  		if (length($lead) > 4) {
> -			$body =~ s/^[^;]*;// if ($lead =~ m/&[^;]*$/);
>  			$lead = " ...";
>  		}
>  		return "$lead$body";
> @@ -1341,8 +1340,6 @@ sub chop_str {
>  		$str =~ m/^(.*?)($begre)$/;
>  		my ($mid, $right) = ($1, $2);
>  		if (length($mid) > 5) {
> -			$left  =~ s/&[^;]*$//;
> -			$right =~ s/^[^;]*;// if ($mid =~ m/&[^;]*$/);
>  			$mid = " ... ";
>  		}
>  		return "$left$mid$right";
> @@ -1352,7 +1349,6 @@ sub chop_str {
>  		my $body = $1;
>  		my $tail = $2;
>  		if (length($tail) > 4) {
> -			$body =~ s/&[^;]*$//;
>  			$tail = "... ";
>  		}
>  		return "$body$tail";
