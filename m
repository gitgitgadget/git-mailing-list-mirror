From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge-recursive: fix parsing of "diff-algorithm" option
Date: Thu, 26 Sep 2013 13:47:20 -0700
Message-ID: <20130926204720.GH9464@google.com>
References: <689bf88b6f1d33e123cc786042cc6dba23464351.1380225743.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Luke Noel-Storr <luke.noel-storr@integrate.co.uk>,
	Michal Privoznik <mprivozn@redhat.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Sep 26 22:47:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPITB-00062b-3D
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 22:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab3IZUrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 16:47:25 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:56820 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab3IZUrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 16:47:24 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so1641270pbc.17
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DUOOjXgSNOcMb9hS94SfZx9B7zvu3ZQ0ykKXBU2r+BU=;
        b=KU7LN+dwx0FsodoQ1+h2zbhnYriPWTqctUS9E49iOEM32xx+MPwQWvYiSbOdzh+DvA
         Q0eMel6D2k8y6VvnJSALURBhmSf+GgjscFj8+QmjmUv6WyBMoiErXpOLb8Tq1ScXdDMh
         M+d1G3bUV7BVLKAyVQBmcpTnjbh4E4J2YkshXuBb6xadgP0/hxLjAh9E7WV8ZpRfOZLi
         Km9B7iJHZi+gaquAGhfE6/7NZfRqpT8LNwKUwqMfH7jmUko+AgubODq3VMuApyg72w3r
         ZAJcbxZju4kzmAk6pPkdLrSi/pK1pwzg6BhW0b+9ZSm69CsQMYcbNKbgpESQDJB/F+qc
         2ALQ==
X-Received: by 10.68.137.161 with SMTP id qj1mr3433555pbb.50.1380228444051;
        Thu, 26 Sep 2013 13:47:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wd6sm7382438pab.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 13:47:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <689bf88b6f1d33e123cc786042cc6dba23464351.1380225743.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235434>

John Keeping wrote:

> The "diff-algorithm" option to the recursive merge strategy takes the
> name of the algorithm as an option, but it uses strcmp on the option
> string to check if it starts with "diff-algorithm=", meaning that this
> options cannot actually be used.
>
> Fix this by switching to prefixcmp.  At the same time, clarify the
> following line by using strlen instead of a hard-coded length, which
> also makes it consistent with nearby code.
>
> Reported-by: Luke Noel-Storr <luke.noel-storr@integrate.co.uk>
> Signed-off-by: John Keeping <john@keeping.me.uk>

Thanks, both.

[...]
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2069,8 +2069,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
>  		o->xdl_opts = DIFF_WITH_ALG(o, PATIENCE_DIFF);
>  	else if (!strcmp(s, "histogram"))
>  		o->xdl_opts = DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
> -	else if (!strcmp(s, "diff-algorithm=")) {
> -		long value = parse_algorithm_value(s+15);
> +	else if (!prefixcmp(s, "diff-algorithm=")) {
> +		long value = parse_algorithm_value(s + strlen("diff-algorithm="));
>  		if (value < 0)
>  			return -1;

While we're here:

Part of the problem is that there are no tests for this option (or for
'git diff --diff-algorithm', or for the '[diff] algorithm'
configuration), so we didn't notice it didn't work until someone
actually tried it.

Do you have any examples of a diff or merge that works better with
some particular diff algorithm, that could be used in tests?

Ciao,
Jonathan
