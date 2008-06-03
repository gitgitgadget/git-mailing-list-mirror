From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 03 Jun 2008 04:43:50 -0700 (PDT)
Message-ID: <m34p8a2173.fsf@localhost.localdomain>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 13:44:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3UwY-0006bb-QR
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 13:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbYFCLny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 07:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbYFCLny
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 07:43:54 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:65286 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbYFCLnx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 07:43:53 -0400
Received: by gv-out-0910.google.com with SMTP id e6so213616gvc.37
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 04:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=f3ZYAkLil1TeL2RqKThSnIJvpirt+34kBGbNRacjO4E=;
        b=fJETvXSnLFeecfjU3DdmRLKPEM7N+17yCqziIjV/NlkAEcllWom0Tz5y6q0cBvraVKb/sPAkDdfKg68lvy1zeRzH4eSRgF60hgskk1l1CHrjgoYAlUUWdRgWzFOtpT6TEjuAlJqwnRI2a1vgCo6fp83Se70gxx1rnWN5MHiqQFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Kox/N95NAjiqD9CHYeh1hGb4jNOc3EP1rrC7dCh1WBveTgn9DZyP3R4G9vvDF6JgEe1al7D9zc1eAIYP9iZSaK2M7RA9CSIY9ftS5yu0plYgYi4lE5jkUuqHZoq+wFKqLDKIII8hxjKzEqLyDOT5c4SNL0LH32pVjGZMrUsYFBI=
Received: by 10.125.84.3 with SMTP id m3mr723560mkl.99.1212493431363;
        Tue, 03 Jun 2008 04:43:51 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.199])
        by mx.google.com with ESMTPS id f4sm27004225nfh.0.2008.06.03.04.43.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 04:43:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m53Bhknd026304;
	Tue, 3 Jun 2008 13:43:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m53BhilU026301;
	Tue, 3 Jun 2008 13:43:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83643>

Cc-ed Luben Tuikov, author of this part.

Rafael Garcia-Suarez <rgarciasuarez@gmail.com> writes:

> git-rev-parse will abort with an error when passed a non-existent
> revision spec, such as "deadbeef^" where deadbeef has no parent.
> Using the --revs-only parameter makes this error go away, while
> retaining functionality, keeping the web server error log nice
> and clean.

Thanks.  This error wasn't detected earlier probably because
'blame' view is rarely enabled; and repo.or.cz gitweb which has
'blame' enabled IIRC use gitweb which is modified there, allowing
incremental blame using AJAX.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 55fb100..f3b4b24 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4226,9 +4226,9 @@ git_blame2
>  			              esc_html($rev));
>  			print "</td>\n";
>  		}
> -		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
> +		open (my $dd, "-|", git_cmd(), "rev-parse", '--revs-only', "$full_rev^")
>  			or die_error(undef, "Open git-rev-parse failed");
> -		my $parent_commit = <$dd>;
> +		my $parent_commit = <$dd> || '';
>  		close $dd;
>  		chomp($parent_commit);
>  		my $blamed = href(action => 'blame',

I'd rather remove this, correct it, or make it optional (this is very
fork-heavy).

But this patch is good as it is now...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
