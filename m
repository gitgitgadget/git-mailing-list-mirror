From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame --follow
Date: Tue, 15 Mar 2011 10:30:19 -0700
Message-ID: <7vy64g9tqs.fsf@alter.siamese.dyndns.org>
References: <201103151644.44360.wolfgang@rohdewald.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: wolfgang@rohdewald.de
X-From: git-owner@vger.kernel.org Tue Mar 15 18:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzY4n-0008Kt-0c
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 18:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758121Ab1CORa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 13:30:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762Ab1CORa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 13:30:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 707C04F81;
	Tue, 15 Mar 2011 13:31:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HnhBsmhqRvknoiMvuAWd8z+hE8g=; b=ScbdF4
	ccUqwcWAHMHGqtPzpGZ0Wz7ZcQpKXKHx+pjkC1oF4QKrjTidRTXp5W6e/xOmaybz
	mnLXpyavSbJWhVPgUjU7A9rVivKV/A8qL6crpcVccgdjMzhQkdjmODAUtZU5Jgqj
	rx9OWA6/HEJ6lpk1GOrj3m82Z92aEZSftVaTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xrVhrh3WSx3efDFu6YJSRBFuk/CFtowN
	Vu3+vjaW+1S7CTe3u/6O4rWx6yBIAH6QIUP9FCUtj/KIudmj8h7h3m/MkMmzVRD9
	wRAsrtWtMqVIXlsx3cAZBca4w4jkFFVfGih63VvnVqxIY6+jArPaJTX9o6a3QGCe
	EQ7PgH7jwP8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 504BA4F7B;
	Tue, 15 Mar 2011 13:31:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 58BE74F72; Tue, 15 Mar 2011
 13:31:53 -0400 (EDT)
In-Reply-To: <201103151644.44360.wolfgang@rohdewald.de> (Wolfgang Rohdewald's
 message of "Tue, 15 Mar 2011 16:44:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FD5CF1C-4F2A-11E0-B0CB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169081>

Wolfgang Rohdewald <wolfgang@rohdewald.de> writes:

> git log --follow filename
>
> shows the full history, while
>
> git blame --follow filename
>
> blames everything to the latest commit (which was
> a file rename)

Huh?

    $ git checkout master^0
    $ git mv COPYING RENAMING
    $ git commit -m renamed
    $ git blame --follow RENAMING

gives everything blamed to 075b845a COPYING (but that is probably by
accident, see below).  FYI,

    $ git blame RENAMING

should also blame everything to the same commit and the same COPYING
file. If you get a different behaviour out of the above command sequence,
there is something else going on.

I didn't know "blame" even accepted "--follow".  It is entirely out of the
scope of its design to take "--follow" option, as the "blame" command
itself has its own and real "follow" logic that is enabled by default
(i.e. it follows a whole file rename without any option), instead of the
checkbox "--follow" hack that is in "git log" family of commands.  You
cannot even turn it off.

Perhaps the behaviour you saw comes from the internal revision traversal
machinery blame uses getting confused by the use of --follow, but I am too
lazy to check (and I don't think it is worth to check, as the command
should follow by default).

We should just teach "blame" to ignore --follow option from the command
line, without even complaining.
