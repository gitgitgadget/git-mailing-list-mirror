From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: search author pattern against mailmap
Date: Sat, 24 Aug 2013 22:16:55 -0700
Message-ID: <xmqqob8ml588.fsf@gitster.dls.corp.google.com>
References: <xmqqsiy0nnlr.fsf@gitster.dls.corp.google.com>
	<1377353267-3886-1-git-send-email-apelisse@gmail.com>
	<20130825040122.GA18676@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:17:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDShL-00024U-4p
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab3HYFQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:16:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab3HYFQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:16:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7DAB2E3C2;
	Sun, 25 Aug 2013 05:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X/vfyRCGRH0Id7namPmBIZqwa2Y=; b=kWvcUt
	dPsco6mTzkyojzUUwZ1BmgCksh0CeLVlAZiIzgnNYT5lGQc4oDP+N4Buf37MrJzj
	KbkTcCVjGX6FPC3RdomvHSKln9QvlB6jpN7iMPmV4QPSnSTWDWRqmw4TxkG9+gr5
	CGqRB/OeXOjf49EVGRGgdgt+3Zxy3sU/P9vEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j2GVOLsFRm/UzV5BC4yU47JuEe/nripB
	OB1is6y9aVRFa9cII3Cls7ZR5Ou2DbSq6eHuztoX0aQ4D7DskNx/a56JwcaJWmlZ
	UoRL2zBcl2402+Qf/bquXuhfOzlOUkoPvafmxI1g15vI6VlIuwDRJ70gucR2h673
	IRw0iZThXtI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE2BD2E3C0;
	Sun, 25 Aug 2013 05:16:57 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A6492E3BF;
	Sun, 25 Aug 2013 05:16:57 +0000 (UTC)
In-Reply-To: <20130825040122.GA18676@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 25 Aug 2013 00:01:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 901FACD0-0D45-11E3-8778-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232918>

Jeff King <peff@peff.net> writes:

> On Sat, Aug 24, 2013 at 04:07:47PM +0200, Antoine Pelisse wrote:
>
>> @@ -945,13 +947,16 @@ static const char *find_author_by_nickname(const char *name)
>>  	av[++ac] = buf.buf;
>>  	av[++ac] = NULL;
>>  	setup_revisions(ac, av, &revs, NULL);
>> +	revs.mailmap = &mailmap;
>> +	read_mailmap(revs.mailmap, NULL);
>> +
>>  	prepare_revision_walk(&revs);
>>  	commit = get_revision(&revs);
>>  	if (commit) {
>>  		struct pretty_print_context ctx = {0};
>>  		ctx.date_mode = DATE_NORMAL;
>>  		strbuf_release(&buf);
>> -		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
>> +		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
>>  		return strbuf_detach(&buf, NULL);
>>  	}
>>  	die(_("No existing author found with '%s'"), name);
>
> Do we need to clear_mailmap before returning to avoid a leak?

Good question. What I queued yesterday seems to have a call to
clear_mailmap(&mailmap) before that return.
