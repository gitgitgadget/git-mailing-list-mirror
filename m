From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] gitk: refactor: separate generic hunk parsing out of find_hunk_blamespecs{}
Date: Mon, 3 Feb 2014 18:20:36 -0500
Message-ID: <CAPig+cRv6851TWgRU6sBorKYZ0ABXv+a3oi=hrGjxYz9P6T7mg@mail.gmail.com>
References: <20140203205352.GA5136@wheezy.local>
	<20140203223346.GA14202@wheezy.local>
	<20140203224152.GA14305@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, Git List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Feb 04 00:20:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASoj-0008E9-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 00:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbaBCXUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 18:20:38 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:41891 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbaBCXUh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 18:20:37 -0500
Received: by mail-yk0-f171.google.com with SMTP id 142so42910734ykq.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9sTQ2mkNWRP97QOpBWeVC5s9OrdCHAZGAvLjgVwDI/0=;
        b=qv7DF/pLptyk2P6hy7I8fX5r704qq3YWTo3chB5EtG9tJlOfLgSaW6lTVsDA0spq0U
         W9Nxp6M/f3vB/ICMvDy7/6lqgCrpnnfuiLMW+j49IyDCcy+5U3iuHWMZIisDcwwCPdfj
         eq7neqS8g8+oZoaITiyk2wx6oL+xyVDiH8WeIViGJ4i7D2cW4oPTwzP9WUWOFKzUHUzX
         CcfyUk8LYz/Z1nbx3x7dkGgNfIrL8tUR4Ld3Tio4UnDCcITKrr5ZjiudSNQjXJmZuGIU
         HZY+M4mJEUR/1HiiveHyZvdIJNgRPard6PMc2c9UcQHzYm8Abheu9Kt8PVoHJTpIv3P4
         wHHA==
X-Received: by 10.236.127.39 with SMTP id c27mr2772312yhi.120.1391469636684;
 Mon, 03 Feb 2014 15:20:36 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Mon, 3 Feb 2014 15:20:36 -0800 (PST)
In-Reply-To: <20140203224152.GA14305@wheezy.local>
X-Google-Sender-Auth: uRy_ePjsoTtIYa_sl89pTHBARSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241493>

On Mon, Feb 3, 2014 at 5:41 PM, Max Kirillov <max@max630.net> wrote:
> For requesting a region blame, it is necessary to parse a hunk and
> find the region in the parent file corresponding to the selected region.
> There is already hunk parsin functionality in the find_hunk_blamespec{},

s/parsin/parsing/
s/in the/in/

> but returns only information for a single line.

s/but/but it/

> The new function, resolve_hunk_lines{}, scans the hunk once and returns
> for all hunk lines between $start_diffline and $end_diffline, in which parent
> each of them exists and which is its number there.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  gitk | 93 ++++++++++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 57 insertions(+), 36 deletions(-)
>
> diff --git a/gitk b/gitk
> index dfac4fd..7699a66 100755
> --- a/gitk
> +++ b/gitk
> @@ -3590,11 +3590,11 @@ proc external_diff {} {
>      }
>  }
>
> -proc find_hunk_blamespec {base line} {
> +proc resolve_hunk_lines {base start_diffline end_diffline} {
>      global ctext
>
>      # Find and parse the hunk header
> -    set s_lix [$ctext search -backwards -regexp ^@@ "$line.0 lineend" $base.0]
> +    set s_lix [$ctext search -backwards -regexp ^@@ "$start_diffline.0 lineend" $base.0]
>      if {$s_lix eq {}} return
>
>      set s_line [$ctext get $s_lix "$s_lix + 1 lines"]
> @@ -3614,49 +3614,70 @@ proc find_hunk_blamespec {base line} {
>      }
>
>      # Now scan the lines to determine offset within the hunk
> -    set max_parent [expr {[llength $base_lines]-2}]
> -    set dline 0
> +    set max_parent [expr {[llength $base_lines]-1}]
>      set s_lno [lindex [split $s_lix "."] 0]
>
> -    # Determine if the line is removed
> -    set chunk [$ctext get $line.0 "$line.1 + $max_parent chars"]
> -    if {[string match {[-+ ]*} $chunk]} {
> -       set removed_idx [string first "-" $chunk]
> -       # Choose a parent index
> -       if {$removed_idx >= 0} {
> -           set parent $removed_idx
> +    set commitlines_by_diffline {}
> +    array unset commit_lines
> +    for {set p 0} {$p <= $max_parent} {incr p} {
> +       set commit_lines($p) [expr [lindex $base_lines $p] - 1]
> +    }
> +    for {set diffline [expr $s_lno + 1]} {$diffline <= $end_diffline} {incr diffline} {
> +       set chunk [$ctext get $diffline.0 "$diffline.0 + $max_parent chars"]
> +       if {$chunk eq {} || [string match "\[\n@\]*" $chunk]} {
> +           # region is larger than hunk
> +           return {}
> +       }
> +       set is_removed [expr [string first "-" $chunk] >= 0]
> +       if {!$is_removed} {
> +           incr commit_lines(0)
> +           set commitlines [list [list 0 $commit_lines(0)]]
>         } else {
> -           set unchanged_idx [string first " " $chunk]
> -           if {$unchanged_idx >= 0} {
> -               set parent $unchanged_idx
> -           } else {
> -               # blame the current commit
> -               set parent -1
> -           }
> -       }
> -       # then count other lines that belong to it
> -       for {set i $line} {[incr i -1] > $s_lno} {} {
> -           set chunk [$ctext get $i.0 "$i.1 + $max_parent chars"]
> -           # Determine if the line is removed
> -           set removed_idx [string first "-" $chunk]
> -           if {$parent >= 0} {
> -               set code [string index $chunk $parent]
> -               if {$code eq "-" || ($removed_idx < 0 && $code ne "+")} {
> -                   incr dline
> +           set commitlines {}
> +       }
> +       for {set p 1} {$p <= $max_parent} {incr p} {
> +           switch -- [string index $chunk "$p-1"] {
> +               "+" {
>                 }
> -           } else {
> -               if {$removed_idx < 0} {
> -                   incr dline
> +               "-" {
> +                   incr commit_lines($p)
> +                   lappend commitlines [list $p $commit_lines($p)]
> +               }
> +               " " {
> +                   if {!$is_removed} {
> +                       incr commit_lines($p)
> +                       lappend commitlines [list $p $commit_lines($p)]
> +                   }
> +               }
> +               default {
> +                   error_popup "resolve_hunk_lines: unexpected diff line($diffline): $chunk"
> +                   break
>                 }
>             }
>         }
> -       incr parent
> -    } else {
> -       set parent 0
> +       if {$diffline >= $start_diffline} {
> +           lappend commitlines_by_diffline [list $diffline $commitlines]
> +       }
>      }
> +    return $commitlines_by_diffline
> +}
>
> -    incr dline [lindex $base_lines $parent]
> -    return [list $parent $dline]
> +proc find_hunk_blamespec {base line} {
> +    foreach cl_spec [resolve_hunk_lines $base $line $line] {
> +       if {[lindex $cl_spec 0] == $line} {
> +           set commitlines [lindex $cl_spec 1]
> +           if {[llength $commitlines] > 0} {
> +               if {[llength $commitlines] > 1 && [lindex $commitlines 0 0] eq 0} {
> +                   return [lindex $commitlines 1]
> +               } else {
> +                   return [lindex $commitlines 0]
> +               }
> +           } else {
> +               error_popup "find_hunk_blamespec: invalid commitlines: $commitlines"
> +           }
> +       }
> +    }
> +    return {}
>  }
>
>  proc external_blame_diff {} {
> --
> 1.8.5.2.421.g4cdf8d0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
