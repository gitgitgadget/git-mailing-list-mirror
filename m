From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 1/5] Fix generation of Documentation/usage-%.txt.
Date: Fri, 23 Jan 2015 09:21:03 -0500
Message-ID: <20150123142103.GA101465@meili.jeffnet.31bits.net>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
 <1422019499-2012-2-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:21:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEf6o-0000QL-NH
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbbAWOVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:21:09 -0500
Received: from josefsipek.net ([71.174.113.7]:1594 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841AbbAWOVI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:21:08 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id 1FD2D55654;
	Fri, 23 Jan 2015 09:21:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1422019499-2012-2-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262928>

On Fri, Jan 23, 2015 at 02:24:55PM +0100, Per Cederqvist wrote:
> The old rule worked, most of the time, but had several issues:
> 
>  - It depended on the corresponding guilt-*.txt file, but the usage.sh
>    script actually reads ../guilt-foo.
> 
>  - Actually, each usage-%.txt depended on all guilt-*.txt files, so
>    make had to do more work than necessary if a single file was
>    altered.
> 
>  - The construct broke parallel make, which would spawn several
>    usage.sh at once.  This leads to unnecessary work, and could
>    potentially result in broken usage files if the "echo some_string >
>    some_file" construct used by usage.sh isn't atomic.
>
> Fixed by letting the usage.sh script update a single file, and writing
> a proper implicit make rule.  This makes parallel make work a lot
> better.

Nice!

> There is a small downside, though, as usage.sh will now be run once
> for each command (if everything is regenerated).  I think it is worth
> to pay that price to get the correctness.  This command is still very
> fast compared to the docbook processing.

Given how much simple usage.sh got, I'm thinking it might be worth it to
just remove it, and just shove the rule into the makefile itself.

Ok, I tried to write it.  I came up with the following.  (Note: I have *not*
tested it.)  It's not *that* ugly.

usage-guilt-%.txt: ../guilt-% usage.sh
	echo "'$(basename $<)' `sed -n -e '/^USAGE=/{s/USAGE="//; s/"$//; p; q}' $<`" > $@

What do you think?  Too opaque?  Your change looks good.

Jeff.

> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  Documentation/Makefile | 4 ++--
>  Documentation/usage.sh | 8 +++-----
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index b6c3285..ec3c9e8 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -66,8 +66,8 @@ clean:
>  	rm -f usage-*.txt
>  	rm -f version.txt
>  
> -usage-%.txt: $(MAN1_TXT) usage.sh
> -	sh ./usage.sh
> +usage-guilt-%.txt: ../guilt-% usage.sh
> +	sh ./usage.sh $<
>
>  %.html : %.txt footer.txt version.txt
>  	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $(ASCIIDOC_EXTRA) $<
> diff --git a/Documentation/usage.sh b/Documentation/usage.sh
> index 20fdca4..629f546 100644
> --- a/Documentation/usage.sh
> +++ b/Documentation/usage.sh
> @@ -1,7 +1,5 @@
>  #!/bin/sh
>  
> -for i in `ls ../guilt-*`; do
> -	name=$(basename $i)
> -	u=$(grep USAGE $i |  sed 's/USAGE="//' | sed 's/"$//') 
> -	echo "'$name' $u"  > usage-$name.txt
> -done
> +name=$(basename $1)
> +u=$(grep USAGE $1 |  sed 's/USAGE="//' | sed 's/"$//') 
> +echo "'$name' $u"  > usage-$name.txt
> -- 
> 2.1.0
> 

-- 
The reasonable man adapts himself to the world; the unreasonable one
persists in trying to adapt the world to himself. Therefore all progress
depends on the unreasonable man.
		- George Bernard Shaw
