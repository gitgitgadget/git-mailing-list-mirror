From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/7] push: introduce new push.default mode "simple"
Date: Mon, 23 Apr 2012 18:09:42 +0200
Message-ID: <vpqbomil9a1.fsf@bauges.imag.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-5-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqehrela20.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:10:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMLqH-0004J6-J0
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027Ab2DWQKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 12:10:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40420 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab2DWQKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 12:10:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3NG3G0S017383
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 18:03:16 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SMLpf-0005rc-6i; Mon, 23 Apr 2012 18:09:43 +0200
In-Reply-To: <xmqqehrela20.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Apr 2012 08:52:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 23 Apr 2012 18:03:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3NG3G0S017383
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335801801.30584@v/zkND9sfFV9oEjTMUyoUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196136>

Junio C Hamano <gitster@pobox.com> writes:

>> -static void setup_push_upstream(struct remote *remote)
>> +NORETURN die_push_simple(struct branch *branch, struct remote *remote) {
>
> Not static?

fixed.

> Unless you change behaviour depending on NULL-ness of this variable
> later in this code (and I do not think you do---this is only for a
> message string as far as I can see), I'd prefer to see that ?: you have
> at the use site here instead, i.e.
>
> 	if (!short_up)
> 		short_up = branch->merge[0]->src;

applied.

> perhaps with s/short_up/dest_branch/ or something.

Hmm, not really. It's a candidate destination branch, but we'll use the
variable only if the push fails because there is another candidate.

I did s/short_up/short_upstream/ to make it clearer.

>> +	if (simple && strcmp(branch->refname, branch->merge[0]->src)) {
>> +		die_push_simple(branch, remote);
>> +	}
>
> Lose unnecessary {} pair, perhaps?

Yes, removed.

>> +	git --git-dir=repo1 log -1 --format="%h %s" "other-name" >expect-other-name &&
>> +	test_push_success current master &&
>> +	git --git-dir=repo1 log -1 --format="%h %s" "other-name" >actual-other-name &&
>> +	test_cmp expect-other-name actual-other-name
>
> Hrm.
>
> There is nothing wrong in the above part, but it shows taht it would be
> very nice if test_push_success helper also encapsulated the "make sure
> others did not change" logic.

The issue is that one has to define "others", and it is different for
current and upstream so we'd have to add arguments to specify that to
test_push_success. I'd rather keep the helpers API simple, and
special-case when needed as we did here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
