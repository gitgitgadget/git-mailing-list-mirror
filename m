From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH] imap-send.c: replace git_config with git_config_get_string
Date: Fri, 27 Jun 2014 01:57:53 +0200
Message-ID: <53ACB381.80307@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-3-git-send-email-tanayabh@gmail.com> <vpqbntfmx81.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 01:57:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0JYE-00081u-6M
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 01:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbaFZX5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 19:57:53 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:42112 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbaFZX5x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 19:57:53 -0400
Received: by mail-we0-f176.google.com with SMTP id u56so4530516wes.7
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2xKG44t8vNVveQnP++2yQAWsQdUQW8mVwIEr1TIX5BA=;
        b=FsPrx/TzZJjh3HuIVtBKpVY47CuaZnWx++2ZXRiqoCgd/utfYRa9smUbzu1YRxWik4
         Oa2j28yFz6LbI8nbYT3w3uqlqorruLS4A7QJ2CuVE1PvKmUOcgXamtYjU1LbnNy7EY/T
         D/TuAJWj6SIiM5Eh7CRHTMr09cgxGaoWj42TAXgJt7CXTFQoUwPi/kFmcjm0hWzk9R6+
         dZdJb6VrnC3TOLFLh81/Lm1x7T4VOXxCeVOBmckzixJXa3iaZVKvbICAu+ZsRFb9zBTK
         0wvYfXMSyfWYZCD5jKl3QOT3lwYLWAc2Yut8lO2WZePhNLNtZ+QomcsSMLNVQmC1JXzA
         HM6Q==
X-Received: by 10.194.6.134 with SMTP id b6mr15500503wja.64.1403827071802;
        Thu, 26 Jun 2014 16:57:51 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id wk8sm17577541wjb.22.2014.06.26.16.57.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 16:57:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqbntfmx81.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252530>

Am 26.06.2014 18:50, schrieb Matthieu Moy:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> +	if (!git_config_get_string("imap.user", &value))
>> +		server.user = xstrdup(value);
>> +	if (!git_config_get_string("imap.pass", &value))
>> +		server.pass = xstrdup(value);
>> +	if (!git_config_get_string("imap.port", &value))
>> +		server.port = git_config_int("port", value);
>> +	if (!git_config_get_string("imap.tunnel", &value))
>> +		server.tunnel = xstrdup(value);
>> +	if (!git_config_get_string("imap.authmethod", &value))
>> +		server.auth_method = xstrdup(value);
> 
> Given this kind of systematic code, I find it very tempting to factor
> this with a new helper function as
> 
> ...
> git_config_get_string_dup("imap.tunnel", &server.tunnel)
> git_config_get_string_dup("imap.authmethod", &server.auth_method)
> 
> Is there any reason not to do so?
> 


With a pull-style API, you no longer need global variables for
everything, so IMO the helper functions should _return_ the values
rather than taking an output parameter.

E.g. with helper functions as suggested here [1] we could have:

  if (git_config_get_bool("imap.preformattedhtml", 0))
    wrap_in_html(&msg);

...rather than needing an extra variable:

  int bool_value;
  git_config_get_bool("imap.preformattedhtml", &bool_value);
  if (bool_value)
    wrap_in_html(&msg);

...and specify default values along with their respective keys:

  server.ssl_verify = git_config_get_bool("imap.sslverify", 1);
  server.port = git_config_get_int("imap.port", server.use_ssl ? 993 : 143);

...rather than ~1300 lines apart (yuck):

  static struct imap_server_conf server = {
    NULL,  /* name */
    NULL,  /* tunnel */
    NULL,  /* host */
    0,     /* port */
    NULL,  /* user */
    NULL,  /* pass */
    0,     /* use_ssl */
    1,     /* ssl_verify */
    0,     /* use_html */
    NULL,  /* auth_method */
  };


Regarding xstrdup(), I think this is a remnant from the callback
version, which _requires_ you to xstrdup() (the value parameter is
invalidated after returning from the callback).

Side note: with the current callback design, config variables may
get passed to the callback multiple times (last value wins), so
each xstrdup() in current 'git_*_config' functions actually
causes memory leaks (unless prefixed with 'free(my_config_var);').

[1] http://git.661346.n2.nabble.com/PATCH-v3-0-3-git-config-cache-special-querying-api-utilizing-the-cache-tp7613911p7614050.html
