From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Wed, 12 Mar 2014 15:37:17 -0700
Message-ID: <xmqqha73jb6q.fsf@gitster.dls.corp.google.com>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
	<20140312175624.GA7982@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:38:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNrmo-0007AB-6H
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 23:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbaCLWhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 18:37:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbaCLWhW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 18:37:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B84C7412B;
	Wed, 12 Mar 2014 18:37:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gYoXHcVU+NZhGiRcQilZDsGlEiE=; b=RjVqX9
	fZEkWSbn/GePwk1j0IIJw3k/bCsYZ87xel7dpMjbvsBENcIMD+msseYXRLtCUhP+
	+uXz07pH0cKgJZmQSBQrdQPsI2X688ctI2aakiR9RekcV5TrpatJtEwhLh6do842
	z7D0f0dWouUgOqkFkYq5fPXCOf7K0g8YKMln4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fl/0iamxa3SHkS1Pm135y/SMiI+NitKH
	M9egCQcOSxLEnVM4blxXdPiJuRE/LV1I9BzANNcgogtedlPsGsfw8yJqVGC3G7+V
	WE40I8zcnyc+Lpw/4OMEn5L3qJ5hxjSmL374iVKMsg/WUMNnZcY0Dm0wGON04z5j
	KnNmt/a/0wY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66B5874128;
	Wed, 12 Mar 2014 18:37:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F67474127;
	Wed, 12 Mar 2014 18:37:20 -0400 (EDT)
In-Reply-To: <20140312175624.GA7982@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Mar 2014 13:56:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DF6CD04A-AA36-11E3-A6D2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244005>

Jeff King <peff@peff.net> writes:

> Thanks, I think this is a real readability improvement in most cases.
> ...
>
> I tried:
>
>   perl -i -lpe '
>     s/memcmp\(([^,]+), "(.*?)", (\d+)\)/
>      length($2) == $3 ?
>        qq{!starts_with($1, "$2")} :
>        $&
>     /ge
>   ' $(git ls-files '*.c')
>
> That comes up with almost the same results as yours, but misses a few
> cases that you caught (in addition to the need to simplify
> !!starts_with()):
>
>   - memcmp(foo, "bar", strlen("bar"))
>
>   - strings with interpolation, like "foo\n", which is actually 4
>     characters in length, not 5.
>
> But there were only a few of those, and I hand-verified them. So I feel
> pretty good that the changes are all correct transformations.
>
> That leaves the question of whether they are all improvements in
> readability (more on that below).

After reading the patch and the result of your Perl replacement, I'd
agree with the "correctness" but I am not as convinced as you seem
to be about the "real readability improvement in most cases."  "some
cases", perhaps, though.

Taking two random examples from an early and a late parts of the
patch:

--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -82,7 +82,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 				enum object_type type;
 				unsigned long size;
 				char *buffer = read_sha1_file(sha1, &type, &size);
-				if (memcmp(buffer, "object ", 7) ||
+				if (!starts_with(buffer, "object ") ||
 				    get_sha1_hex(buffer + 7, blob_sha1))
 					die("%s not a valid tag", sha1_to_hex(sha1));
 				free(buffer);

diff --git a/transport.c b/transport.c
index ca7bb44..a267822 100644
--- a/transport.c
+++ b/transport.c
@@ -1364,7 +1364,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 
 	while (other[len-1] == '/')
 		other[--len] = '\0';
-	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
+	if (len < 8 || !starts_with(other + len - 8, "/objects"))
 		return 0;
 	/* Is this a git repository with refs? */
 	memcpy(other + len - 8, "/refs", 6);


The original hunks show that the code knows and relies on magic
numbers 7 and 8 very clearly and there are rooms for improvement.
The result after the conversion, however, still have the same magic
numbers, but one less of them each.  Doesn't it make it harder to
later spot the patterns to come up with a better abstraction that
does not rely on the magic number?  Especially in the first hunk, we
can spot the repeated 7s in the original that make it glaringly
clear that we might want a better abstraction there, but in the text
after the patch, there is less clue that encourages us to take a
look at that "buffer + 7" further to make sure we do not feed a
wrong string to get_sha1_hex() by mistake when we update the
surrounding code or the data format this codepath parses.

I think grepping for "memcmp()" that compares the same number of
bytes as a constant string, like you showed in that Perl scriptlet,
is a very good first step to locate where we might want to look for
improvements.  I however think that a mechanical replacement of all
such memcmp() with !start_with() is of a dubious value.

After finding the hunk in the cat-file.c shown above, and after
seeing many other similar patterns, one may realize that it is a
good use case for a variant of skip_prefix() that returns boolean,
which we discussed earlier, perhaps like so:

	if (!skip_over(buffer, "object ", &object_name) ||
            get_sha1_hex(object_name, blob_sha1))
		die(...);

and such a solution would be what truly eradicates the reliance of
magic constants that might break by miscounting bytes in string
constants.  I do not think mechanical replacement to !start_with()
is "going in the right direction and reaching a halfway to that
goal".  I honestly think that it instead is taking us into a wrong
direction, without really solving the use of brittle magic constants
and making remaining reliance of them even harder to spot.

So....
