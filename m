From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v7 4/9] gitweb: Prepare for splitting gitweb
Date: Fri, 24 Dec 2010 03:29:32 -0600
Message-ID: <20101224092932.GA31537@burratino>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
 <20101222235618.7998.17447.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 24 10:30:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW3yU-0002pz-5d
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 10:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836Ab0LXJ3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 04:29:48 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:48135 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab0LXJ3r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 04:29:47 -0500
X-Greylist: delayed 4252 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Dec 2010 04:29:46 EST
Received: by yib18 with SMTP id 18so990072yib.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 01:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n0Xgw8gUfukFdujgBA4iKf+DuScdOAHh+f6RFyuHx0s=;
        b=YBlEQY78kWHRnzmaEQ0/0nJSpXAAvv2A9OhJKoHv2VwDT+4M4GJuFTnpX1Yoh2hZcY
         X7I9UmUC2sJmwn8wbTmFVpqS9WVTU6gmdcrkyMX+49CO2R/HG/28qy0YVOEx9yZrWTEm
         vUbM4a9lnjwJp3vVyAoyZNliVi7lKnEeKtnXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=A25c8Y3iK69Uopgt/ZhiRJ/KnmZdihhP7IV1VyPdPddiAsMOkW+MtHWTMp02uzNJrC
         4vZqPDygAx4Y/QbBbPG+NlMWYLiRqGgjLNPQm/qVVU4R93NrMGN8L+BZ9vqfzk0DCO3M
         Cwg/hlJTh8kRn9Dqz5Kbrc53w6DEexOhtGEvw=
Received: by 10.150.54.21 with SMTP id c21mr13167624yba.408.1293182986363;
        Fri, 24 Dec 2010 01:29:46 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id p32sm7166422ybk.20.2010.12.24.01.29.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 01:29:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101222235618.7998.17447.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164151>

Jakub Narebski wrote:

> Prepare gitweb for having been split into modules that are to be
> installed alongside gitweb in 'lib/' subdirectory, by adding
> 
>   use lib __DIR__.'/lib';
> 
> to gitweb.perl (to main gitweb script), and preparing for putting
> modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.

Spelled out, this means modules would typically go in

	/usr/share/gitweb/lib

Is that the right place?  I suspect something like

	/usr/lib/gitweb/

could make sense in some installations for two reasons:

 - even braindamaged webserver configurations would not serve lib/
   as static files in that case;

 - if some modules are implemented in C for speed, they would need
   to go in /usr/lib anyway to follow usual filesystem conventions.

Does the Makefile let us override the directory with such a setting?

> While at it pass GITWEBLIBDIR in addition to GITWEB_TEST_INSTALLED to
> allow testing installed version of gitweb and installed version of
> modules (for future tests which would check individual (sub)modules).
> 
> Using __DIR__ from Dir::Self module (not in core, that's why currently
> gitweb includes excerpt of code from Dir::Self defining __DIR__) was
> chosen over using FindBin-based solution (in core since perl 5.00307,
> while gitweb itself requires at least perl 5.8.0) because FindBin uses
> BEGIN block

This explanation and the code below leave me nervous that the answer
might be "no". ;-)

[...]
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -10,6 +10,14 @@
>  use 5.008;
>  use strict;
>  use warnings;
> +
> +use File::Spec;
> +# __DIR__ is taken from Dir::Self __DIR__ fragment
> +sub __DIR__ () {
> +	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
> +}
> +use lib __DIR__ . '/lib';
> +
>  use CGI qw(:standard :escapeHTML -nosticky);
>  use CGI::Util qw(unescape);
>  use CGI::Carp qw(fatalsToBrowser);
