From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/6] Cleanup unboxing/boxing
Date: Wed, 6 Feb 2008 02:06:31 -0500
Message-ID: <20080206070631.GM24004@spearce.org>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com> <1202170534-15788-2-git-send-email-robin.rosenberg@dewire.com> <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	"Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 08:07:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMeNP-0005Kx-E0
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 08:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbYBFHGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 02:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbYBFHGv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 02:06:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33279 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515AbYBFHGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 02:06:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JMeMa-0006nr-QL; Wed, 06 Feb 2008 02:06:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3BAB320FBAE; Wed,  6 Feb 2008 02:06:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72762>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> These operation are relatively expensive in general so it is good to make them
> visible, but when they are needed a lot we just want to do without explicit conversion
> so we ignore the warning there.
> @@ -207,7 +207,7 @@ public class GitResourceDecorator extends LabelProvider implements
>  					return Boolean.FALSE;
>  				}
>  
> -				return mapped.isResourceChanged(rsrc);
> +				return new Boolean(mapped.isResourceChanged(rsrc));
>  			}
>  			return null; // not mapped
>  		} catch (CoreException e) {

Oooooooow.  That hurts.

Use Boolean.valueOf(boolean) instead of new Boolean.  It recycles
the cached Boolean.TRUE and Boolean.FALSE and thus avoids creating
garbage that the GC needs to reclaim later.

> @@ -358,7 +358,7 @@ public class GitResourceDecorator extends LabelProvider implements
>  		try {
>  			Integer dirty = (Integer) rsrc.getSessionProperty(GITFOLDERDIRTYSTATEPROPERTY);
>  			if (dirty == null) {
> -				rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, flag);
> +				rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, new Integer(flag));
>  				Activator.trace("SETTING:"+rsrc.getFullPath().toOSString()+" => "+flag);
>  				orState(rsrc.getParent(), flag);
>  				Display.getDefault().asyncExec(new Runnable() {

Use Integer.valueOf(int).  Post Java 5 implementations of the J2SE
are required to cache values between -128 and 127 (inclusive).

Actually, when the Java compiler autoboxes values it does so through
these static valueOf methods, which were mostly introduced as part
of the Java 5 API updates.  For small common values its cached and
will thus avoid garbage generation, for less common values it goes
back to allocating the object.

-- 
Shawn.
