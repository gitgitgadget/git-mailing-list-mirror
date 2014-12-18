From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 4/6] receive-pack.c: use a single ref_transaction for atomic pushes
Date: Thu, 18 Dec 2014 09:02:31 -0800
Message-ID: <xmqqppbg7uxk.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418841177-12152-1-git-send-email-sbeller@google.com>
	<1418841177-12152-5-git-send-email-sbeller@google.com>
	<xmqqa92l97u1.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZCTb5Uj34Kj-qnQEWmD+4=3U8LyeHxQWmLg-ozJr7Azg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 18:02:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1eTH-0006Vw-VY
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 18:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbaLRRCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 12:02:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbaLRRCe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 12:02:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14055263A5;
	Thu, 18 Dec 2014 12:02:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lnlUkNqcMAMrgdOfATbUD6KDJZw=; b=EvXdZV
	f4oR1QAzxeWe/7LoOJ4vtQGb69Uf4aAkQ8MfdDltmDqUPVwiAMLwaAaC/2BCmZnj
	Iw43JEd/XG1rQ6gtSH/BULNTbrM8wmf8s/kAhNv5LCPxkIL53iCfLRXSbBIO6bkj
	3Tw3pP7Dkmk7rsJl3P+LlDIM7uwlpAzSQHjBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UJ5bT14YDSMoBDHEzNrH5cqJGkZ83DO7
	MeNOZgqtinUEk/KuWaE8Z4UHQU5P1nI+7gfR9X4M4UWPM4lqtPyX2Hgc6fzK+hXA
	vqc8CtDEg3ZxqAA8UfHYSrOlRI5qChOFKYA9Cl38m1ayVckX/0jD3rgyq0V7ozkK
	5j9Gt/oyjMk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07D61263A0;
	Thu, 18 Dec 2014 12:02:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 680E52639F;
	Thu, 18 Dec 2014 12:02:34 -0500 (EST)
In-Reply-To: <CAGZ79kZCTb5Uj34Kj-qnQEWmD+4=3U8LyeHxQWmLg-ozJr7Azg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 17 Dec 2014 15:58:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A957F038-86D7-11E4-9E4E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261528>

Stefan Beller <sbeller@google.com> writes:

> This would change the current behavior. In the case of !atomic we want
> to consider all commands and not stop early.

Quite right.

> So maybe more
> if (!cmd->error_string) {
>         if (!use_atomic
>             && ref_transaction_commit(...)) {
>             ...
>         }
> } else {
>         if (use_atomic)
>              goto check_atomic_commit;
> }

Don't you need to rollback/abort/free in one-at-a-time mode and did
not commit because error_string is already set, though?
