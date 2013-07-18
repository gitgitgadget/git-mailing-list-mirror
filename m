From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/2] git-svn: allow git-svn fetching to work using serf
Date: Thu, 18 Jul 2013 12:29:43 -0700
Message-ID: <20130718192943.GT14690@google.com>
References: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79>
 <ac83ba2812aee248275a0760bb39a00@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Rothenberger <daveroth@acm.org>,
	Eric Wong <normalperson@yhbt.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 21:29:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uztth-0000TS-7b
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 21:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759120Ab3GRT3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 15:29:48 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32830 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758908Ab3GRT3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 15:29:47 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so3580783pab.41
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tzJjvOAD6EfnhQtrVhieQnG7I7hR18w3tCJICjgSwAE=;
        b=V7Yp7DhOwdeKpqdZm+WsqHK7wRAV6Oe8+VlYzCWvEIZ6yWuXoc/G2YECrmBm1zv3G8
         C87VEMQD/aFB2vIFsqa4jwbkda/AaWWUSP97qDO5grIqpBEI7nyKuTzeuGEMX6g/zGlU
         aOoxxCkedJ39UfspAjL3t4d1fdOoq7/6o7uD0YbZ8DiXv4WIaJQ2o6wj7/64dEMLrBEy
         BS8IbH5xiGP00gvmSy/yNtmBqraqYfnYkkI/F/jMX/BQcE52OofAVlSmYuyxzPvkmmu5
         skK1HBpbt7IbMGqcl2/lEnTcE0pUQbIjtfYlrixSV0k602OpltIWArtf9Taog/xsaIEh
         tzCQ==
X-Received: by 10.68.252.169 with SMTP id zt9mr314629pbc.87.1374175787280;
        Thu, 18 Jul 2013 12:29:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bb1sm5435911pbc.10.2013.07.18.12.29.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 12:29:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ac83ba2812aee248275a0760bb39a00@f74d39fa044aa309eaea14b9f57fe79>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230728>

(cc-ing Eric Wong, who maintains git-svn and knows both it and
the libsvn perl bindings much better than I do)
Kyle J. McKay wrote:

> David Rothenberger <daveroth@acm.org> has determined the cause to
> be that ra_serf does not drive the delta editor in a depth-first
> manner [...]. Instead, the calls come in this order:

Thanks.

Sorry to nitpick, but the problem is not depth-first versus
breadth-first versus random.  Blaming the traversal order makes this
completely confusing.  The actual problem is that the driver asks us
to keep multiple files open at a time.

The approach taken in this patch would be racy if the driver calls us
multiple times concurrently (since temp_acquire can fail).  I believe
it doesn't but haven't checked.

The approach is generally good.  I wanted to propose some clearer
documentation for temp_is_locked() but didn't end up finding a moment
for it, so... meh.  I'll be happy to help get the details right if
someone else finds time for that (hint, hint).

Hope that helps,
Jonathan
