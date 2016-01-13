From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] t5304: Ensure wanted files are not deleted
Date: Wed, 13 Jan 2016 12:55:50 -0800
Message-ID: <xmqqmvs9mc6h.fsf@gitster.mtv.corp.google.com>
References: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
	<cover.1452704305.git.dougk.ff7@gmail.com>
	<670a9d9268beb0d70fb877a7c62d769062babba9.1452704305.git.dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, sbeller@google.com
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:56:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJSST-0004vj-DG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 21:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbcAMUzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 15:55:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751957AbcAMUzw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 15:55:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D4CB3A12B;
	Wed, 13 Jan 2016 15:55:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MTdtMf3Nma9Cgcr+HRbfK3l/Q5A=; b=pgqDRa
	ZOJ13AEUhmk4bRQwWyzHDT6p19Rkudz5fmyUcE31WQLzrw6fsf/zRWBsFCTGVcjA
	6J/tECfrulbfPgrcd+uoxmPbJU8Pl6Jf5YPks7Q5nn7fFKBqs4BirACZ5KJLqhkJ
	MVx0LHA1L77+eMYBXu+zC5RqDF1z2IZXE8/No=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BGsCfOie+Nt2Rh+goubAyUOmCrkMvH/1
	kK2ofdVRK36vP9i8tG7TkXfE6Q4jGS9n4mRRomynGtifpl+2472MHkRIJDN3u+TW
	XbPqDkHGM8VqHu7Fqa6gYzGHUcGQaIi+9/JiUVveY7pic+u9JY5UTiXVHk153e7m
	+SSyEUn1Jn4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 439A83A12A;
	Wed, 13 Jan 2016 15:55:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BBDDC3A128;
	Wed, 13 Jan 2016 15:55:51 -0500 (EST)
In-Reply-To: <670a9d9268beb0d70fb877a7c62d769062babba9.1452704305.git.dougk.ff7@gmail.com>
	(Doug Kelly's message of "Wed, 13 Jan 2016 11:07:11 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07E165FA-BA38-11E5-938C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283985>

Doug Kelly <dougk.ff7@gmail.com> writes:

> Subject: Re: [PATCH 3/4] t5304: Ensure wanted files are not deleted

I'd suggest s/wanted/non-garbage/.

> Explicitly test for and ensure files that may be wanted are not
> deleted during a gc operation.  These include .pack without .idx
> (which may be in-flight), garbage in the directory, and .keep files
> the user created.

"garbage in the directory" is not well defined.  "files in the
directory that clearly are not related to packing" is probably what
you meant, but the definition of "related to packing" is still
fuzzy.  Please clarify.

The following is me thinking aloud about things that you would need
to think about while attempting to clarify this.

What should the code do if we find

    pack-b0a9d62a7471e58832a575a78d57f8fb26822125.frotz

in $GIT_OBJECT_DIRECTORY/pack/ directory?  Is it a "garbage in the
directory"?  The filename looks so similar to the usual things with
know suffixes .pack, .idx, .bitmap, and .keep, that we may want to
consider that it might be another file related to the packing left
by a future version of Git and if we do not see corresponding .pack
we would want to remove it?  Or do we want to do something else?

What should "gc" do if we find

    pack-frotz.idx

without corresponding ".pack"?  Wouldn't it be safer to consider it
a garbage unrelated to packing (because regular packing would have
given it with 40-hex name, not "frotz") and leave it undeleted?

Thanks.

> Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
> ---
>  t/t5304-prune.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index 4fa6e7a..f7c380c 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -285,6 +285,23 @@ EOF
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'ensure unknown garbage kept with gc' '
> +	test_when_finished "rm -f .git/objects/pack/fake*" &&
> +	test_when_finished "rm -f .git/objects/pack/foo*" &&
> +	: >.git/objects/pack/foo.keep &&
> +	: >.git/objects/pack/fake.pack &&
> +	: >.git/objects/pack/fake2.foo &&
> +	git gc &&
> +	git count-objects -v 2>stderr &&
> +	grep "^warning:" stderr | sort >actual &&
> +	cat >expected <<\EOF &&
> +warning: garbage found: .git/objects/pack/fake2.foo
> +warning: no corresponding .idx or .pack: .git/objects/pack/foo.keep
> +warning: no corresponding .idx: .git/objects/pack/fake.pack
> +EOF
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'prune .git/shallow' '
>  	SHA1=`echo hi|git commit-tree HEAD^{tree}` &&
>  	echo $SHA1 >.git/shallow &&
