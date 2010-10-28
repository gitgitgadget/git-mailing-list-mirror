From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] Introduce bulk-move detection in diffcore.
Date: Thu, 28 Oct 2010 13:20:00 -0700
Message-ID: <7vr5fa9ij3.fsf@alter.siamese.dyndns.org>
References: <1287868022-24872-1-git-send-email-ydirson@altern.org>
 <1287868022-24872-2-git-send-email-ydirson@altern.org>
 <7veibeitip.fsf@alter.siamese.dyndns.org> <20101025201227.GB3347@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Thu Oct 28 22:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBYxR-0007H5-0r
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 22:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934544Ab0J1UUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 16:20:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934541Ab0J1UUK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 16:20:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C5871A57;
	Thu, 28 Oct 2010 16:20:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/zLvuDhMhucw4SSamN25tdeIvVA=; b=JHpoK9
	Tf/NN+/oRVXZf5kLY9nZkMoLqqWMVa4Qtv8ujVPG4dDCIqhA45Oe2qVjFhpKgu6E
	rGajp2PznaiFQU4U1uTH7LxBmc/l7ZRXNElzWn9xvuCrPSoh5kV/ZujJ6+nZ73Rs
	DNR8Om1WCAqsvFStYXHpLP9QrSV/1Pttf7BEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H3wZZmuJ3U3iiCyOD10XJ2PSPviUMSUF
	wfe4FKb5gZaLp84+7hPXIGaQ+25mRRHuF9drOxcBPyp0MFPwX0X7h6eREvnAEliw
	c3Fhbj/xGB2h9lO/pofl6rZW9piorY3snc52S8uF0DZiRpdFj8e/qO+V6KR7yi1b
	1EcSlj6V13Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5791D1A55;
	Thu, 28 Oct 2010 16:20:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8022C1A4E; Thu, 28 Oct
 2010 16:20:02 -0400 (EDT)
In-Reply-To: <20101025201227.GB3347@home.lan> (Yann Dirson's message of
 "Mon\, 25 Oct 2010 22\:12\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0FD60BA-E2D0-11DF-8C63-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160220>

Yann Dirson <ydirson@free.fr> writes:

> OTOH, the quoting rules for diff output are quite minimalist, I don't
> know whether adding "*" as a character that requires quotes around the
> filename would be acceptable.

I suspect that would be an unacceptable entry to a slippery slope.

>> IOW, is the goal of this series
>> to use the "A/* -> B/" to label the change as bulk directory rename, if
>> the preimage has A/{1,2,3} and the postimage has their moved contents in
>> B/{one,two,three}?
>
> Yes.  But --hide-bulk-move-details would not hide them, as they would
> not be strictly included in the bulk move.  Desite their name change,
> they are however a confirmation that the contents of A/ was move to B/.
>
>> I am wondering about the utility of such an extra information.  If there
>> were no "a/file0 -> b/file3" entry in the example, I would imagine that we
>> could use this "a/* -> b/" information to move "a/file5" to "b/file5" when
>> rebasing this patch to apply to a different preimage that had files other
>> than file{1,2} in directory "a", and I would further imagine that might be
>> a wonderful thing.
>
> I imagined that as well, and that situation would not be a problem:
> since "a/file0 -> b/file3" would be there in the rebased patch,
> "apply" would be able to spot the possible conflict.
>
> OTOH, I had the vision of "merge does automatic moves" when starting
> this project, but got convinced on-list that there are always cases
> where the "automatic move" on merge would be wrong, and that we should
> report a conflict instead.
>
> That would mostly shift the problem to...

That would mostly make this patch not worth worrying about, wouldn't it?
What's the point of spending extra cycles to say "many things have moved
in the same direction" without turning it into a usable information?
