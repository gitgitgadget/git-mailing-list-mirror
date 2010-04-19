From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4' 1/2] gitk: do not parse "  >" context as submodule
 change
Date: Mon, 19 Apr 2010 19:22:44 +0200
Message-ID: <4BCC9164.3080301@web.de>
References: <20100419010819.GA4386@brick.ozlabs.ibm.com> <671110fcac73c5fc8a935b82d88f8553c510c50c.1271694102.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 19 19:22:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ugR-0007Ws-Ic
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 19:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab0DSRWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 13:22:50 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:53193 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab0DSRWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 13:22:49 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id B609615E3536B;
	Mon, 19 Apr 2010 19:22:48 +0200 (CEST)
Received: from [80.128.59.171] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O3ugJ-0002dt-00; Mon, 19 Apr 2010 19:22:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <671110fcac73c5fc8a935b82d88f8553c510c50c.1271694102.git.trast@student.ethz.ch>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+87O0pAGJ7lYxygn88geGiRaPk8s9hSVzNDl1c
	E3rScNAW0aoobhqkmk7NUmmtsCcW3F/QyrGVWJV1Kq2ArpaQd0
	VMDEen+VhFR0DQHS09PA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145318>

Am 19.04.2010 18:27, schrieb Thomas Rast:
>> Thanks, but now that I have applied Jens Lehmann's patch that also
>> touches this area, your patch doesn't apply.  Could you rebase it and
>> send it again?
> 
> Sure.

There might be a problem with this rebase. Unfortunately I am very
short on time, so I can't test this today.

I think setting the $currdiffsubmod variable to the empty string
has to show up in the two sections formatting the lines with
"  >" & "  <".


>  gitk |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 1b0e09a..6513ef8 100755
> --- a/gitk
> +++ b/gitk
> @@ -7706,14 +7706,8 @@ proc getblobdiffline {bdf ids} {
>  	    } else {
>  		$ctext insert end "$line\n" filesep
>  	    }
> -	} elseif {![string compare -length 3 "  >" $line]} {
> -	    set $currdiffsubmod ""
> -	    set line [encoding convertfrom $diffencoding $line]
> -	    $ctext insert end "$line\n" dresult
> -	} elseif {![string compare -length 3 "  <" $line]} {
> -	    set $currdiffsubmod ""
> -	    set line [encoding convertfrom $diffencoding $line]
> -	    $ctext insert end "$line\n" d0
> +	    # pretend we're in a file header to correctly parse "  [><]"
> +	    set diffinhdr 1
>  	} elseif {$diffinhdr} {
>  	    if {![string compare -length 12 "rename from " $line]} {
>  		set fname [string range $line [expr 6 + [string first " from " $line] ] end]
> @@ -7732,6 +7726,14 @@ proc getblobdiffline {bdf ids} {
>  		    set fname [lindex $fname 0]
>  		}
>  		makediffhdr $fname $ids
> +	    } elseif {![string compare -length 3 "  >" $line]} {

I suspect we need a 'set $currdiffsubmod ""' here

> +		set line [encoding convertfrom $diffencoding $line]
> +		$ctext insert end "$line\n" dresult
> +		continue
> +	    } elseif {![string compare -length 3 "  <" $line]} {

and here.

> +		set line [encoding convertfrom $diffencoding $line]
> +		$ctext insert end "$line\n" d0
> +		continue
>  	    } elseif {[string compare -length 3 $line "---"] == 0} {
>  		# do nothing
>  		continue

If you can wait until tomorrow I can check that.
