From: David Turner <dturner@twopensource.com>
Subject: Confused about sparse vs untracked-cache
Date: Wed, 29 Jul 2015 22:32:07 -0400
Organization: Twitter
Message-ID: <1438223527.18134.53.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 04:32:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKddo-0004uh-8G
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 04:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbbG3CcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 22:32:11 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35159 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbbG3CcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 22:32:10 -0400
Received: by qgii95 with SMTP id i95so15954653qgi.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 19:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=XF/maUnu5dEPsWci/80UEfch6ro0gP/y/pKlkiiNeww=;
        b=IyogcAE1X5LXtg82sCMRQ3SmS7ISPKl8KdRRCTwQD8CArhDgrkrctVN7uBo0c/Fagm
         NmFQzJah3X8+WHjR98voZ8jk7m/hlT+a5SzLQV8+Kk+O6bnamdOWD9CE8BPMofOWlbzB
         F0Z9Km2Cp+traO6I/pqwkqYpiuESoaRSVKAdN7YhNE5LJoprzMLU2dc+lw1mjtv00mm9
         TmbYaiP1eeOs69LR4/GgNzondxL7c8lnAisKe98J8kBwzrLz2qTUxS9B0ui2y8533JSZ
         V5pLmFd2+glr+Z1fUVE5yqD8YIangHSYVCzkekkMzE4I1CkOQtA64j34vIqXkw/V5Wxe
         lxdA==
X-Gm-Message-State: ALoCoQlXrYh/zzHtXsAsOHO2cHfLK4U0agwT8F0ex/VrfllzPtMAr74e5t4T2KLeBXbiGvXjutmX
X-Received: by 10.140.16.74 with SMTP id 68mr64475421qga.99.1438223529679;
        Wed, 29 Jul 2015 19:32:09 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id j102sm15097786qkh.46.2015.07.29.19.32.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2015 19:32:09 -0700 (PDT)
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274965>

I'm looking at dir.c, and there's a bit I'm confused about:

prep_exclude() says:
		     /*
		      * .. and .gitignore does not exist before
		      * (i.e. null exclude_sha1 and skip_worktree is
		      * not set). Then we can skip loading .gitignore,
		      * which would result in ENOENT anyway.
		      * skip_worktree is taken care in read_directory()
		      */
		     !is_null_sha1(untracked->exclude_sha1))) {

That "skip_worktree is taken care in read_directory()" appears to be
referring to this bit of validate_untracked_cache():
	/*
	 * An optimization in prep_exclude() does not play well with
	 * CE_SKIP_WORKTREE. It's a rare case anyway, if a single
	 * entry has that bit set, disable the whole untracked cache.
	 */
	for (i = 0; i < active_nr; i++)
		if (ce_skip_worktree(active_cache[i]))
			return NULL;
------------
I'm confused about why skip_worktree needs to be unset.  When I comment
out the second snippet, all the tests still pass.  What was the reason
behind that condition?  Is it really necessary?
