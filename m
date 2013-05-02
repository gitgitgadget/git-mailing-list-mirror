From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] index-pack, unpack-objects: add --not-so-strict for connectivity check
Date: Thu, 02 May 2013 09:27:53 -0700
Message-ID: <7vvc711h4m.fsf@alter.siamese.dyndns.org>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-5-git-send-email-pclouds@gmail.com>
	<7vvc722s0h.fsf@alter.siamese.dyndns.org>
	<CACsJy8A2dYssdV7JHutYKgo-nZswBAuedXoJ=aygrVSR=JeTrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 18:28:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXwMU-0008UH-8I
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 18:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760696Ab3EBQ15 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 12:27:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760689Ab3EBQ14 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 May 2013 12:27:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB7BF1BC18;
	Thu,  2 May 2013 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=58mTu/YZIw6j
	dt2Bb2f/LAD0BRY=; b=LZMGjEy6okinn22AL5HWRZrY4osDo6u+80dXS676E5ji
	SZ7Y/lsxBD9FkRwKBLh6ySawYtBDLX2WskaT4xPeYisl7/iPm6YgbMSS/OgAgllq
	Nb+1re+4SgnhDQS3A+UKklIAm/AvWeZy3540ZtV46AhuHR9R+f6TwAi2gb2smHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MugVD5
	0Bannft4iJnDsKia0edNFmPkRaQ65hcZkxyHPi5MSEoqWYhRtb8BdypiGPla2IJC
	0O+S742BvAecaLgBuFS/sNzSJpUBpaD1LUC/83lDOhiJpcwRbQCuuVE5uWpWYfzu
	0Lc2Vcieen+Z2DT0CL0b3N065HrvuWB3muxBk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E31211BC17;
	Thu,  2 May 2013 16:27:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56A011BC15;
	Thu,  2 May 2013 16:27:55 +0000 (UTC)
In-Reply-To: <CACsJy8A2dYssdV7JHutYKgo-nZswBAuedXoJ=aygrVSR=JeTrw@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 2 May 2013 16:53:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E493052-B345-11E2-81D7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223218>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, May 2, 2013 at 6:35 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> --not-so-strict only checks if all links from objects in the pack
>>> point to real objects (either in current repo, or from the pack
>>> itself). It's like check_everything_connected() except that:
>>>
>>>  - it does not follow DAG in order
>>>  - it can detect incomplete object islands
>>
>> Could you clarify what this second point means?
>>
>> "rev-list --objects --all --not $this $that" does not detect
>> "islands" but checking with the updated index-pack does?
>
> Object islands (in the new pack) by definition are not connected to
> the main DAG and so invisible to/unreachable from rev-list. index-pac=
k
> examines all objects in the pack and checks links of each object. Wit=
h
> this approach, islands are no different than reachable objects.

OK, so if you are fetching an updated tip of the main history, and a
new tip of a history that is disjoint. If we imagine that my public
repository just added the 'todo' branch and you are fecting them for
the first time. The history of 'todo' branch is an island that is
not connected anywhere from your refs namespace yet. In order to
ensure that updating the tip of fetched 'todo' is safe, you would
need to verify the island is free of dangling pointers and the only
thing you need to be sure is the tip of 'todo' is _in_ that island.

>> I am guessing that the code assumes that we are updating our refs to
>> objects that are in the pack that we are looking at, and I can see
>> how the new check in sha1_object() may detect an object that points
>> at another object that is missing.  But that assumption (which I
>> think is correct) is probably the most important thing to say in the
>> log message.
>
> Yes, we need to make sure the new value of our refs are existing
> objects. But it does not need to be in the new pack.

It is a bit more tricky than that.  A malicious (or simply buggy)
other side can send a subset of my 'todo' branch, which is an island
that is free of dangling pointers (think: 'rev-list --objects
todo~8').  Further imagine that you earlier attempted a fetch of the
same history from me over a commit walker and you happen to have
partial history near the tip of 'todo' but not connected to the
island.  sha1_object() will find it, but that does not say anything
useful.  The tip _must_ appear in the island for your check to yield
a usable result, no?

The existing "everything connected" was designed to protect against
that kind of breakage as well.

I might be reading your change incorrectly, but I am not sure how
the new code protects against such a breakage.

> After index-pack
> is run, we're guaranteed that all objects in repo are connected and
> any of them could be new ref. This is also why I add has_sha1_file()
> in clone.c.
