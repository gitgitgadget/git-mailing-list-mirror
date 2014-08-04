From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 5/8] config: add `git_die_config()` to the config-set API
Date: Mon, 04 Aug 2014 22:04:13 +0200
Message-ID: <vpqegwwauo2.fsf@anie.imag.fr>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
	<1406912756-15517-6-git-send-email-tanayabh@gmail.com>
	<xmqqoaw0ruwf.fsf@gitster.dls.corp.google.com>
	<53DFD729.8090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:04:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEOUp-0002Lz-Dd
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbaHDUEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:04:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52547 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbaHDUEe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:04:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s74K4BD6013976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 22:04:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74K4Di9005131;
	Mon, 4 Aug 2014 22:04:13 +0200
In-Reply-To: <53DFD729.8090307@gmail.com> (Tanay Abhra's message of "Tue, 05
	Aug 2014 00:25:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Aug 2014 22:04:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74K4BD6013976
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407787452.71007@1VeueYV5AuW3QR59DHfu/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254772>

Tanay Abhra <tanayabh@gmail.com> writes:

> I was aping the old git_config() system, it also does exactly what you described
> above. for example, builtin/gc.c line 91,
>
> 		if (!strcmp(var, "gc.pruneexpire")) {
> 		if (value && strcmp(value, "now")) {
> 			unsigned long now = approxidate("now");
> 			if (approxidate(value) >= now)
> 				return error(_("Invalid %s: '%s'"), var, value);
> 		}
>
> would print,
>  	error: Invalid gc.pruneexpire: 'value'
> 	fatal: bad config variable 'gc.pruneexpire' at file line 15 in .git/config

It's good to do at least as well as the old system, but I agree with
Junio that it's suboptimal.

Having a single API call to replace

        error("'%s' must be between 1 and 3");
        git_config_die(key);

with stg like:

        git_config_die(key, "'%s' must be between 1 and 3");

in Junio's example would allow git_config_die to format the error
message the way it likes (i.e. it can be the same as before when you
introduce it, and improve afterwards).

I've never been disturbed by the quality of Git's error messages wrt
config files (it's not a compiler!), so having good quality messages is
not a high priority IMHO, but having a good API that as a side effect
can produce good error messages is important. If changing the error
messages requires rewritting all callers later, then we've missed the
point doing the refactoring now.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
