From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why is ident_is_sufficient different on Windows?
Date: Wed, 06 Feb 2013 12:41:17 -0800
Message-ID: <7vmwvhb2fm.fsf@alter.siamese.dyndns.org>
References: <991CBC1C-912C-4DD6-B911-93F6B41D895E@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:41:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3BoO-0000Yx-5l
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197Ab3BFUlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 15:41:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51386 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757909Ab3BFUlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:41:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1DC5D720;
	Wed,  6 Feb 2013 15:41:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C5DKT64FNpqJrkYYAcVXhpkxPc0=; b=Ev/d3h
	jF2hMRB9sTs2jcworyipd+DApdXPd5Y+3umJi7EyNWRgATm2J6gVE1qFWkPaavk+
	utbeD0DaKJeYjLO/GteHcNuPCxHObGPagXtjv3bzc0cGfsxBT2VjKuQZBj/oIjXm
	4JV8WftO6sGWeNlnt6CWopkiyFKogBV+cN4XU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z37y3QQOrhpRvNJ0DURLi52/niJbvS4L
	sneR3oXPRtoIpqUBx2aGI5nJG5I13Uhq1vmbfQT8RNAE2twn0GVh7fZXs2uRtvMX
	CTHVWzDrAurWC5zsTFoyRFnFiGJW+E9+mg65SYg0DpntI6nFZNqC5fjwXarOJIH4
	C/jWOpYCpJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9654ED71F;
	Wed,  6 Feb 2013 15:41:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F07A9D71E; Wed,  6 Feb 2013
 15:41:18 -0500 (EST)
In-Reply-To: <991CBC1C-912C-4DD6-B911-93F6B41D895E@quendi.de> (Max Horn's
 message of "Wed, 6 Feb 2013 14:06:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F3E1238-709D-11E2-9BCE-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215634>

Max Horn <max@quendi.de> writes:

> static int ident_is_sufficient(int user_ident_explicitly_given)
> {
> #ifndef WINDOWS
> 	return (user_ident_explicitly_given & IDENT_MAIL_GIVEN);
> #else
> 	return (user_ident_explicitly_given == IDENT_ALL_GIVEN);
> #endif
> }
>
>
> According to git blame, this was introduced here:
>
> commit 5aeb3a3a838b2cb03d250f3376cf9c41f4d4608e
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Sun Jan 17 13:54:28 2010 -0800
>
>     user_ident_sufficiently_given(): refactor the logic to be usable from elsewhere
>
>
> The commit message sounds as if this was only a refactoring, but
> the patch to me look as if it changes behaviour, too. Of course
> this could very well be false, say due to code elsewhere that
> already caused Windows to behave differently; I wouldn't know.
>
> Still, I wonder: Why does this difference exist?

Sorry but I do not recall why these ifdefs are there.  The commit
did this to builtin-commit.c:

-               if (user_ident_explicitly_given != IDENT_ALL_GIVEN)
+               if (!user_ident_sufficiently_given())

I would have written the function to always check with ALL_GIVEN
myself, and it is very likely that I was *not* the person who
noticed that the function needs to behave differently on Windows, as
I do not do Windows.

I suspect somebody from the Windows camp saw a patch I posted
without the ifdef, noticed that there is a problem to expect
IDENT_NAME_GIVEN to be set on Windows for some reason, and resulted
in a reroll of the function in that shape.

I didn't find anything in the list archive, though.  So I am
stumped.
