From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] convert: ce_compare_data() checks for a sha1 of a path
Date: Thu, 19 May 2016 16:03:37 -0700
Message-ID: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
References: <573A993F.8020205@web.de>
	<1463667680-26008-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Fri May 20 01:03:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Wyp-0002XA-6b
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 01:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbcESXDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 19:03:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753809AbcESXDl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 19:03:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C583F1C409;
	Thu, 19 May 2016 19:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DvWhnTxz6iR+UYe9M3Makc5ShFM=; b=OojAUh
	zsKcV15QPnk2X115iZjBPZl1ITHHzK75wO0NKXlHq8RYwv1hDuN5EdhcXEdRawKy
	eJaOjCRUbwRey4qHy4zHwnoUp6qp7lWE8oQZ9EjlNP/oAUOXssYmPOjghIIK/qBM
	sdDwlfrEPyUO1tgf4zR0eYPxcygmKJVjNtCzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V0aIqY/XjPFVdorVEuTv4DkE5pbuSOHa
	WEQX6uG0ZHxh24fSoyBprWTjcqCbpseaYzfc/JPJdljmgLayCsI6JynE2VMq5Iq8
	62r2PghE0z7D/Uoq93Lb1YziWAORt0YP2xn76eYhTvfKk6CaV7Nae5C+UR8e+LiE
	NfXlP8db6vc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD0EA1C408;
	Thu, 19 May 2016 19:03:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 351BD1C407;
	Thu, 19 May 2016 19:03:39 -0400 (EDT)
In-Reply-To: <1463667680-26008-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Thu, 19 May 2016 16:21:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EC7F4CF4-1E15-11E6-A7B0-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295126>

tboegi@web.de writes:

> +int convert_to_git_ce_sha1(const char *path, const unsigned char *sha1,
> +			   const char *src, size_t len,
> +			   struct strbuf *dst, enum safe_crlf checksafe)

That's a strange name for the function, as "ce" and "sha1" gives no
hints what they are about.

If I understand correctly:

 - convert_to_git() is about converting <src, len> into <dst>, and
   "path" is not for reading the contents to be converted.  It is
   used to tell crlf_to_git() the index entry to pay attention to
   when defeating the usual conversion rules due to strange contents
   in the index (it also is used to report errors for safe-crlf
   check).

 - This one adds "sha1", and that is not about the contents to be
   converted, either.  Like "path", "sha1" is used to tell what blob
   to check when disabling the usual conversion rules.

Does the above description help in coming up with a better
description for the ce/sha1 thing?  The comment near the code that
uses them reads like so:

	/*
	 * If the file in the index has any CR in it, do not convert.
	 * This is the new safer autocrlf handling.
	 */

What is a good name to call the input to that logic?  "This
function, in addition to convert_to_git(), takes an extra parameter,
that tells it an extra piece of information 'X'"; what is X?

At the same time, the parameter "sha1" needs to be renamed to
clarify what object it is and what purpose it serves.  "sha1" alone
is an overly generic name, and it does not hint that it may not even
be given to the function, and that it doesn't have anything to do
with the contents <src, len> points at.

	Note. Perhaps you wanted _ce_sha1 suffix to tell the readers
	that it takes "an object name of the cache entry" that
	further affects the conversion?  If so the sha1 parameter
	should be renamed to match (and make it clear to readers
	that is what you meant).

The "sha1" is pretending to be the more important input for the
primary function of this function by being in early part of the
parameter list.  This may need to be rethought; we probably should
have done so as part of your previous refactoring of this file.

convert_to_git() takes the data for <path> in <src, len> and gives
result in <dst>, so these four should be its first parameters.  The
detail of the way the conversion works may be affected by additional
parameters, e.g. <checksafe> controls if extra warnings are given.

The <sha1> is to influence the conversion logic further to disable
the crlf-to-git conversion by inspecting a blob, and it tells the
function that the blob comes from an unusual place (as opposed to
the index entry at <path>).  So it should sit next to checksafe as
an auxiliary input parameter.

The logic implemented by the patch looks correct, but I'd have to
say that the result is an unmaintainable mess.  Right now, I can see
what is going on in the new code.  I am sure that in 6 months, with
poorly named helper functions and parameters, I will have hard time
recalling how the new code works.
