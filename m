From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Tue, 06 Mar 2012 08:40:42 -0600
Message-ID: <87mx7tiyhh.fsf@smith.obbligato.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
	<1330903437-31386-2-git-send-email-greened@obbligato.org>
	<87aa3vzdoc.fsf@thomas.inf.ethz.ch>
	<nngy5re29zn.fsf@transit.us.cray.com>
	<878vje86cy.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David A. Greene" <dag@cray.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 15:44:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4vcM-0002Bt-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 15:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030797Ab2CFOnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 09:43:53 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:55456 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030784Ab2CFOnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 09:43:52 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1S4vdY-0000Sn-IR; Tue, 06 Mar 2012 08:45:14 -0600
In-Reply-To: <878vje86cy.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Tue, 6 Mar 2012 09:46:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Thomas Rast <trast@inf.ethz.ch> writes: >>> I'm a bit curious:
    why isn't it enough to spell that path >>> $GIT_BUILD_DIR/t/valgrind instead
    of making it fully configurable? >> >> For the same reason that TEST_DIRECTORY
    is different and unrelated from >> GIT_BUILD_DIR. It's my understanding that
    GIT_BUILD_DIR could end up >> being somewhere compeltely unrelated to where
    TOP_SRC/t/valgrind is. >> At least that's why I introduced a new parameter.
    > > I'm just worried that for such a fringe use-case, the maintainer of the
 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192354>

Thomas Rast <trast@inf.ethz.ch> writes:

>>> I'm a bit curious: why isn't it enough to spell that path
>>> $GIT_BUILD_DIR/t/valgrind instead of making it fully configurable?
>>
>> For the same reason that TEST_DIRECTORY is different and unrelated from
>> GIT_BUILD_DIR.  It's my understanding that GIT_BUILD_DIR could end up
>> being somewhere compeltely unrelated to where TOP_SRC/t/valgrind is.
>> At least that's why I introduced a new parameter.
>
> I'm just worried that for such a fringe use-case, the maintainer of the
> out-of-tree tests will never notice that he missed to customize *this*
> particular parameter.  So I'd rather have it spelled in terms of the
> existing two (?).

I understand your concern.  Perhaps it could be mitigated with some
"HOWTO" comments at the top of the script.  I'm nervous about basing the
value on other variables because that's what limited the script to such
a narrow scope in the first place.

> Don't we, right now, get stuff as follows:
>
>   item                   path
>   --------------------------------------------
>   test-lib.sh            $TEST_DIRECTORY

Right now, yes, but it breaks for out-of-tree tests.  In the out-of-tree
case, TEST_DIRECTORY doesn't contain test-lib.sh.  For exmaple, in
t7900-subtree.sh, I do this:

. ../../../t/test-lib.sh

because TEST_DIRECTORY is set to some directory under contrib/subtree.

>   git                    $GIT_BUILD_DIR/bin-wrappers

I think so.

>   valgrind.sh            $TEST_DIRECTORY/valgrind

That's what it is now and it's wrong for out-of-tree tests.

>   git (with --valgrind)  $TEST_DIRECTORY/valgrind/bin

Yep.  This is ok.

> You are saying this must change to an entirely new path
>
>   valgrind.sh            $GIT_VALGRIND_TOOLS
>   git (with --valgrind)  $GIT_VALGRIND_TOOLS/bin

The first, yes.  The second, no.  We can leave that alone.

> but what's wrong with simply
>
>   valgrind.sh            $GIT_BUILD_DIR/t/valgrind
>   git (with --valgrind)  $TEST_DIRECTORY/valgrind/bin

These are two separate issues.

GIT_BUILD_DIR may not be anywhere within the source tree, right?  If so,
t/valgrind may not have any relation whatsoever to GIT_BUILD_DIR.  Hence
GIT_VALGRIND_TOOLS.

The second part is correct.  test-lib.sh sets it up that way (~line 983)
and it works fine for out-of-tree tests.

> In the common case of t/, these just map to what we had before.  In the
> out-of-tree case, we'd create valgrind/bin in the test directory for the
> *temporary* stuff, and still look for the wrapping valgrind.sh in the
> git tree.

Putting valgrind/bin in the test directory is fine.  There's no change
there.  It's this looking for the wrapping valgrind.sh that fails in the
current scheme.  We cannot rely on GIT_BUILD_DIR to find it as noted
above.

                              -Dave
