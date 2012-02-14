From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Tue, 14 Feb 2012 14:34:31 -0600
Message-ID: <20120214203431.GB13210@burratino>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:34:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxP5P-0007xK-HH
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760831Ab2BNUeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:34:44 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65523 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757234Ab2BNUen (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:34:43 -0500
Received: by ghrr11 with SMTP id r11so300028ghr.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 12:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xtOx7rFpCXWdZjWa8x7lpLhYIEAnj2pxDKmTlpsIpT8=;
        b=EBWv09pa3DDKWpz+OcNQh5jvbpm4bfXTuwo8kmthlvM2GMUm7oE+gJ+DCLAvfaheQ5
         DXzj1r3SsBjGM3fOPD59L6AgZ/l+LiSsENuMTWqmMUtfMnKTFhNkn2Fx2EH1fM2dxQxH
         KGifcBwKcPmDFFert5jQVakcyNXJlOrK/HdmM=
Received: by 10.50.15.132 with SMTP id x4mr7043983igc.27.1329251681127;
        Tue, 14 Feb 2012 12:34:41 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gw1sm21322295igb.0.2012.02.14.12.34.40
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 12:34:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190753>

Hi again,

Felipe Contreras wrote:

> I sent both the fix and the tests. Another fix was applied, but we are still
> missing the tests.
>
> These are good before, and after the fix.

To summarize the previous discussion[1]: some people had comments, and
you seem to have found value in exactly none of them.  OK.  CC-ing
Peff, since he at least probably has looked over this code before.

By the way, the address you are using for Marius is out of date.

> Felipe Contreras (2):
>   t: mailmap: add 'git blame -e' tests

So that people don't destroy this test in later refactorings, I would
like to collect statements that we want the test to ensure remain
true.

Apparently the fix in f026358e ("mailmap: always return a plain mail
address from map_user()", 2012-02-05) was for the case of the name
changing and email address not changing due to mailmap mapping.  Most
callers use a separate buffer for the email address so there is room
to modify the name in place, but "git blame" keeps angle brackets in
the same buffer for no obvious reason I can see.  (Callers should
be able to add the brackets themselves instead of relying on
ci.author_mail to contain them, but that's a story for another day.)

Anyway, the existing tests for the returned email missed this since
it does not affect "git shortlog -e" but only "git blame -e".
Therefore this patch reuses the test data for shortlog -e and lets us
use it for blame, too.  It is easier to understand after the other
patch, IMHO.

This is _not_ meant as a more general test for the "git blame -e"
format (which would belong somewhere near t8008) as far as I can tell.
It is just checking that mailmap doesn't screw up.

>   t: mailmap: add simple name translation test

Before, I thought this might be a straightforward test for the bug
fixed by f026358e.  That didn't justify the patch that touches
several different test assertions.

In fact it seems to be intended to test the case addressed by f026358e
(name changing, email not) in various mailmap callers: "git shortlog -e",
"git log --pretty", "git blame".

Here's a reroll.

Enjoy,
Jonathan

Felipe Contreras (2):
  test: mailmap can change author name without changing email
  test: check that "git blame -e" uses mailmap correctly

 t/t4203-mailmap.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/189896
