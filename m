From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Sun, 16 Mar 2014 14:20:14 -0700
Message-ID: <7v1ty14z8x.fsf@alter.siamese.dyndns.org>
References: <20140308183501.GH18371@serenity.lan>
	<1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
	<8738ijzbue.fsf@thomasrast.ch>
	<20140316020018.GA20019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Guillaume Gelin <contact@ramnes.eu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 16 22:19:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPISh-000351-N3
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 22:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbaCPVTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 17:19:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079AbaCPVTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 17:19:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E6997203B;
	Sun, 16 Mar 2014 17:19:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k2IV1r2hk9uxhLKC8xw2pv7mSNk=; b=JTRWi8
	i38K8I4SPKjjmo9shzt6kF/NnIpGym96SdFggjWTCTdhr+qxtLeZB3mo6p+1OR4f
	I2gNZ51brAIPjZHQgTm/MDy2AVk593KiBZtHBvot7drhDXlMwChAn7uhZSruo7om
	N7DWd30xNSPyBpfu/WF2U7DTHyTj6db6CzfpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i01hSYb8PcVxpVHjY/OjtMfgiOawA3vM
	oyP49agFVd6O0yO6xrkhdbxEgeR6+yNgpl7e9qTGujLMvJmflnKRDfLT4BkpGRGt
	GlYqccg7+Rma/PBvNOhvjMad+9RjblCV05Wf9D1+bUYAG74FALv5Acf1iHIkLxs7
	BPIm1nej2wA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A70472038;
	Sun, 16 Mar 2014 17:19:06 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9328C72031;
	Sun, 16 Mar 2014 17:19:05 -0400 (EDT)
In-Reply-To: <20140316020018.GA20019@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 15 Mar 2014 22:00:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 9AB9F85C-AD50-11E3-B628-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244209>

Jeff King <peff@peff.net> writes:

> On Sat, Mar 15, 2014 at 05:05:29PM +0100, Thomas Rast wrote:
>
>> > diff --git a/builtin/mv.c b/builtin/mv.c
>> > index f99c91e..b20cd95 100644
>> > --- a/builtin/mv.c
>> > +++ b/builtin/mv.c
>> > @@ -230,6 +230,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>> >  					memmove(destination + i,
>> >  						destination + i + 1,
>> >  						(argc - i) * sizeof(char *));
>> > +					memmove(modes + i, modes + i + 1,
>> > +						(argc - i) * sizeof(char *));
>> 
>> This isn't right -- you are computing the size of things to be moved
>> based on a type of char*, but 'modes' is an enum.
>> 
>> (Valgrind spotted this.)
>
> Maybe using sizeof(*destination) and sizeof(*modes) would make this less
> error-prone?
>
> -Peff

Would it make sense to go one step further to introduce two macros
to make this kind of screw-up less likely?

 1. "array" is an array that holds "nr" elements.  Move "count"
    elements starting at index "at" down to remove them.

    #define MOVE_DOWN(array, nr, at, count)

    The implementation should take advantage of sizeof(*array) to
    come up with the number of bytes to move.


 2. "array" is an array that holds "nr" elements.  Move "count"
    elements starting at index "at" up to make room to copy new
    elements in.

    #define MOVE_UP(array, nr, at, count)

    The implementation should take advantage of sizeof(*array) to
    come up with the number of bytes to move.

Optionally, to make 2. even safer, these macros could take "alloc"
to say that "array" has memory allocated to hold "alloc" elements,
and the implementation may check "nr + count" does not overflow
"alloc".  This would make 1. and 2. asymmetric (move-down can do no
validation using "alloc", but move-up would be helped), so I am not
sure it is a good idea.

After letting my eyes coast over hits from "git grep memmove", there
do seem to be some places that these would help readability, but not
very many.
