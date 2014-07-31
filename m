From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 6/7] config: add `git_die_config()` to the config-set API
Date: Thu, 31 Jul 2014 20:41:57 +0200
Message-ID: <vpqoaw55q16.fsf@anie.imag.fr>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
	<1406821662-1570-7-git-send-email-tanayabh@gmail.com>
	<vpqr411h69h.fsf@anie.imag.fr> <53DA7281.8060403@gmail.com>
	<vpqr411bhd5.fsf@anie.imag.fr> <53DA7C23.3090603@gmail.com>
	<vpqa97p8koq.fsf@anie.imag.fr> <53DA8A54.6060208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCvIo-0002P5-5m
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 20:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbaGaSmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 14:42:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33856 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbaGaSmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 14:42:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VIftVM002514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 20:41:55 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VIfv0J029373;
	Thu, 31 Jul 2014 20:41:57 +0200
In-Reply-To: <53DA8A54.6060208@gmail.com> (Tanay Abhra's message of "Thu, 31
	Jul 2014 23:56:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 Jul 2014 20:41:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VIftVM002514
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407436919.20518@rEd7v4fyC4hTZCFr8dLjkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254597>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/31/2014 11:39 PM, Matthieu Moy wrote:
>
>> This is the part I find weird. You're calling git_die_config_exact() on
>> the first boggus value, and git_die_config_exact() will notify an error
>> at the line of the last boggus value.
>
> Hmn, we may have some confusion here. I meant the implementation of
> git_config_exact() to look like this,
>
> void git_die_config_exact(const char *key, const char *value)
> {
> 	int i;
> 	const struct string_list *values;
> 	struct key_value_info *kv_info;
> 	values = git_config_get_value_multi(key);
> 	for (i = 0; i < values.nr; i++) {
> 		kv_info = values->items[i].util;
> 		/* A null check will be here also */
> 		if (!strcmp(value, values->items[i].string)) {
> 			if (!kv_info->linenr)
> 				die(_("unable to parse '%s' from command-line config"), key);
> 			else
> 				die(_("bad config variable '%s' at file line %d in %s"),
> 					key,
> 					kv_info->linenr,
> 					kv_info->filename);
> 		}
> 	}
> }
>
> The above code would print the info on first bogus value.

OK, I got confused because git_die_config() errors out at the first
error. So, your version works, but I do not see any added value in this
extra complexity.

To be cleary, my version would be

NORETURN static /* not sure about the "static" */
void git_die_config_linenr(const char *key,
                           const char *filename, int linenr)
{
	if (!linenr)
		die(_("unable to parse '%s' from command-line config"), key);
	else
		die(_("bad config variable '%s' at file line %d in %s"),
			key,
			linenr,
			filename);
}

(hmm, I actually do not need the value, it's not printed)

NORETURN
void git_die_config(const char *key)
{
	const struct string_list *values;
	struct key_value_info *kv_info;
	values = git_config_get_value_multi(key);
	kv_info = values->items[values->nr - 1].util;
	git_die_config_linenr(key, kv_info->linenr, kv_info->filename);
}

(we forgot the NORETURN in previous version BTW. It should be there in
both functions here and in the .h file)

In my version, git_die_config uses git_die_config_linenr, and there's no
issue with first/last boggus value. Callers of git_die_config_linenr
have all the information to call it directly.

There are 3 code path that leads to the final die() calls, and having
this little helper allows making sure the messages are the same for
every callers, by construction (as opposed to cut-and-pasting).

Really, I don't see any reason to do anything more complex.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
