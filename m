From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error
 back to client
Date: Fri, 31 Oct 2008 22:39:58 -0700
Message-ID: <7vy7043sy9.fsf@gitster.siamese.dyndns.org>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tom Preston-Werner" <tom@github.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 06:42:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw9FT-0003ob-0c
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 06:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbYKAFk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 01:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbYKAFk5
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 01:40:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbYKAFk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 01:40:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DF3B76E8F;
	Sat,  1 Nov 2008 01:40:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 89B3376DC2; Sat,  1 Nov 2008 01:40:06 -0400 (EDT)
In-Reply-To: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>
 (Tom Preston-Werner's message of "Fri, 31 Oct 2008 18:59:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A71B41CA-A7D7-11DD-A2D0-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99719>

"Tom Preston-Werner" <tom@github.com> writes:

> Example
>
> S: ERR No matching repository.
> C: fatal: remote error: No matching repository.

I like what this tries to do.

I briefly wondered if this should be restricted to the very first message
from the other end, but I think it is not necessary.  If the remote throws
a few valid looking "SHA-1 SP refname" lines and then said "ERR" (which
cannot be the beginning of a valid SHA-1), we can safely and unambiguously
declare that this is an error message from the remote end.

> diff --git a/connect.c b/connect.c
> index 0c50d0a..3af91d6 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -70,6 +70,9 @@ struct ref **get_remote_heads(int in, struct ref **list,
>  		if (buffer[len-1] == '\n')
>  			buffer[--len] = 0;
>
> +		if (len > 4 && !memcmp("ERR", buffer, 3))

Would matching 4 bytes "ERR " here an improvement?  You are expecting
buffer+4 is where the message begins in die() anyway, and otherwise you
would show the message without "N" if you got "ERRNo matching repo".

> +			die("remote error: %s", buffer + 4);
> +

It was very considerate that you did not say "server error" in the error
message.  This code is shared between both the fetch side and the push
side.
