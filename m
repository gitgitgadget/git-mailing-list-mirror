From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fast-import deltas
Date: Tue, 01 Apr 2014 15:32:49 -0700
Message-ID: <xmqqlhvoy92m.fsf@gitster.dls.corp.google.com>
References: <20140401102554.GA32231@glandium.org>
	<20140401114502.GA15549@sigill.intra.peff.net>
	<20140401130703.GA1479@glandium.org>
	<20140401131512.GA19321@sigill.intra.peff.net>
	<20140401141856.GA2497@glandium.org>
	<xmqqk3b90y79.fsf@gitster.dls.corp.google.com>
	<20140401221003.GA5923@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 11:13:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVdeW-0004JW-RY
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbaDAWcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 18:32:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbaDAWcx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 18:32:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57FA579E29;
	Tue,  1 Apr 2014 18:32:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=My5U/PC6PR/CXR4eljWY3W2Xs5E=; b=ZUh9db
	IFA85cfkJNrlkdaqkkzsbatPDaQ3M/X4IfAKUQTD1yjI5Bku26UvUBzol99/ColH
	9jz9NIoebAnaciB20UeMsp+p5rrhzG2zT4dMbYl6Ie7HuBZshoxIj5dWa/uKeXV8
	Zeyovuw3uHMsoUkYXfpLxM8DGLuphdn0HlRiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fROlNqja6WfJoRwcpqkTQLTXZlbIl+9a
	zaXv3ZWD6V+sY7uZl/iZWuPhqZndRoQEYfSsvg1EyBpv2WBiRg7Asxely+AHE/1c
	ZUwTmYj98hjtjbrjK/xti67lsw3c7ucFtx2vulzp3Sudk+0y04erKlcMFjYr2xe1
	a/jbaszj/zc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43DAF79E28;
	Tue,  1 Apr 2014 18:32:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 917ED79E23;
	Tue,  1 Apr 2014 18:32:51 -0400 (EDT)
In-Reply-To: <20140401221003.GA5923@glandium.org> (Mike Hommey's message of
	"Wed, 2 Apr 2014 07:10:03 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F6F0AEC-B9ED-11E3-852C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245669>

Mike Hommey <mh@glandium.org> writes:

> On Tue, Apr 01, 2014 at 10:14:02AM -0700, Junio C Hamano wrote:
> ...
>> Unless you already have your change in the xdelta on hand, or the
>> format your foreign change is in gives sufficient information to
>> produce a corresponding xdelta without looking at the content that
>> your foreign change applies to, it is silly to try to convert your
>> foreign change into xdelta and feed it to fast-import.
>
> The patch format I'm getting from mercurial boils down to:
>   - replace N bytes from offset in the source material with the given
>     M bytes.
> Which can easily be converted to xdelta without looking at the original.

If that is the case, and if you can identify the original in a way
fast-import can understand, it might be interesting [*1*] to add support
for accepting <base object, xdelta> pair in place of blob data, as
Jonathan already hinted earlier.

It would not be sufficient for the receiving fast-import to store
the delta data to its output---it needs to make sure that the base
object is stored in the same output file as well, but that should
not be too complicated.


[Footnote]

*1* I am still not sure how useful the feature would be outside
slurping from Hg and Git---for obvious reasons, though.  As long as
the change is to a cleanly isolated codepath, it would be OK, I
guess.
