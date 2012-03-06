From: "David A. Greene" <dag@cray.com>
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Tue, 6 Mar 2012 17:00:19 -0600
Message-ID: <87mx7te3ng.fsf@smith.obbligato.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
	<1330903437-31386-2-git-send-email-greened@obbligato.org>
	<87aa3vzdoc.fsf@thomas.inf.ethz.ch>
	<nngy5re29zn.fsf@transit.us.cray.com>
	<878vje86cy.fsf@thomas.inf.ethz.ch>
	<87mx7tiyhh.fsf@smith.obbligato.org>
	<7vaa3ttvj1.fsf@alter.siamese.dyndns.org>
	<87hay1fkfk.fsf@smith.obbligato.org>
	<7vboo9qskb.fsf@alter.siamese.dyndns.org>
	<7v7gyxqrty.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, "David A. Greene" <dag@cray.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:03:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S53Pk-0000Eb-T7
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 00:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031516Ab2CFXDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 18:03:16 -0500
Received: from exprod6og114.obsmtp.com ([64.18.1.33]:41360 "EHLO
	exprod6og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031500Ab2CFXDN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 18:03:13 -0500
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob114.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT1aXropaGpK4KkyXX9FGDZr6N5nyxLWp@postini.com; Tue, 06 Mar 2012 15:03:13 PST
Received: from smith.obbligato.org (192.168.233.145) by
 CFWEX01.americas.cray.com (172.30.88.25) with Microsoft SMTP Server (TLS) id
 14.1.355.2; Tue, 6 Mar 2012 17:03:09 -0600
In-Reply-To: <7v7gyxqrty.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 6 Mar 2012 14:37:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192412>

Junio C Hamano <gitster@pobox.com> writes:

> that says "As a side benefit this change also makes it easy for us
> to move the t/*.sh tests into subdirectories if we ever want to do
> that."
>
> This expects that an out-of-tree test script is expected to set
> TEST_DIRECTORY before dot-sourcing test-lib.sh, e.g.
>
> 	#!/bin/sh
> 	TEST_DIRECTORY=/srv/project/git/git.git/t
>         test_description='an out-of-tree test'
>         . "$TEST_DIRECTORY/test-lib.sh"

Hmm...I think I missed this part when I originally tried this.  I
originally tried to set TEST_DIRECTORY in the environment and I
misunderstood its role.

> which in turn lets the test framework to learn GIT_BUILD_DIR.  From
> there, 'git' will be found in GIT_BUILD_DIR/bin-wrappers and the
> valgrind variants are found in a similar way.

Ok, I see.  So TEST_DIRECTORY is supposed to point to the "official"
location of git's tests and testing support files.  That wasn't clear to
me.

> One thing that is potentially missing is a way for such an out-of-tree
> test scripts to ship with supporting material in a separate file,
> relative to the test script.  The in-tree t/t4013-diff-various.sh
> has its test vectors kept in t/t4013/ directory and finds them by
> doing
>
> 	expect="$TEST_DIRECTORY/t4013/diff.$test"

Right.  I did not run into this issue but I can see how others might.

> This is because the working directory after test-lib comes back to
> us may not be "trash" directory under TEST_DIRECTORY, and ../t4013/
> is not the right way to find it.  If an out-of-tree test t9999 wants
> to do something similar, it needs to do something like:
>
> 	#!/bin/sh
>         HERE=$(PWD)
> 	TEST_DIRECTORY=/srv/project/git/git.git/t
>         test_description='an out-of-tree test'
>         . "$TEST_DIRECTORY/test-lib.sh"
>
> and find it relative to $HERE, e.g. "$HERE/../t9999/diff.$test"

Ahh...

> Of course, it would be nice to use a name better than $HERE for such
> a purpose ;-)

I think naming is a big issue here.  Perhaps TEST_DIRECTORY needs a
better name, something like GIT_TEST_SUPPORT or such?

So before you apply my patches let me try to restructure the git-subtree
tests with this newly provided insight and see if I can get it to work.

Thanks, Junio!

                           -Dave
