From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add some fancy colors in the test library when terminal
 supports it.
Date: Mon, 22 Oct 2007 10:53:36 +0200
Message-ID: <471C6510.8010300@viscovery.net>
References: <20071022081341.GC32763@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 10:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijt2k-000245-GY
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 10:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbXJVIxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 04:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbXJVIxk
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 04:53:40 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:41114 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbXJVIxj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 04:53:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ijt2H-0001c8-L1; Mon, 22 Oct 2007 10:53:21 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 100866B7; Mon, 22 Oct 2007 10:53:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071022081341.GC32763@artemis.corp>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61974>

Pierre Habouzit schrieb:
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
> 
> Maybe this is just me, but I don't find the output of the test-suite
> easy to watch while scrolling. This puts some colors in proper places.
> 
>   * end-test summaries are in green or red depending on the sucess of
>     the tests.
>   * errors are in red.
>   * skipped tests and other things that tests `say` are in brown (now
>     you can _see_ that your testsuite skips some tests on purpose, I
>     only noticed recently that I missed part of the environment for
>     proper testing).
> 
> I'm not 100% sure the test to see if terminal supports color is correct, and
> people using emacs shell buffer or alike tools may have better ideas on how to
> make it.
> 
> and yes, I know that it "depends" upon tput, but if tput isn't available, the
>     [ "x$TERM" != "xdumb" ] && tput hpa 60 >/dev/null 2>&1 && tput setaf 1 >/dev/null 2>&1
> expression will fail, and color will be disabled.
> 
>  t/test-lib.sh |   32 ++++++++++++++++++++++----------
>  1 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index cc1253c..c6521c0 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -59,14 +59,24 @@ esac
>  # '
>  # . ./test-lib.sh
>  
> +[ "x$TERM" != "xdumb" ] && tput hpa 60 >/dev/null 2>&1 && tput setaf 1 >/dev/null 2>&1
> +nocolor=$?

test "x$TERM" != "xdumb" &&
	tput hpa 60 >/dev/null 2>&1 &&
	tput setaf 1 >/dev/null 2>&1 &&
	color=t

BTW, doesn't tput fail if stdout/stderr is not a terminal, like above?

> +
> +say_color () {
> +	[ "$nocolor" = 0 ] &&  [ "$1" != '-1' ] && tput setaf "$1"
> +	shift
> +	echo "* $*"
> +	tput op
> +}

What if tput is not available, like on Windows? How about this (at the end 
of the file, so it can obey --no-color):

if test "$color"; then
	say_color () {
		test "$1" != '-1' && tput setaf "$1"
		shift
		echo "* $*"
		tput op
	}
else
	say_color() {
		shift
		echo "* $*"
	}
fi

> +	--no-color)
> +	    nocolor=1; shift ;;

	    color=; shift ;;

-- Hannes "We don't need no double negation"
