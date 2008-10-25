From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/7] gitk: Allow starting gui blame for a specific line.
Date: Sat, 25 Oct 2008 22:57:23 +1100
Message-ID: <18691.2467.601039.480382@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-4-git-send-email-angavrilov@gmail.com>
	<18688.26370.467724.404768@cargo.ozlabs.ibm.com>
	<200810241213.01337.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 13:58:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kthn5-000164-5k
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 13:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYJYL53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 07:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYJYL53
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 07:57:29 -0400
Received: from ozlabs.org ([203.10.76.45]:33891 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867AbYJYL52 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 07:57:28 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 86B1FDDDF5; Sat, 25 Oct 2008 22:57:27 +1100 (EST)
In-Reply-To: <200810241213.01337.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99103>

Alexander Gavrilov writes:

> Good point. How about this variant? I renamed the menu item, and
> changed the code to blame the current commit if:

Sounds good, just a couple of minor nits...

> +    # Now scan the lines to determine offset within the hunk
> +    set parent {}
> +    set dline 0
> +    set s_lno [lindex [split $s_lix "."] 0]
> +
> +    for {set i $line} {$i > $s_lno} {incr i -1} {
> +	set c_line [$ctext get $i.0 "$i.0 + 1 lines"]
> +	# Determine if the line is removed
> +	set chunk [string range $c_line 0 [llength $base_lines]-2]

You need an [expr]:

set chunk [string range $c_line 0 [expr {[llength $base_lines] - 2}]]

> +	set removed_idx [string first "-" $chunk]
> +	# Choose a parent index
> +	if {$parent eq {}} {
> +	    if {$removed_idx >= 0} {
> +		set parent $removed_idx
> +		incr parent
> +	    } else {
> +		set unchanged_idx [string first " " $chunk]
> +		if {$unchanged_idx >= 0} {
> +		    set parent $unchanged_idx
> +		    incr parent
> +		} else {
> +		    # blame the current commit
> +		    set parent 0
> +		}
> +	    }
> +	}

I like this better than the previous version, but it would turn out a
bit simpler if you use parent = -1 to indicate that we're blaming the
current commit, and then increment it right at the end.

> +	# then count other lines that belong to it
> +	if {$parent > 0} {
> +	    set code [string index $c_line $parent-1]

Once again you need an [expr].

Apart from those things, it looks good.  If you like I will fix those
things and commit it.

Paul.
