From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] Add to gitk an --argscmd flag to get the list of refs to
	draw at refresh time.
Date: Sat, 17 Nov 2007 22:44:00 +1100
Message-ID: <18238.54272.198637.788805@cargo.ozlabs.ibm.com>
References: <20071102222436.23191.91785.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Nov 17 12:45:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItM6i-0002aa-KX
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 12:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbXKQLor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 06:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761283AbXKQLor
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 06:44:47 -0500
Received: from ozlabs.org ([203.10.76.45]:36806 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760939AbXKQLoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 06:44:46 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 205E2DDDDB; Sat, 17 Nov 2007 22:44:43 +1100 (EST)
In-Reply-To: <20071102222436.23191.91785.stgit@gandelf.nowhere.earth>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65268>

Yann Dirson writes:

> This allows to display a set of refs, when the refs in the set may
> themselves change between two refresh operations (eg. the set of
> patches in a patch stack), and is expected to be called from other
> porcelain suites.
> 
> The command is expected to generate a list of commits, which will be
> appended to the commits litterally passed on the command-line.  That
> command is handled similarly to the litteral refs, and has its own
> field in the saved view, and an edit field in the view editor.

The idea is fine, but I have some comments on the implementation:

> +--argscmd=<command>::
> +	Command to be run each time gitk has to determine the list of
> +	<revs> to show.  The command is expected to print on its
> +	standard output a list of additional revs to be shown.  Use

, one per line

> +	this instead of explicitely specifying <revs> if the set of

explicitly

> +	commits to show may vary between refreshs.

refreshes

> +    set args $viewargs($view)
> +    if {$viewargscmd($view) ne "None"} {
> +	if {[catch {
> +	    set fd [open [concat | $viewargscmd($view)] r]
> +	} err]} {
> +	    puts stderr "Error executing --argscmd command: $err"
> +	    exit 1
> +	}
> +	set args [concat $args [read $fd 500000]]

I don't think you necessarily want to limit the number of characters
read to 500000, do you?

What this will do is interpret the output of the program according to
Tcl list syntax.  I think it would be better to use [split $str "\n"]
to split the program's output at the newlines.  Also, you could
combine the open, read and close into a single exec call.  Thirdly,
use error_popup rather than just writing to stderr.

I wonder if you should be invoking a shell to interpret the command.
As you have it at the moment, the string that the user puts after
--argscmd= is treated as a Tcl list, whereas the string they put into
the entry field when creating a new view is split with shellsplit,
which implements shell-style quoting.  I think we should at least be
consistent here, and possibly just leave it as a string and pass it to
sh -c.

> +set revtreeargscmd None

Why the string "None" rather than the empty string?  Is this a
python-ism that has crept in?

>  foreach arg $argv {
> -    switch -- $arg {
> -	"" { }
> -	"-d" { set datemode 1 }
> -	"--merge" {
> +    switch -regexp -- $arg {

Hmmm, it'd be simpler to use switch -glob here, I think.

> +	"^$" { }
> +	"^-d$" { set datemode 1 }
> +	"^--merge$" {
>  	    set mergeonly 1
>  	    lappend revtreeargs $arg
>  	}
> -	"--" {
> +	"^--$" {
>  	    set cmdline_files [lrange $argv [expr {$i + 1}] end]
>  	    break
>  	}
> +	"^--argscmd=" {
> +	    regexp {^--argscmd=(.*)} $arg match revtreeargscmd

set revtreeargscmd [string range $arg 10 end]

Paul.
