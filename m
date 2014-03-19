From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Wed, 19 Mar 2014 15:11:22 -0700
Message-ID: <xmqqlhw5260l.fsf@gitster.dls.corp.google.com>
References: <1395232712-6412-1-git-send-email-dak@gnu.org>
	<xmqq38id3nfs.fsf@gitster.dls.corp.google.com>
	<87ob11g9st.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:11:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQOhx-0002Vj-Am
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 23:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724AbaCSWL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 18:11:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52187 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754962AbaCSWL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 18:11:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 563197593C;
	Wed, 19 Mar 2014 18:11:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9UcD+EOm7yVJQP1HFJvTpzJE42Q=; b=ndcDa4
	k1kES0a8HqPtZ7lXAXhjOFj3yuP9cOYZfmkDpmJjiYuTDoV7Hyru6f9iX7Wjsxcd
	5WiKRbCzYgKzx4fz7z3U2ZtuKdAjN6wSvsgugS5k8chiz/pcp1qDYctIoirb0/np
	0dbvYGFl7C3PhXfMl6V+O+iJTWodUAx7vTz/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gov+rmKg9o2hQyVt220ep8tKHRTKJ+9t
	dfTiqi1bNDJ9VKuyGQMOl/boy/qq3UgXtx3hjfpzyBN+UIWB/qxMbjxyQxQ9dmYD
	RAyNp4VvdQ+8mbu1EWtByzyl9HQ5fMWPoBdHNhKaA70HySot2kGpoeO6N/jMJzFf
	JOjIOHKSaro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 421247593B;
	Wed, 19 Mar 2014 18:11:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E47A75931;
	Wed, 19 Mar 2014 18:11:24 -0400 (EDT)
In-Reply-To: <87ob11g9st.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 19 Mar 2014 22:25:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 68ABB3D6-AFB3-11E3-9496-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244501>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> The default of 16MiB causes serious thrashing for large delta chains
>>> combined with large files.
>>>
>>> Signed-off-by: David Kastrup <dak@gnu.org>
>>> ---
>>
>> Is that a good argument?  Wouldn't the default of 128MiB burden
>> smaller machines with bloated processes?
>
> The default file size before Git forgets about delta compression is
> 512MiB.  Unpacking 500MiB files with 16MiB of delta storage is going to
> be uglier.
>
> ...
>
> Documentation/config.txt states:
>
>     core.deltaBaseCacheLimit::
>             Maximum number of bytes to reserve for caching base objects
>             that may be referenced by multiple deltified objects.  By storing the
>             entire decompressed base objects in a cache Git is able
>             to avoid unpacking and decompressing frequently used base
>             objects multiple times.
>     +
>     Default is 16 MiB on all platforms.  This should be reasonable
>     for all users/operating systems, except on the largest projects.
>     You probably do not need to adjust this value.
>
> I've seen this seriously screwing performance in several projects of
> mine that don't really count as "largest projects".
>
> So the description in combination with the current setting is clearly wrong.

That is a good material for proposed log message, and I think you
are onto something here.

I know that the 512MiB default for the bitFileThreashold (aka
"forget about delta compression") came out of thin air.  It was just
"1GB is always too huge for anybody, so let's cut it in half and
declare that value the initial version of a sane threashold",
nothing more.

So it might be that the problem is 512MiB is still too big, relative
to the 16MiB of delta base cache, and the former may be what needs
to be tweaked.  If a blob close to but below 512MiB is a problem for
16MiB delta base cache, it would still be too big to cause the same
problem for 128MiB delta base cache---it would evict all the other
objects and then end up not being able to fit in the limit itself,
busting the limit immediately, no?

I would understand if the change were to update the definition of
deltaBaseCacheLimit and link it to the value of bigFileThreashold,
for example.  With the presented discussion, I am still not sure if
we can say that bumping deltaBaseCacheLimit is the right solution to
the "description with the current setting is clearly wrong" (which
is a real issue).
