From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does "git log -G<regex>" works with "regexp-ignore-case" but not with other regexp-related options?
Date: Fri, 17 Apr 2015 09:18:48 -0700
Message-ID: <xmqqh9sehgnr.fsf@gitster.dls.corp.google.com>
References: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app>
	<55311831.6010004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tim Friske <me@tifr.de>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:47:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjBIn-00033J-H9
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 20:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbbDQSrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 14:47:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754107AbbDQSrj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 14:47:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1231F4AB2D;
	Fri, 17 Apr 2015 14:47:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=40R49uAepm16rwcyfkY6Bgn5oTE=; b=fUbZ3i
	0FdWEz8Q7n/wKkj622vgPcip1d0NzuDM/V4NHeTjs9yw/ITRl5n9103BxnmC32Ws
	QJZ1qzAyrI9Qy4sMNuyE0yzo1uO8VFOt+MBO/3nk492Lvc9xz40AK6QLEbdzTu1K
	4z++OvtqZ5rMRFJXAP1gJca2GyagwGO4ZGHrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nCeVjLO3M35YSj9RX8BGjhLUWUC0QxIo
	UAJzJaU2rv5BeoFbPgwPcAvhAOdEmcmXsZeZBJYm13ZM6e1kHT5kEi2RUOdf0RRq
	rY5/WXAulWSZpZi7x5QrP536K3H2hvLJPmkXBcRV1mos5pIuwLmj8h/UNABTJHoV
	BV8ALfqv5A8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 099664AB2A;
	Fri, 17 Apr 2015 14:47:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AC8C49D7B;
	Fri, 17 Apr 2015 12:18:49 -0400 (EDT)
In-Reply-To: <55311831.6010004@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 17 Apr 2015 16:26:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E5F3ED8-E51D-11E4-AD37-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267376>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Similarly I think it is not very consistent that one cannot combine any of
>> the above options with the "S<string>" but instead have yet another option
>> called "pickaxe-regex" to toggle between "fixed-string" and
>> "extended-regexp" semantics for the argument passed to option "S".
>
> The defaults are different, and it is likely that users want to switch
> one without switching the other.
>
> E.g., with -S you often use strings that you'd rather not have to quote
> to guard them against the regexp engine.

But the hypothetical -G that would look for a fixed string would be
vastly different from -S, wouldn't it?

The -S<string> option was invented to find a commit where one side
of the comparison has that string in the blob and the other side
does not; it shows commits where <string> appears different number
of times in the before- and the after- blobs, because doing so does
not hurt its primary use case to find commits where one side has one
instance of <string> and the other side has zero.

But -G<regexp> shows commits whose "git show $that_commit" output
would have lines matching <regexp> as added or deleted.  So you get
different results from this history:

    (before)    (after)    
    a           b          
    b           a          
    c           c         

As "git show" for such a commit looks like this:

diff --git a/one b/one
index de98044..0c81c28 100644
--- a/one
+++ b/one
@@ -1,3 +1,3 @@
-a
 b
+a
 c

"git log -Ga" would say it is a match.  But from "git log -Sa"'s
point of view, it is not a match; both sides have the same number of
'a' [*1*].

I think it would make sense to teach --fixed-strings or whatever
option to -G just like it pays attention to ignore-case, but "-G
--fixed-strings" cannot be "-S".  They have different semantics.


[Footnote]

*1* This is because -S was envisioned as (and its behaviour has been
    maintained as such) a building block for Porcelain that does
    more than "git blame".  You feed a _unique_ block of lines taken
    from the current contents as the <string> to quickly find the
    last commit that touched that area, and iteratively dig deeper.
    The -S option was meant to be used for that single step of
    digging, as a part of much more grand vision in $gmane/217,
    which I would still consider one of the most important messages
    on the mailing list, posted 10 years ago ;-)
