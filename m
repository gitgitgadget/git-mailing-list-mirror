From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] exclude: do strcmp as much as possible before
 fnmatch
Date: Sun, 27 May 2012 11:14:42 -0700
Message-ID: <7v8vgd7ap9.fsf@alter.siamese.dyndns.org>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
 <1338035474-4346-3-git-send-email-pclouds@gmail.com>
 <7vk3zyp14i.fsf@alter.siamese.dyndns.org>
 <CACsJy8DOz30GD_zv9yO7KD55+=H0t=+q_5qRtt51nOoYXwOBBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 20:14:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYhzP-0003p6-KH
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 20:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab2E0SOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 May 2012 14:14:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39574 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab2E0SOp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2012 14:14:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52A45852A;
	Sun, 27 May 2012 14:14:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zaLvpqct8oYE
	ggvhD8QapiO6UmY=; b=MruWHouPfctuvyrq28c3i8URYIR7nYJje0qagH1PUdyP
	Fva3Qs4kSLG37fAhGfFUAnC6aCW0FYwoRcsNZPLOFlu6SEeEafYkL77JNuEvSODn
	yLBWLEl4rYIag2l4MOuQv9qbZN5uIH73NI/KNEZjUH7oPfgEIeMEF+F4aFpHmTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BQSN+6
	5E39ynkXiUKYQGPNYV6vAIqs31/hqYFqR8kIzAp7MiYPJuSOWUqqcs5gP5f6wwqR
	vS3ys/8UtLkkSyfbLnVaRGRK8YdgzRMs665T8+QHWmLsXSAT9NFrkNnMHjfwaFIG
	uMUuCKUfSP08ZQGxpuhrN6HHB5O0ZSHigeAHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49C558529;
	Sun, 27 May 2012 14:14:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE9278527; Sun, 27 May 2012
 14:14:43 -0400 (EDT)
In-Reply-To: <CACsJy8DOz30GD_zv9yO7KD55+=H0t=+q_5qRtt51nOoYXwOBBQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 27 May 2012 19:06:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D598BAEC-A827-11E1-992E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198615>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> I have been wondering if you can take a different approach based on =
the
>> same observation this patch is based on. =C2=A0If you see an entry /=
foo/bar/*.c
>> in the top-level .gitignore, perhaps you can set it aside in a diffe=
rent
>> part of "struct exclude" for the top-level directory (because the pa=
ttern
>> will never match outside foo/bar directory), so that it is not even =
used
>> for matching, and only when you descend to foo/bar directory, add "/=
*.c"
>> to the "struct exclude" you create for that directory.
>
> that part is "base" field in "struct exclude", I believe.

Sorry, I misspoke; it is not about struct exclude at all.

>> That way, instead of "strcmp is faster than fnmatch, but we always c=
ompare
>> all elements in the huge pattern list given at the toplevel", you wo=
uld be
>> doing "we do not even bother to compare with the elements we know do=
 not
>> matter", which would be far more efficient, no?
>
> You still have to do at least one strncmp on "base" though to know if
> a pattern is applicable to the given directory. So it's not really
> cheaper than what is done in 3/3.

Actually I was referring to the exclude_stack.

Suppose you have .gitignore file at the top that lists /foo/bar/*.c
(among other millions of patterns anchored to specific directory),
and another in the foo/bar directory.  When you are looking at a
path in the top-level, currently the exclude_stack would have one
element, per-directory one for .gitignore at the top, that has
millions of patterns that would never match.  And then when you
descend into foo/bar directory, prep_exclude would link two elements
(one for foo/ directory which may be empty, another for foo/bar
directory) to this, and then you check paths you see in foo/bar
directory using all the elements that appear in the exclude_stack.

What I was suggesting was that you could choose not to add
/foo/bar/*.c entry in the exclude_stack element for the top-level
(but remember you did so), and then inside prep_exclude() when you
look at different directory, e.g. foo/bar, notice that higher level
(i.e. toplevel in this example) has such a deferred patterns that
applies to the new directory.  Then instead of adding /foo/bar/*.c
at the top-level, you can pretend as if /*.c appeared in .gitignore
file in the deeper level in the hierarchy.

And this does not happen per path you check; exclude_stack used by
excluded() is designed to take advantage of the access pattern that
we tend to check paths from the same directory together, so such an
adjustment will be per directory switching (i.e. it will be part of
the prep_exclude() overhead that is amortized over paths you walk).
