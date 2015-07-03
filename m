From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Fri, 03 Jul 2015 10:45:59 -0700
Message-ID: <xmqq38155e3s.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
	<xmqqfv578x87.fsf@gitster.dls.corp.google.com>
	<xmqq8uaz8vjb.fsf@gitster.dls.corp.google.com>
	<xmqq4mln8ve2.fsf@gitster.dls.corp.google.com>
	<20150702135309.GA18286@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 03 19:46:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB52R-0004MA-GM
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 19:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbbGCRqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 13:46:05 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34848 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbbGCRqB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 13:46:01 -0400
Received: by igblr2 with SMTP id lr2so144340594igb.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=P9BxAqaLFt7MXDlDA78LMvaK0dbqXZNzt/7+Vwd9bDo=;
        b=mRZsTtTvcY801hTJeaEpJZaLv9cjE+Vqu7xalqzBlMQVmaT7bc48MWughZgpqpOSeB
         j/+6PNIbxadE9POWme/dGXKdKiTdmgpDVEMczE2tAGfo1bACXCxGnKOae7gaRHJzXUZM
         JPaqf98AngKcr/Ht8Sf2hXhZNuTgweWcviu0Lccnllk/Q98InN7y5mg8i47BDLzhIKNu
         Qmg9LUZToKrKqnlI+6+uDzBkTWHESruiGTOqldvK6Dh7oMF20xIR08Gjj1UPt+fXgL8H
         Am4aW9aNA7U4GhauEg40NrNc1lIZz4jmXjeZ5T0ZcnFaHUr92mmx2TwuQFynwwEqAdPJ
         JYxw==
X-Received: by 10.50.50.204 with SMTP id e12mr47575582igo.0.1435945561166;
        Fri, 03 Jul 2015 10:46:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by smtp.gmail.com with ESMTPSA id n6sm3863767igv.17.2015.07.03.10.46.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 10:46:00 -0700 (PDT)
In-Reply-To: <20150702135309.GA18286@peff.net> (Jeff King's message of "Thu, 2
	Jul 2015 09:53:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273301>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 01, 2015 at 01:39:49PM -0700, Junio C Hamano wrote:
>
>> There is a slight complication on sending an empty line without any
>> termination, though ;-)  The reader that calls packet_read() cannot
>> tell such a payload from a flush packet, I think.
>> 
>> *That* may be something we want to document.
>
> Usually flush packets are "0000", and an empty data packet
> is "0004". Or are you talking about some kind of flush inside the
> pkt-data stream?

Neither.  At the wire level there is a difference, but the callers
of most often used function in pkt-line API, packet_read(), says

	while (1) {
		len = packet_read();
	        if (!len) {
	        	/* flush */
	                break;
		}
	        ... do things on the "len" bytes received ...
		... and then on to the next packet ...
	}

I think the least intrusive change to the caller side would be
to teach packet_read() to keep a static and let the callers do
this:

	while (1) {
		len = packet_read();
	        if (!len && packet_last_was_flush()) {
	        	/* flush */
	                break;
		}
	        ... do things on the "len" bytes received ...
		... and then on to the next packet ...
	}

even though that looks very ugly.

	len = packet_read(..., &flag);
        if (!len && (flag & PKT_LAST_WAS_FLUSH)) {
        	/* flush */
                ...

might be better.
