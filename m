From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk tag delete/rename support
Date: Sat, 24 Nov 2012 22:26:09 -0800
Message-ID: <7vzk26xkou.fsf@alter.siamese.dyndns.org>
References: <1353649899-15641-1-git-send-email-leon.kukovec@gmail.com>
 <1353688894-2526-1-git-send-email-leon.kukovec@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Leon KUKOVEC <leon.kukovec@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 07:31:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcVk6-00076V-Qj
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 07:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab2KYG0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 01:26:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab2KYG0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 01:26:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E17336A93;
	Sun, 25 Nov 2012 01:26:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xc0RhJb47OcfLlJct6GzizG2Hzc=; b=UY21E5
	PMe/uIe8UPQXKNu+ugDQ48TLs3rYfIQ1lg9ZGHOpictpy0Xf+bXMxYbpqrpmr+pm
	We/ZEtWihZGpwtzsUiRvOcOqN0BQFXY+3jZMsUTOprUWygh1z3vN5Jlp1BNNiDby
	L/3Fc1+FVWPFPIm5QjSTwl06qNrUZsgliP0cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ds0fwp3JY2zeog2/SkWDK2xkcfrRpqOG
	TS1VRm3O313TDn/TVhUoQxeh1OeocV5pgYw1CuwFvoyg8r4evVfj5zkZiMQrR6/t
	CRC6iTfWSPZK6ZWdgbzC0Y0BIW3svuijx23kV40mBhp2Ghgo0x9jdbJr8cYCsawu
	CkJMzWNCZls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF08F6A92;
	Sun, 25 Nov 2012 01:26:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1245B6A91; Sun, 25 Nov 2012
 01:26:10 -0500 (EST)
In-Reply-To: <1353688894-2526-1-git-send-email-leon.kukovec@gmail.com> (Leon
 KUKOVEC's message of "Fri, 23 Nov 2012 17:41:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0130B5C6-36C9-11E2-891F-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210333>

Leon KUKOVEC <leon.kukovec@gmail.com> writes:

> Right clicking on a tag pops up a menu, which allows
> tag to be renamed or deleted.
>
> Signed-off-by: Leon KUKOVEC <leon.kukovec@gmail.com>
> ---

Thanks, but I prefer not to take patches to gitk-git/ directly;
could you prepare a patch against Paul's tree at


    git://ozlabs.org/~paulus/gitk

and send it in that direction (paulus@) instead?

>  gitk-git/gitk |  154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index d93bd99..38cc233 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2032,6 +2032,7 @@ proc makewindow {} {
>      global have_tk85 use_ttk NS
>      global git_version
>      global worddiff
> +    global tagctxmenu
>  
>      # The "mc" arguments here are purely so that xgettext
>      # sees the following string as needing to be translated
> @@ -2581,6 +2582,13 @@ proc makewindow {} {
>  	{mc "Run git gui blame on this line" command {external_blame_diff}}
>      }
>      $diff_menu configure -tearoff 0
> +
> +    set tagctxmenu .tagctxmenu
> +    makemenu $tagctxmenu {
> +	{mc "Rename this tag" command mvtag}
> +	{mc "Delete this tag" command rmtag}
> +    }
> +    $tagctxmenu configure -tearoff 0
>  }
>  
>  # Windows sends all mouse wheel events to the current focused window, not
> @@ -6400,6 +6408,7 @@ proc drawtags {id x xt y1} {
>  		   -font $font -tags [list tag.$id text]]
>  	if {$ntags >= 0} {
>  	    $canv bind $t <1> [list showtag $tag_quoted 1]
> +	    $canv bind $t $ctxbut [list showtagmenu %X %Y $id $tag_quoted]
>  	} elseif {$nheads >= 0} {
>  	    $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
>  	}
> @@ -8931,6 +8940,113 @@ proc domktag {} {
>      return 1
>  }
>  
> +proc mvtag {} {
> +    global mvtagtop
> +    global tagmenuid tagmenutag tagctxmenu maintag NS
> +    global mvtagtag
> +
> +    set mvtagtag $tagmenutag
> +    set top .movetag
> +    set mvtagtop $top
> +    catch {destroy $top}
> +    ttk_toplevel $top
> +    make_transient $top .
> +
> +    ${NS}::label $top.msg -text [mc "Enter a new tag name:"]
> +    ${NS}::entry $top.tag -width 60 -textvariable mvtagtag
> +
> +    grid $top.msg -sticky w -row 0 -column 0
> +    grid $top.tag -sticky w -row 0 -column 1
> +
> +    ${NS}::frame $top.buts
> +    ${NS}::button $top.buts.gen -text [mc "Rename"] -command mvtaggo
> +    ${NS}::button $top.buts.can -text [mc "Cancel"] -command mvtagcan
> +    bind $top <Key-Return> mvtaggo
> +    bind $top <Key-Escape> mvtagcan
> +    grid $top.buts.gen $top.buts.can
> +    grid columnconfigure $top.buts 0 -weight 1 -uniform a
> +    grid columnconfigure $top.buts 1 -weight 1 -uniform a
> +    grid $top.buts - -pady 10 -sticky ew
> +}
> +
> +proc domvtag {} {
> +    global mvtagtop env tagids idtags tagmenutag tagmenuid mvtagtag
> +
> +    set tag $mvtagtag
> +    set id $tagmenuid
> +
> +    # add tag
> +    # XXX: reuse domktag including keeping comment from the original tag.
> +    if {[catch {
> +        exec git tag $tag $id
> +    } err]} {
> +        error_popup "[mc "Error renaming tag:"] $err" $mvtagtop
> +        return 0
> +    }
> +
> +    # delete old tag, content stored in $tagmenutag and $tagmenuid
> +    dormtag
> +
> +    set tagids($tag) $id
> +    lappend idtags($id) $tag
> +    redrawtags $id
> +    addedtag $id
> +    dispneartags 0
> +    run refill_reflist
> +    return 1
> +}
> +
> +proc rmtag {} {
> +    global rmtagtop
> +    global tagmenuid tagmenutag tagctxmenu maintag NS
> +
> +    set top .maketag
> +    set rmtagtop $top
> +    catch {destroy $top}
> +    ttk_toplevel $top
> +    make_transient $top .
> +    ${NS}::label $top.title -text [mc "Delete tag"]
> +    grid $top.title - -pady 10
> +
> +    ${NS}::label $top.msg -text [mc "You are about to delete a tag"]
> +    ${NS}::label $top.tagname -foreground Red -text [mc "$tagmenutag"]
> +    grid $top.msg -sticky w -row 0 -column 0
> +    grid $top.tagname -sticky w -row 0 -column 1
> +
> +    ${NS}::frame $top.buts
> +    ${NS}::button $top.buts.gen -text [mc "Delete"] -command rmtaggo
> +    ${NS}::button $top.buts.can -text [mc "Cancel"] -command rmtagcan
> +    bind $top <Key-Return> rmtaggo
> +    bind $top <Key-Escape> rmtagcan
> +    grid $top.buts.gen $top.buts.can
> +    grid columnconfigure $top.buts 0 -weight 1 -uniform a
> +    grid columnconfigure $top.buts 1 -weight 1 -uniform a
> +    grid $top.buts - -pady 10 -sticky ew
> +}
> +
> +proc dormtag {} {
> +    global rmtagtop env tagids idtags tagmenutag tagmenuid
> +
> +    set tag $tagmenutag
> +    set id $tagmenuid
> +
> +    if {[catch {
> +        exec git tag -d $tag
> +    } err]} {
> +        error_popup "[mc "Error deleting tag:"] $err" $rmtagtop
> +        return 0
> +    }
> +
> +    unset tagids($tag)
> +    set idx [lsearch $idtags($id) $tag]
> +    set idtags($id) [lreplace $idtags($id) $idx $idx]
> +
> +    redrawtags $id
> +    dispneartags 0
> +    run refill_reflist
> +    return 1
> +}
> +
>  proc redrawtags {id} {
>      global canv linehtag idpos currentid curview cmitlisted markedid
>      global canvxmax iddrawn circleitem mainheadid circlecolors
> @@ -8974,6 +9090,30 @@ proc mktaggo {} {
>      mktagcan
>  }
>  
> +proc rmtagcan {} {
> +    global rmtagtop
> +
> +    catch {destroy $rmtagtop}
> +    unset rmtagtop
> +}
> +
> +proc rmtaggo {} {
> +    if {![dormtag]} return
> +    rmtagcan
> +}
> +
> +proc mvtagcan {} {
> +    global mvtagtop
> +
> +    catch {destroy $mvtagtop}
> +    unset mvtagtop
> +}
> +
> +proc mvtaggo {} {
> +    if {![domvtag]} return
> +    mvtagcan
> +}
> +
>  proc writecommit {} {
>      global rowmenuid wrcomtop commitinfo wrcomcmd NS
>  
> @@ -9288,6 +9428,20 @@ proc headmenu {x y id head} {
>      tk_popup $headctxmenu $x $y
>  }
>  
> +# context menu for a tag
> +proc showtagmenu {x y id tag} {
> +    global tagmenuid tagmenutag tagctxmenu maintag
> +
> +    stopfinding
> +    set tagmenuid $id
> +    set tagmenutag $tag
> +    set state normal
> +
> +    $tagctxmenu entryconfigure 0 -state normal
> +    $tagctxmenu entryconfigure 1 -state normal
> +    tk_popup $tagctxmenu $x $y
> +}
> +
>  proc cobranch {} {
>      global headmenuid headmenuhead headids
>      global showlocalchanges
