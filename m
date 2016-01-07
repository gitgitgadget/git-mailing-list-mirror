From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/15] ref-filter: use parsing functions
Date: Thu, 07 Jan 2016 10:43:41 -0800
Message-ID: <xmqqvb7544de.fsf@gitster.mtv.corp.google.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRjXHmBnnmHbbibeV-gcvwMFQc7-5ce4s2OHu+wQwMy4Q@mail.gmail.com>
	<CAOLa=ZSi0c61G8oXsCC0UfprDhf3hESaqKw8eGNRZJ7MTvNY4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 19:43:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHFXI-0005T3-K9
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 19:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbcAGSno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 13:43:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752707AbcAGSnn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 13:43:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAF8139644;
	Thu,  7 Jan 2016 13:43:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rYUbbOIYUR53+vKFbzj/3VhpXc8=; b=smbG+t
	KoZw1eC4fgv6fmPXBBxRps9gRBOkz0NapGaWHhdiEy0NqfoELb4zXyeG+XyXMvVI
	r5bUbO6hL6f4AgQZnq9riSIoBd5yBVQfeT9/lobF6xWRuz3HuIMCYDOEM8RW7paG
	UvttAJ+KL5V0yDYfYJyz6IxVkR1/I2QpPwgos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rEwUG2KA/FJW0wX0gi5THYrW3U6rzOoL
	ysM+38LHQQ2PXTN6kiH43Vi5XPOBntCrf6/2Ix8vQtxzG1lKD1xyVrnlrLsIDtTN
	jwGGLOC0tSM0sDaMBnoUEl2xBElKDf8Lu9vHzKJVHD27RXSVSFPiqPEW5d+ISi1/
	kuqDmhzgpio=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D276539643;
	Thu,  7 Jan 2016 13:43:42 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 558C839642;
	Thu,  7 Jan 2016 13:43:42 -0500 (EST)
In-Reply-To: <CAOLa=ZSi0c61G8oXsCC0UfprDhf3hESaqKw8eGNRZJ7MTvNY4g@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 7 Jan 2016 19:55:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9319EE0E-B56E-11E5-9862-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283499>

Karthik Nayak <karthik.188@gmail.com> writes:

>> I don't understand the difficulty. It should be easy to manually skip
>> the 'deref' for this one particular case:
>>
>>     const char *name = atom->name;
>>     if (*name == '*')
>>         name++;
>>
>> Which would allow this unnecessarily complicated code from patch 14/15:
>>
>>     if (match_atom_name(atom->name, "subject", &buf) && !buf) {
>>         ...
>>         return;
>>     } else if (match_atom_name(atom->name, "body", &buf) && !buf) {
>>         ...
>>         return;
>>     } if (!match_atom_name(atom->name, "contents", &buf))
>>         die("BUG: parsing non-'contents'");
>>
>> to be simplified to the more easily understood form suggested during
>> review[1] of v2:
>>
>>     if (!strcmp(name, "subject")) {
>>         ...
>>         return;
>>     } else if (!strcmp(name, "body")) {
>>         ...
>>         return;
>>     } else if (!match_atom_name(name,"contents", &buf))
>>         die("BUG: expected 'contents' or 'contents:'");
>>
>> You could also just use (!strcmp("body") || !strcmp("*body")) rather
>> than skipping "*" manually, but the repetition makes that a bit
>> noisier and uglier.
>>
>> [1]: http://article.gmane.org/gmane.comp.version-control.git/282645
>
> Definitely not a difficulty per se. Just that it seems like something
> match_atom_name()
> seems to be fit for. As the function name suggests that we're matching
> the atom name
> and the check for '!buf' indicates that no options are to be included
> for that particular atom.
>
> Also after Junio's suggestion[1], I think It looks better now[2]. But
> either ways, I'm not
> strongly against what you're saying, so my opinion on this matter is
> quite flexible.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/283404
> [2]: http://article.gmane.org/gmane.comp.version-control.git/283449

Sorry, but I suspect I was looking at a leaf function without
thinking about the larger picture.

I suspect that the interface to customized parsing function called
by parse_ref_filter_atom() is misdesigned.  I understand that the
overall parsing that starts at verify_ref_format() goes like this:

 * Iterate over the string and find a matching "%(",")" pair.

   - For each such pair found, use parse_ref_filter_atom() on
     what is inside that matching pair.

     - parse_ref_filter_atom() iterates over the table of known
       atoms, and finds the entry in that table.

       Note that at this point, it knows that "%(" is followed by
       'contents' or 'contents:' when it picked the "contents" atom
       from the table, for example.

     - if the entry we found in that table for the atom being parsed
       has a custom parse function, that function is called, but the
       calling convention does not pass the fact that we already
       know what we are seeing inside "%(",")" pair is 'contents',
       for example, and we know what argument it is given if any.

So it appears to me that match_atom_name() is a misguided helper
function that you shouldn't have to use too often.  If the signature
of parse() functions is changed to take not just the atom but the
pointer to its argument (could be NULL, if we are seeing
"%(contents)", for example) that is already available as "formatp"
in the function, then contents_atom_parser() could become more like:

contents_atom_parser(struct used_atom *atom, const char *arg)
{
	if (args)
        	atom->u.contents.option = C_BARE;
	else if (!strcmp(arg, "body"))
        	atom->u.contents.option = C_BODY;
	...
}

and there is no reason for this caller to even look at atom->name or
worry about that it might have the dereferencing asterisk in front.

If we really want to avoid having separate subject_atom_parser() and
body_atom_parser(), they can be folded into the same function and it
becomes necessary to switch on atom->name like you did in the code
being discussed in the quoted part above.  For that, as Eric said,
skipping '*' manually would not be a big deal, as that should not
happen so often in the code _anyway_.  It is not a good idea to
switch on atom->name inside contents_atom_parser() like you did.
You are better off having separate {subject,body}_atom_parser()
functions.

For one thing, you are not reusing or sharing any code by squishing
these three functions into one.  A conceptually larger problem is
that you are adding two extra !strcmp() calls to figure out the
caller _already_ knows (notice I said this is "conceptual", this is
not about performance).  parse_ref_filter_atom() knows that it is a
"%(subject)" or "%(subject:...)" atom, but because you throw away
that information and call contents_atom_parser() by saying that it
is one of the contents, subject or body, the called function has to
redo strcmp in order to figure it out itself.
