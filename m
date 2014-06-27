From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] pager.c: replace git_config with git_config_get_string
Date: Fri, 27 Jun 2014 13:55:14 +0200
Message-ID: <vpqr42afty5.fsf@anie.imag.fr>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-6-git-send-email-tanayabh@gmail.com>
	<CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>
	<53AC6A7B.3040602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Tanay Abhra <tanayabh@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 13:55:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Ukc-0006YX-FA
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 13:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbaF0LzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 07:55:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49316 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378AbaF0LzU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 07:55:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s5RBtDRP001756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Jun 2014 13:55:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5RBtEQL026396;
	Fri, 27 Jun 2014 13:55:14 +0200
In-Reply-To: <53AC6A7B.3040602@gmail.com> (Karsten Blees's message of "Thu, 26
	Jun 2014 20:46:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 27 Jun 2014 13:55:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5RBtDRP001756
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404474914.00811@BUhBVNuMJ8EYKneyr+5Myg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252545>

Karsten Blees <karsten.blees@gmail.com> writes:

> If for some reason a config string is accessed after config_cache_free()
> (which would be a bug), you won't notice if strings are xstrdup()ed (i.e. git
> will continue to run with some invalid configuration). This is IMO much worse
> than failing with segfault.

I disagree. In most case, continuing to use the old config value is the
right thing.

First, config_cache_free() is called whenever _any_ configuration
variable is set. So, setting "core.foo" also invalidates "core.bar" in
the cache, while a user of "core.bar" could continue working with the
old, unchanged value.

Then, allowing the invalidation of a config variable at any time raises
a lot of tricky cases (if a command uses a configuration variable twice,
do we really want to implement and test the behavior for all combination
of old/new values for both usages?). More tricky cases usually means
more bugs on the user-side ...

When the code really want the freshest value, it's cheap to re-query the
config cache anyway.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
