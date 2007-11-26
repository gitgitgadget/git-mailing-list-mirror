From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Mon, 26 Nov 2007 16:48:28 +0300
Message-ID: <87wss5p177.fsf@osv.gnss.ru>
References: <1195470026-7389-1-git-send-email-ask@develooper.com>
	<7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
	<7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com>
	<7v8x4slovk.fsf@gitster.siamese.dyndns.org>
	<87ejekzpx3.fsf@osv.gnss.ru>
	<7vr6ikk6rf.fsf@gitster.siamese.dyndns.org>
	<87lk8orgpm.fsf@osv.gnss.ru>
	<7vejegu4in.fsf@gitster.siamese.dyndns.org>
	<87hcjcra10.fsf@osv.gnss.ru>
	<7vejegsejz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:57:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IweSD-0003es-W8
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 14:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbXKZN4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 08:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbXKZN4d
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 08:56:33 -0500
Received: from javad.com ([216.122.176.236]:4516 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbXKZN4c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 08:56:32 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAQDmYH99990;
	Mon, 26 Nov 2007 13:48:34 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IweK4-0000sy-Kn; Mon, 26 Nov 2007 16:48:28 +0300
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66075>

Junio C Hamano <gitster@pobox.com> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> Yeah, it's one valid interpretation. Here is another one:
>> ...
>> taken from here: <http://www.answers.com/topic/diff?cat=technology>
>
> Rants about how dangerous GNU patch liberally (mis)interprets a
> broken patch and git-apply is written deliberately more strict
> have been repeated on this list, and I would not steal it from
> Linus in this response.

Yeah, being strict when applying patches is a good idea, I agree, though
I fail to see how it is relevant to the problem at hand. I mean that if
we either remove the signature or put an empty line before it, the
resulting file won't become less conforming to the patch format, isn't
it?

>>> The diff editing mode of Emacs, at least the version that caused
>>> this issue, however did not make use of that information.
>>
>> IMHO it's rather useless to argue about it without strict definition of
>> correct format of a patch (do you have one?)
>
> Yes.  2004 POSIX does not talk about unified context, but Austin
> group's SD5-XCU-ERN-103/120 has additions to define unified
> context and renames the traditional '-c' output to "copied
> context".  Obviously it defines what the numbers on the hunk
> header lines mean quite precisely.

I don't argue it. But the descriptions of the format I've seen suggest
that the hunks of the proper unified diff format could be easily
syntactically separated, thus providing a way to check a patch for
correctness by comparing what is written in headers with what is
gathered by syntactic analysis. Git's signature makes this rather
difficult.

IMHO, putting extra lines that don't follow the patch format precisely
is an extension, and being an extension, it should better be compatible
with as many tools as possible, and this signature of the format-patch
is known to break at least one tool. Unfortunately I don't have the
document you mention, but I doubt it discusses extensions, and therefore
I'm afraid we won't be able to conclude from it if putting signature
just after the hunk is allowed by the format or not.

As for Emacs, the problem is not that it doesn't know what the numbers
of the hunk header lines mean, but that it needs to re-build them from a
patch that has been arbitrary edited and could potentially be broken
from the beginning. Therefore, it needs hunks to be clearly
syntactically separated to rebuild header numbers from the context.

> GNU folks even managed to insert text that allows a completely empty
> line (not a line with a single SP on it) to express a context line
> that is empty, which means...

Really? That's a surprise for me. What I can tell for sure, Emacs' diff
mode doesn't support this, as it does interpret plain empty line as a
hunk delimiter, at least in Emacs 22.1.

[...]
>> Therefore I repeat my question: are there any objections to add such an
>> empty line by format-patch?
>
> ... there is a strong objection, if you are talking about adding
> an empty line before "-- \n" that is in front of the GIT version
> signature: such an empty line would not help at all.

Yes, I'm talking about exactly this, and the fact is that it does help,
at least in Emacs case. [How comes you think I didn't check it before
posting?!]

> A broken implementation will just skip over such an empty line,
> counting it as a line common to both preimage and postimage, and will
> still miscount the e-mail signature separator "-- \n" as a line
> removed from the preimage.

Emacs doesn't do it when empty line is present, -- it considers empty
line as hunk delimiter (along with any line that doesn't start with ' ',
'+', '-', or '!'). BTW, it counts lines starting with either '#' or '\'
as comments, i.e., just ignores them when counting the number of lines
in the hunk.

> If we wanted to have a workaround to this issue, we could simply
> remove these last two lines, and that would a be much better one
> than an extra blank line.

Why? I think it's nice idea to put git version as signature, and I see
no reason to remove it.

Besides, if empty line is put there before the signature, it'd be more
readable for human beings as well, as humans seem to prefer to put empty
line before their signature anyway.

-- 
Sergei.
