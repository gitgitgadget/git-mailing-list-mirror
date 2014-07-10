From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 1/2] add `config_set` API for caching config-like files
Date: Thu, 10 Jul 2014 11:41:38 +0200
Message-ID: <vpqa98hwnxp.fsf@anie.imag.fr>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>
	<1404903454-10154-2-git-send-email-tanayabh@gmail.com>
	<vpq61j6d92z.fsf@anie.imag.fr> <53BD3805.40504@gmail.com>
	<vpqion68viq.fsf@anie.imag.fr>
	<xmqqmwci7e9p.fsf@gitster.dls.corp.google.com>
	<xmqq38ea77gt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 11:41:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5ArS-0004of-FI
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 11:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbaGJJlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 05:41:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40138 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889AbaGJJlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 05:41:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6A9fbfF031304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jul 2014 11:41:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6A9fct2004144;
	Thu, 10 Jul 2014 11:41:38 +0200
In-Reply-To: <xmqq38ea77gt.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 09 Jul 2014 10:44:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 10 Jul 2014 11:41:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6A9fbfF031304
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405590100.11146@cYcREu/FojKTynavGVfyLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253181>

Junio C Hamano <gitster@pobox.com> writes:

> After thinking about it a bit more, I think <file, line> support
> needs to be done not as a mere client of the generic, uncached
> git_config() API that we have had for forever, like the current
> iteration, but needs to know a bit more about the state the caller
> of the callback (namely, git_parse_source()), and we obviously do
> not want to expose that machinery to anybody other than the
> implementation of the config subsystem (to which the new facility
> this GSoC project adds belongs to), so in that sense you have to
> have your code in the same config.c file anyway.

I do not buy the argument. Why would callers of the callback-style API
not be allowed to give <file, line> errors?

To me, it is a weakness of the API that <file, line> information is not
available to callback functions, regardless of the config-cache.

> It is somewhat dissapointing that this initial implementation was
> done as a client of the traditional git_config(), by the way.  I
> would have expected that it would be the other way around, in that
> the traditional callers of git_config() would behefit automatically
> by having the cache layer below it.

I disagree, and I agree ;-).

I disagree that it is disapointing to use git_config(), and I think the
beauty of the current implementation is to allow this cache mechanism
without changing the parsing code.

I agree that the callers of git_config() could benefit from the cache
mechanism, i.e. use the in-memory pre-parsed config instead of
re-parsing the file each time.

> But we have to start from somewhere.  Perhaps the round after this
> one can rename the exisiting implementation of git_config() to
> something else internal to the caching layer and give the existing
> callers a compatible interface that is backed by this new caching
> layer in a transparent way.

In PATCH v4, there was a git_config_iter function that did exactly that.
I didn't notice it was gone for v5, but could be rather easily
resurected.

I suggest, on top of the current series:

PATCH 3 : (re)introduce git_config_iter, compatible with git_config
  (one variant with a configset argument, another working on the_config_set).

PATCH 4 : rename git_config to e.g. git_config_parse, and
  git_config_iter to git_config.

Then, check that tests still pass (PATCH 4 automatically uses the new
code essentially in every place where Git deals with config, so existing
tests will start to stress the code a lot more), and check with e.g.
"strace -e open git ..." that config files are now parsed only once
where they used to be parsed multiple times.

I'd do that as a separate series, to let the current one finally reach
pu.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
