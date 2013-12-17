From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any file, fail properly
Date: Tue, 17 Dec 2013 15:11:29 -0800
Message-ID: <xmqqvbynkr8e.fsf@gitster.dls.corp.google.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
	<1387224586-10169-3-git-send-email-naesten@gmail.com>
	<xmqqwqj4mqhe.fsf@gitster.dls.corp.google.com>
	<CAJYzjmd_EWcQ5OzuZBQwhkfAtdxbPbvhVxUSsh98SzMzyz=-8w@mail.gmail.com>
	<xmqqsitrmkhe.fsf@gitster.dls.corp.google.com>
	<CALWbr2zXNF-aJHHnBnW1q1yaCmWt-rmMWypBWFanTBAK1pMWiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Bronson <naesten@gmail.com>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 00:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt3nf-0006hg-5R
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 00:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433Ab3LQXLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 18:11:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839Ab3LQXLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 18:11:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBE1A5C1EB;
	Tue, 17 Dec 2013 18:11:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7OiM+EMPWiSogehUhbcXa/GJvJ4=; b=JOoDc/
	oaJX3eHcFFMDoJXMvk8rCNdnrNEh79HdIQ334VEv8c3wsUufIt3enH+K+VtbQhkD
	HpxEn9PjdNShbdiOpspmKqsEZuXFEgaowsDjFxx1ysYtYNB8g1E/h79l3NqWezfr
	c3x0YbvHZspD2db9eNg6lfRDPs7O5de+q0WCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N/ja2s0eZTRUo3QzhdNWH6cnPbUmPYNA
	XM4fZ+9yG4Mj+rv/crxvjwKNZEX9wn0pK1QdGqhQsyIazvS2REgYJIReKf3Xv+UH
	JrS8rKAW3wYhkT0PwNzPrn/5psF+FuVDpj2+pZX3nV5IM7Mlk311irQJxlLXvCdl
	RfLA0PEj2PQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EF365C1EA;
	Tue, 17 Dec 2013 18:11:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA2CE5C1E9;
	Tue, 17 Dec 2013 18:11:32 -0500 (EST)
In-Reply-To: <CALWbr2zXNF-aJHHnBnW1q1yaCmWt-rmMWypBWFanTBAK1pMWiQ@mail.gmail.com>
	(Antoine Pelisse's message of "Tue, 17 Dec 2013 21:37:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 91A92038-6770-11E3-A62A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239409>

Antoine Pelisse <apelisse@gmail.com> writes:

> I'm not sure about the deadlock though. Both read and write will wait
> for each other to start operating on the fifo.

It is true only if the fifo already exists.  That is, if you did
this:

	a lot of &&
        commands &&
        before &&
        mkfifo fifo &&
        feed >fifo &

	git diff -Ofifo
        
the consumer may attempt to open and read fifo when the other
process is still running a lot of commands, no?

>
> You can probably fix the &&-chain by doing something like:
>
>     mkfifo order_fifo && {
>         cat order_file_$i >order_fifo &
>         git diff -O order_fifo --name-only HEAD^..HEAD >actual
>     } && ...
>
> Also, "rm -f order_fifo" should probably be done in test_when_finished
> rather than at the beginning of the test.
>
> Antoine,
