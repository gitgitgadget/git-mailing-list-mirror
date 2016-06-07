From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 07 Jun 2016 14:05:20 -0700
Message-ID: <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
References: <20160607195608.16643-1-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Tue Jun 07 23:05:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAOBl-0001tH-PF
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162316AbcFGVF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 17:05:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161158AbcFGVFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:05:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DC49232F5;
	Tue,  7 Jun 2016 17:05:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zdvjwblEe2t5hGvK3Z1sahIkK2A=; b=mZgkRp
	X04onXVgSLohl83IXkVmhucqQpiGTyL7eGmJtyNjTd8VDfT77ddCI2vZ8JTVCw9N
	9P7+omTHECLB1nXJpiCjp5OSL2HiX8E1JIznn/Jr3xtzdJ60EBJ+alAEZal4kLya
	Lt4/8fdIx4g2o1VTS/iAmUX8TqHeADV11zuYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZ+qACjYt+CvzQSF2bKP5kE85DeSAwQo
	mId/U3HEH9RFbLsL5v1cxg0uynSYSONWKZsY4A0QjcYMBXIooF1bmJ0N5023qkbo
	VM86asm08pTmxIbZ+3nAtZ5ERhtCzzE5gyohra7EOl+CoCNQ86VzpSZZqIvIitIC
	M9ez9qwMDHs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 162F9232F4;
	Tue,  7 Jun 2016 17:05:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87C64232F2;
	Tue,  7 Jun 2016 17:05:22 -0400 (EDT)
In-Reply-To: <20160607195608.16643-1-santiago@nyu.edu> (santiago@nyu.edu's
	message of "Tue, 7 Jun 2016 15:56:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C67BB5C-2CF3-11E6-A74D-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296723>

santiago@nyu.edu writes:

> 1.- Using a tag ref as a check-out mechanism is pretty common by package
>     managers and other tools. Verifying the tag signature provides
>     authentication guarantees, but there is no feedback that the
>     signature being verified belongs to the intended tag.

Very true.

The above means that the existing package managers and other tools
need to be updated with some new code that lets them learn how to
tell if the tagname (in their refs/tags/ namespace) matches the
intended "real" tag name, and your --check-name option could be
that.

But if you are adding new code to the existing package managers and
other tools _anyway_, wouldn't it be a more direct solution to let
them learn how to tell what the intended "real" tag name is with
that new code?

It is true that "git cat-file tag v1.4.11" lets you examine all
lines of a given tag object, but the calling program needs to pick
pieces apart with something like:

	git cat-file tag v1.4.11 | sed -e '/^$/q' -e 's/^tag //p'

which may be cumbersome.  Perhaps, just like "git tag -v v1.4.11" is
a way to see if the contents of the tag is signed properly, if you
add "git tag --show-tagname v1.4.11" that does the above pipeline,
these package managers and other tools can be updated to

	tag="$1"
-	if ! git tag -v "$tag"
+	if ! git tag -v "$tag" ||
+	   test "$tag" != "$(git tag --show-tagname $tag)"
        then
		echo >&2 "Bad tag."
                exit 1
	fi
	make dest=/usr/local/$package/$tag install

Or it could even do this:

	tag="$1"
	if ! git tag -v "$tag"
	if ! git tag -v "$tag"
        then
		echo >&2 "Bad tag."
                exit 1
	fi
+	tag=$(git tag --show-tagname $tag)
	make dest=/usr/local/$package/$tag install

i.e. ignore the refname entirely and use the "real" tagname it reads
after validating the signature as the name of the resulting version
getting installed, distributed and/or used.
