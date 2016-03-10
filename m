From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Thu, 10 Mar 2016 13:26:08 -0800
Message-ID: <xmqqbn6mdnyn.fsf@gitster.mtv.corp.google.com>
References: <20160307221539.GA24034@sigill.intra.peff.net>
	<xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
	<20160308121444.GA18535@sigill.intra.peff.net>
	<CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
	<20160308132524.GA22866@sigill.intra.peff.net>
	<20160310122020.GA24007@lanh>
	<20160310211052.GC30595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:26:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae86F-0000lN-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbcCJV0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 16:26:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932377AbcCJV0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 16:26:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63C3449855;
	Thu, 10 Mar 2016 16:26:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B4KqzsVDxkNLaJ4qr40ZdGj6dnA=; b=BPBhAc
	dQS0o1G8xSykBDq+HkfOaFosQQt5b2mHCyUuQDUTdfdN68KOkGUJztjHo9KeUO/A
	5UjZlpKiogH1oAwUVnISCkkbD/f+OeH+walUFcLhC8cO2VF2VHtVd+W+KNNC9EXc
	2X/8Vt3fb5hCcn/P2KxGy7WyemrOdIk0SvjPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=apdiZiakR5VMF7LjWpizgWsy5J5ixbmc
	f1Ilu6q5T6MIYOPk16IkPmQiv5p7K0DSXF1NpL51xTJes/7g8t15RI3JUYJ+vE8P
	zGni9dqMROgo9JhQL5ItopUqSvqUsmFF/xMExBsNMNNoxM8mEBdoEwQqOAS81Rua
	dfzlqvsujPg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5AA9949854;
	Thu, 10 Mar 2016 16:26:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CC3C949853;
	Thu, 10 Mar 2016 16:26:09 -0500 (EST)
In-Reply-To: <20160310211052.GC30595@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 10 Mar 2016 16:10:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B5144652-E706-11E5-9F9A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288643>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 10, 2016 at 07:20:20PM +0700, Duy Nguyen wrote:
>
>> > +	else if (shallows.nr > 0) {
>> > +		struct rev_info revs;
>> > +		struct argv_array av = ARGV_ARRAY_INIT;
>> > +		struct commit *c;
>> > +		int i;
>> > +
>> > +		argv_array_push(&av, "rev-list");
>> > +		argv_array_push(&av, "--boundary");
>> 
>> Nice. I didn't know about --boundary. But will it work correctly in
>> this case?
>> 
>>        --- B ---- C ---- F
>>           /      /
>>      --- D ---- E ---- G
>> 
>> C and D will be current shallow cut points. People "want" F and G.
>> "rev-list --boundary F G ^C ^D" would mark E as boundary/shallow too,
>> correct? If so the history from G will be one depth short on a normal
>> fetch.
>
> IMHO, that is the right thing. They asked for "C" as a shallow cut-off
> point, so anything that is a parent of "C" should be omitted as shallow,
> too. It has nothing to do with the numeric depth, which was just the
> starting point for generating the shallow cutoffs.

I think that is the right mental model.  The statement that "C and D
are current cut points" does not make much sense.  As you cannot
rewrite parents of commits after the fact, you cannot construct a
case like "when the shallow clone originally was made, two histories
were forked long time before B and D, and the cloner ended up with C
and D as the cutoff point, but now that we have the ancestry linkage
between B and D (and C and E), we need to make E a new cutoff".  The
original "shallow" implementation does not store "starting point +
number of depth" and instead translates that to the cut-off point
for this exact reason.

> Yeah, we definitely need an extension. I'm not sure if the extension
> should be "I know about spontaneous shallow/deepen responses; it's OK to
> send them to me" or "I want you to include the shallow points I send as
> boundary cutoffs for further shallow-ing of newly fetched history".
>
> They amount to the same thing when implementing _this_ feature, but the
> latter leaves us room in the future for a client to say "sure, I
> understand your spontaneous responses, but I explicitly _don't_ want you
> to do the boundary computation". I don't know if that is useful or not,
> but it might not hurt to have later on (and by adding it now, it "just
> works" later on with older servers/clients).

I am not sure what distinction you are worried about.  An updated
client that is capable of saying "you may give shallow/deepen
responses to me" can optionally be told not to say it to the server,
and that is equivalent to saying "I don't want you to send them", no?
