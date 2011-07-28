From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/WIP 3/7] fast-import: fix a data corruption in parse_ls
Date: Thu, 28 Jul 2011 09:34:34 +0200
Message-ID: <20110728073434.GC4179@elie>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
 <1311828370-30477-4-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 09:34:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmL7P-00016u-3s
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 09:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab1G1Hes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 03:34:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54501 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab1G1Heq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 03:34:46 -0400
Received: by fxh19 with SMTP id 19so998678fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zLiP4wWKgSjyPSiYbERlGROJVUyPmQNnT57wdkSGqII=;
        b=fD8MpkQ4v9kWsEx59defDhwbwOmhBBEjnKqVeT5OC12N6ec5loyeh8++ahDHtxtsSk
         SLVgnMDCukAw+zMczUFPlGpt2EDx7oO1kAQuFlTefkfjrF9EPwc1yIa26pnS0oawTL4A
         V1qObxkGVfW0845c4/6x5nL5X8+l3Okb1ScTQ=
Received: by 10.223.17.151 with SMTP id s23mr958663faa.13.1311838485015;
        Thu, 28 Jul 2011 00:34:45 -0700 (PDT)
Received: from elie (adsl-165-140-99.teol.net [109.165.140.99])
        by mx.google.com with ESMTPS id h9sm308000faa.39.2011.07.28.00.34.43
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 00:34:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311828370-30477-4-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178044>

Dmitry Ivankov wrote:

> store_tree sets versions[0] = versions[1] unconditionally. This is fine
> if it is run from the very root.

True.

> But if it's run for a intermediate
> node in parse_ls, node's parent versions[0] can become invalid as it
> references it's children versions[0].

A puzzle: when would parse_ls() call store_tree() on a subdirectory?
The store_tree() call is preceded by

	tree_content_get(root, p, &leaf);

which makes a deep copy of "root" in leaf (which seems to be leaked
--- oops).
