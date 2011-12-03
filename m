From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: Re: Suggestion on hashing
Date: Fri, 02 Dec 2011 16:48:43 -0800
Message-ID: <1322873323.1729.91.camel@yos>
References: <1322813319.4340.109.camel@yos>
	 <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 03 01:58:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWdvy-0005oJ-08
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 01:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab1LCAsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 19:48:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49105 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab1LCAst (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 19:48:49 -0500
Received: by iage36 with SMTP id e36so4959550iag.19
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 16:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=hcCEjrlBk1G2lM9FE0WbCqmTlFP9ASfbMtzN28pH9Qc=;
        b=jEbckhKqJb5paowAhTYXbSFQgj5PK7vPqdbb7HxwdqCT3f6AUfdU4HQBtCDCB2+O/J
         J6wAKmZOqEKkh8YEhwbtWOOV3WqdrubMNK+HWUYKvYAkYc9aOacCRiHQWBawr4obXYFc
         R2MVCnnhLRoy3V8gcxF9u3eTYi7uOFK/u1TrM=
Received: by 10.50.216.167 with SMTP id or7mr650582igc.22.1322873328820;
        Fri, 02 Dec 2011 16:48:48 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id v18sm40912797ibh.4.2011.12.02.16.48.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Dec 2011 16:48:47 -0800 (PST)
In-Reply-To: <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186248>

On Fri, 2011-12-02 at 21:22 +0700, Nguyen Thai Ngoc Duy wrote:
> (I'm not sure why you dropped git@vger. I see nothing private here so
> I bring git@vger back)

Oh, I just didn't want to flood the mailing list with too much on
one topic and figured we could summarize a discussion at some point
and post that, but if you'd rather keep it all on the list, that's 
fine with me.

I can split the code into a series of smaller patches - smaller than
the set of three I sent, but I'm not sure if the test scripts will work
with all of the intermediate patches if I do that.

I can also make the digest (current a CRC) pluggable.  Then you can try
different digests as an experiment and see how that affects performance.
My implementation uses the CRC or new digests only when
the object database is being modified or explicitly verified. Basically
the code provides memoization for an additional hash function, used
for whatever purpose you desire.

If you want to put a digest of message digests into a commit message,
you can do that fairly quickly as one level of digests has been
precomputed. I think Jeff's or your suggestion of putting an additional
digest in the commit message is a good idea.  If you want to experiment
with such changes, the code would provide a reasonable start on that.

So, I guess I should make those changes - pluggable digest and 
splitting the patches further.

> You'd need to convince git maintainer this is worth doing first,
> before talking how big the changes are ;-)

I'd guess there are several issues: the amount of code, how complex
the changes are, what the performance impacts are, whether the changes
are backwards compatible, and what you get for the effort.

As a start on the last question, "what you get," aside from some extra
checking to detect problems, if you modify commit messages and signed
tags to use better digests, you can make a stronger argument regarding
authentication.  For example, suppose you have a project in which your
code is dual-licensed - GPL for free use but a separate license if the
code is used in a proprietary product and there is a legal dispute,
using a better digest than SHA-1 would have some advantages - when they
start calling in expert witnesses, one side will bring in a security
expert who will testify that SHA-1 is too weak to be used for
authentication, citing government publications such
as http://csrc.nist.gov/groups/ST/hash/statement.html as evidence. The
jury is not going to consist of people who can fully understand the
details, so being able to say that git's authentication matches current
best practices would be an additional reason to use git.
