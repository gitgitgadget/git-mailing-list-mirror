From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase: accept indented comments (fixes regression)
Date: Wed, 30 Sep 2015 21:17:02 +0200
Message-ID: <vpqwpv7hg41.fsf@grenoble-inp.fr>
References: <1443600661-19391-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqd1wz9402.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Galan =?iso-8859-1?Q?R=E9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 21:17:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhMsc-0002Sx-KV
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 21:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbbI3TR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 15:17:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41936 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932923AbbI3TRT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 15:17:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8UJH0vW028824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 30 Sep 2015 21:17:00 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8UJH2qN016786;
	Wed, 30 Sep 2015 21:17:02 +0200
In-Reply-To: <xmqqd1wz9402.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 30 Sep 2015 11:05:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 Sep 2015 21:17:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8UJH0vW028824
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444245420.67541@S1M9EqDVJ911INfEgMEWzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278856>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> With Git <2.0.6, 'git rebase' used to accept lines starting with
>> whitespaces followed with '#' as a comment. This was broken by
>> 804098b (git rebase -i: add static check for commands and SHA-1,
>> 2015-06-29), which introduced additional checks on the TODO-list using
>> "git stripspaces" which only strips comments starting at the first
>> column.
>
> I cannot help thinking that this is sidestepping the real issue.
>
> The real issue, I think, is that the new check tokenises the input
> differently from how the expand_todo_ids -> transform_todo_ids
> callchain parses it.  The problem Nazri Ramliy noticed about the new
> check that does not ignore the indentation is merely one aspect of
> it.

Right.

> Stripping leading whilespaces with sed may ignore indented anything
> and help Nazri's script, but 804098b tightened checks to disallow
> other things that we historically allowed, e.g. if you replace SP
> between "pick" and the commit object name with an HT, the new check
> will not notice that HT is also a perfectly good token separator
> character and barfs.

Indeed. I'm adding a test for that too.

> I am actually tempted to say that we should revert 804098b, which is
> the simplest fix.

I think the commit has value, and reverting it makes the "drop" command
essentially useless.

> As far as I can tell, the hand-rolled parsing is there only in oder
> to report the incoming $line as-is.

Indeed, I remember finding the parsing code weird when I reviewed it,
and the reason was to provide the exact line.

> It is much easier to just identify with which line number the location
> of the problem, and show it when it is necessary from the original
> source, and we do not care about performance in the error codepath.

Agreed.

> Perhaps something along these lines instead, with your new tests
> added in?

Sounds good, yes. I'll send a patch with this and my updated tests.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
