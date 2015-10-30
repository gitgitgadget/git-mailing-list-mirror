From: Knut Franke <k.franke@science-computing.de>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Fri, 30 Oct 2015 19:01:30 +0100
Message-ID: <20151030180129.GA6425@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <1446025245-10128-1-git-send-email-k.franke@science-computing.de>
 <1446025245-10128-2-git-send-email-k.franke@science-computing.de>
 <xmqqsi4vkkcf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:11:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsE92-0006zx-RM
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760217AbbJ3SLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:11:16 -0400
Received: from mx3.science-computing.de ([193.197.16.20]:29152 "EHLO
	mx3.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbbJ3SLP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:11:15 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Oct 2015 14:11:15 EDT
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 29D253CF0;
	Fri, 30 Oct 2015 19:01:31 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obi.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wPzlfa-HrC3U; Fri, 30 Oct 2015 19:01:30 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id A745B3AC5;
	Fri, 30 Oct 2015 19:01:30 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 8DBC7A771D; Fri, 30 Oct 2015 19:01:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqsi4vkkcf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280502>

Junio C Hamano wrote:
> > +	if (http_proxy_authmethod) {
> > +		int i;
> > +		for (i = 0; i < ARRAY_SIZE(http_proxy_authmethods); i++) {
> > +			if (!strcmp(http_proxy_authmethod, http_proxy_authmethods[i].name)) {
> > +				curl_easy_setopt(result, CURLOPT_PROXYAUTH,
> > +						http_proxy_authmethods[i].curlauth_param);
> > +				break;
> > +			}
> > +		}
> > +		if (i == ARRAY_SIZE(http_proxy_authmethods)) {
> > +			warning("unsupported proxy authentication method %s: using default",
> > +			      http_proxy_authmethod);
> > +		}
> > +	}
> > +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> > +	else
> > +		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> > +#endif
> > +}
> 
> This patch should take what 1c2dbf20 (http: support curl < 7.10.7,
> 2015-02-03) wanted to do into account.  Having the configuration
> variable or the environment variable defined by itself, while
> running a Git built with old cURL, shouldn't trigger any warning,
> but the entire function should perhaps be ifdefed out or something?

Maybe add a #define LIBCURL_CAN_HANDLE_PROXY_AUTH to clarify this, like we do
with LIBCURL_CAN_HANDLE_AUTH_ANY? If so, should this be a separate patch? With
the current (scattered) version dependencies, it took me a while to realize that
if the function is ifdefed out for LIBCURL_VERSION_NUM < 0x070a07, we don't need
to worry about default behavior in case LIBCURL_CAN_HANDLE_AUTH_ANY is not
defined. (on the other hand, looking at other curl-version-ifdefs, the define
for AUTH_ANY is the exception)

> >> +static void copy_from_env(const char **var, const char *envname)
> >> +{
> >> +  const char *val = getenv(envname);
> >> +  if (val)
> >> +      *var = xstrdup(val);
> >> +}
[...]
> I primarily was
> wishing that its name more clearly conveyed that it sets the
> variable from the environment _only if_ the environment variable
> exists, and otherwise it does not clobber.

How about env_override? Not perfect, but probably better. I don't think
squeezing in more information (maybe_env_override, override_from_env_var) would
help.

> The implementation of the helper seems to assume that the variable
> must not be pointing at a free-able piece of memory when it is
> called

In fact, if http.proxyAuthMethod (btw, I agree with Eric about capitalization)
is set, I do call it with *var pointing to free-able memory. Will fix this.

FWIW, set_from_env() has the same pre-condition, which doesn't seem to be
satisfied in all cases (namely when overwriting variables previously set by
git_config_string()); not to mention missing free()s in http_cleanup.


Otherwise, I'll make the suggested fixes. Thanks.


Cheers,
Knut
-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Arno Steitz
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
