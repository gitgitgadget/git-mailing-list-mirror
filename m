From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v12 11/11] Documentation: add documentation for 'git
 interpret-trailers'
Date: Sun, 29 Jun 2014 11:37:31 +0200 (CEST)
Message-ID: <20140629.113731.1129545703421115235.chriscool@tuxfamily.org>
References: <20140525051254.5329.66539.chriscool@tuxfamily.org>
	<20140525053223.5329.28002.chriscool@tuxfamily.org>
	<xmqqegzdd7cm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 29 11:38:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1BYd-00050M-IC
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 11:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbaF2Jh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 05:37:56 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:37727 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752383AbaF2Jhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 05:37:54 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 1D65D1EA;
	Sun, 29 Jun 2014 11:37:31 +0200 (CEST)
In-Reply-To: <xmqqegzdd7cm.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252635>

From: Junio C Hamano <gitster@pobox.com>

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> +The trailers are recognized in the input message using the following
>> +rules:
>> +
>> +* only lines that contains a ':' (colon) are considered trailers,
>> +
>> +* the trailer lines must all be next to each other,
>> +
>> +* after them it's only possible to have some lines that contain only
>> +  spaces, and then a patch; the patch part is recognized using the
>> +  fact that its first line starts with '---' (three minus signs),
>> +
>> +* before them there must be at least one line with only spaces.
> 
> While I agree with Michael on the other thread that we should limit
> the syntax and start with ':' only, if you really want to allow
> random syntax like "Bug #12345" and "Acked-by= Peff", for which you
> have demonstrations in the tests in the other patch, the above rule
> should be updated to also allow prefix matches to possible set of
> keys defined by the user, so that an existing line that is produced
> by your tool, e.g. "Acked-by= Peff", can be picked up as matching
> with some token having a key "Acked-by= ".  Otherwise, the input
> side of your tool is inconsistent with the output side of your own
> tool, and that will make the flexiblity of the output side useless.

I don't think that the flexibility of the output side would be
useless.

We already emit stuff like:

(cherry picked from commit f72baf07969242882128aff4c95ec8059e7fd054)

and we don't care about any input side when we do that.

So being able to emit lot of different stuff is valuable even if we
are not yet able to parse it.

For example what if people wanted cherry-pick messages written like:

Cherry picked from f72baf0796 ("do this and that", 2014-01-01)

we just cannot let them have the above if we decide that ':' has to
always be used as the separator.

We also emit stuff like "Merge commit '71260bf'" or "Merge tag
'mystuff'" or Merge branch 'dev' and we don't let people customize
this and we don't care about any input side.

And when there is a merge conflict we emit:

Conflicts:
	file1
	file2
...

instead of:

Conflicts: file1
Conflicts: file2
...        

Of course at least for cherry-pick it would have been nice if since
the beginning we would have written something in a canonical trailer
way like:

Cherry-picked-from: f72baf0796

This way we could now use "git interpret-trailers" to both emit the
above and to read it. But it is still be better to just be able to
emit it than to not be able to do anything about it.

Because if we are able to emit it with "git interpret-trailers", then
we can let people customize how it is emitted, and this might be
enough for many people. Also now those who are ok to output it using
the canonical way, could now configure that.

And this is not just for us, something like:

fixes #42 ("do this and that", 2014-01-01)

for example could be nice for both Github and human beings.

Thanks,
Christian.
