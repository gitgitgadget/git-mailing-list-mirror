From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd "git diff" breakage
Date: Mon, 31 Mar 2014 11:38:39 -0700
Message-ID: <xmqq38hy6wnk.fsf@gitster.dls.corp.google.com>
References: <CA+55aFxYBDXs8mGQ3weR2PSOdMgOzMXPT=uWstL4c4BKnykkdA@mail.gmail.com>
	<xmqq7g7a6x0g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:38:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUh6g-0001Di-OA
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbaCaSim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 14:38:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbaCaSil (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 14:38:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70F0E7854F;
	Mon, 31 Mar 2014 14:38:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0jxtmjs1QjZ4Nl80VZfIRhc7cTQ=; b=GbYTUn
	JcEmBEyjOMS1EIAV26ysM+KLefKuqighNvLsXLSDUh/ypvbPULVjgV+lBxyA6IOO
	JEVf1K9dQrAz36naSDG5C5fiVKhK4qXKsfM1W9WMy4N7jlhQZQwODaP+4qPI3+Wn
	ApvGkH0C2pV1WxvMsbMzTQAX67BXB/2ctYyMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BJVtZUewJCgNdNJt+G7pNLUQ1pJD/nmD
	BaDq1BTq1hg7mScR7nx7MBoxToJBsufJ3F1PvfvYhJ2sP919bgM83Z6xIyG79DBj
	Ew3fipDLel1AP4t9XvTr9GR7gdKcuo5RN2twB5ixzAeUHe24zqDaZ2EM5ZyYPjKc
	lekuVitksUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 502237854C;
	Mon, 31 Mar 2014 14:38:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A88CE78546;
	Mon, 31 Mar 2014 14:38:40 -0400 (EDT)
In-Reply-To: <xmqq7g7a6x0g.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 31 Mar 2014 11:30:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE079C20-B903-11E3-B04F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245507>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> I hit this oddity when not remembering the right syntax for --color-words..
>>
>> Try this (outside of a git repository):
>>
>>    touch a b
>>    git diff -u --color=words a b
>>
>> and watch it scroll (infinitely) printing out
>>
>>    error: option `color' expects "always", "auto", or "never"
>>
>> forever.
>>
>> I haven't tried to root-cause it, since I'm supposed to be merging stuff..
>>
>>                 Linus
>
> Hmph, interesting.  "outside a repository" is the key, it seems.
> And I can see it all the way down to 1.7.3 (at least).

diff_opt_parse() returns the number of options parsed, or often
returns error() which is defined to return -1.  Yes, return value
of 0 is "I don't understand that option", which should cause the
caller to say that, but negative return should not be forgotten.



 diff-no-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index c554691..265709b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -198,7 +198,7 @@ void diff_no_index(struct rev_info *revs,
 			i++;
 		else {
 			j = diff_opt_parse(&revs->diffopt, argv + i, argc - i);
-			if (!j)
+			if (j <= 0)
 				die("invalid diff option/value: %s", argv[i]);
 			i += j;
 		}
