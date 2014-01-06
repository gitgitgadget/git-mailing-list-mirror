From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Mon, 06 Jan 2014 08:16:31 -0800
Message-ID: <xmqqbnzpkrvk.fsf@gitster.dls.corp.google.com>
References: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
	<20140106152742.GA26221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Burke <spraints@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 17:17:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0CrD-00034n-Fa
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 17:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbaAFQQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 11:16:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63716 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755431AbaAFQQo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 11:16:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4281F5F2E5;
	Mon,  6 Jan 2014 11:16:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xCBSJALuWTSOEiFClOdbTstzyF0=; b=GXjWBH
	Ly4LKTR14IRUWbveSdMgmyAnsxBFp00ogEP62dECiWEJ20uBmiCu4dwWGG9vj8xg
	bJQL2xQiu7dDj/bXP/YDp/UK0h59jSaYJbq4YGW5QqLe/llCZOK9ncs4z6sMvRFy
	B0tCV5TErVPs8W7oQ/kzu4bwuZ9iWGcgn9BkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UPyqi+uUN3/3G9dyZp/UqUZJ6Im2XB/s
	4CoXIl2EAN5J23Gfjc69H8mA9Q/wk37Kmti1Dg/y4cqhnAIqw7HtVwqUgX498E1X
	FFjvqhDZDWlsx5HX7unKwAw4CSMOSnEmHb756JJ8disjzlgKKtkW+mM+1xP03dwk
	X39R1dYU9aU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D9CA5F2DE;
	Mon,  6 Jan 2014 11:16:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3BF15F2DB;
	Mon,  6 Jan 2014 11:16:34 -0500 (EST)
In-Reply-To: <20140106152742.GA26221@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 Jan 2014 10:27:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E980FEE8-76ED-11E3-A75D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240022>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 03, 2014 at 04:12:51PM -0500, Matt Burke wrote:
>
>> + git init -q
>> + git fetch -q -fu ../../../other '+refs/*:refs/*'
>> fatal: bad object 9b985fbe6a2b783c16756077a8be261c94b6c197
>> error: ../../../other did not send all necessary objects
>
> I was going to ask you to send your repository, but I can easily
> reproduce here. I guess people don't run into it because it's uncommon
> to fetch the whole refs/ namespace from a non-bare repo (and bare repos
> do not tend to have stashes). Here's a minimal reproduction recipe:
>
>   git init repo &&
>   cd repo &&
>   echo content >foo &&
>   git add . &&
>   git commit -m foo &&
>   echo more >>foo &&
>   git stash &&
>   git init --bare sub &&
>   cd sub &&
>   git fetch .. 'refs/*:refs/*'
>
> It looks like we are not feeding refs/stash properly to pack-objects.
> I'll try to take a closer look later today.

I looked at this in the past and I vaguely recall that we reject it
in the for-each-ref loop with check-ref-format saying "eh, that is a
single-level name".

At that point I stopped digging, thinking it was a feature ;-)
based on your exact observation about stash vs bare/non-bare.
