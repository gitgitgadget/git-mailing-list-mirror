From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Case rename not detected
Date: Mon, 04 May 2015 23:17:55 -0700
Message-ID: <xmqqzj5jeeek.fsf@gitster.dls.corp.google.com>
References: <CAGHpTBJuRCrg5jL7Anm9kxGJEf5cUmPzDToZG0UXeT_xNMWfsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 08:18:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpWB9-0005za-RD
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 08:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068AbbEEGR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 02:17:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756057AbbEEGR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 02:17:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1CA844744;
	Tue,  5 May 2015 02:17:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kYj9X3Wtlj4lwQ6C1iIg6S6A3is=; b=Jj9m99
	vCojInv+J8bEEcs62vtXnVhWAKr/t8E+nDkFIaIzbvnfq2UK74yAS01R0rjeFGv7
	3445vP1/ktg0VnJGeKynEHiHHkqKAmGERH2Y3N9Mp8Mkt+AHjs0q1A+IjhRD8Wqx
	CIhlL1/bZEcMKaPup5KTSyIFQZtWVEyCA8Ayw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kWwbRDqK95OJdI7qgI+VonC3bEP07bY1
	lRjskAlv6rx6lTiQFkl5It7waqUFNi7QtI+6uEhUM8paxJpxWwxHEX37u9oUwJQM
	JHCZudjvegBOBSRjkV/VnwzDXGLapQIIQP2CPTDtuUJ7dH+/UqvlIZRAfSueodlW
	bXamWHjOACw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA0FA44742;
	Tue,  5 May 2015 02:17:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5121244741;
	Tue,  5 May 2015 02:17:56 -0400 (EDT)
In-Reply-To: <CAGHpTBJuRCrg5jL7Anm9kxGJEf5cUmPzDToZG0UXeT_xNMWfsg@mail.gmail.com>
	(Orgad Shaneh's message of "Tue, 5 May 2015 08:52:08 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 785D4806-F2EE-11E4-BF2E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268387>

Orgad Shaneh <orgads@gmail.com> writes:

> File case rename is not detected correctly on case-insensitive
> filesystems. git mv does support it though.

It is a very much deliberate design decision to keep the case
recorded in the index on case insensitive filesystems, where people
can screw up the case of files they obtained from the project
without even meaning to do so, as these filesystems and tools on
them can carelessly change cases---after all, the case doesn't
matter to these tools, but the people who interact with your work
result via Git do---so we trust what Git initially gave you
(e.g. via "checkout") more than the filesystem.

To effect the same as "git mv" at the end-user level, you would need
to remove the entry from the index and re-add it.  I.e.

> git init
> echo hello > foo
> git add foo
> git commit -m initial
> mv foo Foo
> git status # No changes

git rm --cached foo ;# Foo should also work here, I think
git add Foo ;# you should not say 'foo' here

> git add . -A # Doesn't add anything
>
> - Orgad
