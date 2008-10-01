From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 3/8] Dispose of allocated colors on finalize()
Date: Wed, 1 Oct 2008 07:37:18 -0700
Message-ID: <20081001143718.GU21310@spearce.org>
References: <1222818823-22780-1-git-send-email-robin.rosenberg@dewire.com> <1222818823-22780-2-git-send-email-robin.rosenberg@dewire.com> <1222818823-22780-3-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:40:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl2qV-0006xN-G8
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 16:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbYJAOhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 10:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbYJAOhU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 10:37:20 -0400
Received: from george.spearce.org ([209.20.77.23]:37341 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbYJAOhT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 10:37:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A754C3835F; Wed,  1 Oct 2008 14:37:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222818823-22780-3-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97223>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> ---

Missing SBO.

>  .../egit/ui/internal/history/SWTPlotRenderer.java  |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
> index 23ec255..a58b3bf 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
> @@ -45,6 +45,17 @@ SWTPlotRenderer(final Display d) {
>  		sys_darkblue = d.getSystemColor(SWT.COLOR_DARK_BLUE);
>  	}
>  
> +	@Override
> +	protected void finalize() throws Throwable {
> +		sys_black.dispose();
> +		sys_blue.dispose();
> +		sys_gray.dispose();
> +		sys_darkblue.dispose();
> +		sys_yellow.dispose();
> +		sys_green.dispose();
> +		sys_white.dispose();
> +	}

I think this is wrong.  Any color that we get from
Display.getSystemColor() must not be disposed of by the application,
its in use by the Display and/or other parts of the application.

>From the Javadocs:

  This color should not be free'd because it was allocated by the
  system, not the application.

I take that to mean that the color should not be disposed of.

Though reading the Gtk SWT sources it seems that the system color
objects aren't pooled, each call to getSystemColor causes a new
Color instace to be allocated.  So it may be harmless on Gtk.

What was the rationale for disposing of these resources?  Did you
identify that this is a resource leak somewhere?  Because I'd like
to make sure I actually understand the SWT resource model better
so I don't commit mistakes in the future.

-- 
Shawn.
