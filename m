From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/5] builtin/notes: Add --allow-empty, to allow storing empty notes
Date: Fri, 07 Nov 2014 10:04:18 -0800
Message-ID: <xmqq1tpehopp.fsf@gitster.dls.corp.google.com>
References: <1415351961-31567-1-git-send-email-johan@herland.net>
	<1415351961-31567-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 07 19:04:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmnte-0000oh-0b
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 19:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbaKGSEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 13:04:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753072AbaKGSEW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 13:04:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C1AE1B448;
	Fri,  7 Nov 2014 13:04:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pD88ck5LgTC5MCLwBXp1Sh8rNgc=; b=JdIn2I
	gb3Zt1xmcbFggmbtAVJJvgjLZI+Ia6XPvnrKpsr6tPh5KRrgheci8ox5YEtRUze6
	mK9NWpiO7pbj8KNBQia75rPCGEj8dgq8VwCkza6vrezz29LS1N1emKF8J4e27WU6
	9XNnUyrAq7TODfJYkLaFtqJGGkhJ0jzC/rWuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bR4VXXUiYNGkgIaBmeYAmjz+PMTEP8ii
	Xn8JnBJ7rpqCeLsjJBum5Dm0KBxA9Yw03WmCAr9WMGxOzPu08bdF8WSbX+S90DzZ
	6ujT/qk8MpQlpp0U38/fKeuwD9kvH4wYQ4zHJiNfX7Y+CRwoiYsOxLHU20Wy82CU
	+kKy5VhSYRE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82D501B447;
	Fri,  7 Nov 2014 13:04:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05EEC1B446;
	Fri,  7 Nov 2014 13:04:20 -0500 (EST)
In-Reply-To: <1415351961-31567-4-git-send-email-johan@herland.net> (Johan
	Herland's message of "Fri, 7 Nov 2014 10:19:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7F1BAF70-66A8-11E4-832C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> Although the "git notes" man page advertises that we support binary-safe
> notes addition (using the -C option), we currently do not support adding
> the empty note (i.e. using the empty blob to annotate an object). Instead,
> an empty note is always treated as an intent to remove the note
> altogether.
>
> Introduce the --allow-empty option to the add/append/edit subcommands,
> to explicitly allow an empty note to be stored into the notes tree.
>
> Also update the documentation, and add test cases for the new option.
>
> Reported-by: James H. Fisher <jhf@trifork.com>
> Improved-by: Kyle J. McKay <mackyle@gmail.com>
> Improved-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---

Assuming that it is a good idea to "allow" empty notes, I think
there are two issues involved here:

 * Traditionally, feeding an empty note is taken as a request to
   remove an existing note.  Therefore, there is no way to
   explicitly ask an empty note to be stored for a commit.

 * Because feeding an empty note was the way to request removal,
   even though "git notes remove" is there, it is underused.

In other words, assuming that it is a good idea to allow empty
notes, isn't the desired endgame, after compatibility transition
period, that "git notes add" will never remove notes?

With that endgame in mind, shouldn't the internal implementation be
moving in a direction where "create_note()" will *not* be doing any
removal, and its caller (i.e. "add") does the switching depending on
the "do we take emptyness as a request to remove"?  I.e.

         static int add(...)
         {
		if (!allow_empty && message_is_empty())
                	remove_note();
		else
                	create_note();
	}

>  static void create_note(const unsigned char *object, struct msg_arg *msg,
> -			int append_only, const unsigned char *prev,
> -			unsigned char *result)
> +			int append_only, int allow_empty,
> +			const unsigned char *prev, unsigned char *result)

In other words, I have this suspicion that create_note() that 
removes is a wrong interface in the first place, and giving it
a new allow_empty parameter to conditionally perform removal is
making it worse.  No?
