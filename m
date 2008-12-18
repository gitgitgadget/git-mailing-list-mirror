From: "James Pickens" <jepicken@gmail.com>
Subject: Re: [PATCH 1/2] Add support for multi threaded checkout
Date: Thu, 18 Dec 2008 16:35:01 -0700
Message-ID: <885649360812181535h36d24b0gb31acddded452a0@mail.gmail.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
	 <1229633811-3877-1-git-send-email-james.e.pickens@intel.com>
	 <alpine.LFD.2.00.0812181333150.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 00:36:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDSPo-0001kO-AO
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 00:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbYLRXfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 18:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbYLRXfE
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 18:35:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:30768 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbYLRXfC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 18:35:02 -0500
Received: by wa-out-1112.google.com with SMTP id v27so352022wah.21
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 15:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JPvfZ8NUVOcwAgYEfDxxL1C4+b30nuxBjiuBnZuygX8=;
        b=l3xEWpqHNZtPvOnHGhGVvVgLH1gMYxvU6hfdLt3CNwVzI/vKfzcyjgvRDtqtEglc5t
         iAmVswalf3YozMcGJqA4JMEyHRk0EUv4l6Fk3PL++Dya1+OvY8/Ffw8LrJm9wiAa5fmQ
         1G1e9lWx58zXWvtB2dnaVF5jiQVWOzI9q4uRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FITxgwxoi9+KCctmGkf+Ob+v5Q1q4XGVnLAq/ss4gl2jy5ubDDKyhwz9/1bq/WJpFn
         aDpTYCPDT165wLPk4MnQ6SzBWGiUDr72b3aNkjmMMByYafUNrp6Gf3T82opX9Z9Zxj7Z
         fokRg/BVyTCIq7K9mGyvAEgVBSbV0iwGBrPNY=
Received: by 10.114.194.1 with SMTP id r1mr1481180waf.149.1229643301414;
        Thu, 18 Dec 2008 15:35:01 -0800 (PST)
Received: by 10.114.80.15 with HTTP; Thu, 18 Dec 2008 15:35:01 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812181333150.14014@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103509>

On Thu, Dec 18, 2008, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> So instead of doing all the unpacking etc in parallel (with locking around
> it to serialize it), I'd suggest doing ll the unpacking serially since
> that isn't the problem anyway (and since you have to protect it with a
> lock anyway), and just have a "write out and free the buffer" phase that
> is done in the threads.

That's certainly a more elegant way to do it, but unless I'm missing
something, it requires rewriting a good bit of code.  The main reason I
went with the locking was to keep the patch as simple and non-intrusive
as possible.

> The alternative would be to actually do what your patch suggests, but
> actually try to make the code git SHA1 object handling be thread-safe. At
> that point, the ugly locking in write_entry() would go away, and you might
> actually improve performance on SMP thanks to doing the CPU part in
> parallel.

I started down that path at one point, and quickly got in over my head.
Making all that code thread safe looks like a big task to me.  From my
perspective, I get a ~350% speedup from this easy patch, and I might get
an additional 25% (blind guess) from a much more difficult patch.  It
didn't seem worth the effort.

James
