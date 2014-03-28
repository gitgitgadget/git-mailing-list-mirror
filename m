From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 09/10] t4213: test --function-name option
Date: Fri, 28 Mar 2014 08:25:45 +0100
Message-ID: <533523F9.2000108@viscovery.net>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu> <4eb91822043e730bf8a47f12a9129d02f6fc135d.1395942768.git.davidad@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, l.s.r@web.de,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 28 08:25:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTRAo-0001Gl-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 08:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbaC1HZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 03:25:50 -0400
Received: from so.liwest.at ([212.33.55.23]:48032 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaC1HZt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 03:25:49 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WTRAg-0005Q2-FB; Fri, 28 Mar 2014 08:25:46 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 31BC716613;
	Fri, 28 Mar 2014 08:25:46 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <4eb91822043e730bf8a47f12a9129d02f6fc135d.1395942768.git.davidad@alum.mit.edu>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245367>

Am 3/27/2014 19:50, schrieb David A. Dalrymple (and Bhushan G. Lodha):
> From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>
> 
> This test builds a sample C file, adding and removing functions, and
> checks that the right commits are filtered by --function-name matching.

This is probably the most important patch in your series as it documents
the expected behavior. Unfortunately, I find its clarity very lacking. :(

This new feature uses the userdiff driver, IIUC. Does it do so in all
respects? In particular, does it also evaluate the negative patterns? For
example, when there is a label in the code, is it not mistaken as the
beginning of a function? A test for this case would be very instructive.

Furthermore, consider a patch for a change at the very beginning of a
function. Then the function name would appear in the pre-context of the
hunk, but the hunk header would show the function before the one with the
change. Would such a change confuse your implementation? I guess not.
Again, a test case would remove any doubts.

Is it possible to search for a change that is before any functions? It
would be useful to enumerate commits that change #include lines.

> 
> Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
> ---
>  t/t4213-log-function-name.sh | 73 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100755 t/t4213-log-function-name.sh
> 
> diff --git a/t/t4213-log-function-name.sh b/t/t4213-log-function-name.sh
> new file mode 100755
> index 0000000..1243ce5
> --- /dev/null
> +++ b/t/t4213-log-function-name.sh
> @@ -0,0 +1,73 @@
> +#!/bin/sh
> +
> +test_description='log --function-name'
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	echo "* diff=cpp" > .gitattributes
> +
> +	>file &&
> +	git add file &&
> +	test_tick &&
> +	git commit -m initial &&
> +
> +	printf "int main(){\n\treturn 0;\n}\n" >> file &&
> +	test_tick &&
> +	git commit -am second

Broken && chain here and later as well. Please be careful.

> +
> +	printf "void newfunc(){\n\treturn;\n}\n" >> file &&
> +	test_tick &&
> +	git commit -am third

	git commit -am "append a function" &&

> +
> +	printf "void newfunc2(){\n\treturn;\n}\n" | cat - file > temp &&
> +	mv temp file &&
> +	test_tick &&
> +	git commit -am fourth

	git commit -am "prepend a function" &&

etc. You get the picture.

> +
> +	printf "void newfunc3(){\n\treturn;\n}\n" | cat - file > temp &&
> +	mv temp file &&
> +	test_tick &&
> +	git commit -am fifth
> +
> +	sed -i -e "s/void newfunc2/void newfunc4/" file &&
> +	test_tick &&
> +	git commit -am sixth
> +'
> +
> +test_expect_success 'log --function-name=main' '

test_expect_success 'log --function-name finds a function with a change' '

> +	git log --function-name=main >actual &&
> +	git log --grep=second >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --function-name "newfunc\W"' '

test_expect_success 'log --function-name with extended regexp' '

etc. You get the picture.

> +	git log --function-name "newfunc\W" >actual &&
> +	git log --grep=third >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --function-name "newfunc2"' '
> +	git log --function-name newfunc2 >actual &&
> +	git log -E --grep "sixth|fourth" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --function-name "newfunc3"' '
> +	git log --function-name newfunc3 >actual &&
> +	git log --grep=fifth >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --function-name "newfunc4"' '
> +	git log --function-name newfunc4 >actual &&
> +	git log --grep=sixth >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --function-name "newfunc"' '
> +	git log --function-name newfunc >actual &&
> +	git log -E --grep "third|fourth|fifth|sixth" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> 
