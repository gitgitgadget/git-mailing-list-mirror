From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/7] Refactor of RefUpdate force to call common
	updateImpl instead of duplication
Date: Thu, 14 Aug 2008 15:23:45 -0700
Message-ID: <20080814222345.GU3782@spearce.org>
References: <1218708829-8175-1-git-send-email-charleso@charleso.org> <1218708829-8175-2-git-send-email-charleso@charleso.org> <1218708829-8175-3-git-send-email-charleso@charleso.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Charles O'Farrell <charleso@charleso.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:24:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlFO-0002dw-Uj
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbYHNWXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbYHNWXq
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:23:46 -0400
Received: from george.spearce.org ([209.20.77.23]:58052 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbYHNWXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:23:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 831A438376; Thu, 14 Aug 2008 22:23:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1218708829-8175-3-git-send-email-charleso@charleso.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92422>

Charles O'Farrell <charleso@charleso.org> wrote:
> @@ -266,31 +266,8 @@ public class RefUpdate {
>  	 *             an unexpected IO error occurred while writing changes.
>  	 */
>  	public Result forceUpdate() throws IOException {
[clipped uinteresting deletions to show only the postimage]
> +		force = true;
> +		return update();
>  	}
>  
>  	/**
> @@ -347,6 +324,12 @@ public class RefUpdate {
>  			if (oldValue == null)
>  				return store(lock, Result.NEW);
>  
> +			if (isForceUpdate()) {
> +				if (oldValue.equals(newValue))
> +					return Result.NO_CHANGE;
> +				return store(lock, Result.FORCED);
> +			}
> +
>  			newObj = walk.parseAny(newValue);
>  			oldObj = walk.parseAny(oldValue);
>  			if (newObj == oldObj)
> @@ -355,13 +338,8 @@ public class RefUpdate {
>  			if (newObj instanceof RevCommit && oldObj instanceof RevCommit) {
>  				if (walk.isMergedInto((RevCommit) oldObj, (RevCommit) newObj))
>  					return store(lock, Result.FAST_FORWARD);
> -				if (isForceUpdate())
> -					return store(lock, Result.FORCED);
> -				return Result.REJECTED;

The problem with this change is that calls to just update() which
have isForceUpdate() true but actually turn out to be FAST_FORWARD
types of updates now report FORCED as the result.  We don't want
to always report FORCED if the application is using just update().

Its nice to know that the remote side didn't rewind since we last
saw them (for example).

-- 
Shawn.
