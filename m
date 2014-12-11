From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] refs.c: add transaction function to append to the reflog
Date: Thu, 11 Dec 2014 13:50:30 -0800
Message-ID: <xmqq7fxxetzt.fsf@gitster.dls.corp.google.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
	<1417833995-25687-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 22:50:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzBdC-0007ea-Kb
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 22:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934244AbaLKVuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 16:50:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933134AbaLKVue (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 16:50:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68FBA24805;
	Thu, 11 Dec 2014 16:50:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bbZ6sMpmzJMS+9EV39Lx2zEyL9s=; b=RlmZfi
	Bchkr/dVEqEL6SrG54/VvwXbMox4a5uImb7iN28f2Z21T0RyGjWPhVYaV6BIjQ3c
	3Ju2DkfaDB/5n2RLEPMugHO5VcLWYWsPgVI1OaqBT/d6w5XA6235yuMPK+kcOTu+
	0FiQWLFuk+R3fEftn534ozRSdgjXzjW4TdZag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DUIkBpDcl087IJ35YIwSxvM3XkabU82s
	Bh/gonvIhHwfBQnug11Ei9sJ4ldEDSr5WJ/J5NR2vR8wFaAfktwyIkfA/5iPontI
	G/WsxHhzLOL5KUOGMBczHva80han2xeU2vaC4cYzCH5v51toD4VUDp/Lo1ICYFUP
	eAZDDSjwEhc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55F3E24803;
	Thu, 11 Dec 2014 16:50:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB4F0247FF;
	Thu, 11 Dec 2014 16:50:31 -0500 (EST)
In-Reply-To: <1417833995-25687-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 5 Dec 2014 18:46:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA8A89C2-817F-11E4-A821-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261295>

Stefan Beller <sbeller@google.com> writes:

> Unlike transaction_update_ref, this writes out the proposed contents of the
> reflog to a temporary file at transaction_reflog_update time instead of
> waiting for the transaction waiting to be committed. This avoids an
> explosion of memory usage when writing lots of reflog updates within a
> single transaction.

Copying an existing reflog with thousands of entries over so that I
can append a single new entry, just so that I can rollback by not
renaming?

After ensuring that you are the only process that holds a write fd
to the reflog file (e.g. by taking a lock on the ref itself),
shouldn't you be able to ftell(), write() and then truncate() to
roll back sanely before close()?  After all you are not protecting
from power loss and other kinds of glitches that would leave *.lock
file behind, so...
