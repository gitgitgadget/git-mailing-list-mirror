From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v8 3/3] gitweb: add If-Modified-Since handling to git_snapshot().
Date: Fri, 30 Mar 2012 17:07:54 +0100
Message-ID: <201203301807.55284.jnareb@gmail.com>
References: <201203282328.08876.jnareb@gmail.com>  <bfbde5354e25dfbf535307a72016a6b5ac3a2c56.1333024238.git.wking@drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:08:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDeN2-00055S-64
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab2C3QH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:07:59 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60199 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab2C3QH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:07:57 -0400
Received: by wgbdr13 with SMTP id dr13so741982wgb.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=9NHsLrOxEiVmT6Mly2WQGx7d1q/zqEGFj/lVJFDWw20=;
        b=AJedpRYGJigSTlP0GWdycX9FrYA5vmKNusgcqTAtkJvQ0WDagQOSH1oSyJ8zkx5444
         3HT4Uvgm7osh+yV4yK7xLgW8ZBDTtBZy7BIc3orMDk5h95hKkOwuXZaDsKdQYYsDfiq1
         mu/2Qlbnk/xFRdUkEfmKjHpFt+U/unEe76SLDvC35YnJHlckDfSaCWcoYgmtRgHBEkmY
         HKyKxH/7upIp6oLP8knR4hMaGxTOJdyOBQSMIlZRDIfki61Bby7tSjEYXUgWvFi6ejHu
         LgA3h4boYcAAlEsASzHFO85Agv6YpJQfQhcUvF9KVbNLgYjPh9HT3sIa8LJFYWxx7cpE
         sCOA==
Received: by 10.180.102.101 with SMTP id fn5mr7850280wib.6.1333123676271;
        Fri, 30 Mar 2012 09:07:56 -0700 (PDT)
Received: from [192.168.1.13] (addb154.neoplus.adsl.tpnet.pl. [79.184.53.154])
        by mx.google.com with ESMTPS id o2sm11796916wiv.11.2012.03.30.09.07.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 09:07:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <bfbde5354e25dfbf535307a72016a6b5ac3a2c56.1333024238.git.wking@drexel.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194370>

On Thu, 29 Mar 2012, W. Trevor King wrote:

> Because snapshots can be large, you can save some bandwidth by
> supporting caching via If-Modified-Since.  This patch adds support for
> the i-m-s request to git_snapshot() if the request is a commit.
>
Perhaps it is worth clarifying that "caching" here means external HTTP
caching, either by web browser, or by web accelerator / reverse proxy.
Supporting Last-Modified and If-Modified-Since helps that[1][2].

[1]: http://www.mnot.net/cache_docs/#VALIDATE
[2]: http://www.mnot.net/cache_docs/#SCRIPT

> Requests for snapshots of trees, which lack well defined timestamps,
> are still handled as they were before.

"still handled as they were before" means "do not support l-m / i-m-s",
isn't it?  Wouldn't it be better to write it explicitely?
> 
> Signed-off-by: W Trevor King <wking@drexel.edu>

Anyway, I like those changes:

  Acked-by: Jakub Narebski <jnareb@gmail.com>

[...]
> +test_expect_success 'modification: tree snapshot' '
> +	ID=`git rev-parse --verify HEAD^{tree}` &&
> +	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
> +	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
> +	grep "Status: 200 OK" gitweb.headers &&
> +	! grep -i "last-modified" gitweb.headers

If we ignore case, we can write

  +	! grep -i "Last-Modified:" gitweb.headers

which is IMVVVHO slightly more readable.

Not that it matters much.  Just nitpicking.

> +'
> +test_debug 'cat gitweb.headers'

-- 
Jakub Narebski
Poland
