From: Sean Brandt <sean@fuzzymagic.com>
Subject: Re: Install on opensolaris 2008.05
Date: Sun, 17 Aug 2008 16:50:13 -0400
Message-ID: <1DC600E8-5D3A-44F7-994E-2B46254F192C@fuzzymagic.com>
References: <7a675f570808170555ie640c86jb5561cc6f7b68c73@mail.gmail.com> <20080817200321.GA17785@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 17 23:03:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUpP4-0006Ec-Jg
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 23:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbYHQUum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbYHQUul
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:50:41 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:63929 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYHQUul (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:50:41 -0400
Received: by py-out-1112.google.com with SMTP id p76so1490507pyb.10
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:50:40 -0700 (PDT)
Received: by 10.114.15.1 with SMTP id 1mr4411003wao.184.1219006240105;
        Sun, 17 Aug 2008 13:50:40 -0700 (PDT)
Received: from ?192.168.1.15? ( [68.48.33.158])
        by mx.google.com with ESMTPS id k21sm8133744waf.8.2008.08.17.13.50.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:50:38 -0700 (PDT)
In-Reply-To: <20080817200321.GA17785@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92664>

Ahh, looks like it's a grep problem, thanks. opensolaris grep doesn't  
like the options in the test.

By default it provides ggrep (gnu grep ) which does have the  
appropriate options.

After making some changes so that the right grep is available ( moving  
the old one out of the way and symlinking ggrep in place ) the tests  
proceed past the original point to here:


* passed all 6 test(s)
*** t0004-unwritable.sh ***
* expecting success:

         >file &&
         git add file &&
         test_tick &&
         git commit -m initial &&
         echo >file &&
         git add file


Created initial commit 1bd44cb: initial
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 file
*   ok 1: setup

* expecting success:

         (
                 chmod a-w .git/objects .git/objects/?? &&
                 test_must_fail git write-tree
         )
         status=$?
         chmod 775 .git/objects .git/objects/??
         (exit $status)


47d83249b05cf06491633be38ea8637c5b356acc
* FAIL 2: write-tree should notice unwritable repository


                 (
                         chmod a-w .git/objects .git/objects/?? &&
                         test_must_fail git write-tree
                 )
                 status=$?
                 chmod 775 .git/objects .git/objects/??
                 (exit $status)


gmake[1]: *** [t0004-unwritable.sh] Error 1
gmake[1]: Leaving directory `/root/git-1.5.6.5/t'
gmake: *** [test] Error 2




- Sean

On Aug 17, 2008, at 4:03 PM, Jeff King wrote:

> On Sun, Aug 17, 2008 at 08:55:57AM -0400, Sean Brandt wrote:
>
>> I'm installing on opensolaris 2008.05 and the tests fail in
>> t0002-gitfile.sh  ( test numbers 2 and 3 ) is this expected/ok?
>
> No, it's not expected nor ok (though it there is a reasonable chance  
> it
> is a portability problem in the test script, and not a real git
> breakage).
>
> What does
>
>  make test GIT_TEST_OPTS="-v -i"
>
> tell you?
>
>>                if ! grep -qe "Invalid gitfile format" .err
>
> Just a guess, but I think Solaris grep doesn't understand "-q".
>
> Does the patch below help?
>
> ---
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> index 4db4ac4..e4970fe 100755
> --- a/t/t0002-gitfile.sh
> +++ b/t/t0002-gitfile.sh
> @@ -32,7 +32,7 @@ test_expect_success 'bad setup: invalid .git file  
> format' '
> 		echo "git rev-parse accepted an invalid .git file"
> 		false
> 	fi &&
> -	if ! grep -qe "Invalid gitfile format" .err
> +	if ! grep -e "Invalid gitfile format" .err
> 	then
> 		echo "git rev-parse returned wrong error"
> 		false
> @@ -46,7 +46,7 @@ test_expect_success 'bad setup: invalid .git file  
> path' '
> 		echo "git rev-parse accepted an invalid .git file path"
> 		false
> 	fi &&
> -	if ! grep -qe "Not a git repository" .err
> +	if ! grep -e "Not a git repository" .err
> 	then
> 		echo "git rev-parse returned wrong error"
> 		false
