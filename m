From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Malformed branch name in fast-export when specifying
 non-HEAD/branch revision
Date: Wed, 17 Aug 2011 15:30:14 -0700
Message-ID: <7vliurd62x.fsf@alter.siamese.dyndns.org>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
 <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
 <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Owen Stephens <git@owenstephens.co.uk>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 00:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtoeh-0001Gy-0T
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 00:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab1HQWaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 18:30:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324Ab1HQWaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 18:30:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64E2F45BE;
	Wed, 17 Aug 2011 18:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jCRtJJnyGgVPhCICC2lTR66K6KY=; b=XJtfMh
	BfpTLGLaS8J1/1dtN8pqMfdak3xd/Gxee8ywU541vaukofrgiPEm+YKNAWRTEb07
	R6rw0HQaCk6cgxXE0du4rlI3y7qmf4U+0YLHcEVBYcrcuEnDtOh9EezLC+v1UDYL
	6TvfeQq4PPeq86FkS+3ZknTeZEucjc7NNM3Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eyiIrpt/SV1bK3CvllPEiTu7HOJJ6lmX
	U6+/maVpfO6OdgfNx3vnXK8Es7UwjpA6P/Zq3gKZJplkXs1f2Za6cmyJXqhBtuJ6
	sWrD1BMieJryJeB0DOSSN2wryLEbklOj74x4nZoYxF9x5UIoLYCO8QjM07TZ9Soy
	nJibPOPLZ4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BDD545BD;
	Wed, 17 Aug 2011 18:30:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A28F45BC; Wed, 17 Aug 2011
 18:30:16 -0400 (EDT)
In-Reply-To: <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com> (Elijah
 Newren's message of "Wed, 17 Aug 2011 13:36:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B191BE8-C920-11E0-969C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179542>

Elijah Newren <newren@gmail.com> writes:

>> $ # uses HEAD~1 instead of refs/heads/master
>> $ git fast-export HEAD~1
>>
>> blob
>> mark :1
>> data 0
>>
>> reset HEAD~1
>> commit HEAD~1
>
> Thanks for the report.  It turns out this bug has been reported and is
> in the testsuite as t9350.19 -- currently marked as expected to fail.
> I looked at the problem a couple years ago for a little bit but never
> finished that particular patch and never got back around to it.

What _should_ be the right behaviour to begin with, I have to wonder.

Even though it is very clear that the set of objects that are exported are
defined by the "rev-list arguments" given to the command, I do not think
fast-export's semantics is not clearly defined as to what "refs" are to be
updated.

The easiest fix for this issue would be to forbid "git fast-export HEAD~1"
(or any range whose positive endpoints are _not_ refs), and I think that
would be in line with the original motivation of the command to export the
whole repository in a format fast-import would understand.  The original
f2dc849 (Add 'git fast-export', the sister of 'git fast-import',
2007-12-02) says "This program dumps (parts of) a git repository...",
implying that partial export is within the scope of the command, but I do
not think it was designed carefully enough to deal with ranges more
complex than just "a set of branches".

I however have a feeling that people would want to say:

 - I want to export up to that commit, and have that commit on this branch
   on the importing side; or even better

 - I want to export up to that commit, but what refs points at the commits
   contained in the output stream will be decided when the output is
   imported.

I do not think the latter meshes well with how "fast-import" works,
though.  But fast-export should be fixable to allow the former without
breaking the semantics of fast-import.

You can think of "fast-export" an off-line "push" command [*1*]; instead
of giving a random commit object, e.g. "git fast-export HEAD~1", that can
not be used as a ref, you can use the refspec notation to tell where the
result should go, e.g. "git fast-export HEAD~1:refs/heads/a-bit-older",
from the command line of fast-export.

I suspect that also may clarify what Sverre was trying to do in his recent
series. The root cause of both this and the issue Sverre wanted to fix is
the design mistake of fast-export that tries to reuse the notation of
object range specification for a different purpose of telling which "ref"
to update, I think.

[Footnote]

*1* In a similar sense, unpacking "git bundle" output is an off-line
"fetch"; the bundle creator gave anchor points for tip objects, and allows
the unpacker to map them into its own namespace.
