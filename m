From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/WIP 2/7] fast-import: be saner with temporary trees
Date: Thu, 28 Jul 2011 09:27:48 +0200
Message-ID: <20110728072748.GB4179@elie>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
 <1311828370-30477-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 09:28:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmL0o-0007Cw-2c
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 09:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab1G1H2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 03:28:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36543 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab1G1H2A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 03:28:00 -0400
Received: by fxh19 with SMTP id 19so993214fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 00:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xEd0p28pCyoimFRiwLOnQe+S32cef40a/dUk6h/6GKA=;
        b=K+YEQBqOToEu7nb0C3BWAwpUTBCpjWqzOU9bPinmvzwL1AXAGC7vQpjAYKKkLVo8IB
         IZG6FxLQyvGQtGcnkE+mybqTnHOFOvaVFepQBxuT7vzkJbsGZuB6uc8kK6kG53RIqNLl
         CP8TeNxcDFXMAg6AZqk+dQoJHLyDILFcUuGyc=
Received: by 10.223.91.156 with SMTP id n28mr942449fam.102.1311838078796;
        Thu, 28 Jul 2011 00:27:58 -0700 (PDT)
Received: from elie (adsl-165-140-99.teol.net [109.165.140.99])
        by mx.google.com with ESMTPS id r12sm307563fam.0.2011.07.28.00.27.56
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 00:27:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311828370-30477-3-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178043>

Dmitry Ivankov wrote:

> new_tree_entry() doesn't zero or otherwise initialize the returned
> entry, neither does release_tree_entry(). So it is quite possible
> to get previously released data in a new entry.

Thanks.  Background for the confused: new_tree_entry /
release_tree_entry manage a stack of tree_entry structs to use as
temporaries.  Initializing them is the responsibility of the caller,
both after allocation with xmalloc() when existing temporaries are
exhausted and after used entries are pushed with release_tree_entry().

> parse_ls doesn't set entry->versions[0] fields, but it does call
> store_tree(entry) which looks for this base sha1 and tries to do
> delta compression with that random object.
>
> Reset entry->versions[0] fields to make things more predictable
> and to avoid surprises here.
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>

Good idea --- "root" is invalid at this point.  Looks like a mistake
introduced by my tweaks to v1.7.5-rc0~3^2~33 (fast-import: add 'ls'
command, 2010-12-02).

But isn't store_tree() only called on "leaf" which is completely
zero-initialized?

So I don't see why this change would have any effect.  For what it's
worth, even so, except for the commit message,

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
