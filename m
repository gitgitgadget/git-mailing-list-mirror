From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2 1/2] gitk: alter the ordering for the "Tags and heads"
 view
Date: Sat, 19 Mar 2016 17:53:47 +1100
Message-ID: <20160319065347.GC27126@fergus.ozlabs.ibm.com>
References: <1458327097-92126-1-git-send-email-rappazzo@gmail.com>
 <1458327097-92126-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:00:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahAsY-00048z-J8
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 08:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbcCSHAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 03:00:41 -0400
Received: from ozlabs.org ([103.22.144.67]:47026 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbcCSHAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 03:00:39 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3qRtK147DKz9sB6; Sat, 19 Mar 2016 18:00:37 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1458327097-92126-2-git-send-email-rappazzo@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289289>

On Fri, Mar 18, 2016 at 02:51:36PM -0400, Michael Rappazzo wrote:
> In the "Tags and heads" view, the list of refs is globally sorted.
> Because of this, the list of local refs (heads) can be interrupted by the
> list of remote refs.  This change re-orders the view to be: local refs,
> remote refs tracked by local refs, remote refs, tags, and then other refs.

This seems like a nice idea, and could lead on to having a section that
can be opened and closed for each of these categories.  However, I
have some comments on the implementation:

> @@ -9933,35 +9933,71 @@ proc refill_reflist {} {
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
>  	    if {[commitinview $headids($n) $curview]} {
> -		lappend refs [list $n H]
> +		lappend localrefs [list $n H]
> +		catch {set remote_name [exec git config --get branch.$n.remote]}
> +		if {$remote_name ne ""} {
> +		    catch {set remote_ref [exec git config --get branch.$n.merge]}
> +		    set remote_ref [string map {"refs/heads/" ""} $remote_ref]
> +		    set locally_tracked_remote_ref "remotes/$remote_name/$remote_ref"
> +		    set upstream_exists ""
> +		    catch {set upstream_exists [exec git rev-parse --verify $locally_tracked_remote_ref]}
> +		    if {$upstream_exists ne ""} {
> +			if {[lsearch $locally_tracked_remote_refs [list $locally_tracked_remote_ref H]] < 0} {
> +			    lappend locally_tracked_remote_refs [list $locally_tracked_remote_ref H]
> +			}
> +		    }
> +		}

I'm worried about the number of external git invocations we're
potentially doing here, and how long that would take when you have a
lot of heads.  Can we cache the results perhaps?  Or is there a way to
do a single git command and get a list of tracking branches with their
remotes etc.?

Also, the default for lsearch is glob-style matching.  It's unlikely
that ref names would have any of *?[\ in them, but AFAIK it's not
impossible.  You probably want -exact in there.

Further, the kind of thing you are using lsearch for can often be done
more efficiently using an array (which becomes essentially a hash
table underneath).

Paul.
