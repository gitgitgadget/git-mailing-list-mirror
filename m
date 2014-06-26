From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Thu, 26 Jun 2014 19:37:38 +0200
Message-ID: <vpq1tubinbx.fsf@anie.imag.fr>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<53A84077.4010200@ramsay1.demon.co.uk>
	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
	<53A99FEB.5040808@ramsay1.demon.co.uk>
	<xmqq61joamcc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 19:39:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Ddt-0001Cb-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 19:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbaFZRjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 13:39:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55263 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214AbaFZRjV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 13:39:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s5QHbaY7026913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jun 2014 19:37:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5QHbcRx015376;
	Thu, 26 Jun 2014 19:37:38 +0200
In-Reply-To: <xmqq61joamcc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 25 Jun 2014 11:13:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 26 Jun 2014 19:37:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5QHbaY7026913
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404409058.47423@fOaszEhHOFiBlZIfsnkQJw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252511>

Junio C Hamano <gitster@pobox.com> writes:

> When the submodule script that uses "git config -f .gitmodules" is
> converted into C, if the updated config API is ready, it may be able
> to do something like these in a single program:
>
> 	const char *url;
> 	struct config_set *gm_config;
>
>         /* read from $GIT_DIR/config */
>         url = git_config_get_string("remote.origin.url");
>
>         /*
>          * allow us to read from .gitmodules; the parameters are
>          * list of files that make up the configset, perhaps.
>          */
> 	gm_config = git_configset_new(".gitmodules", NULL);
>
>
>         if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore")) {
> 		/* do a lot of stuff for the submodule */
>                 ...
> 	}
>
>         /* when we are done with the configset */
>         git_configset_clear(gm_config);

Isn't that a bit overkill? Why not just let the caller manage a hashmap
directly instead of a config_set? Your code could become

  struct hashmap *gm_config;
  config_cache_init(&gm_config);
  config_cache_read_from_file(".gitmodule", gm_config);
  /* possibly more calls to
     config_cache_read_from_file("some-other-file", ...). */
  
and then

  if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore")) {
     ...
  

Perhaps a bit more complicated to use, but much simpler to implement.
Since there are very few callers, I'd say it's better to keep the
implementation simple.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
