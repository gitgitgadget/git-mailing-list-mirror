From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: latest clone/pull of git.git problems with setlinebuf.
Date: Wed, 3 Sep 2008 23:39:55 -0600
Message-ID: <alpine.LNX.1.10.0809032337480.26028@suse104.zenez.com>
References: <alpine.LNX.1.10.0809031858570.12887@suse104.zenez.com> <7vljy88u0m.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0809032157200.21167@suse104.zenez.com> <7vhc8w8rme.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0809032325080.25336@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 07:41:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb7aZ-00048r-6p
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 07:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbYIDFj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 01:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbYIDFj5
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 01:39:57 -0400
Received: from suse104.zenez.com ([198.60.105.164]:26315 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbYIDFj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 01:39:56 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 7C00FA7C93D; Wed,  3 Sep 2008 23:39:55 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 6792EA7C939;
	Wed,  3 Sep 2008 23:39:55 -0600 (MDT)
In-Reply-To: <alpine.LNX.1.10.0809032325080.25336@suse104.zenez.com>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94897>

On Wed, 3 Sep 2008, Boyd Lynn Gerber wrote:
> On Wed, 3 Sep 2008, Junio C Hamano wrote:
>> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>>> On Wed, 3 Sep 2008, Junio C Hamano wrote:
>>>> Ah, ok.  I should have noticed that setlinebuf() was outside POSIX (it is
>>>> not usable on older BSDs either).
>>>> 
>>>> Let's see if we can replace it with setvbuf() which is POSIX.
>>> 
>>> This fixes the problem. on both OS's.
>> 
>> By the way, have you actually exercised the codepath, or does your above
>> "fixes" mean "compiles"?
>> 
>> I knew it would compile on a system with POSIX setvbuf(), but I was unsure 
>> about the size argument.  I know for glibc giving <NULL, 0> would be 
>> equivalent to setlinebuf(), but POSIX itself leaves what exactly happens to 
>> the size argument quite vague, saying only "otherwise [when buf is a null 
>> pointer], size may determine the size of a buffer allocated by the 
>> setvbuf() function."  Does size=0 mean it allocates very little, and while 
>> it tries to line buffer the output, because the buffer is so small that it 
>> fails to buffer an entire line causing early flushing of the stream?
>
> I only compiled it.  I am debuging some test errors.  I did a gmake test
>
> This is the test that fails.  Everything before it passes.

...
*   still broken 4: pretend we have a known breakage
*   FIXED 5: pretend we have fixed a known breakage
...

> *   ok 41: very long name in the index handled sanely
> * fixed 1 known breakage(s)
> * still have 1 known breakage(s)
> * passed all remaining 40 test(s)
> *** t0001-init.sh ***
> ...
> *   ok 9: GIT_DIR & GIT_WORK_TREE (2)
> * FAIL 10: reinit
>
>
>                (
>                        unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG
>
>                        mkdir again &&
>                        cd again &&
>                        git init >out1 2>err1 &&
>                        git init >out2 2>err2
>                ) &&
>                grep "Initialized empty" again/out1 &&
>                grep "Reinitialized existing" again/out2 &&
>                >again/empty &&
>                test_cmp again/empty again/err1 &&
>                test_cmp again/empty again/err2
>
> * FAIL 11: init with --template
>
>                mkdir template-source &&
>                echo content >template-source/file &&
>                (
>                        mkdir template-custom &&
>                        cd template-custom &&
>                        git init --template=../template-source
>                ) &&
>                test_cmp template-source/file template-custom/.git/file
>
> *   ok 12: init with --template (blank)
> * failed 2 among 12 test(s)
> gmake[2]: *** [t0001-init.sh] Error 1

I have now inclulded everything in gmake test that was not an OK.  I hope 
this answers your questions.

What I should have said is that I have not used it outside of gmake and 
gmake test.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
