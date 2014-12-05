From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the reflog file
Date: Fri, 05 Dec 2014 11:32:47 -0800
Message-ID: <xmqqoarhq4dc.fsf@gitster.dls.corp.google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
	<1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
	<20141205002331.GJ16345@google.com>
	<20141205191829.GB16682@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 20:32:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwycZ-00017Z-7G
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 20:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbaLETcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 14:32:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751233AbaLETcu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 14:32:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF7DA23987;
	Fri,  5 Dec 2014 14:32:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p/NyiAI3elNFxaAiBP9Jqw2rzsQ=; b=UH4edO
	GaleV0RxsMW5HSHvzrgMsrfQxiZ+EOaP7Eu5xYK0QWFiKsS4Yvd31Vkz4ObGybyk
	SG0TUxFq8qV14e2emSoYBkqurR+Y2IACA9Yys5YuSC1KIWz06Ea2ey6imgDdmFLo
	Vp8qgE9Z3ghHgQ/RKOQTedfSpbOnu8HdtuVnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AMV0XTaCCvdbDvxtooLEXIlxV6IeKdRk
	fssfFc3UEuYf0QClwEMeyAmUcY9RL92yC7/eubB4kdLOfFgaNqxWxqTNneWzMaPM
	uKkOrClfycZKhbFKNWrDEpPAZT+sC9yJihFrBsmeX8jpeKa4iAuIcoKgOsitTDF+
	aFRsXyLgzKU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6C9023985;
	Fri,  5 Dec 2014 14:32:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52ECE23984;
	Fri,  5 Dec 2014 14:32:49 -0500 (EST)
In-Reply-To: <20141205191829.GB16682@google.com> (Stefan Beller's message of
	"Fri, 5 Dec 2014 11:18:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7F3BECFE-7CB5-11E4-9A20-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260885>

Stefan Beller <sbeller@google.com> writes:

>> > +static struct lock_file reflog_lock;
>> 
>> If this lockfile is only used in that one function, it can be declared
>> inside the function.
>> 
>> If it is meant to be used throughout the 'git reflog' command, then it
>> can go near the top of the file.
>> 
>
> After the series completes, this lock is only used in reflog_expire.
> So I'd rather move it inside the function? Then we could run the reflog_expire
> function in parallel for different locks in theory?

I am not sure about the "parallel" part, but I would imagine that it
is an essential prerequisite to move this outside the "client" code
if we want to later replace the backing storage of refs and reflogs
outside the filesystem, so from that point of view,  I think the
suggestion makes sense.

Thanks.
