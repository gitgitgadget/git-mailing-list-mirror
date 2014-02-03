From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH v2] userdiff: update Ada patterns
Date: 3 Feb 2014 13:33:01 -0500
Message-ID: <20140203183301.3642.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
To: ajohnson@redneon.com
X-From: git-owner@vger.kernel.org Mon Feb 03 19:33:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAOKT-0004qG-V4
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 19:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbaBCSdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 13:33:05 -0500
Received: from science.horizon.com ([71.41.210.146]:44641 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752559AbaBCSdE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 13:33:04 -0500
Received: (qmail 3643 invoked by uid 1000); 3 Feb 2014 13:33:01 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241446>

Looking at the grammar at http://www.adahome.com/rm95/rm9x-P.html
and http://www.adaic.org/resources/add_content/standards/05rm/html/RM-2-4.html
I see the following restrictions apply:

- A number must begin and end with a digit.  There must be at least one
  digit on either side of each underscore and decimal point.
- There may be at most one decimal point in a number.
- The base must be between 2 and 16, inclusive.

[-+]?(
        [0-9](_?[0-9])*([.][0-9](_?[0-9])*)?|
        ([2-9]|1[0-6])#[0-9a-fA-F](_?[0-9a-fA-F])*([.][0-9a-fA-F](_?[0-9a-fA-F])*)?#
)([eE][+-]?[0-9](_?[0-9])*)?

If you want a slightly smaller version, we can drop the "only one decimal
point" rule and get

[-+]?(
        [0-9]([._]?[0-9])*|
        ([2-9]|1[0-6])#[0-9a-fA-F]([._]?[0-9a-fA-F])*#
)([eE][+-]?[0-9](_?[0-9])*)?

Ideally, for a based number, the range of acceptable digits would
depend on the base.  Which is possible for a finite-state machine since
the number of bases is finite, but laeds to a bit of a state explosion.
Here's an approximation that separates bases 2-9 and 10-16:

[-+]?(
        [0-9](_?[0-9])*([.][0-9](_?[0-9])*)?|
        [2-9]#[0-8](_?[0-8])*([.][0-8](_?[0-8])*)?#|
        1[0-6]#[0-9a-fA-F](_?[0-9a-fA-F])*([.][0-9a-fA-F](_?[0-9a-fA-F])*)?#
)([eE][+-]?[0-9](_?[0-9])*)?

because I think that this is overdoing it:

[-+]?(
        [0-9](_?[0-9])*([.][0-9](_?[0-9])*)?|
        2#[0-1](_?[0-1])*([.][0-1](_?[0-1])*)?#|
        3#[0-2](_?[0-2])*([.][0-2](_?[0-2])*)?#|
        4#[0-3](_?[0-3])*([.][0-3](_?[0-3])*)?#|
        5#[0-4](_?[0-4])*([.][0-4](_?[0-4])*)?#|
        6#[0-5](_?[0-5])*([.][0-5](_?[0-5])*)?#|
        7#[0-5](_?[0-5])*([.][0-5](_?[0-5])*)?#|
        8#[0-7](_?[0-7])*([.][0-7](_?[0-7])*)?#|
        9#[0-8](_?[0-8])*([.][0-8](_?[0-8])*)?#|
        10#[0-9](_?[0-9])*([.][0-9](_?[0-9])*)?#|
        11#[0-9aA](_?[0-9aA])*([.][0-9aA](_?[0-9aA])*)?#|
        12#[0-9abAB](_?[0-9abAB])*([.][0-9abAB](_?[0-9abAB])*)?#|
        13#[0-9a-cA-C](_?[0-9a-cA-C])*([.][0-9a-cA-C](_?[0-9a-cA-C])*)?#|
        14#[0-9a-dA-D](_?[0-9a-dA-D])*([.][0-9a-dA-D](_?[0-9a-dA-D])*)?#|
        15#[0-9a-eA-E](_?[0-9a-eA-E])*([.][0-9a-eA-E](_?[0-9a-eA-E])*)?#|
        16#[0-9a-fA-F](_?[0-9a-fA-F])*([.][0-9a-fA-F](_?[0-9a-fA-F])*)?#|
)([eE][+-]?[0-9](_?[0-9])*)?

Another point is that Ada doesn't actually include leading + or -
signs in the syntax for "number", but rather makes them unary operators.
This means that spaces are allowed, and whether you want to include them
in the "number" pattern is a judgement call.
