From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Sun, 08 Mar 2015 13:36:32 -0700
Message-ID: <xmqqr3szql9r.fsf@gitster.dls.corp.google.com>
References: <20150302092136.GA30278@lanh>
	<1425685087-21633-1-git-send-email-sbeller@google.com>
	<xmqqr3t1vefz.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZBYFSwR6E86BF6Dt7xdh0zs07tkGnQAKfEJpSduTK-aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 21:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUhwG-0005Ne-Vj
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 21:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbbCHUgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 16:36:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751779AbbCHUgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 16:36:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ACB33D0AE;
	Sun,  8 Mar 2015 16:36:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I4k5Q/aTwn4K865OdytDtN9wL+8=; b=SwhnrO
	beQxMq0cclZopT9vuCkgh3jvWZYWtUPPgxzwDyVt7lCXH9v73xeQR4WMRL6Lzh1W
	N80IRBn4bG3sOXSNox1sUp1vjocizAICyBdOQROq429yZnsIRwrgwEdVe/A5uXfq
	gRYSCNxYKC7aimmKP1PleiLwVQpT+oKFe42ck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cPtkL4VEwO2PFTk8+iOj93oSiQ9Xc7yr
	JFjXEP5QSL3nQiwmu/AlUlEui2lIC21NLmpTnfrT2RWOstxKZcOV25OBOMHdvA26
	EGFsqetJ9hBcjrQjWJSjzdwF5r3+nryrxyAZ1+PrWgl/Rj80NOBPGEKGOz6KoT2w
	kaUYBdKUqsQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 109E73D0AD;
	Sun,  8 Mar 2015 16:36:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 884E83D0AC;
	Sun,  8 Mar 2015 16:36:33 -0400 (EDT)
In-Reply-To: <CAGZ79kZBYFSwR6E86BF6Dt7xdh0zs07tkGnQAKfEJpSduTK-aw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 6 Mar 2015 20:28:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF109C14-C5D2-11E4-8928-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265109>

Stefan Beller <sbeller@google.com> writes:

>> I do not see a good reason why we want "I am sending N caps"
>> upfront, instead of "this, that, and here is the end of the group".
>
> I thought about having an end marker, so something like
> capabilities start
> thin-pack
> lang
> ofs-delta
> capabilities done
>
> (Each line a pkt-line)
>
> Though all decisions I thought through I tried to put more weight on
> future expandability. Now that I think about it again, it makes no
> difference, whether to use a counter or an end marker.

One reason why I would suggest avoiding "count upfront" is to make
sure we do not repeat the mistake of "Content-Length" which had to
later be corrected by introducing chunked transfer by HTTP folks.
Closer to home, our "type and then size upfront and then contents
and hash the whole thing" loose object format makes it quite hard
to produce without having the whole thing in-core, or otherwise
having a separate way to know the size upfront.

For the capability list, the number of the capabilities you support
may be limited, bounded and may even be known at the compile time,
so count-upfront may not be a burden, but in other parts of the
protocol where you need to feed the result of computation to the
other end, you would need "the group ends here" marker.  It would
be easier for everybody if we can make all types of messages use
the same syntax, regardless of type.

>>> +  cap              =  PKT-LINE("capabilities" SP size LF list)
>>
>> Isn't a cap packet terminated by LF without any "list" following it?
>> The notation PKT-LINE(<blah>) is "wrap <blah> in a single packet",
>> and I do not think you meant to send the capability line and a series
>> of cap:foo entries in a single packet.
>
> Yeah I meant to use one packet per line
> So after considering your input, you'd want to have
> PKT-LINE("capabilities start")
> PKT-LINE("no-prefix-for-capabilities")
> PKT-LINE("ofs-delta")
> PKT-LINE("agent-as-capability-2.6")
> PKT-LINE("capabilities end")

OK, so that "list" at the end is just a typo; there shouldn't be
"list at the end inside PKT-LINE().

>>> +  size             =  *DIGIT
>>> +  capability-list  =  *(capability) [agent LF]
>>> +  capability       =  "cap:" keyvaluepair LF
>>> +  agent            =  keyvaluepair LF
>>
>> I do not see a reason to make 'agent' as part of capability.  That
>> was an implementation detail of v1 but v2 does not have an
>> obligation to consider agent announcement as capability.
>
> So I think we don't want to drop the agent announcement as it may
> reveal useful information ("How many outdated clients connect to our
> $HOSTING_SITE?", "I need to debug failures which happen only rarely,
> Oh! it can be narrowed down to clients with agent xyz.")

Don't be overly defensive and try not to misunderstand and see a
criticism where there is none.  All I am saying is that agent
announcement is not annoucing capability.  You may announce many
things, and server or client version may be something you would want
to announce.

I have a feeling that it is a bit too premature to specify the
details at such a low level as "capaiblities are announced by
prefixing four-byte 'c', 'a', 'p', ':' in front" and "a multi-record
group has its element count at the beginning (or an end marker at
the end, for that matter)", and it may be a better idea to outline
all the necessary elements at a bit higher level first---that would
avoid needs for useless exchanges like what we are having right now.

It's that when you write things in EBNF, you are writing something
that you would eventually want to cast in stone, and the
non-terminal names in EBNF matter (they convey the semantics, what
these named things are), and I was reacting to that because I wanted
to make sure we avoid mislabaling things as something that are not.

The "shallow" vs "reference advertisement" is the same.  I think the
former is _not_ part of reference announcement but is an optional
phase of the protocol, but the level of the detail that would make
the difference matter would appear only when you start writing it in
EBNF and call both "reference advertisement".  If you keep the
discussion at the level like "fetch first asks capabilities it wants
upload-pack-2 to enable, optionally gives the current shallow
boundaries when the capaibilty says the other side supports it, and
then starts showing what it has" while we are trying to achieve
concensus on what kind of protocol elements we would need, and what
information each element would carry, the discussion will help us
reach a shared understanding on what to write down in EBNF form
exactly faster, I would imagine.
