From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/apply.c: report error on failure to
 recognize input
Date: Mon, 05 Dec 2011 11:27:18 -0800
Message-ID: <7vzkf6lsyx.fsf@alter.siamese.dyndns.org>
References: <1322944550-27344-1-git-send-email-drafnel@gmail.com>
 <1322944550-27344-2-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, artem.bityutskiy@linux.intel.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 05 20:27:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXeCF-0005ZI-A2
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 20:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440Ab1LET1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 14:27:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932126Ab1LET1V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 14:27:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E4386679;
	Mon,  5 Dec 2011 14:27:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pcWb//efWhGwI/aDx/VSw01lrGU=; b=qg3jNo
	OKOEBJFety6XSmPKrcwTvhSMDcFrozOo+B+1ZSnpSNnM9Io2LR9JG/xRdCuJEocB
	dyu6pNYL+0vBzjUuyoUQhyeT5rOs3XyCX92iwEjwYcGGwCGDuo4Xfutp/zua64Y/
	NXrgC7cM0875SfeT+HwHIfdZ8qeAbciYqXkqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fkkjs6TYmTHx54WJplfmY5bGE4qJI9f1
	QgdEwF5DUUS6E7d4hJSRIvqGF0A8fPOSlqoaB4Novw9EMtGz47+a3NEzBxI8O7O1
	1mePFR2S026eAKjxX2lD9SImfxN2j5Ng0B/NuAK5NYxm39Du5HGK9Y9i2xbnJVv1
	apXqM8OMfbg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85C736678;
	Mon,  5 Dec 2011 14:27:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 145966677; Mon,  5 Dec 2011
 14:27:19 -0500 (EST)
In-Reply-To: <1322944550-27344-2-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Sat, 3 Dec 2011 14:35:50 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 263D76A2-1F77-11E1-B064-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186286>

Brandon Casey <drafnel@gmail.com> writes:

> When git apply is passed something that is not a patch, it does not produce
> an error message or exit with a non-zero status if it was not actually
> "applying" the patch i.e. --check or --numstat etc were supplied on the
> command line.
>
> Fix this by producing an error when apply fails to find any hunks whatsoever
> while parsing the patch.
>
> This will cause some of the output formats (--numstat, --diffstat, etc) to
> produce an error when they formerly would have reported zero changes and
> exited successfully.  That seems like the correct behavior though.  Failure
> to recognize the input as a patch should be an error.
>
> Plus, add a test.
>
> Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>
> Initially, I was reluctant to change the error message, thinking that
> error messages for plumbing commands were not supposed to change.  But I
> think I was wrong in that thought, so I changed the error message so it
> was a more descriptive "unrecognized input".

I am still reluctant to see

    $ git apply </dev/null
    error: unrecognized input

instead of "error: No changes", though.

"git apply --check" is about asking "do you see anything offending in the
diff?" and it is not "git apply --dry-run" that asks "do you promise if I
feed this for real to you you will apply it without complaint?".

I am slightly in favor of answering "well you do not have a diff to begin
with, which in itself is suspicious" to "do you see anything offending?"
question, but I have to admit that it is an equally valid answer to say
"no, there is nothing offending in the diff.", which is what we do with
the current code.

So, I dunno.
