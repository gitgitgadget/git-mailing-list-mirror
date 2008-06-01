From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitweb: use Git.pm, and use its parse_rev method for
 git_get_head_hash
Date: Sun, 01 Jun 2008 14:33:56 -0700
Message-ID: <7vy75oalh7.fsf@gitster.siamese.dyndns.org>
References: <20080531130450.GI18781@machine.or.cz>
 <1212243564-30109-1-git-send-email-LeWiemann@gmail.com>
 <7vzlq5bm32.fsf@gitster.siamese.dyndns.org> <4842C3F1.5000001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 23:35:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2vCd-0006L3-Oy
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 23:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYFAVeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 17:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbYFAVeF
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 17:34:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbYFAVeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 17:34:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 960343CD2;
	Sun,  1 Jun 2008 17:34:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B2F983CD0; Sun,  1 Jun 2008 17:33:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7383A870-3022-11DD-B393-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83469>

Lea Wiemann <lewiemann@gmail.com> writes:

> Junio C Hamano wrote:
>> With this on top of your parse_rev patch (I used v2 but I do not think v3
>> changes the situation in any way), you seem to have broken t9500.
>>
>> [...] I suspect that you are not using your own Git in the build tree in
>> your test, but an already installed one.
>
> That was indeed the case, thanks for pointing it out!
>
> However, after applying my two patches and your patch on a pristine
> current git.git clone, I still don't get an error...

If you applied the "this on top of yours" fix, you shouldn't have seen any
breakage.

The breakage was not about what you did in Git.pm, but about adding "use
Git" in gitweb.perl but without arranging it to find Git.pm (I do not have
any git installed in usual places on my machine, and I strip the directory
I keep my git installation out of my $PATH when running tests, to make
sure "make test" can bootstrap itself without first installing).

> How about putting this into test-lib.sh?  There are more tests (like
> my new Git.pm test suite) that will need it, so setting it up in a
> central place would probably more convenient and prevent future
> problems of this sort.

Sure, I think that would be sensible.

> If PERL5LIB already contains paths, can we just discard them, or
> should we preserve them?

It would be best to keep the existing one but make ours the first thing to
be found, so that we will be sure that we test the one we just built.

> Since perl/Makefile only copies Git.pm to blib/lib/Git.pm, we could
> also set the path to ../../perl, which would prevent us from
> accidentally running tests against an old version of Git.pm (because
> we haven't run cd perl; make before).  And perhaps add a comment to
> perl/Makefile about this, in case someone wants to change the build
> process in the future. Or is there some reason why this would be a bad
> idea?

I think it is a bad idea.  In principle we should be testing what we just
built and will install; even if currently the "building procedure" for
blib/lib/Git.pm may happen to be bit-for-bit copy of the original, that is
just by accident and not something we would want to rely on.
