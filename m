From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9r2 1/2] add `config_set` API for caching config-like files
Date: Wed, 16 Jul 2014 18:06:59 +0200
Message-ID: <vpqha2h9tjw.fsf@anie.imag.fr>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>
	<1405434571-25459-3-git-send-email-tanayabh@gmail.com>
	<xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>
	<53C665A0.2060705@gmail.com> <vpqvbqxjzfx.fsf@anie.imag.fr>
	<53C66E70.3050507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 18:07:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Rjc-0000Rc-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 18:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbaGPQHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 12:07:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48320 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934509AbaGPQHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 12:07:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6GG6vmO011637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jul 2014 18:06:57 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6GG6xic026953;
	Wed, 16 Jul 2014 18:06:59 +0200
In-Reply-To: <53C66E70.3050507@gmail.com> (Tanay Abhra's message of "Wed, 16
	Jul 2014 17:52:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Jul 2014 18:06:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6GG6vmO011637
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406131618.62319@T9h+EfmiWiwzCgu3HVG3+A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253671>

Tanay Abhra <tanayabh@gmail.com> writes:

> implemented as a thin wrapper around the `config_set` API.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>  Documentation/technical/api-config.txt | 137 +++++++++++++++++
>  cache.h                                |  30 ++++
>  config.c                               | 264 +++++++++++++++++++++++++++++++++
>  3 files changed, 431 insertions(+)

(you broke the patch by removing the ---)

> +static void git_config_check_init(void)
> +{
> +	if (the_config_set.hash_initialized)
> +		return;
> +	git_configset_init(&the_config_set);
> +	git_config(config_set_callback, &the_config_set);
> +}

So, you're now ignoring the return value of git_config. What is the
rationale for this? In particular, why did you reject the "die"
possibility (I understood that you were inclined to take this option, so
I'm curious why you changed your mind).

OTOH, you're transmitting the return value without dying here:

+int git_configset_add_file(struct config_set *cs, const char *filename)
+{
+	return git_config_from_file(config_set_callback, filename, cs);
+}

and I think this one is correct, as we cannot tell in advance how
serious an error would be for any callers. And we do test this (I think
we can improve a bit, I'll send a fixup patch).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
