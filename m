From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v2] gitk: Show patch for initial commit
Date: Sat, 01 Oct 2011 23:03:18 +0200
Message-ID: <4E878016.703@in.waw.pl>
References: <20111001190554.GA5854@kennedy.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Paul Mackerras <paulus@samba.org>
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Sat Oct 01 23:03:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA6id-0008ST-TP
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 23:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401Ab1JAVDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 17:03:32 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:47297 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057Ab1JAVDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 17:03:30 -0400
Received: from 86-85-n1.aster.pl ([85.222.86.85] helo=[192.168.1.6])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RA6iX-00061P-I5; Sat, 01 Oct 2011 23:03:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110807 Icedove/5.0
In-Reply-To: <20111001190554.GA5854@kennedy.acc.umu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182577>

[cc: Paul Mackerras]

Hi,
I think that the historical explanation that Junio gave could
be used as a basis for a commit message:

  In early days, all projects managed by git (except for git itself) had the
  product of a fairly mature development history in their first commit, and
  it was deemed unnecessary clutter to show additions of these thousands of
  paths as a patch.

  "git log" learned to show the patch for the initial commit without requiring
  --root command line option at 0f03ca9 (config option log.showroot to show
  the diff of root commits, 2006-11-23).

  Teach gitk to respect log.showroot.

Also the gitk should be mentioned in the man-page for git-config log.showroot.
The current description of this option seems suboptimal because it explains
how it used to be, which is not really relevant:
  log.showroot
    If true, the initial commit will be shown as a big creation event. This is
    equivalent to a diff against an empty tree. Tools like git-log(1) or git-
    whatchanged(1), which normally hide the root commit will now show it. True by
    default.
This could be changed to:
    If true (the default), the root commit will be shown as a big creation
    event --- a diff against an empty tree. This diff can be very large for
    a project which was imported into git after some development history.
    If log.showroot is false tools like git-log(1), git-whatchanged(1), or
    gitk(1) will not display the added files.
    
Zbyszek

On 10/01/2011 09:05 PM, Marcus Karlsson wrote:
> Make gitk show the patch for the initial commit by default.
> Override with log.showroot.
> 
> Signed-off-by: Marcus Karlsson<mk@acc.umu.se>
> ---
>   gitk-git/gitk |   13 +++++++++++--
>   1 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 4cde0c4..40ea73f 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -7402,7 +7402,7 @@ proc addtocflist {ids} {
>   }
> 
>   proc diffcmd {ids flags} {
> -    global nullid nullid2
> +    global log_showroot nullid nullid2
> 
>       set i [lsearch -exact $ids $nullid]
>       set j [lsearch -exact $ids $nullid2]
> @@ -7436,7 +7436,11 @@ proc diffcmd {ids flags} {
>   	    lappend cmd HEAD
>   	}
>       } else {
> -	set cmd [concat | git diff-tree -r $flags $ids]
> +	set cmd [concat | git diff-tree -r]
> +	if {$log_showroot eq true} {
> +	    set cmd [concat $cmd --root]
> +	}
> +	set cmd [concat $cmd $flags $ids]
>       }
>       return $cmd
>   }
> @@ -11403,6 +11407,11 @@ catch {
>       }
>   }
> 
> +set log_showroot true
> +catch {
> +    set log_showroot [exec git config --get log.showroot]
> +}
> +
>   if {[tk windowingsystem] eq "aqua"} {
>       set mainfont {{Lucida Grande} 9}
>       set textfont {Monaco 9}
