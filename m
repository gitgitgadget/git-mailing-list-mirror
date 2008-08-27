From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [egit PATCH] avoiding output in the error log
Date: Wed, 27 Aug 2008 22:28:06 +0200
Message-ID: <200808272228.07060.robin.rosenberg.lists@dewire.com>
References: <218798.11648.bm@omp221.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: robert_no.spam_m@yahoo.fr
X-From: git-owner@vger.kernel.org Wed Aug 27 22:31:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRfo-0000zJ-41
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbYH0UaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbYH0UaM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:30:12 -0400
Received: from av12-2-sn2.hy.skanova.net ([81.228.8.186]:51231 "EHLO
	av12-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbYH0UaL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:30:11 -0400
Received: by av12-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id CA39F380FA; Wed, 27 Aug 2008 22:30:09 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id B2BE4380E9; Wed, 27 Aug 2008 22:30:09 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 764B237E45;
	Wed, 27 Aug 2008 22:30:09 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <218798.11648.bm@omp221.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93943>

onsdagen den 27 augusti 2008 11.34.33 skrev robert_no.spam_m@yahoo.fr:
> Hi,this is a patch for egit. The purpose of the patch
> is to avoid a lot of output in the error log.

Welcome Robert!

> 
> From 6f7be5d1a41d356a9b558ac81722e959095ff04d Mon Sep 17 00:00:00 2001
> From: robert <robert_no.spam_m@yahoo.fr>
> Date: Mon, 25 Aug 2008 20:42:39 +0200
> Subject: [PATCH] Checks added to avoid a lot of entries in the log
> 
> * IResource.exists() must be checked before calling setProperty on it.
> * getActiveDecorator() was returning null in some case.
> ---
>  .../internal/decorators/GitResourceDecorator.java  |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
> index 5857eaf..7c10ec6 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
> @@ -143,7 +143,9 @@ if (resources.size() > 0)
>  					try {
>  						m.accept(new IResourceVisitor() {
>  							public boolean visit(IResource resource) throws CoreException {
> -								getActiveDecorator().clearDecorationState(resource);
> +								GitResourceDecorator decorator = getActiveDecorator();
> +								if (decorator != null)
> +									decorator.clearDecorationState(resource);

When doest his happen?

>  								return true;
>  							}
>  						},
> @@ -197,8 +199,10 @@ synchronized (resources) {
>  	} // End ResCL
>  
>  	void clearDecorationState(IResource r) throws CoreException {
> -		r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
> -		fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
> +		if (r.exists()) {
> +			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
> +			fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
> +		}

Shawn, you removed the test from the code in 4a230ea1. Perhaps you could care to
comment on this patch to restore the test, though slightly different.

		if (r.isAccessible())
			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);

-- robin
