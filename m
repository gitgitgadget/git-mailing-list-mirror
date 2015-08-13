From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Alter the ordering for the "Tags and heads" view
Date: Thu, 13 Aug 2015 10:43:02 +1000
Message-ID: <20150813004302.GB6686@fergus.ozlabs.ibm.com>
References: <1433243470-93392-1-git-send-email-rappazzo@gmail.com>
 <1433243470-93392-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 02:43:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPgc0-0004EY-5R
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 02:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbbHMAnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 20:43:11 -0400
Received: from ozlabs.org ([103.22.144.67]:43345 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbbHMAnL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 20:43:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 06096140562; Thu, 13 Aug 2015 10:43:08 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1433243470-93392-2-git-send-email-rappazzo@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275830>

On Tue, Jun 02, 2015 at 07:11:10AM -0400, Michael Rappazzo wrote:
> In the "Tags and heads" view, the list of refs is globally sorted.
> The list of local refs (heads) is separated by the remote refs.  This
> change re-orders the view toi be: local refs, remote refs tracked by
> local refs, remote refs, tags, and then other refs
> 
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>

Sorry it's taken me so long to get around to reviewing this.  I have a
couple of comments:

> ---
>  gitk-git/gitk | 48 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 9a2daf3..431a6a1 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -9879,35 +9879,71 @@ proc refill_reflist {} {
>      global curview
>  
>      if {![info exists showrefstop] || ![winfo exists $showrefstop]} return
> -    set refs {}
> +    set localrefs {}
> +    set remoterefs {}
> +    set locally_tracked_remote_refs {}
> +    set tagrefs {}
> +    set otherrefs {}
>      foreach n [array names headids] {
> -	if {[string match $reflistfilter $n]} {
> +	if {![string match "remotes/*" $n] && [string match $reflistfilter $n]} {
> +	    if {[commitinview $headids($n) $curview]} {
> +		lappend localrefs [list $n H]
> +		catch {set remote_name [exec git config --get branch.$n.remote]}
> +		if {$remote_name ne ""} {

First off, if the git config command fails for any reason and returns
an error status, the set command won't get done and $remote_name will
either be undefined or will have whatever value it had before.  If it
is undefined then the if statement is going to throw an error.  I
don't think that is what you meant to happen.  This same problem will
occur for other variables such as $remote_ref and $exists.

Secondly, I'm not very happy about doing all these external git
commands every time we run refill_reflist.  Couldn't we cache which
remote each local branch is tracking?  We would then throw away and
reload the cache in rereadrefs.  Most executions of refill_reflist
would then not need to do any external git commands at all.

Paul.
