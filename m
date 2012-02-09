From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Thu, 09 Feb 2012 11:04:02 -0800
Message-ID: <7vk43vx1zx.fsf@alter.siamese.dyndns.org>
References: <4F3120D4.1050604@warmcat.com>
 <7vvcni1r5u.fsf@alter.siamese.dyndns.org>
 <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org>
 <CAHkRjk6dr=5wxm+iSC2_CSB-q3k2WG_Um+X7dwsy-H8tL508EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	=?iso-2022-jp?B?QW5keSBHcmVlbiAoGyRCTlMwQlcvGyhCKQ==?= 
	<andy@warmcat.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 20:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZHy-0002O3-2C
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 20:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289Ab2BITEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 14:04:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757631Ab2BITEG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 14:04:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C1067B01;
	Thu,  9 Feb 2012 14:04:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=H6DC2Gz4D5h1
	NR95eOzwl41/6Qw=; b=yAFIobLsC7Dv9CAd6lFlpNXy7fBqFhpl+JK8FaTF57ca
	z279cTMcAor0GFr2ziIuoIS30PVVvnaj0jAkSgnyUO5mv1es2tkVZYW9+No+FySE
	dwK/FJbGNPnpDrzsSAXl0atCPyJh5PstFXGzOdNQctP5hytOl008DtC9gvIGt/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GmseOW
	KpRKCWc7B/d3nNpVRwvxQYW9gkshP/L8CTqYZSEWWMCUoTWn3ulqPYGYiynhpn6Y
	Xc68b/Z0P7c9WuIHRHWbVWw9jhAu0PExAkRpVw4hl9IkbW5SA4Dc0FRBL/xfoD9+
	D+d5baWlpoBFcqweGAIB+7iFOvzP3NO+OmsdE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 034017B00;
	Thu,  9 Feb 2012 14:04:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 381937AFD; Thu,  9 Feb 2012
 14:04:04 -0500 (EST)
In-Reply-To: <CAHkRjk6dr=5wxm+iSC2_CSB-q3k2WG_Um+X7dwsy-H8tL508EA@mail.gmail.com> (Catalin
 Marinas's message of "Thu, 9 Feb 2012 09:38:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D58297A2-5350-11E1-839B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190307>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> On 8 February 2012 07:33, Junio C Hamano <gitster@pobox.com> wrote:
>> To allow parsing the header produced by versions of Git newer than t=
he
>> code written to parse it, all commit parsers are expected to skip un=
known
>> header lines, so that newer types of header lines can be added safel=
y.
>> The only three things that are promised are:
>>
>> =C2=A0(1) the header ends with an empty line (just an LF, not "a bla=
nk line"),
>> =C2=A0(2) unknown lines can be skipped, and
>> =C2=A0(3) a header "field" begins with the field name, followed by a=
 single SP
>> =C2=A0 =C2=A0 followed by the value.
>
> Thanks for looking into this. Is this the same as an email header? If
> yes, we could just use the python's email.Header.decode_header()
> function (I haven't tried yet).

If you are thinking about feeding everything up to the first empty line=
 to
whatever is designed to parse email header, please don't.  I do not thi=
nk
they obey "skip unknown lines without barfing" rule [*1*], so we would =
be
back to square one if you did so.

The fix posted in this thread is necessary because the change to StGit
between v0.15 and v0.16 made to ignore lines starting with "encoding " =
was
a wrong way to work around the broken parser in v0.15 in the first plac=
e.
The parser assumed that (1) all whitespaces around the header lines can=
 be
stripped, (2) the result after such stripping will always have at least
one whitespace so that line.split(None, 1) will never barf, and (3)
between the field name and its value there may be arbitrary number of
whitespace characters that can be ignored so that line.split(None, 1) i=
s a
safe way to split it into a (key,value) pair.  None of which is a safe
thing to assume.  The rule for safe parsing is to ignore all lines it d=
oes
not understand without assuming anything, and I wrote the patch in this
thread to make sure it makes no such unwarranted assumption.

> BTW, does Git allow custom headers to be inserted by tools like StGit=
?

The header format is designed in such a way that it is safe for a parse=
r
to silently ignore unknown cruft, but that also means tools that work o=
n
an existing commit and produce a similar one, like "commit --amend", ar=
e
free to either ignore and drop them when creating a new commit out of t=
he
original one, or replay it verbatim without adjusting them to the new
context they appear in.  In that sense, they are technically "allowed",
but depending on the nature of the information you are putting there, i=
t
semantically may or may not produce the desired result [*2*].  I would =
say
it is strongly discouraged to invent new types of header lines without
first consulting the people who maintain tools you must interoperate wi=
th,
so that they will also be aware of them, and hopefully their tools can =
be
adjusted to help you use them.

Sorry for the breakage and making you to deal with this post release. W=
e
observed that recent StGit did not barf after we added "encoding " fiel=
d
to Git, and assumed that StGit correctly ignored lines that it did not
understand, without inspecting its code.

At least we should have Cc'ed you guys directly when the change was bei=
ng
discussed on the list.


[Footnote]

*1* I also suspect that it will handle a line that begins with a single=
 SP
differently if you use email parsing rules. In a commit object header, =
the
content of such a line is appended to the value of the previous field
after turning that leading single SP into a LF, and the resulting value
will be a string that consists of multiple lines. The header folding ru=
le
used for e-mail in RFC2822 is a way to represent a (logically) single l=
ine
as physically multiple lines, so the result of unfolding will become a
single line.  This difference may not matter for the purpose of the
current StGit that understands nothing but tree/parent/author/committer=
,
but because we are discussing a forward-looking fix for its parser, I
wouldn't recommend "it does not matter because we do not currently care=
"
approach.

*2* For example, a line that begins with "gpgsig " is a field that reco=
rds
the GPG signature of a commit itself (using "git commit -S"), and it
should not survive across "commit --amend".  A line that begins with
"mergetag " is a field that records the tag information that was merged
from a side branch, and amending such a merge does not change what was
merged, so it should survive across "commit --amend".
