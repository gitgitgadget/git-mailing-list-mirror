From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 49/83] builtin/apply: move 'lock_file' global into 'struct apply_state'
Date: Mon, 25 Apr 2016 10:55:30 -0700
Message-ID: <xmqqzishlgj1.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-50-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cRSe8oOjo2h6SuJQyD+he_Q7zHfF4TivZ0amhAu4HLQ+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:55:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aukjS-0005aU-GA
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932950AbcDYRze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 13:55:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932791AbcDYRzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 13:55:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B3C114E72;
	Mon, 25 Apr 2016 13:55:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=elsVWvu9sgxs2Qvtu+bSjKb28/c=; b=IaL3bZ
	xLPQxHN5p0VuOUVva+aqUMqHvEwkfJuUhBv9cm+oP6BB9Besbqlt8GtSnuBaAzpE
	0R0YnBybQEaQ4p2SnSHIhq/Brol6qNjGoeigsUNpbhWPLGQQQUfVFSNofE1whNi8
	yFg0FInrkcfUpe4ZvhyEM0RjfEPAc6x1adiEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=My4he317xOFj4JeC2DDe1OKlD/PGZKQS
	FjOHWf0wjYfw7/uE9o5Wosi2v6oqq5Zlspn+fNbHVvKgmds/FV7+NHhM0R6OmqaK
	ku8KOPVdCSob5U9U0TPg1fSzseo89VnrgIMAP9LdXDfkHYAut/V43Jhum36LoeMV
	661mehOCgqI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71DA914E71;
	Mon, 25 Apr 2016 13:55:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C108314E70;
	Mon, 25 Apr 2016 13:55:31 -0400 (EDT)
In-Reply-To: <CAPig+cRSe8oOjo2h6SuJQyD+he_Q7zHfF4TivZ0amhAu4HLQ+g@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 25 Apr 2016 03:50:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E742435A-0B0E-11E6-BD7C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292535>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       /*
>> +        * Since lockfile.c keeps a linked list of all created
>> +        * lock_file structures, it isn't safe to free(lock_file).
>> +        */
>> +       struct lock_file *lock_file;
>
> Is there ever a time when lock_file is removed from the list (such as
> upon successful write of the index), in which case it would be safe to
> free() this?

I do not think you need to think about "free"ing.

Even if the libified version of the apply internal can be called
multiple times to process multiple patch inputs, there is no need to
run multiple instances of it yet.  And a lockfile, after the caller
finishes interacting with one file using it by calling commit or
rollback, can be reused to interact with another file.

So the cleanest would be to:

 * make the caller of apply API responsible for preparing a static
   or (allocating and leaking) lockfile instance,

 * make it pass a pointer to the lockfile to the apply API so that
   it can store it in apply_state, and

 * have the caller use apply API feeding one patch at a time in a
   loop, allowing the same lockfile instance used for each
   "invocation".

I sounded as if I were advocating non-reentrant implementation in
the introductory paragraph, but that is not the intention.  If you
want to do N threads, you would prepare N lockfile instances, give
them to N apply API instances to be stored in N apply_state
instances, and you would have N parallel applications, if you wanted
to.
