From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] sha1_file: implement changes for "cat-file --literally -t"
Date: Sun, 08 Mar 2015 12:09:48 -0700
Message-ID: <xmqq61abs3ur.fsf@gitster.dls.corp.google.com>
References: <54F89D90.6090505@gmail.com>
	<1425579560-18898-1-git-send-email-karthik.188@gmail.com>
	<xmqq61af100p.fsf@gitster.dls.corp.google.com>
	<54F9E6B6.4070105@gmail.com>
	<xmqq1tl2ylfo.fsf@gitster.dls.corp.google.com>
	<54FACD30.6080005@gmail.com>
	<xmqqpp8jsyel.fsf@gitster.dls.corp.google.com>
	<54FC0CCE.70009@gmail.com>
	<xmqqegozsvx5.fsf@gitster.dls.corp.google.com>
	<54FC292C.5060405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 20:10:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUgaK-00025v-6l
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 20:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbbCHTJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 15:09:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751035AbbCHTJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 15:09:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 563DE3DD9D;
	Sun,  8 Mar 2015 15:09:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=80YMgDR+CEBQXxYaf4Of0lZ6W8g=; b=hFO0jM
	pySZDvaPoEVhDxB+lOzfLI6KnbEjXtoPYI6w7+RFW/TzXD8a54oNf6b1pof2I9p5
	6KRQmuLL9jzXg0Mlgl8mRimOxlgCey2fg8ZoqSgi6zdvgQRZeoGrwaxfpHZr3UFR
	O/Xv6QLHAz/1SmyYoJUnQwpbo88YrkqdESqoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CCAFYpc2XQdftEZpuSGpWi2bzcFQIg/7
	ertTGTd1e3Nkl/NXFEjgkJ9EfxP/ZjDSczTwIsHxuKc6NM+RerFlcoYeN4x1yoqp
	LRr5PbM0G1Ed7WOOd43z9soshrReRDb8dRBseQWTkLkWK9fI5Jkx0vAOu8rM3DJi
	+c+87p+9t+4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EC963DD9C;
	Sun,  8 Mar 2015 15:09:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4CA43DD9B;
	Sun,  8 Mar 2015 15:09:49 -0400 (EDT)
In-Reply-To: <54FC292C.5060405@gmail.com> (karthik nayak's message of "Sun, 08
	Mar 2015 16:19:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B162CF18-C5C6-11E4-850C-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265103>

karthik nayak <karthik.188@gmail.com> writes:

> Sorry for the confusion, you did already say that in $gmane/264955 , I'm
> talking about how I tackled the issue in $gmane/264855.

Well, I am suggesting how to improve what you did in your
$gmane/264855 and a part of that was to suggest that teaching
parse_sha1_header() the "literally" mode may be necessary and why
"do not have to call parse_sha1_header()" may not be a good
solution.

Unless our goal is only to support "--literally -t" and go home,
never intending to support other things like "--literally -s" and
"--literally flob $OBJ", that is ;-)

Let's try again.

> Like :
>
>     else if ((flags & LOOKUP_LITERALLY)) {
>         size_t typelen = strcspn(hdrbuf.buf, " ");
>         strbuf_add(oi->typename, hdrbuf.buf, typelen);
>     }
>     else if ((status = parse_sha1_header(hdrp, &size)) < 0)
>         status = error("unable to parse %s header", sha1_to_hex(sha1));
>     else if (oi->sizep)
>         *oi->sizep = size;
>
> This way, we don't have to modify parse_sha1_header() to worry if "literally"
> is set or not.

When you are dealing with a crafted object $OBJ of type "florb", how
would your

    $ git cat-file --literally florb $OBJ
    $ git cat-file --literally -s $OBJ

be implemented, if parse_sha1_header() has not been enhanced to
allow you to say "for this invocation, the type name in the object
header may be something unknown to us, and it is OK"?

One possible implementation of "--literally florb $OBJ" would be to
still call the same loose object reading codepath, which would
eventually hit parse_sha1_header() to see what the type of the
object is and how long the object contents is, and error out if the
type is not "florb" or the length of the inflated contents does not
match the expected size.  Wouldn't you need a way for you to say
"for this invocation, the type name in the object header may be
something unknown to us, and it is OK"?

One possible implementation of "--literally -s $OBJ" would be to
change the call to sha1_object_info() to instead to call the
_extended() version, just like you did for "--literally -t", and
then read the result from *(oi.sizep), but the quoted piece of code
above would not let you use it that way, no?

Of course the above two are both "one possible implementation", and
not how the implementation ought to be [*1*].  But knowing a bit of
this part of the codepath, they look the most natural way to enhance
these codepaths, at least to me.


[Footnote]

*1* You could for example sidestep the issue and introduce a
parallel implementation of what parse_sha1_header() does, minus the
validation to ensure the object type is one of the known ones, and
use that function instead of the users of parse_sha1_header() in the
codepaths that implement "-s" and "cat-file" itself.

But I do not think that is a good direction to go in to keep the
codebase healthy in the longer term.  A refactoring that is similar
to what we did when we introduced sha1_object_info_extended(), which
was done in 9a490590 (sha1_object_info_extended(): expose a bit more
info, 2011-05-12) would be more desirable, so that we can avoid such
a duplicated parallel implementations.  That way, the existing
callers that do not have to know about "--literally" can keep using
parse_sha1_header(), but parse_sha1_header_extended() is called from
the updated parse_sha1_header() behind the scene.  And the extended
version would let callers that need to care about "--literally" ask
"the type name in the object header may be something unknown to us,
and it is OK" by passing an extra flag.
