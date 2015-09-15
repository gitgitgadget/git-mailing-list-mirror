From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] strtoul_ui: actually report error in case of negative input
Date: Tue, 15 Sep 2015 08:50:03 +0200
Message-ID: <vpq4miwfa78.fsf@anie.imag.fr>
References: <1442181636-27821-1-git-send-email-max@max630.net>
	<vpqr3m1seap.fsf@anie.imag.fr> <20150914202647.GA7806@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 08:50:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbk4N-0000Ua-Hc
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 08:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbbIOGuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 02:50:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47754 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbbIOGuR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 02:50:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8F6o2XE003528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 15 Sep 2015 08:50:03 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8F6o3lI005811;
	Tue, 15 Sep 2015 08:50:03 +0200
In-Reply-To: <20150914202647.GA7806@wheezy.local> (Max Kirillov's message of
	"Mon, 14 Sep 2015 23:26:47 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Sep 2015 08:50:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8F6o2XE003528
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442904606.9204@cSFEKp5yyRkVHqMXWa4VXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277888>

[ Cc-ing Michael Haggerty who wrote the numparse module ]

Max Kirillov <max@max630.net> writes:

> On Mon, Sep 14, 2015 at 08:30:54AM +0200, Matthieu Moy wrote:
>>> Fix it by changing the last check to trigger earlier, as soon as it
>>> becomes bigger than INT_MAX.
>> 
>> What if the value is actually greater than INT_MAX? The function is
>> returning an unsigned long (64 bits on 64bits architectures), and your
>> version is restricting it to integers smaller than 2^31, right?
>
> the return type of the function is "int", so this is not
> going to work anyway.

Not just the return type (which is the error status), but also the type
of the result argument indeed. It's not clear to me whether this is
intentional (09f2825 (git-grep: don't use sscanf, 2007-03-12) introduced
it, the commit message doesn't help). I first read strtoul_ui as
"strtoul with a better UI (user interface)", but maybe the name was
meant to say "a fuction that uses strtoul and returns an ui (unsigned
int)".

I think it would be better to just return a long to avoid needless
limitations, but changing the argument to "long" would interfer with
in-flight topics. Not worth the trouble.

One potential issue with your patch is that you're forbidding the
interval [2^31, 2^32[ which was previously allowed, both on 32 and 64
bits. I'm not sure whether we have a use for this in the codebase.

This alternative patch is rather ugly to, but I think it is less
limiting and does not have the "large negative wrapped to positive"
issue:

--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -814,6 +814,9 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
        char *p;
 
        errno = 0;
+       /* negative values would be accepted by strtoul */
+       if (strchr(s, '-'))
+               return -1;
        ul = strtoul(s, &p, base);
        if (errno || *p || p == s || (unsigned int) ul != ul)
                return -1;

What do you think?

> As I mentioned, some negative values are still accepted
> as coresponding mod 2**32 positive numbers (-3221225472 as
> 1073741824), so there really is room for improvement, but it
> cannot be accomplished just by examining strtoul output.

On 64 bits architectures, it's not as bad: you need to go really far in
the negatives to wrap to positive values.

> I saw in the list archives an attempt to abandon the
> function in favor of more accurate parser [1], but seems
> like it did not make it into the project.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/265635

I went through the thread quickly, my understanding is that there were
more work to do, but no objection to merging.

Michael, any plan to resurect the topic?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
