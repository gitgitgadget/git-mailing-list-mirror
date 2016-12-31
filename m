Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD861FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 11:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbcLaLEG (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 06:04:06 -0500
Received: from ozlabs.org ([103.22.144.67]:49713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbcLaLEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 06:04:05 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3trL7P36G8z9t3N; Sat, 31 Dec 2016 22:04:01 +1100 (AEDT)
Date:   Sat, 31 Dec 2016 20:08:59 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Pierre Dumuid <pmdumuid@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] Add a tree view to the local branches, remote
 branches and tags, where / is treated as a directory seperator.
Message-ID: <20161231090859.GC21019@fergus.ozlabs.ibm.com>
References: <20161215112847.14719-1-pmdumuid@gmail.com>
 <20161215112847.14719-3-pmdumuid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161215112847.14719-3-pmdumuid@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 09:58:44PM +1030, Pierre Dumuid wrote:
> Signed-off-by: Pierre Dumuid <pmdumuid@gmail.com>
> ---
>  gitk | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)

Nice idea in general... a few comments below.  Also, please don't put
the entire commit message in the subject line. :)

> diff --git a/gitk b/gitk
> index 36cba49..a894f1d 100755
> --- a/gitk
> +++ b/gitk
> @@ -2089,6 +2089,10 @@ proc makewindow {} {
>  	    {mc "Reread re&ferences" command rereadrefs}
>  	    {mc "&List references" command showrefs -accelerator F2}
>  	    {xx "" separator}
> +	    {mc "List Local Branches"  command {show_tree_of_references_dialog "localBranches"}  -accelerator F6}
> +	    {mc "List Remote Branches" command {show_tree_of_references_dialog "remoteBranches"} -accelerator F7}
> +	    {mc "List Tags"            command {show_tree_of_references_dialog "tags"}           -accelerator F8}
> +	    {xx "" separator}
>  	    {mc "Start git &gui" command {exec git gui &}}
>  	    {xx "" separator}
>  	    {mc "&Quit" command doquit -accelerator Meta1-Q}
> @@ -2601,6 +2605,9 @@ proc makewindow {} {
>      bind . <F5> updatecommits
>      bindmodfunctionkey Shift 5 reloadcommits
>      bind . <F2> showrefs
> +    bind . <F6> {show_tree_of_references_dialog "localBranches"}
> +    bind . <F7> {show_tree_of_references_dialog "remoteBranches"}
> +    bind . <F8> {show_tree_of_references_dialog "tags"}
>      bindmodfunctionkey Shift 4 {newview 0}
>      bind . <F4> edit_or_newview
>      bind . <$M1B-q> doquit
> @@ -10146,6 +10153,116 @@ proc rmbranch {} {
>      run refill_reflist
>  }
>  
> +# Display a tree view of local branches, remote branches, and tags according to view_type.
> +#
> +# @param string view_type
> +#    Must be one of "localBranches", "remoteBranches", or "tags".
> +#
> +proc show_tree_of_references_dialog {view_type} {
> +    global NS
> +    global treefilelist
> +    global headids tagids
> +
> +    switch -- $view_type {
> +	"localBranches" {
> +	    set dialogName "Local Branches"
> +	    set top .show_tree_of_local_branches
> +	    set listOfReferences [lsort [array names headids -regexp {^(?!remotes/)} ]]
> +	    set truncateFrom 0
> +	}
> +	"remoteBranches" {
> +	    set dialogName "Remote Branches"
> +	    set top .show_tree_of_remote_branches
> +	    set listOfReferences [lsort [array names headids -regexp {^remotes/} ]]
> +	    set truncateFrom 8
> +	}
> +	"tags" {
> +	    set dialogName "Tags"
> +	    set top .show_tree_of_tags
> +	    set listOfReferences [lsort [array names tagids]]
> +	    set truncateFrom 0
> +	}
> +    }
> +
> +    if {[winfo exists $top]} {
> +	raise $top
> +	return
> +    }
> +
> +    ttk_toplevel $top
> +    wm title $top [mc "$dialogName: %s" [file tail [pwd]]]
> +    wm geometry $top "600x900"

Do you really need to do this?  A fixed size like this is inevitably
going to be too big for some users and too small for others.

> +
> +    make_transient $top .
> +
> +    ## See http://www.tkdocs.com/tutorial/tree.html
> +    ttk::treeview $top.referenceList -xscrollcommand "$top.horizontalScrollBar set" -yscrollcommand "$top.verticalScrollBar set"

We still have the option for people to run without ttk, in case
someone is still using an old Tcl/Tk version or just doesn't like the
ttk widgets.  However, there isn't an equivalent of ttk::treeview in
the older Tk widget set.  It would be OK to omit the new menu entries
or to disable them if $use_ttk is false, but I don't want to have menu
entries that will always cause gitk to blow up when $use_ttk is false.

We possibly should consider converting the file list view to use a
ttk::treeview when $use_ttk is true.

Paul.
