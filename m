From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 2/5] notes.c: replace `git_config()` with `git_config_get_value_multi()`
Date: Wed, 30 Jul 2014 16:13:31 +0200
Message-ID: <vpq1tt3q6ic.fsf@anie.imag.fr>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
	<1406727549-22334-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:13:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCUda-0002My-6f
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 16:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbaG3ONr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 10:13:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43744 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762AbaG3ONq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 10:13:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6UEDTBP014191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2014 16:13:29 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6UEDVJs014069;
	Wed, 30 Jul 2014 16:13:31 +0200
In-Reply-To: <1406727549-22334-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 30 Jul 2014 06:39:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 30 Jul 2014 16:13:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6UEDTBP014191
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407334411.21821@dgUXXYSd9Hf9/iXnX2852A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254496>

Tanay Abhra <tanayabh@gmail.com> writes:

> -	git_config(notes_display_config, &load_config_refs);
> +	if (load_config_refs) {
> +		values = git_config_get_value_multi("notes.displayref");
> +		if (values) {
> +			for (i = 0; i < values->nr; i++) {
> +				if (!values->items[i].string)
> +					config_error_nonbool("notes.displayref");
> +				else
> +					string_list_add_refs_by_glob(&display_notes_refs,
> +								     values->items[i].string);
> +			}
> +		}
> +	}

It seems to me that you're doing a lot here that should have been done
once in the config API:

* if (values) {
          for (i = 0; i < values->nr

  => We could avoid the "if" statement if git_config_get_value_multi was
  always returning a string_list, possibly empty (values->nr == 0
  instead of values == NULL).

  Not as obvious as it seems, because you normally return a pointer to
  the string_list that is already in the hashmap, so you can't just
  malloc() an empty one if you don't want to leak it.

  Another option would be to provide an iterator that would call a
  function on each value of the list, and do nothing when there's no
  list at all (back to the callback-style API, but you would iterate
  only through the values for the right key).

* if (!values->items[i].string)
          config_error_nonbool(

  => This check could be done once and for all in a function, say
  git_config_get_value_multi_nonbool, a trivial wrapper around
  git_config_get_value_multi like

const struct string_list *git_configset_get_value_multi_nonbool(struct config_set *cs, const char *key)
{
	struct string_list l = git_configset_get_value_multi(cs, key);
        // possibly if(l) depending on the point above.
	for (i = 0; i < values->nr; i++) {
		if (!values->items[i].string)
			git_config_die(key);
	}
	return l;
}

const struct string_list *git_config_get_value_multi_nonbool(const char *key)
{
	git_config_check_init();
	return git_configset_get_value_multi_nonbool(&the_config_set, key);
}


  (totally untested)

  BTW, is it intentional that you call config_error_nonbool() without
  die-ing?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
