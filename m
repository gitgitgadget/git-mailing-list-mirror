From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 26/41] walker.c: use ref transaction for ref updates
Date: Wed, 28 May 2014 12:56:46 -0700
Message-ID: <20140528195645.GY12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-27-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 21:56:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpjy2-0004z1-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 21:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbaE1T4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 15:56:50 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60748 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbaE1T4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 15:56:49 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so11549430pab.17
        for <git@vger.kernel.org>; Wed, 28 May 2014 12:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kOMt5gZMjP2GN0icmkfcspkFUqO6dFv7Se2TRGA9T5g=;
        b=L0tx3abEPCN1PqahchDiMR7LvsvvOoXElVlgVzkFe2Y5XkDO75MhB6uTB7+l3OPQgW
         P1d8/OBjT7UtosTRIFt2Iag9xLybVpPds94s56Z7Ac/r+lz0S4olatAr3Fj9Hlm2DK4T
         nQAg36Na223ca5xMVUoYuzXEwLVhHWwao8qdPO72WVRXPnf3QMPv5osPNXqE9HATXQ14
         LZbwkcnUdTR4UeHrrnOFEpV6OAMBxP8JNwlPadoRsKiWLBSfEW32AcRIW1WnTrvTVL0N
         AGz9a505ElnGwB64ezM4gO1IrWjLKrVEkoM+we9s3YnJpHBkPPTi5/zDukUx8uHQ0Emw
         Nivw==
X-Received: by 10.68.194.134 with SMTP id hw6mr2328943pbc.49.1401307008783;
        Wed, 28 May 2014 12:56:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ox3sm29724608pbb.88.2014.05.28.12.56.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 12:56:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-27-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250324>

Ronnie Sahlberg wrote:

> Switch to using ref transactions in walker_fetch(). As part of the refactoring
> to use ref transactions we also fix a potential memory leak where in the
> original code if write_ref_sha1() would fail we would end up returning from
> the function without free()ing the msg string.

Sounds good.

> This changes the locking slightly for walker_fetch. Previously the code would
> lock all refs before writing them but now we do not lock the refs until the
> commit stage.

I don't think this actually changes locking in any significant way.
(Timing changes, but that's to be expected whenever code changes.)

The old contract was:

You run git http-fetch with refnames passed with "-w".  http-fetch
will overwrite the refs with their new values.

The new contract is:

You run git http-fetch with refnames passed with "-w".  http-fetch
will overwrite the refs with their new values.

What changed?

[...]
> Note that this function is only called when fetching from a remote HTTP
> repository onto the local (most of the time single-user) repository which
> likely means that the type of collissions that the previous locking would
> protect against and cause the fetch to fail for to be even more rare.

More to the point, while this function is used by 'git remote-http' (and
hence by "git fetch https://foo/bar/baz"), it is only used to fetch
objects by that code path.  The remote helper machinery handles the ref
updates on its own (and passes NULL as the write_ref argument to the
dumb walker).

[...]
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  walker.c | 56 +++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 23 deletions(-)

The code change looks good from a quick glance.

gcc 4.6.3 doesn't seem to be smart enough to notice that 'transaction'
is always initialized before it is used, so it (optionally) could be
worth initializing 'transition = NULL' to work around that.

So I think this just needs a simpler commit message and then it would be
good to go.

Jonathan
