From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 10/28] Run test_failed if the exit status of a test
 script is bad.
Date: Tue, 6 May 2014 15:56:53 -0400
Message-ID: <20140506195653.GL1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-11-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:29:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhlUE-0005TX-01
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbaEFT4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:56:51 -0400
Received: from josefsipek.net ([64.9.206.49]:1692 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbaEFT4u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:56:50 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 2440B55654;
	Tue,  6 May 2014 15:56:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-11-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248243>

On Fri, Mar 21, 2014 at 08:31:48AM +0100, Per Cederqvist wrote:
> There were two problems with the old code:
> 
>  - Since "set -e" is in effect (that is set in scaffold) the run-test
>    script exited immediately if a t-*.sh script failed.  This is not
>    nice, as we want the error report that test_failed prints.
> 
>  - The code ran "cd -" between running the t-*.sh script and checking
>    the exit status, so the exit status was lost.  (Actually, the exit
>    status was saved in $ERR, but nothing ever looked at $ERR.)

Oops :)

> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/run-tests | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/regression/run-tests b/regression/run-tests
> index a10e796..d39f9ef 100755
> --- a/regression/run-tests
> +++ b/regression/run-tests
> @@ -55,11 +55,16 @@ function run_test
>  
>  	# run the test
>  	cd "$REPODIR" > /dev/null
> -	"$REG_DIR/t-$1.sh" 2>&1 > "$LOGFILE"
> -	ERR=$?
> +	if "$REG_DIR/t-$1.sh" 2>&1 > "$LOGFILE"
> +	then
> +	    ERR=false
> +	else
> +	    ERR=true

I'm going to comment on this here... Coding style.  Guilt is a bit of a
hodge-podge of style as my personal style for shell changed over the years
and various contributors threw in some more.  I need to get better at
spotting style mismatch during review.  With that said, I have two comments
about the above:

(1) I'd put the 'then' on the same line as 'if' but I don't feel strongly
    enough about this to reject this patch.

(2) Tabs for indentation.  I do feel strongly about this one :)

Jeff.

> +	fi
> +
>  	cd - > /dev/null
>  
> -	[ $? -ne 0 ] && test_failed
> +	$ERR && test_failed
>  	diff -u "t-$1.out" "$LOGFILE" || test_failed
>  
>  	echo "done."
> -- 
> 1.8.3.1
> 

-- 
I'm somewhere between geek and normal.
		- Linus Torvalds
