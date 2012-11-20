From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] diff: introduce diff.submodule configuration
 variable
Date: Mon, 19 Nov 2012 16:48:36 -0800
Message-ID: <7vk3tht7yz.fsf@alter.siamese.dyndns.org>
References: <http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 01:49:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tac1U-0007Wr-0m
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 01:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab2KTAsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 19:48:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332Ab2KTAsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 19:48:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF466609F;
	Mon, 19 Nov 2012 19:48:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=izhF2i6d6xtoddF3VK51aGm5uPM=; b=LWCIsevmnHPFWcDTzxz5
	0OyNz5WF8LpooarwNSP+3j8BDSDg3JuUIMHWM+/O08iKQBZ9iVX493yxMF20NmDw
	8DKbMdP96XUmCbMoaBfGmMtu6aEo1if/vT5kzHfo8daJ1rccs183RR9kMfM9XxU0
	N1NW3JNN60JENP0zSscvT6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aiYUqk0kdxdN444GdC4a+mwa4tniNDNKJrn/7/gK5V/BlA
	/eKfTReRjajPgw+1uQkO/vLY42r5J7su7JejV85cWoI/wU8+KFsmKPQmxBNsJi5p
	oM37fLdjg/tdYIQrlNKmu+hkumHAg2stw+r/dsnlsizcPS0mOGL2+3PK3r2N4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD1A0609E;
	Mon, 19 Nov 2012 19:48:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C477609D; Mon, 19 Nov 2012
 19:48:38 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 056B921C-32AC-11E2-AC67-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210072>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index 6c01d0c..e401814 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -33,6 +33,7 @@ test_create_repo sm1 &&
>  add_file . foo >/dev/null
>  
>  head1=$(add_file sm1 foo1 foo2)
> +fullhead1=$(cd sm1; git rev-list --max-count=1 $head1)

That looks like quite a roundabout way to say

	$(cd sm1; git rev-parse --verify HEAD)

doesn't it?  I know this is just moved code from the original, so I
am not saying this should be fixed in this commit.

Existing code in t7401 may want to be cleaned up, perhaps after this
topic settles.  The add_file() function, for example, has at least
these points:

 - do we know 7 hexdigits is always the right precision?
 - what happens when it fails to create a commit in one of the steps
   while looping over "$@" in its loop?
 - the function uses the "cd there and then come back", not
   "go there in a subshell and do whatever it needs to" pattern.

> +test_expect_success 'added submodule, set diff.submodule' "

s/added/add/;

Shouldn't it test the base case where no diff.submodule is set?  For
those people, the patch should not change the output when they do or
do not pass --submodule option, right?

> +	git config diff.submodule log &&
> +	git add sm1 &&
> +	git diff --cached >actual &&
> +	cat >expected <<-EOF &&
> +Submodule sm1 0000000...$head1 (new submodule)
> +EOF
> +	git config --unset diff.submodule &&
> +	test_cmp expected actual
> +"
> +
> +test_expect_success '--submodule=short overrides diff.submodule' "
> +	git config diff.submodule log &&
> +	git add sm1 &&
> +	git diff --submodule=short --cached >actual &&
> +	cat >expected <<-EOF &&
> +diff --git a/sm1 b/sm1
> +new file mode 160000
> +index 0000000..a2c4dab
> +--- /dev/null
> ++++ b/sm1
> +@@ -0,0 +1 @@
> ++Subproject commit $fullhead1
> +EOF
> +	git config --unset diff.submodule &&
> +	test_cmp expected actual
> +"
> +
>  commit_file sm1 &&
>  head2=$(add_file sm1 foo3)
>  
> @@ -73,7 +102,6 @@ EOF
>  	test_cmp expected actual
>  "
>  
> -fullhead1=$(cd sm1; git rev-list --max-count=1 $head1)
>  fullhead2=$(cd sm1; git rev-list --max-count=1 $head2)
>  test_expect_success 'modified submodule(forward) --submodule=short' "
>  	git diff --submodule=short >actual &&
