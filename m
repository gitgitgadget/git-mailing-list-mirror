From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Fri, 14 Mar 2008 05:14:51 -0700 (PDT)
Message-ID: <m3hcf9y02p.fsf@localhost.localdomain>
References: <20080313231413.27966.3383.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 14 13:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja8p9-0006Ra-Ca
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 13:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbYCNMO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 08:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbYCNMO4
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 08:14:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:31236 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbYCNMOz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 08:14:55 -0400
Received: by ug-out-1314.google.com with SMTP id z38so52794ugc.16
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=XaZ/JAb6fmjbOjLY7zYh98HnqfkG1Qh11MJTaVYW0Dg=;
        b=K28Jndui0ArucQDqcRh2Dt71kewmmy/SgXTGkTwoYVVsvtvfwp+Sre1GkA/pwZn7DQmTT9SMDnC+XiPz/x/QX+PgA5sk5Xr++A2UWmZ44QvpCzObBE2FRcakDr3KoTqFPQa7AAaTYAJsO7/6oMHU5vYQ2wXLL9Z8piDUH8m+OFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=YegJK+Z8Zc4YTmitZdWHzglb0usjZSu57kuCGePS9S0NlDvSelUZzlfi7WXNGMr46vFbG6DendgadoTq9FlwisyX3i6weLSOreBRpp7lgDvLNhBl0X2q6FRsyxjCE3RMa0FRuQEC5yhL/RrgiZxBcJ6JE01QPCj56SjVWEJHBUs=
Received: by 10.67.98.15 with SMTP id a15mr308903ugm.69.1205496893310;
        Fri, 14 Mar 2008 05:14:53 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.191.199])
        by mx.google.com with ESMTPS id 39sm412536ugb.15.2008.03.14.05.14.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 05:14:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2ECEiGf025603;
	Fri, 14 Mar 2008 13:14:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2ECENWh025599;
	Fri, 14 Mar 2008 13:14:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080313231413.27966.3383.stgit@rover>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77211>

Petr Baudis <pasky@suse.cz> writes:

> On repo.or.cz (permanently I/O overloaded and hosting 1050 project +
> forks), the projects list (the default gitweb page) can take more than
> a minute to generate. This naive patch adds simple support for caching
> the projects list data structure so that all the projects do not need
> to get rescanned at every page access.

Nice.

BTW adding caching to gitweb is one of proposed ideas (projects) for
Google Summer of Code 2006: http://git.or.cz/gitwiki/SoC2008Ideas

> For clarity, projects scanning and @projects population is separated
> to git_get_projects_details().

Perhaps this could be submitted as separate patch?
I could do this if you are otherwise busy...


[...]
> +	if ($cache_lifetime and -f $cache_file
> +	    and stat($cache_file)->mtime + $cache_lifetime * 60 > time()
> +	    and open (my $fd, $cache_file)) {
> +		$stale = time() - stat($cache_file)->mtime;
> +		my @dump = <$fd>;
> +		close $fd;
> +		# Hack zone start
> +		my $VAR1;
> +		eval join("\n", @dump);
> +		@projects = @$VAR1;
> +		# Hack zone end

Why do you read line by line, only to join it, i.e.
  my @dump = <$fd>; ... join("\n", @dump);
instead of slurping all file in one go:
  local $/ = undef; my $dump = <$fd>; ... $dump;

Besides, why do you use Data::Dumper instead of Storable? Both are
distributed with Perl; well, at least both are in perl-5.8.6-24.

[...]
> -	git_project_list_body(\@list, $order);
> +	git_project_list_body(\@list, $order, undef, undef, undef, undef, $projlist_cache_lifetime);

This is ugly. Why not use hash for "named parameters", as it is done
in a few separate places in gitweb (search for '%opts')?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
