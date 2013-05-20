From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating diff
Date: Sun, 19 May 2013 21:46:43 -0700
Message-ID: <7vwqquw958.fsf@alter.siamese.dyndns.org>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
	<20130519193612.GH3362@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Kevin Bracey <kevin@bracey.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 06:46:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeHzm-0003q3-Vu
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 06:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237Ab3ETEqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 00:46:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53229 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab3ETEqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 00:46:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3550E16137;
	Mon, 20 May 2013 04:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JYRqUD1E2djvhjUOuJGeUGWCrsg=; b=Dodt74
	32VMVp1vyR6xkGrV5ClBWoemPVoWWExyKFxMMDZTFLi1/NKJyYneAhPYQMfm+kGh
	0ShQP6h8kgC6Nh1BwpqQGz4KxVO+75OTTn2sfyQJsnGTn2BszuXUpsqcbYYJ7Cs8
	6PL5oPsgnYWikNikZNMmnBFQMQlQHtg21bKf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gc9FbRuDZ6FX9Fo5KrckpK5fVytHqw7h
	WjdmEtHRQh3/bnwjTkBN48pEAHIjEeUoGkvoVZtWw8YKmQG7aPGeqrf6vcTXAbWF
	vFybewku8tXL/bH/yXeMQJjebcoYS2nF8ezEfDbqHVegrD9+j6FQfAZNRoYO3N5/
	+pHqTonWW34=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28B9116136;
	Mon, 20 May 2013 04:46:46 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6765C16133;
	Mon, 20 May 2013 04:46:45 +0000 (UTC)
In-Reply-To: <20130519193612.GH3362@elie.Belkin> (Jonathan Nieder's message of
	"Sun, 19 May 2013 12:36:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4616B766-C108-11E2-BE35-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224935>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> @@ -64,6 +199,13 @@ static struct patch_id *add_commit(struct commit *commit,
>>  	unsigned char sha1[20];
>>  	int pos;
>>  
>> +	if (no_add) {
>> +		if (collect_touched_paths(commit, ids, 1) < 0)
>> +			return NULL;
>
> Ah, so this is what the "searching" does.
>
> The existing "no_add" argument is very confusing (what does it mean to
> add a commit without adding?),

Such a mode of operation is usually called "dry-run", no?
