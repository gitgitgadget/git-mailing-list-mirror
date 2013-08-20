From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] config: properly range-check integer values
Date: Tue, 20 Aug 2013 16:07:49 -0700
Message-ID: <20130820230749.GM4110@google.com>
References: <20130820223953.GA3429@sigill.intra.peff.net>
 <20130820224256.GA24766@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 21 01:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBv1p-0002db-UR
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 01:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884Ab3HTXHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 19:07:54 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:58161 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab3HTXHx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 19:07:53 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so976646pbc.9
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 16:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VK4o0TUzp5zx8CaSU+uU2CEpZzc2J79iDOtMJW77czA=;
        b=byN/Un6SokW15BzF9im1QzqmgbJlwS1cwdG9GRuCzeoFS8JldyGBZlAb97QWaoeKWq
         7cAQ/ZJAyDsp/gXNl7lmOdIm0YmWrV6k8TCaf/sUn85NbU5sxmUTCmpw1YoaSEYwORce
         y/Q4xFxXZ7NZfv2Iz/qG/V9ttJjRTaur+MfBwZywvGLPYIe+wzqFmzmUiaMfCfpn7qhb
         6r1CBwWkA8tQhPGNCWMrxkSaLVNn0ss8G5Trky8kOZ1KUJ2/vLLyuDbYfDTG1rJknt1x
         JWUHZL6YDQHTk2wrHj98ZbiCfBvG+cnrPqo9/LyOCyqtZg0+rwky8okm223YGh6eh31F
         ja5w==
X-Received: by 10.67.1.41 with SMTP id bd9mr6379300pad.116.1377040073077;
        Tue, 20 Aug 2013 16:07:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id oc10sm592468pbb.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 16:07:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130820224256.GA24766@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232668>

Jeff King wrote:

> I added a test. It would not fail on existing 32-bit systems, but would
> on existing LP64 systems. It will pass with the new code on both.
> However, it will fail on ILP64 systems (because their int is large, and
> can represent 3GB). I'm not sure if any such systems are in wide use
> (SPARC64?), but we would want a prereq in that case, I guess. I'm
> inclined to wait to see if it actually fails for anybody.

Yuck.

What will go wrong if "git config --int" starts returning numbers too
large to fit in an 'int'?  That can already happen if "git" and a
command that uses it are built for different ABIs (e.g., ILP64 git,
32-bit custom tool that calls git).

It's possible that what the test should be checking for is "either
returns a sane answer or fails" (which would pass regardless of ABI).
Something like:

	test_expect_success 'large integers do not confuse config --int' '
		git config giga.crash 3g &&
		test_might_fail git config --int giga.crash >actual &&
		echo 3221225472 >expect &&
		{
			test_cmp expect actual ||
			test_must_fail git config --int giga.crash
		}
	'

Sensible?
Jonathan
