From: Jeremy Morton <admin@game-point.net>
Subject: Re: [PATCH] mergetools/p4merge: Handle "/dev/null"
Date: Sat, 27 Oct 2012 09:47:05 +0100
Message-ID: <508B9F89.7050909@game-point.net>
References: <1349925756-87801-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 10:45:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS21V-0000LP-1c
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 10:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324Ab2J0IpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 04:45:23 -0400
Received: from ip.game-point.net ([208.100.1.149]:57665 "EHLO
	ip.game-point.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298Ab2J0IpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 04:45:17 -0400
Received: from 87-194-212-214.bethere.co.uk ([87.194.212.214]:1357 helo=[192.168.0.101])
	by ip.game-point.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <admin@game-point.net>)
	id 1TS215-00047Q-NU; Sat, 27 Oct 2012 09:45:16 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <1349925756-87801-1-git-send-email-davvid@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ip.game-point.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - game-point.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208502>

Sorry to be replying to this so late; I hadn't noticed the post until now!

I've tried putting that code in my p4merge script and yes it does indeed 
work fine.  However, it puts a temporary file in the working directory 
which I'm not sure is a good idea?  If we look at this patch which 
actually solved pretty much the same problem, but when merging and, 
during a merge conflict, a file was created in both branches:
https://github.com/git/git/commit/ec245ba

... it is creating a temp file in a proper temp dir, rather than in the 
working dir.  I think that would be the proper solution here.  However, 
I really want to get this fixed so I'd be happy for this band-aid fix of 
the p4merge script to be checked in until we could get a patch more like 
the aforementioned one, at a later date, to create empty files in a 
proper temp dir and pass them as $LOCAL and $REMOTE.  :-)

-- 
Best regards,
Jeremy Morton (Jez)

On 11/10/2012 04:22, David Aguilar wrote:
> p4merge does not properly handle the case where "/dev/null"
> is passed as a filename.
>
> Workaround it by creating a temporary file for this purpose.
>
> Reported-by: Jeremy Morton<admin@game-point.net>
> Signed-off-by: David Aguilar<davvid@gmail.com>
> ---
> Jeremy, can you test this?
>
>   mergetools/p4merge | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/mergetools/p4merge b/mergetools/p4merge
> index 1a45c1b..295361a 100644
> --- a/mergetools/p4merge
> +++ b/mergetools/p4merge
> @@ -1,5 +1,30 @@
>   diff_cmd () {
> +	# p4merge does not like /dev/null
> +	rm_local=
> +	rm_remote=
> +	if test "/dev/null" = "$LOCAL"
> +	then
> +		LOCAL="./p4merge-dev-null.LOCAL.$$"
> +		>"$LOCAL"
> +		rm_local=true
> +	fi
> +	if test "/dev/null" = "$REMOTE"
> +	then
> +		REMOTE="./p4merge-dev-null.REMOTE.$$"
> +		>"$REMOTE"
> +		rm_remote=true
> +	fi
> +
>   	"$merge_tool_path" "$LOCAL" "$REMOTE"
> +
> +	if test -n "$rm_local"
> +	then
> +		rm -f "$LOCAL"
> +	fi
> +	if test -n "$rm_remote"
> +	then
> +		rm -f "$REMOTE"
> +	fi
>   }
>
>   merge_cmd () {
