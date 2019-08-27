Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0AF1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 21:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfH0V6h (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 17:58:37 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52429 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0V6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 17:58:37 -0400
X-Originating-IP: 1.186.12.40
Received: from localhost (unknown [1.186.12.40])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 22CB8E0002;
        Tue, 27 Aug 2019 21:58:34 +0000 (UTC)
Date:   Wed, 28 Aug 2019 03:28:32 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitk: Make web links clickable
Message-ID: <20190827215832.ela2e6cuanuk6rvp@yadavpratyush.com>
References: <20190826221444.GB7402@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826221444.GB7402@blackberry>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/08/19 08:14AM, Paul Mackerras wrote:
> This makes gitk look for lines in the commit message which start with
> "Link:" or "BugLink:" followed by a http or https URL, and make the
> URL clickable.  Clicking on it will invoke an external web browser with
> the URL.
 
Why just lines starting with "Link:" or "BugLink:"? Why not do it for 
all links?

> The web browser command is by default "xdg-open" on Linux, "open" on
> MacOS, and "cmd /c start" on Windows.  The command can be changed in
> the preferences window, and it can include parameters as well as the
> command name.  If it is set to the empty string then URLs will no
> longer be made clickable.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  gitk | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/gitk b/gitk
> index a14d7a1..4577150 100755
> --- a/gitk
> +++ b/gitk
> @@ -7016,6 +7016,7 @@ proc commit_descriptor {p} {
>  
>  # append some text to the ctext widget, and make any SHA1 ID
>  # that we know about be a clickable link.
> +# Also look for lines of the form "Link: http..." and make them web links.
>  proc appendwithlinks {text tags} {
>      global ctext linknum curview
>  
> @@ -7032,6 +7033,18 @@ proc appendwithlinks {text tags} {
>  	setlink $linkid link$linknum
>  	incr linknum
>      }
> +    set wlinks [regexp -indices -all -inline -line \
> +		    {^ *(Bug|)Link: (https?://.*)$} $text]

Will it be a better idea to stop at the first whitespace character, 
instead of stopping at the end of the line?

> +    foreach {l sub1 sub2} $wlinks {
> +	set s2 [lindex $sub2 0]
> +	set e2 [lindex $sub2 1]
> +	set url [string range $text $s2 $e2]
> +	incr e2
> +	$ctext tag delete link$linknum
> +	$ctext tag add link$linknum "$start + $s2 c" "$start + $e2 c"
> +	setwlink $url link$linknum
> +	incr linknum
> +    }
>  }
>  
>  proc setlink {id lk} {
> @@ -7064,6 +7077,18 @@ proc setlink {id lk} {
>      }
>  }
>  
> +proc setwlink {url lk} {
> +    global ctext
> +    global linkfgcolor
> +    global web_browser
> +
> +    if {$web_browser eq {}} return
> +    $ctext tag conf $lk -foreground $linkfgcolor -underline 1
> +    $ctext tag bind $lk <1> [list browseweb $url]
> +    $ctext tag bind $lk <Enter> {linkcursor %W 1}
> +    $ctext tag bind $lk <Leave> {linkcursor %W -1}
> +}
> +
>  proc appendshortlink {id {pre {}} {post {}}} {
>      global ctext linknum
>  
> @@ -7098,6 +7123,16 @@ proc linkcursor {w inc} {
>      }
>  }
>  
> +proc browseweb {url} {
> +    global web_browser
> +
> +    if {$web_browser eq {}} return
> +    # Use eval here in case $web_browser is a command plus some arguments
> +    if {[catch {eval exec $web_browser [list $url] &} err]} {
> +	error_popup "[mc "Error starting web browser:"] $err"
> +    }
> +}
> +
>  proc viewnextline {dir} {
>      global canv linespc
>  
> @@ -11488,7 +11523,7 @@ proc create_prefs_page {w} {
>  proc prefspage_general {notebook} {
>      global NS maxwidth maxgraphpct showneartags showlocalchanges
>      global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
> -    global hideremotes want_ttk have_ttk maxrefs
> +    global hideremotes want_ttk have_ttk maxrefs web_browser
>  
>      set page [create_prefs_page $notebook.general]
>  
> @@ -11539,6 +11574,13 @@ proc prefspage_general {notebook} {
>      pack configure $page.extdifff.l -padx 10
>      grid x $page.extdifff $page.extdifft -sticky ew
>  
> +    ${NS}::entry $page.webbrowser -textvariable web_browser
> +    ${NS}::frame $page.webbrowserf
> +    ${NS}::label $page.webbrowserf.l -text [mc "Web browser" ]
> +    pack $page.webbrowserf.l -side left
> +    pack configure $page.webbrowserf.l -padx 10
> +    grid x $page.webbrowserf $page.webbrowser -sticky ew
> +
>      ${NS}::label $page.lgen -text [mc "General options"]
>      grid $page.lgen - -sticky w -pady 10
>      ${NS}::checkbutton $page.want_ttk -variable want_ttk \
> @@ -12310,6 +12352,7 @@ if {[tk windowingsystem] eq "win32"} {
>      set bgcolor SystemWindow
>      set fgcolor SystemWindowText
>      set selectbgcolor SystemHighlight
> +    set web_browser "cmd /c start"
>  } else {
>      set uicolor grey85
>      set uifgcolor black
> @@ -12317,6 +12360,11 @@ if {[tk windowingsystem] eq "win32"} {
>      set bgcolor white
>      set fgcolor black
>      set selectbgcolor gray85
> +    if {[tk windowingsystem] eq "aqua"} {
> +	set web_browser "open"
> +    } else {
> +	set web_browser "xdg-open"
> +    }
>  }
>  set diffcolors {red "#00a000" blue}
>  set diffcontext 3
> @@ -12390,6 +12438,7 @@ set config_variables {
>      filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
>      linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
>      indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
> +    web_browser
>  }
>  foreach var $config_variables {
>      config_init_trace $var
> -- 
> 2.7.4
> 

-- 
Regards,
Pratyush Yadav
