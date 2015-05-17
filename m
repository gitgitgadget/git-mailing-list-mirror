From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Improve readability of highlighted text
Date: Sun, 17 May 2015 14:21:55 +1000
Message-ID: <20150517042155.GD21039@iris.ozlabs.ibm.com>
References: <BLU436-SMTP165FCB03C8F3B79226DB3F093080@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Ventimiglia <Mark.Ventimiglia@hotmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 06:22:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ytq5j-0000C9-PO
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 06:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbbEQEWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 00:22:10 -0400
Received: from ozlabs.org ([103.22.144.67]:41192 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbbEQEWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 00:22:03 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2171C140D57; Sun, 17 May 2015 14:22:00 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP165FCB03C8F3B79226DB3F093080@phx.gbl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269208>

On Thu, Mar 26, 2015 at 12:48:45AM -0500, Mark Ventimiglia wrote:
> Selected text is indicated by displaying a rectangle under the selected
> text. When the default background color of dark blue is used for the
> selection rectangle, it does not have sufficient contrast with the default
> text color of black, and the highlighted text cannot be read easily.
> 
> To fix this, determine the HSV value of the selection background color.
> Then, set the color of the selected text based on that value -- white if
> the value is less than 0.6, black otherwise. This ensures that there is
> sufficent contrast to make the text readable over the background color.
> Also tag all selected text with secseltext, so that it can be reverted to
> the default color on a change of selection.

Finally got back to looking at this again...

> +    foreach t [$canv find withtag secseltext] {
> +	$canv itemconf $t -fill $fgcolor
> +	$canv dtag $t secseltext
> +    }

Why not just:

	$canv itemconf secseltext -fill $fgcolor
	$canv dtag secseltext

> +proc getseltextcolor {c} {
> +    # Get the largest RGB value -- this is the V in HSV
> +    set value [lindex [lsort -integer [winfo rgb . $c]] end]
> +
> +    # If the normalized value is darker than 0.6 use white text,
> +    # otherwise use black text
> +    return [expr ($value < (65535 * .6))?"white":"black"]

The HSV value doesn't correlate very well with perceived lightness,
and this will use black text when the background is R=0 G=0 B=153,
which is very hard to read.  It would probably be better to use
a weighted sum of R, G and B, maybe something like 0.3R + 0.6G + 0.1B.

Paul.
