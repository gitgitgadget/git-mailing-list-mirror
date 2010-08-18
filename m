From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] commit: add parse_commit_repl() to replace
 commits at parsing time
Date: Wed, 18 Aug 2010 07:50:24 -0700
Message-ID: <7vr5hw9dqn.fsf@alter.siamese.dyndns.org>
References: <20100817015901.5592.25471.chriscool@tuxfamily.org>
 <7vbp91aqfk.fsf@alter.siamese.dyndns.org>
 <AANLkTimu0r_3L7_YJgfMVb6saFOyOK-mHLiKyTG_6Q5O@mail.gmail.com>
 <201008180607.54675.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Aug 18 16:50:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OljyY-0001hS-7E
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 16:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab0HROuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 10:50:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab0HROug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 10:50:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BAFFECE653;
	Wed, 18 Aug 2010 10:50:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1nSs73Vt9H+rLA2JwpJY3c+sZ94=; b=Jb7+Yh
	GwcQIcI/Njx1oY/g1XOTfS71CE1Ro5CnzvMJWynI6Lk9lHyQVURgRp5/UymaG82O
	qrROXpM8oBG0MtMJpIOpTrAXE7/LUY8xVanwQ4mrfoTSzmaObdDxpaTBVhA50hD7
	02ByV9Am2EuixJsWm8ucJCbLtHXVBSWpyHwzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rC/Rwvxr7W/o/BpGm8RL5ztPEJaOa8nL
	7oheduhGk2qwTpED09yweU+JJ8XPQFsdo1NWQC0neVVNMhHqoY5V3lSh94ngDlbG
	gdahCJQ4Dcl7g10jLVFHXeZhSdkTsD8DVCf4z0ecBIp0S+qnWBQkYUX97nBtqNCd
	A/rrglm/n6o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 86847CE64F;
	Wed, 18 Aug 2010 10:50:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 783DDCE64B; Wed, 18 Aug
 2010 10:50:26 -0400 (EDT)
In-Reply-To: <201008180607.54675.chriscool@tuxfamily.org> (Christian Couder's
 message of "Wed\, 18 Aug 2010 06\:07\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F2F501DA-AAD7-11DF-9080-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153859>

Christian Couder <chriscool@tuxfamily.org> writes:

> On Wednesday 18 August 2010 05:17:52 Nguyen Thai Ngoc Duy wrote:
>> On Wed, Aug 18, 2010 at 7:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Christian Couder <chriscool@tuxfamily.org> writes:
>> >> The function parse_commit() is not safe regarding replaced commits
>> >> because it uses the buffer of the replacement commit but the object
>> >> part of the commit struct stay the same. Especially the sha1 is not
>> >> changed so it doesn't match the content of the commit.
>> > 
>> > This all sounds backwards to me, if I am reading the discussion
>> > correctly.
>> > 
>> > If a replace record says commit 0123 is replaced by commit 4567 (iow,
>> > 0123 was a mistake, and pretend that its content is what is recorded in
>> > 4567), and when we are honoring the replace records (iow, we are not
>> > fsck), shouldn't read_sha1("0123") give us a piece of memory that stores
>> > what is recorded in 4567, parse_object("0123") return a struct commit
>> > whose buffer points at a block of memory that has what is recorded in
>> > 4567 _while_ its object.sha1[] say "0 123"?
>> 
>> 1. parse_object() as it is now would return object.sha1[] = "4567".
>> 2. lookup_commit(), then parse_commit() would return object.sha1[] =
>> "0123".
>> 
>> > What problem are you trying to solve?
>> 
>> Inconsistency in replacing objects. I have no comments whether #1 or
>> #2 is expected behavior. But at least it should stick to one behavior
>> only.
>
> We discussed this inconsistency in this thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/152321/ 
>
> So we can resolve the inconsistency with Duy's patch to make parse_object() 
> return object.sha1[] = "0123".
>
> It's simpler and probably safer. The downside is that the sha1 will not be 
> consistent with the content anymore and that it will be more difficult to 
> realize that an object has been replaced as there will be no sha1 change to be 
> seen.

I do not see it as a downside at all.

If the user wants to take replaced objects, they should be shown just like
an ordinary objects at the machinery level.

Of course, the user is free to add comments on the commit log to note the
fact that a new commit is replacing some other commit and for what
purpose.  Also if somebody really wants to, cat-file piped to hash-object
can be used to see the difference.
