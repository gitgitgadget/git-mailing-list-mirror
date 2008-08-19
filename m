From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] test-lib.sh: work around ksh's trap shortcomings
Date: Mon, 18 Aug 2008 19:06:38 -0500
Message-ID: <ZqhiQsjr6llIQS0q8PP8utINgu-mnafhFeUc119IDyjsaBEePvtv9g@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil> <gPlIc7E6mNDrXE6mwaHXFoin7rDpLmjvuzlhJfCp-YmuyVK3pEzqNA@cipher.nrlssc.navy.mil> <7vbpzplw9o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:07:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVElK-0003E2-0r
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYHSAGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbYHSAGq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:06:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41672 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbYHSAGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:06:45 -0400
Received: by mail.nrlssc.navy.mil id m7J06dW2031606; Mon, 18 Aug 2008 19:06:39 -0500
In-Reply-To: <7vbpzplw9o.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Aug 2008 00:06:38.0831 (UTC) FILETIME=[739BC7F0:01C9018F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92783>


I will try your suggestions.

I also hope you noticed that these patches followed an FYI message
and were not meant for direct inclusion. I hope you noticed that
since I don't want you to waste your time. Maybe I should have
put FYI in the [PATCH] string.

That being said, I (as always) appreciate the comments.

-brandon


Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> In ksh, if trap is called within a function with 0 or EXIT as its signal,
>> then the trap will be executed at the time the function returns. This
>> causes a problem in the test functions since 'trap - exit' is called
>> within the test_done function
> 
> Your alias test_done that calls function test_done look ugly and confusing
> beyond words.  Perhaps test_done() can instead set a global variable and
> die() can notice it instead, like this?  I haven't bothered to change the
> other "trap - exit" but I think you got the idea...
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 11c0275..010bfda 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -156,10 +156,16 @@ test_count=0
>  test_fixed=0
>  test_broken=0
>  test_success=0
> +test_exit_ok=0
>  
>  die () {
> -	echo >&5 "FATAL: Unexpected exit with code $?"
> -	exit 1
> +	status=$?
> +	if test 1 != $test_exit_ok
> +	then
> +		echo >&5 "FATAL: Unexpected exit with code $status"
> +		exit 1
> +	fi
> +	exit $status
>  }
>  
>  trap 'die' exit
> @@ -415,6 +421,7 @@ test_create_repo () {
>  }
>  
>  test_done () {
> +	test_exit_ok=1
>  	trap - exit
>  	test_results_dir="$TEST_DIRECTORY/test-results"
>  	mkdir -p "$test_results_dir"
