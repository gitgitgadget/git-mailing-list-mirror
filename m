From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Thu, 21 Aug 2008 23:32:05 +0200
Message-ID: <200808212332.07095.jnareb@gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 23:32:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHlD-0006vV-VF
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 23:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283AbYHUVa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 17:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbYHUVa7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 17:30:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:18574 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247AbYHUVa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 17:30:58 -0400
Received: by ug-out-1314.google.com with SMTP id c2so93001ugf.37
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=XLZyHRM4NmaWEW87nUYR/fYKbepZv6bZnveumbUy6kU=;
        b=PM29m2MdYjfKNe257sgCnxMeK8DkrdwsRIlXa8wAVwNYzyaMSf+7UbzpN+3thnoNqx
         L317C34q+rRvslkPs7x3Ll3IQe99GE690OMSHOTeTcYzOrkHvi8tOHkhS97fpeu2sFVl
         rM0xB42AOOzgF/P7ze8mtP2l/gm7boxuNETOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QdHcbzyTX1AYdjU9GDn62f/QRJCrdp0egZbf370PGd/J5oOTucJ3x7Ofphva1+lC69
         nbdDfw2JtJ47YVG0/mL3LjOljQQSaBAJEJl+8Mbu42+DUX1c/iRDJZELEdfrIThM86Lr
         yVDNqVekuLL0WzE2uc7Q7173Xm16doH+DYJHo=
Received: by 10.66.221.19 with SMTP id t19mr1887189ugg.69.1219354255887;
        Thu, 21 Aug 2008 14:30:55 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.232.114])
        by mx.google.com with ESMTPS id 34sm1580614uga.63.2008.08.21.14.30.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 14:30:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93213>

On Thu, 21 Aug 2008, Giuseppe Bilotta wrote:

> This patch turns ref markers for tags and heads into links to
> appropriate views for the ref name. Appropriate changes are made in the
> CSS to prevent ref markers to be annoyingly blue and underlined.
> 
> For all git ref types it's assumed that the preferred view is named like
> the ref type itself. For commits, we map the view to shortlog.

NAK.

It is a good idea, but not so good solution.

> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css

> +span.refs span a {
> +	text-decoration: none;
> +	color: inherit;
> +}

Possible improvement:

We would probably want to make this link discoverable, by adding
underline on :hover, like for other "hidden links" in gitweb (for
example in commitdiff view).

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 90cd99b..a12ce87 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1093,10 +1093,14 @@ sub format_log_line_html {
>  sub format_ref_marker {
>  	my ($refs, $id) = @_;
>  	my $markers = '';
> +	my %view = (
> +		"commit" => "shortlog",
> +	);
>  
>  	if (defined $refs->{$id}) {
>  		foreach my $ref (@{$refs->{$id}}) {
>  			my ($type, $name) = qw();
> +			my $git_type = git_get_type($ref);
>  			# e.g. tags/v2.6.11 or heads/next
>  			if ($ref =~ m!^(.*?)s?/(.*)$!) {
>  				$type = $1;

git_get_type calls 'git cat-file -t', so for each ref shown you make
*additional call* to git command (additional fork).  Not good, especially
that you can get information if a ref is a tag (indirect reference)
or not one can get from within git_get_references; which in turn
uses "git show-refs --dereference" and used to use either 
"git peek-remote ." or ".git/info/refs" file.  If there is <name>^{},
then <name> is indirect reference: is a tag.

As we display ref markers only for log-like views, marker can be tag
or can be "lightweight reference" and be only a commit (in theory
we could show ref markers also for tree and blob items, but it is not
important now).

-- 
Jakub Narebski
Poland
