From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 05/11] notes: clean up t3301
Date: Tue, 16 Feb 2010 15:52:12 -0800
Message-ID: <7vd40420yb.fsf@alter.siamese.dyndns.org>
References: <cover.1266361759.git.trast@student.ethz.ch>
 <2c7b0e51f7d299a481b62cbe4f728ff20e4651ab.1266361759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:52:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXDU-0004XG-0E
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933628Ab0BPXw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:52:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304Ab0BPXwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:52:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6105C9AEF9;
	Tue, 16 Feb 2010 18:52:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Flm95TZC+olIo9iDo8kQINrVB0g=; b=NI06Ex
	14w3R7BVCFvnUfQMNihTxUBWl2FotEEPZdoPhUdNYIu7XjYPfSIXPYHUqjBSiUAx
	oSRxkc8KIWb7+duz0OyPjLo7BF74kbfZUg+K7Ff1ax06fzl3MQWp2Y4n+jxf6nY1
	tXNj3mSgfNd43+wpTSvSpFGjjEJb0f2QGcywY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lo5ExKyZ9T4FHcZ/6FtKt5Batb680Fm/
	vsXbeZkMnN29mUJ9nl3vuQF/lvmh+KZzYClODG7zNRs8wKCMXv42789Vf1ktgN4n
	PfmrteYOgnoNJADE8oqnZjfxZ9gnm9YK/aUqxut7j9lXS6+3UReJEoXozBJ9f2cN
	kIMqKCGrt98=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 080A89AEF2;
	Tue, 16 Feb 2010 18:52:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A27919AEED; Tue, 16 Feb
 2010 18:52:14 -0500 (EST)
In-Reply-To: <2c7b0e51f7d299a481b62cbe4f728ff20e4651ab.1266361759.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed\, 17 Feb 2010 00\:26\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 51EB1290-1B56-11DF-9589-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140181>

Thomas Rast <trast@student.ethz.ch> writes:

> The existing tests handrolled test_commit, so use that instead.
>
> Unfortunately this changes all sha1's.  Since we're not supposed to
> unneccessarily rely on them anyway, introduce a small helper that
> filters out the commit headers before comparing, and remove them from
> the expected outputs.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  t/t3301-notes.sh |  141 ++++++++++++++++++------------------------------------
>  1 files changed, 46 insertions(+), 95 deletions(-)
>
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 90178f9..3fec7ae 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -7,6 +7,15 @@ test_description='Test commit notes'
>  
>  . ./test-lib.sh
>  
> +strip_header () {
> +	sed -i '/^\(commit\|tree\|parent\) /d' "$@"
> +}

I do not think -i is portable.  Neither the use of ERE elements by quoting
them with backslash (which is a non-POSIX GNU extension IIRC).

You use this only for one side of test_cmp, so you should be able to do
something like:

	strip_then_cmp () {
        	sed -e "/^[ctp][a-z]* $x40$/d" "$2" |
                test_cmp "$1" -
	}

But because you are using test_commit to freeze the time and get stable
output, and because you still have something like this anyway:

>  cat > expect << EOF
> -c18dc024e14f08d18d14eea0d747ff692d66d6a3 1584215f1d29c65e99c6c6848626553fdd07fd75
> -c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 268048bfb8a1fb38e703baceb8ab235421bf80c5
> +c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 7a4ca6ee52a974a66cbaa78e33214535dff1d691
> +c18dc024e14f08d18d14eea0d747ff692d66d6a3 d07d62e5208f22eb5695e7eb47667dc8b9860290
>  EOF

it might be easier to do without such a niceness.
