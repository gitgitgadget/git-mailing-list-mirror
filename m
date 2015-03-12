From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Wed, 11 Mar 2015 17:26:56 -0700
Message-ID: <xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
	<1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
	<CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com>
	<20150311220825.GB46326@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 01:27:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVqxt-0000iK-JO
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 01:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbbCLA07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 20:26:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751204AbbCLA07 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 20:26:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DD7D3F12B;
	Wed, 11 Mar 2015 20:26:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9LjE2QHfrZGayYWsi9eU0cp+xvM=; b=g8tIDt
	EAoiJuusIL3tEEuuI081UEvaDzrnEAQz3TuaZOArhb9t4mS/4iAXbBxO1MseAKvK
	cOzm4RhmIWZyL+rVeTzdzvtWSaJpajSskCuD14nFeyIuEPEpyFfxi3lCkjwK+3Dv
	IhIvC5R498/WPPweZylCVnASz4gO90zUvngfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sk35C4akWT10vQmeAcJ7wh3P3IRL91TX
	Ikc6zIF//Twwh7XOu+Xr4Wb8tj2/xe8KBxWF9mYxNlb0KH6BxfawSvJTRyryL6kI
	Kquhz0+JV+fMTMVrc8hLNSyTNr06C9Fs5seLH+SFjkujGUhyyPi956byII2Vna/f
	89xWbvf261s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25FD03F12A;
	Wed, 11 Mar 2015 20:26:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97B383F128;
	Wed, 11 Mar 2015 20:26:57 -0400 (EDT)
In-Reply-To: <20150311220825.GB46326@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 11 Mar 2015 22:08:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7E166B4E-C84E-11E4-AC09-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265346>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Michael Haggerty recommended that I call the structure element sha1
> instead of oid in case we want to turn this into a union if we decide to
> go the additional hash route.

I'd advise against it.

As I wrote in $gmane/265337 in response to Michael:

    > 4. We continue to support working with SHA-1s declared to be (unsigned
    > char *) in some performance-critical code, even as we migrate most other
    > code to using SHA-1s embedded within a (struct object_id). This will
    > cost some duplication of code. To accept this approach, we would need an
    > idea of *how much* code duplication would be needed. E.g., how many
    > functions will need both (unsigned char *) versions and (struct
    > object_id *) versions?

    ...

    I do not know what kind of code duplication you are worried about,
    though.  If a callee needs "unsigned char *", the caller that has a
    "struct object_id *o" should pass o->hash to the callee.

And that would break the abstraction effort if you start calling the
field with a name that is specific to the underlying hash function.
The caller has to change o->sha1 to o->sha256 instead of keeping
that as o->oid and letting the callee handle the implementation
details when calling

        if (!hashcmp(o1->oid, o2->oid))
                ; /* they are the same */
        else
                ; /* they are different */

The only folks that need to _know_ what hash function is used or
how long the field is are the ones that have raw bytes of the hash
obtained from files (e.g. from the index) and they would do
something like this to implement a function that checks the file
records an object name that is expected by the caller:

        void check_oid(int fd, struct object_id *expected)
        {
                unsigned char object_name[GIT_HASH_RAWSZ];

                ...
                read(fd, object_name, GIT_HASH_RAWSZ);
                if (hashcmp(object_name, expected->oid))
                        die("object name mismatch???");
        }

or when they do know they are using a specific function, do:

        void compute_object_name(struct object_id *id,
                                unsignd char*data,
                                size_t len)
        {
                git_SHA_CTX c;
                unsigned char *sha1 = &(id->oid);

                /* if we are paranoid... */
                assert(sizeof(id->oid) >= 20);

                ...
                git_SHA1_Init(&c);
                git_SHA1_Update(&c, data, len);
                ...
                git_SHA1_Final(sha1, &c);
        }

Even the latter would not be helped if the field to store the hash
were named id->sha1 very much, I would think.
