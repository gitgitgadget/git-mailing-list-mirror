From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: Re: Suggestion on hashing
Date: Fri, 02 Dec 2011 17:50:21 -0800
Message-ID: <1322877021.1729.118.camel@yos>
References: <1322813319.4340.109.camel@yos>
	 <20111202175444.GB24093@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 03 02:50:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWekM-0005xX-Et
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 02:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab1LCBu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 20:50:29 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45364 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab1LCBu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 20:50:27 -0500
Received: by iage36 with SMTP id e36so5028341iag.19
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 17:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=J4hLVBuYw0RuKavlpbKK4sWSCnypKuV8eJXE44WZFws=;
        b=U8wYfpaqM4m8MoNIljoU18fcO3hKYtOeebBRytKuc4eB79r3DlIF+YkWCPjrEPwVaT
         izidBGBkuXKaaTiV+5iC+Ee1aYfM4KMN3Z2h6fvOHhdeTCwjYt89q3Qp7SGHI4+pQ9Qw
         u4xm+48l8kMA9poIeC7SdSXV7qt+pfVWQ7rak=
Received: by 10.231.8.143 with SMTP id h15mr160425ibh.94.1322877026300;
        Fri, 02 Dec 2011 17:50:26 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id l28sm41499002ibc.3.2011.12.02.17.50.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Dec 2011 17:50:24 -0800 (PST)
In-Reply-To: <20111202175444.GB24093@sigill.intra.peff.net>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186249>

On Fri, 2011-12-02 at 12:54 -0500, Jeff King wrote:
> On Fri, Dec 02, 2011 at 12:08:39AM -0800, Bill Zaumen wrote:

> I think your code is solving the wrong problem (or solving the right
> problem in a half-way manner). The only things that make sense to me
> are:
> 
>   1. Do nothing. SHA-1 is probably not broken yet, even by the NSA, and
>      even if it is, an attack is extremely expensive to mount. This may
>      change in the future, of course, but it will probably stay
>      expensive for a while.
> 
>   2. Decouple the object identifier and digest roles, but insert the
>      digest into newly created objects, so it can be part of the
>      signature chain. I described such a scheme in one of my replies to
>      you. It has some complexities, but has the bonus that we can build
>      directly on older history, preserving its sha1s.
> 
>   3. Replace SHA-1 with a more secure algorithm.

Suppose I make the digest pluggable, something I intended to do
eventually anyway?  Then you just use the existing SHA-1 as an
object identifier and the new digest in a signature chain?  What I
did was essentially to compute the new digest (using a CRC as the
trivial case) whenever an object's SHA-1 hash is computed, plus
using the new digest for low-cost collision checks.

Then you have everything needed to experiment with your second option.
I got the impression that Nguyen had some interest in that, but could
be mistaken.

The use is simple: if you have the SHA-1 hash of an object, you call
a function, currently named "has_sha1_file_crc" and it returns true if
a CRC is available, writing the hash into the buffer supplied as its
second argument.  You can do whatever you like with it.  If you want
a digest of digests, you just traverse a commit's tree, and call
has_sha1_file_crc whenever you want to look up a digest.  So, the API
is actually very simple if you just use the patch to quickly look up
the digest associated with a SHA-1 ID - everything else it does happens
automatically.

 
