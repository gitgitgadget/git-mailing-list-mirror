From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 1/2] add `config_set` API for caching config-like files
Date: Wed, 09 Jul 2014 16:19:25 +0200
Message-ID: <vpqion68viq.fsf@anie.imag.fr>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>
	<1404903454-10154-2-git-send-email-tanayabh@gmail.com>
	<vpq61j6d92z.fsf@anie.imag.fr> <53BD3805.40504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 16:19:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4sij-0002z2-SG
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 16:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbaGIOTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 10:19:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36636 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbaGIOTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 10:19:37 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s69EJNkG004898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Jul 2014 16:19:23 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s69EJPBJ025574;
	Wed, 9 Jul 2014 16:19:25 +0200
In-Reply-To: <53BD3805.40504@gmail.com> (Tanay Abhra's message of "Wed, 09 Jul
	2014 18:09:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Jul 2014 16:19:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s69EJNkG004898
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405520366.13481@SdKF0xsHyDjNOTrFSRmhYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253125>

Tanay Abhra <tanayabh@gmail.com> writes:

> Also, I tried implementing Junio's request about saving the line
> number and the file name for each
> key-value pair. I had some success, but with some changes,

My opinion on this:

* It's low priority. I think the order of priority should be (high to
  low)

  1) Finish and get the current series into pu (we're almost there, it's
     not time to back off and restart something new).

  2) Work on the other series that uses the new API. We don't need to
     change _all_ the uses, but we do need a few tens of them to
     validate the fact that the new API is nice and convenient to use.

  3) Get new actual features for the user (tidy up config files, give
     error messages based on numbers).

  You probably won't finish everything, so just think: if the GSoC ends
  between 1) and 2), how serious is it? if it ends between 2) and 3),
  how serious? If reverse the order, then the risk of having nothing
  finished and mergeable at the end is high. If it happens, the
  community may or may not take over and finish it ...

* Still, making sure that the (file, line) is doable later without too
  much change is good. So, if indeed, moving all code to another file is
  required, then it may make sense to do it now to avoid code move
  later.

> 1. config-hash.c had to be shifted to config.c entirely.

Why? I guess one reason is the use of struct cf (are there others?), but
moving just

config_hash_callback
config_hash_add_value
git_configset_add_file

to config.c should do it. Then, config.c could use config-hash.c.

But a cleaner way would be to allow the callback to receive the
config_file struct without accessing it as a global variable (currently,
we have no way to parse two config files in parallel for example).

In practice, it should be possible to pass a 4th pointer argument to the
callback, and keep compatibility with 3 arguments callback (having too
many arguments in not a problem will all ABI I know), but I'm don't
think this is allowed in theory.

On overall, I'm not convinced we should move the code. When the argument
"I need to merge these two things otherwise it doesn't compile" comes in
a discussion, it usually means there's an architecture issue
somewhere ;-).

> One more thing, Karsten's string-intern API can be used for saving
> file names as they are repeated a
> lot.

This, or storing the list of filenames in struct config_set (more or
less as you did in previous patch), and store pointers to the same
string in each config_hash_entry.

But strdup-ing all filenames seems a bit heavy to me. Even though we're
not talking about performance-critical part of Git, I don't like the
idea of wasting too much ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
