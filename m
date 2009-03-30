From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: run post-checkout hook on checkout
Date: Mon, 30 Mar 2009 07:34:35 -0700
Message-ID: <20090330143435.GA23521@spearce.org>
References: <49CAB4C1.6070004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 16:36:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoIax-0001qo-LT
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbZC3Oei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 10:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbZC3Oei
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:34:38 -0400
Received: from george.spearce.org ([209.20.77.23]:34289 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbZC3Oeh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 10:34:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BE7EF38211; Mon, 30 Mar 2009 14:34:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49CAB4C1.6070004@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115158>

Jens Lehmann <Jens.Lehmann@web.de> wrote:
> It's been a while since i deeply touched tcl/tk code ... i basically
> adapted the code for calling the post-commit hook here.

Not bad for not having touched tcl/tk in a long time... :-)
 
> +	# -- Run the post-checkout hook.
> +	#
> +	set fd_ph [githook_read post-checkout $old_hash $new_hash 1]
> +	if {$fd_ph ne {}} {
> +		upvar #0 pch_error pc_err

I'd rather spell this "global pch_error".

> +		set pc_err {}
> +		fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
> +		fileevent $fd_ph readable \
> +			[list checkout_postcheckout_wait $fd_ph $this]

The callback should be "[cb _postcheckout_wait $fd_ph]".  This is
a git-gui macro which returns a handle to invoke a "method" named
"_postcheckout_wait", passing in $this as the first parameter.

> +proc checkout_postcheckout_wait {fd_ph t} {

This should be "method _postcheckout_wait {fd_ph} {" to use the
cb macro above, and have $this automatically carry through.

> +	upvar #0 pch_error pch_error

"global pch_error"

> +	append pch_error [read $fd_ph]
> +	fconfigure $fd_ph -blocking 1
> +	if {[eof $fd_ph]} {
> +		if {[catch {close $fd_ph}]} {
> +			hook_failed_popup post-checkout $pch_error 0
> +		}
> +		unset pch_error
> +		delete_this $t
> +		return
> +	}
> +	fconfigure $fd_ph -blocking 0

Also, I'm wondering about the UI state semantics here.  Back on
line 462 (in the preimage) we unlock_index, which means that the
user can start to push buttons again, and then later on around
line 474 you start up the post-checkout hook.

I think we'd want to defer the unlock_index call until after the
hook has terminated, if we are going to run a hook at all.  In fact,
we probably need to move that entire block 462-474 (the unlock_index
... delete_this block) to a new method which we invoke if there is
no hook, or after the hook subprocess terminates.

By waiting until after the hook to do the rescan, we also ensure
that the hook has a chance to update the working directory, perhaps
by dirtying a file, and the user seeing the result of that dirtying
immediately.

-- 
Shawn.
