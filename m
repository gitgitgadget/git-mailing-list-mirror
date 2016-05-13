From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Fri, 13 May 2016 09:37:19 -0700
Message-ID: <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
	<20160513103621.GA12329@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Fri May 13 18:37:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1G5h-0007mm-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 18:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbcEMQhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 12:37:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753021AbcEMQhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 12:37:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F87417DC7;
	Fri, 13 May 2016 12:37:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AEgNItpCz7ojAHueZ22PGHshWAU=; b=Px5qzQ
	0JdJtYZpj3MOD1FgaNV7ZGf9CkrBKnkNWVGgpRC0Vlk5np6Mf9z2k1ReQhCGEeVU
	IQnPj7BOAY8dmiy7cptjQFsdE1oIbMGZpr0AyrNeno7Qb8QDCjo7daCYCpvrwAtU
	5/C8DX0qcSBlR/SzgTUgA0xaG/sMXCxdw+t4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UpriT/rDVDKsMr/mQ6Alkt12n56J+/xo
	HOlmlPUywbVZ7LLGyxx38SULmDt/485acRNE8NKo0M3QoXJIFMj2q81vzvvfQLFr
	TXOcRSM4wgBwalNg3eKiKsaT1xrmCVHCuINXMlazz4eADFIK3jcZs5AJGXLl9PIn
	fk5r7JZgI5k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9681D17DC5;
	Fri, 13 May 2016 12:37:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 196B817DC3;
	Fri, 13 May 2016 12:37:21 -0400 (EDT)
In-Reply-To: <20160513103621.GA12329@dcvr.yhbt.net> (Eric Wong's message of
	"Fri, 13 May 2016 10:36:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6C98E6E-1928-11E6-888D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294542>

Eric Wong <e@80x24.org> writes:

> Lars Schneider <larsxschneider@gmail.com> wrote:
>> Hi,
>> 
>> t9801 and t9803 seem to be broken on next. A quick bisect indicates that d9545c7 
>> "fast-import: implement unpack limit" might be the reason. (@gmane/292562).
>> 
>> Did anyone look into that already?
>
> Just took a look (no p4, so couldn't run tests) and I guess it's
> because the default changed and it doesn't generate tiny packs.

I looked at t9801 but I couldn't spot where it cares if the objects
are in a (tiny) pack or stored as individual loose objects.  All the
counting I saw was about rev-list/log output and they shouldn't care.

Are you saying that "git p4" itself breaks unless fast-import always
writes a new (tiny) packfile?  That sounds quite broken, and setting
unpacklimit to 0 does not sound like a sensible "fix".  Of course,
if the test script is somehow looking at the number of packs or
loose objects and declaring a failure, even when the resulting
history in p4 and git are correct, then that is a different issue,
and forcing to explode a tiny pack is a reasonable workaround.  I
couldn't quite tell which the case is.

Puzzled.  Please help.

> The easiest change is probably to call:
>
> 	git config fastimport.unpackLimit 0
>
> during setup like t9300 now does.
