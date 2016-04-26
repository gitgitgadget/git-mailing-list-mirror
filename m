From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/15] submodule-config: check if submodule a submodule is in a group
Date: Tue, 26 Apr 2016 16:17:36 -0700
Message-ID: <xmqqvb34arjj.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-6-git-send-email-sbeller@google.com>
	<xmqq37q8c6zz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 01:17:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avCEj-0001kt-4a
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 01:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbcDZXRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 19:17:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754213AbcDZXRk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 19:17:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0254216E1D;
	Tue, 26 Apr 2016 19:17:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zwV5usVTLT3+1gCmYZ2z1uWxl6g=; b=mF5COS
	MbY8PFrv6GQYYLjy0a6wOREtvf54ZEDZKtFFGh/+ucIzIQj/F/0GXdEs7vqplUbs
	91lC2lxfv8YU0kuhDz34rJxKbqROkP+EV0N1ZZJ8T9q4d53wMvqSk6a8SGjM6P1U
	shMepq08Y/5wAm8MtOcz2rZla8tU+HFclIkds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=myzOFwYM8okBTr2yYgaaLc4Kxt+1Hu7Y
	Gk3EQx30BTcCKNvDdspSpdabBsrBnWKucNdWQ5i5HQEElmJnycYBHyD6Gbef7272
	gdDadlbEO3nLwcWU24a7G2HgNEOVHnPR6hpRrD5T+0zG2pP4GNIXhrd7qxFTNmLx
	HGzOMxkQ4Cs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ED10716E1C;
	Tue, 26 Apr 2016 19:17:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5ADCE16E1B;
	Tue, 26 Apr 2016 19:17:38 -0400 (EDT)
In-Reply-To: <xmqq37q8c6zz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 26 Apr 2016 15:58:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 112CA65A-0C05-11E6-AAF5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292697>

Junio C Hamano <gitster@pobox.com> writes:

> I see room for bikeshedding here, but the material to bikeshed
> around is not even documented yet ;-)
>
>  * a token prefixed with '*' is a label.
>  * a token prefixed with './' is a path.
>  * a token prefixed with ':' is a name.
>
> Hopefully I will see some description like that in later patches.
> I'll read on.

Extending this on a bit, I would suggest tweaking the above slightly
and make the rule more like this:

  * a token prefixed with '*' is a label.

  * a token prefixed with ':' is a name.

  * everything else is a path, but "./" at the front is skipped,
    which can be used to disambiguate an unfortunate path that
    begins with ':' or '*'.

A bigger thing I am wondering is if it is bettter to do _without_
adding a new --group=X option everywhere.  I am assuming that most
if not all submodule subcommands already use "module_list" aka
"submodule--helper list" that takes paths, and to them, extending
that interface to also understand the groups and names would be a
more natural way to extend the UI, no?  e.g.

	$ git submodule update -- 'path1' 'path2'
        $ git submodule update -- '*default'
        $ git submodule update -- ':named'

instead of

	$ git submodule update -- 'path1 'path2'
        $ git submodule update --group='*default' --
        $ git submodule update --group=':named' --

which special-cases the way to specify a set of submodules by
listing their paths.
