From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] add FreeBSD support
Date: Fri, 9 Aug 2013 10:46:42 -0400
Message-ID: <20130809144641.GK22686@poseidon.cudanet.local>
References: <1376051548-3126-1-git-send-email-wenqing.lz@taobao.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zheng Liu <gnehzuil.liu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 16:55:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7o5y-0006w5-4A
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 16:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757756Ab3HIOzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 10:55:08 -0400
Received: from josefsipek.net ([64.9.206.49]:1671 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757614Ab3HIOzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 10:55:08 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Aug 2013 10:55:07 EDT
Received: from poseidon.cudanet.local (unknown [64.235.151.250])
	by josefsipek.net (Postfix) with ESMTPSA id 94EE5554D8;
	Fri,  9 Aug 2013 10:46:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1376051548-3126-1-git-send-email-wenqing.lz@taobao.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231985>

On Fri, Aug 09, 2013 at 08:32:28PM +0800, Zheng Liu wrote:
> From: Zheng Liu <gnehzuil.liu@gmail.com>
> 
> Currently guilt doesn't support FreeBSD platform.  This commit tries to
> add this support.  The file called 'os.FreeBSD' is copied from os.Darwin
> due to these two platforms have almost the same command tools.

Out of curiosity, is it identical?  I eyeballed it, and they do look
identical.  There's probably a better way to do this whole os-specific
thing, but this will work well enough for now.

Jeff.

> Signed-off-by: Zheng Liu <gnehzuil.liu@gmail.com>
> ---
> Hi all,
> 
> After applied this patch, the regression test 010 and 060 will fail because
> of the output format.  After fixing these issues, all the regression tests
> will pass.
> 
> P.S. I don't subscribe git@ mailing list.  So please put my email address
> in Cc list.  Thanks!
> 
> Regards,
> 						- Zheng
> 
>  os.FreeBSD | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 os.FreeBSD
> 
> diff --git a/os.FreeBSD b/os.FreeBSD
> new file mode 100644
> index 0000000..3f23121
> --- /dev/null
> +++ b/os.FreeBSD
> @@ -0,0 +1,70 @@
> +# usage: touch_date <unix ts> <file>
> +touch_date()
> +{
> +	touch -t `date -r $1 +%Y%m%d%H%M.%S` "$2"
> +}
> +
> +# usage: last_modified <file>
> +last_modified()
> +{
> +	stat -f "%m" "$1"
> +}
> +
> +# usage: format_last_modified <file>
> +format_last_modified()
> +{
> +	stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S %z" "$1"
> +}
> +
> +# usage: head_n [count]
> +head_n()
> +{
> +	if [ "$1" -gt 0 ]; then
> +		head -n "$1"
> +	fi
> +}
> +
> +# usage: sha1 [file]
> +sha1()
> +{
> +	if [ $# = 1 ]
> +	then
> +		openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
> +	else
> +		openssl dgst -sha1 | sed 's,\(.*= \)*\(.*\),\2  -,'
> +	fi
> +}
> +
> +# usage: cp_a <src> <dst>
> +cp_a()
> +{
> +	cp -pR "$1" "$2"
> +}
> +
> +# usage: _tac
> +_tac()
> +{
> +	sed -e '1!G;h;$!d'
> +}
> +
> +_seq()
> +{
> +	(
> +		if [ $# -eq 1 ]
> +		then
> +			/usr/bin/jot $1
> +		elif [ $# -eq 2 ]
> +		then
> +			n1=$((${2} - ${1} + 1))
> +			n2=$1
> +			/usr/bin/jot $n1 $n2
> +		elif [ $# -eq 3 ]
> +		then
> +			num1=$1
> +			incr=$2
> +			num2=$3
> +			/usr/bin/awk -v n1=$num1 -v n2=$num2 -v add=$incr 'BEGIN{ for(i=n1; i<=n2; i+=add) print i;}' | /usr/bin/sed -E '/e/s/^.+e.+$/0/'
> +		fi
> +	)
> +	return 0
> +}
> -- 
> 1.8.3.4
> 

-- 
Research, n.:
  Consider Columbus:
    He didn't know where he was going.
    When he got there he didn't know where he was.
    When he got back he didn't know where he had been.
    And he did it all on someone else's money.
