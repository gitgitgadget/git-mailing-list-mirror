From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] diff: do not use creation-half of -B as a rename target candidate
Date: Mon, 02 Feb 2015 10:25:39 -0800
Message-ID: <xmqqbnlcuq58.fsf@gitster.dls.corp.google.com>
References: <xmqqegqaahnh.fsf@gitster.dls.corp.google.com>
	<xmqqfvapuhkk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 19:26:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YILhL-00062H-2Z
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbbBBS0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:26:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754437AbbBBS0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 13:26:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B25F633E5C;
	Mon,  2 Feb 2015 13:26:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0FzQES3NLxYWDtbX4q+RBjcOxUw=; b=JkwMIF
	Z2InlKFOSvzroya04KrN8r3IAV4rx1qCmO9IQJwuz+bx6/lG8cWwKyuy5Sqv0xKj
	Zko0x8cEPz4lm45rxEyZEX1m/N9Cy51pp/3aBLsCI3Yxskr3FLIjQ+fNfGVTOeiN
	7Z3nOIzwiA5k8K5/y5nW++Ul9OiFhgoK7tn6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D2nDRlX6spmkiGK5OsVQZIvywe92Hgbp
	Cluz8RzZOlX+Lai8U2Ga0wRf2p6USK+axDEHZ7cm2t0lW1MgB4VrjZUS+a88zK3D
	U81f/yGnY5jJennjmS21mTOCdZqYk0XOV8Uc0a+dbm3BQy/UgPrOBED5XsXCjt/R
	nkBP6OHQAKQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA05433E5B;
	Mon,  2 Feb 2015 13:26:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B23833E3E;
	Mon,  2 Feb 2015 13:25:40 -0500 (EST)
In-Reply-To: <xmqqfvapuhkk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 01 Feb 2015 19:18:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E48E20E6-AB08-11E4-A755-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263267>

Junio C Hamano <gitster@pobox.com> writes:

>  * Here is what I am at the moment; I cannot quite explain (hence I
>    cannot convince myself) why this is the right solution, but it
>    seems to make the above sample case work without breaking any
>    existing tests.  It is possible that the tests that would break
>    without the "&& !p->score" bit are expecting wrong results, but I
>    didn't look at them in detail.

Sadly, I think this is garbage.  "Do not consider creation-half of a
broken pair, ever" is too simple and cripples this case that starts
with two files A and B that are quite different:

	$ git add A B
	$ mv A B.new
        $ mv B A
        $ mv B.new B
        $ git diff -B -M

where the internal machinery breaks both A and B into these two file
pairs:

	delete A(old)
        create A(new)

	delete B(old)
        create B(new)

and then match them up to produce

	rename A to B
        rename B to A

The rule need to be "creation-half of a broken pair can be used as
the destination of a rename, if and only if its corresponding
deletion-half is used as the source of another rename elsewhere".
Under that condition, a file A that is completely rewritten to
become similar to another existing file B can be expressed as a
rename of B, because A is renamed away to make room in the same
change.

Fixing this is turning out to be more complex than I originally
hoped X-<.
