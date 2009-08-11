From: Mark A Rada <marada@uwaterloo.ca>
Subject: Re: [PATCH] git-instaweb: detect difference between mod_cgi and mod_cgid for apache2
Date: Mon, 10 Aug 2009 21:23:30 -0400
Message-ID: <7B93F2E3-D6F9-4A5D-BAE1-F630F09E9909@mailservices.uwaterloo.ca>
References: <8366E0BD-3A64-4DDD-B12C-2FD48C357FFB@mailservices.uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Tue Aug 11 03:23:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mag5a-0007IC-I7
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 03:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbZHKBXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 21:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbZHKBXf
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 21:23:35 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:40992 "EHLO
	psyche.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752439AbZHKBXe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 21:23:34 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by psyche.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7B1NUUZ010240
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 10 Aug 2009 21:23:34 -0400
In-Reply-To: <8366E0BD-3A64-4DDD-B12C-2FD48C357FFB@mailservices.uwaterloo.ca>
X-Mailer: Apple Mail (2.936)
X-UUID: c0c2aedf-cfd8-4213-a231-d027c7d678d1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125506>

If you haven't already, ignore this patch, I'm pretty sure it won't  
work for cases where mod_cgid
is built in. I think it should be including the ScriptSock directive  
when built in as well, but I don't
have a setup to test that on, and the apache documentation isn't very  
specific.

I'll try again later, sorry for the spam.


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


On 10-Aug-09, at 1:19 AM, Mark A Rada wrote:

> I'm not sure if this should have been two patches or just one.
>
> First I changed the check of whether mod_cgi is built in or not from  
> matching against
> 'mod_cgi.c' to 'mod_cgi' because I made the assumption that mod_cgid  
> would be called
> 'mod_cgid.c' (I haven't actually checked this, but it sounds  
> reasonable). Then, the
> second change handles the two cases when no cgi module is built in,  
> which I  did try
> (for mod_cgid that is).
>
> Also, should the socket needed for mod_cgid be put in $GIT_DIR or  
> somewhere else?
>
>
> tl;dr I only actually tried 1/4 cases, everything else looks  
> reasonable
>
>
> --
> Mark A Rada (ferrous26)
> marada@uwaterloo.ca
>
>
> --->8---
> Some people have mod_cgid in place of mod_cgi, this will check which  
> one
> the user has available to them first, and then act accordingly.
>
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> ---
> git-instaweb.sh |   10 ++++++++--
> 1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 5f5cac7..fdac0d0 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -297,8 +297,14 @@ EOF
> 		# plain-old CGI
> 		resolve_full_httpd
> 		list_mods=$(echo "$full_httpd" | sed "s/-f$/-l/")
> -		$list_mods | grep 'mod_cgi\.c' >/dev/null 2>&1 || \
> -		echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
> +		$list_mods | grep 'mod_cgi' >/dev/null 2>&1 || \
> +		if test -f "$module_path/mod_cgi.so"
> +		then
> +			echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
> +		else
> +			echo "LoadModule cgi_module $module_path/mod_cgid.so" >> "$conf"
> +			echo "ScriptSock $GIT_DIR/gitweb.sock" >> "$conf"
> +		fi
> 		cat >> "$conf" <<EOF
> AddHandler cgi-script .cgi
> <Location /gitweb.cgi>
> -- 
> 1.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
