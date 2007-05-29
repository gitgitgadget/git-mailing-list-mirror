From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add basic test-script for git-submodule
Date: Tue, 29 May 2007 00:10:22 -0700
Message-ID: <7v7iqs6r6p.fsf@assigned-by-dhcp.cox.net>
References: <11802980992216-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 09:10:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsvqg-0003Eo-39
	for gcvg-git@gmane.org; Tue, 29 May 2007 09:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbXE2HKY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 03:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbXE2HKY
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 03:10:24 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56595 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbXE2HKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 03:10:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070529071023.QMDD22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 29 May 2007 03:10:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4vAN1X00K1kojtg0000000; Tue, 29 May 2007 03:10:23 -0400
In-Reply-To: <11802980992216-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Sun, 27 May 2007 22:34:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Lars Hjemli <hjemli@gmail.com> writes:

> +# create a submodule repository
> +mkdir lib && cd lib
> +git-init >/dev/null
> +echo a >a && git-add a && git-commit -q -m "submodule commit 1"
> +git-tag -a -m "rev-1" rev-1
> +rev1=$(git-rev-parse HEAD)
> +cd ..
> +
> +# add submodule and other files to super repo
> +echo a >a && echo z >z
> +git-add a lib z && git-commit -q -m "super commit 1"
> +
> +# move submodule to another location, register repo url in .gitmodules
> +mv lib .subrepo
> +GIT_CONFIG=.gitmodules git-config module.lib.url ./.subrepo

We typically try to catch malfunction even while setting up the test case.

> +test_expect_success 'status is "missing"' \
> +	'git-submodule status | grep "^-$rev1"'
> +
> +# make sure 'init' will not overwrite a regular file
> +touch lib
> +test_expect_failure 'init fails when path is used by a file' \
> +	'git-submodule init'

I am guilty for introducing "expect-failure", but it is usually
a mistake to use it unless you are testing something very trivial.

For example, for this case, you would want to make sure the
command "git-submodule init" exits with non-zero status, but
also you would want to make sure that it does not disturb the
existing file "lib".  You might also want to see if the command
gives the right error message (or status code) as well, although
typically the wording of error message is subject to change, so
we tend to try not to be too strict about it.

In any case, I would probably write this part of the code like
this:

        test_expect_success 'init fails when path is used by a file' '

                echo hello >lib &&
                if git-submodule init
                then
                        echo "Oops, should have failed"
                        false
                elif test -f lib && test "$(cat lib)" = hello
                then		
                        : happy
                else
                        echo "Oops, failed but lib file was molested"
                        false
                fi
        '

Later when somebody tries to improve git-submodule and botches,
he can run the test with "-i -v" and observe which "Oops" comes
out to see why the test failed -- it would give him a clue on
how he broke it.
