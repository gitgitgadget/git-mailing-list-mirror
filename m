From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] t7400: fix bogus test failure with symlinked trash
Date: Sat, 30 Jul 2011 17:44:21 +0200
Message-ID: <4E3426D5.4060105@web.de>
References: <20110730003609.GA6089@sigill.intra.peff.net> <4E33DFD6.9050709@web.de> <20110730150554.GA5355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 30 17:46:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnBkQ-0003LH-16
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 17:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729Ab1G3PoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 11:44:24 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57883 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab1G3PoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 11:44:23 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id BBAC11A75632A;
	Sat, 30 Jul 2011 17:44:21 +0200 (CEST)
Received: from [93.246.57.12] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QnBi9-0004tV-00; Sat, 30 Jul 2011 17:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110730150554.GA5355@sigill.intra.peff.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+nuPk/4rjMzTC1NbOsGpxe4kL3wMvr9u+Qvrl/
	jIZdKRxY117Puucbzw25490BGWV6mPMRGEaXOR4dDqp0hZvSt3
	jCDZqyCxIfLJ0A/QuLxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178206>

Am 30.07.2011 17:05, schrieb Jeff King:
> On Sat, Jul 30, 2011 at 12:41:26PM +0200, Jens Lehmann wrote:
> 
>> Am 30.07.2011 02:36, schrieb Jeff King:
>>> This feels a little funny, because we are probably using the same
>>> "convert relative to absolute" code to generate our expected value, as
>>> well as in the test itself. So any bug in that code is likely to be
>>> masked. But this test isn't really about checking the absolute path
>>> code, but rather making sure that it is invoked properly.
>>
>> While the patch itself is good (apart from using backticks, I think
>> a "$()" should be used there), I share your concerns about loosing
>> an opportunity to test git functionality against the real world.
>>
>> What about doing the following instead?
>>
>> submodurl=$(cd "$TRASH_DIRECTORY"; pwd -P)
>>
>> (That pattern is already used in t/t0000-basic.sh)
> 
> That's fine by me. I assumed we didn't have any portable external tool
> we could rely on, but if we have been using "pwd -P" in t0000, it's
> probably OK.
> 
> So how about:

Thanks! Unless there is a reason not to use "pwd -P" this is
Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

> -- >8 --
> Subject: [PATCH] t7400: fix bogus test failure with symlinked trash
> 
> One of the tests in t7400 fails if the trash directory has a
> symlink anywhere in its path. E.g.:
> 
>   $ mkdir /tmp/git-test
>   $ mkdir /tmp/git-test/real
>   $ ln -s real /tmp/git-test/link
> 
>   $ ./t7400-submodule-basic --root=/tmp/git-test/real
>   ...
>   # passed all 44 test(s)
> 
>   $ ./t7400-submodule-basic --root=/tmp/git-test/link
>   ...
>   not ok - 41 use superproject as upstream when path is relative and no url is set there
> 
> The failing test does:
> 
>   git submodule add ../repo relative &&
>   ...
>   git submodule sync relative &&
>   test "$(git config submodule.relative.url)" = "$submodurl/repo"
> 
> where $submodurl comes from the $TRASH_DIRECTORY the user
> gave us. However, git will resolve symlinks when converting
> the relative path into an absolute one, leading them to be
> textually different (even though they point to the same
> directory).
> 
> Fix this by asking pwd to canonicalize the name of the trash
> directory for us.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t7400-submodule-basic.sh |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 5afe6cc..14dc927 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -47,8 +47,10 @@ test_expect_success 'setup - repository to add submodules to' '
>  '
>  
>  # The 'submodule add' tests need some repository to add as a submodule.
> -# The trash directory is a good one as any.
> -submodurl=$TRASH_DIRECTORY
> +# The trash directory is a good one as any. We need to canonicalize
> +# the name, though, as some tests compare it to the absolute path git
> +# generates, which will expand symbolic links.
> +submodurl=$(pwd -P)
>  
>  listbranches() {
>  	git for-each-ref --format='%(refname)' 'refs/heads/*'
