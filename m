From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/7] gitk: Allow starting gui blame for a specific line.
Date: Thu, 23 Oct 2008 22:58:58 +1100
Message-ID: <18688.26370.467724.404768@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-3-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-4-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 14:00:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsyrW-0004zV-FM
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 14:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbYJWL7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 07:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbYJWL7F
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 07:59:05 -0400
Received: from ozlabs.org ([203.10.76.45]:52102 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872AbYJWL7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 07:59:04 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 49616DDDEF; Thu, 23 Oct 2008 22:59:02 +1100 (EST)
In-Reply-To: <1223449540-20457-4-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98952>

Alexander Gavrilov writes:

> Adds a context menu item to the diff viewer pane that
> calls blame, focusing it on the clicked line. In case
> of combined diffs, it also automatically deduces which
> parent is to be blamed.

I have some comments on this one, but I haven't finished reviewing it
completely, so I may have more... :)

> +proc find_hunk_blamespec {base line} {
> +    global ctext
> +
> +    # Find and parse the hunk header
> +    set s_lix [$ctext search -backwards -regexp ^@@ "$line.0 lineend" $base.0]
> +    if {$s_lix eq {}} return
> +
> +    set s_line [$ctext get $s_lix "$s_lix + 1 lines"]
> +    if {![regexp {^@@@?(( -\d+(,\d+)?)+) \+(\d+)(,\d+)? @@} $s_line \

In fact there can be many @ characters at the beginning of the line;
the number of parents plus one, in fact.  See commit
c465a76af658b443075d6efee1c3131257643020 in the kernel tree for an
example.  I suggest starting with ^@@@* rather than ^@@@?.

> +    # Now scan the lines to determine offset within the hunk
> +    set parent {}
> +    set dline 0
> +    set s_lno [lindex [split $s_lix "."] 0]
> +
> +    for {set i $line} {$i > $s_lno} {incr i -1} {
> +	set c_line [$ctext get $i.0 "$i.0 + 1 lines"]
> +	if {$parent eq {}} {
> +	    # find first preceeding line that belongs to some parent
> +	    for {set j 0} {$j < [llength $old_lines]} {incr j} {
> +		set code [string index $c_line $j]
> +		if {$code ne {-} && $code ne { }} continue
> +		if {$code eq { } && $parent ne {}} continue
> +		set parent $j
> +		if {$code eq {-}} break
> +	    }
> +	}

This part worries me a bit.  If the user clicks on a line where all
the $code values are "+" then I think we should blame the current
commit.  Either that, or we disable the context menu item before
posting it if the user clicks on a line that starts with all "+"
characters (as many "+" as there are parents).

BTW, writing "-" rather than {-} in expressions is more idiomatic.

Paul.
