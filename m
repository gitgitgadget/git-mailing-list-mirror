From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test cases for git-am
Date: Sat, 31 May 2008 12:22:01 -0700
Message-ID: <7viqwuffdy.fsf@gitster.siamese.dyndns.org>
References: <20080530140447.GB10514@leksak.fem-net>
 <7vy75rh25i.fsf@gitster.siamese.dyndns.org>
 <20080531024027.GB5907@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat May 31 21:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2WfX-0008FY-OR
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 21:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYEaTWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 15:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752698AbYEaTWN
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 15:22:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbYEaTWM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 15:22:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5117338CC;
	Sat, 31 May 2008 15:22:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7474738CA; Sat, 31 May 2008 15:22:08 -0400 (EDT)
In-Reply-To: <20080531024027.GB5907@leksak.fem-net> (Stephan Beyer's message
 of "Sat, 31 May 2008 04:40:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DE34CB5E-2F46-11DD-AE10-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83402>

Stephan Beyer <s-beyer@gmx.net> writes:

>> > +	tail -n +3 msg >file &&
>> 
>> "tail -n 3" you mean?
>
> No :-)
> "tail -n 3" or "tail -n -3" results in the last three lines, but
> "tail -n +3" results in the last lines beginning from the third line.

"git grep 'tail.*+' -- '*.sh'" says that this will the first and only
instance of "tail -n +<number>".  The syntax may be POSIX but not all
/usr/bin/tail unfortunately knows about it.

I tend to prefer "sed -n -e '3,$p'" for things like this for portability.
Incidentally, the only /usr/bin/tail that is incapable of +number I have
access to is so old that it does not even want -n and only wants "tail -3"
or "tail +3"; funnily enough, /usr/bin/head there does accept -n.

>> Hmmm.  Checking for inequality does not feel so robust.  You will allow
>> "am" to record garbage and will not be able to detect a breakage.
>
> Oh, right.
>
> Does this feel better?
> --- a/t/t4151-am.sh
> +++ b/t/t4151-am.sh
> @@ -123,15 +123,13 @@ test_expect_success 'am changes committer and keeps author' '
>  	git checkout first &&
>  	git am patch2 &&
>  	! test -d .dotest &&
> -	test "$(git rev-parse master)" != "$(git rev-parse HEAD)" &&
> -	test "$(git rev-parse master^)" != "$(git rev-parse HEAD^)" &&
>  	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
>  	test -z "$(git diff master..HEAD)" &&
>  	test -z "$(git diff master^..HEAD^)" &&
>  	compare author master HEAD &&
>  	compare author master^ HEAD^ &&
> -	! compare committer master HEAD &&
> -	! compare committer master^ HEAD^
> +	test "Co M Miter <c.miter@example.com>" = \
> +	     "$(git log -1 --pretty=format:"%cn <%ce>" HEAD)"
>  '

That looks like a more direct approach, doesn't it?

>> Again, don't you want to check not just "It added something", but "It
>> added what we expected it to add"?
>
> Like this?
> ---
>  test_expect_success 'am --signoff adds Signed-off-by: line' '
>  	git checkout -b master2 first &&
>  	git am --signoff <patch2 &&
>  	test "$(git cat-file commit HEAD | grep -c "^Signed-off-by:")" -eq 1 &&
> -	test "$(git cat-file commit HEAD^ | grep -c "^Signed-off-by:")" -eq 2
> +	test "$(git cat-file commit HEAD^ | grep -c "^Signed-off-by:")" -eq 2 &&
> +	git cat-file commit HEAD | grep -q "^Signed-off-by: Co M Miter <c.miter@example.com>$" &&
> +	git cat-file commit HEAD^ | grep -q "^Signed-off-by: Co M Miter <c.miter@example.com>$" &&
> +	git cat-file commit HEAD^ | grep -q "^Signed-off-by: C O Mitter <committer@example.com>$"
>  '
> ---
>
> Mh, I thought it is not bad to keep the -eq checks just to go sure nothing
> is added twice by whatever reason.

Why not sed out all Signed-off-by lines and make sure all of what you
expect to appear do appear in the order you expect them to do?
