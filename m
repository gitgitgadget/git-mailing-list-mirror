From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] gitk: Do not select file list entries during diff loading
Date: Mon, 29 Oct 2012 10:56:50 +0200
Message-ID: <1ksq2y4.1mzh8yzydp87lM%lists@haller-berlin.de>
References: <508B08CB.5060702@arcor.de>
Cc: paulus@samba.org (Paul Mackerras)
To: kumbayo84@arcor.de (Peter Oberndorfer), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 29 10:57:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSm5g-0000yr-Qa
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 10:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120Ab2J2J4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 05:56:52 -0400
Received: from server90.greatnet.de ([83.133.96.186]:56917 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758019Ab2J2J4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 05:56:52 -0400
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id AC4C22C4074;
	Mon, 29 Oct 2012 10:56:49 +0100 (CET)
In-Reply-To: <508B08CB.5060702@arcor.de>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.8.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208607>

Peter Oberndorfer <kumbayo84@arcor.de> wrote:

> Please review/test the patch carefully before applying,
> since i do not often work with tcl/tk :-)

The patch makes perfect sense to me.  (I'm not a great tcl coder either
though, and not very familiar with the gitk code; so another review
would be helpful.)

Just one minor suggestion:

>  proc scrolltext {f0 f1} {
> -    global searchstring cmitmode ctext
> +    global searchstring cmitmode ctext ctext_last_scroll_pos
>      global suppress_highlighting_file_for_this_scrollpos
> 
> +    .bleft.bottom.sb set $f0 $f1
> +    if {$searchstring ne {}} {
> +        searchmarkvisible 0
> +    }
> +
>      set topidx [$ctext index @0,0]
> +    if {$topidx eq $ctext_last_scroll_pos} return
> +    set ctext_last_scroll_pos $topidx
> +
>      if {![info exists suppress_highlighting_file_for_this_scrollpos]
>          || $topidx ne $suppress_highlighting_file_for_this_scrollpos} {
>          highlightfile_for_scrollpos $topidx
>      }
> 
>      catch {unset suppress_highlighting_file_for_this_scrollpos}
> -
> -    .bleft.bottom.sb set $f0 $f1
> -    if {$searchstring ne {}} {
> -        searchmarkvisible 0
> -    }
>  }

I don't like early returns, they can easily become a source of bugs when
someone adds more code to the end of a function without realizing that
there's an early return in the middle.  I'd much rather say something
like

    if {$topidx ne $ctext_last_scroll_pos} {
        if {![info exists suppress_highlighting_file_for_this_scrollpos]
             || $topidx ne $suppress_highlighting_file_for_this_scrollpos} {
             highlightfile_for_scrollpos $topidx
        }

        set ctext_last_scroll_pos $topidx
    }


-Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
