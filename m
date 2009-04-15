From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v2] fetch: Strip usernames from url's before storing them
Date: Wed, 15 Apr 2009 22:45:14 +0200
Message-ID: <49E6475A.3090801@op5.se>
References: <49E5EBD2.1070704@op5.se> <1239805814-21340-1-git-send-email-ae@op5.se> <7vbpqxvnpl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 22:47:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuC0T-0007Ty-Rt
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 22:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbZDOUpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 16:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbZDOUpT
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 16:45:19 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59261 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbZDOUpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 16:45:18 -0400
Received: by fxm2 with SMTP id 2so80783fxm.37
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 13:45:16 -0700 (PDT)
Received: by 10.86.36.17 with SMTP id j17mr490146fgj.38.1239828315940;
        Wed, 15 Apr 2009 13:45:15 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm11797441fgg.25.2009.04.15.13.45.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 13:45:15 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vbpqxvnpl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116647>

Thanks for the feedback. Many appreciated.

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> +/*
>> + * Strip username information from the url and return it in a
>> + * newly allocated string which the caller has to free.
>> + *
>> + * The url's we want to catch are the following:
>> + *   ssh://[user@]host.xz[:port]/path/to/repo.git/
>> + *   [user@]host.xz:/path/to/repo.git/
>> + *   http[s]://[user[:password]@]host.xz/path/to/repo.git
> 
> If this is a valid URL:
> 
> 	scheme://host.xz/path@with@at@sign.git/
> 
> we do not want to mistakenly trigger this logic.
> 

I'm guessing, and I'm slightly inebriated so don't yell too hard at me if
you think your mail will hit me in the morning ;-)

It *is* valid for "bare ssh" url's, but that would only trigger the fourth
(and last) case of the if() else if() thing which would return a strdup().
It won't have a scheme, and it won't have a colon after the @-sign.

An url with a scheme can't contain a colon *before* the at-sign if it does
contain a username, and it won't contain a colon *after* the @-sign if it
*does* contain a username. This is a guess, but I wrote that part of the
transport code initially, so I've got a decent inkling of what git accepts
in the first place (although it might not be strong enough in the face of
the various RFC's, I know).

> I do not know if rsync://me@there/path is supported, but we should
> generalize to support any scheme://me@there/path to keep the code simpler.
> You do not do anything special based on the URL scheme other than learning
> how long the scheme:// part is to copy it anyway.

I've never seen rsync://user@ style url's before. It's trivial to add support
for it if it's valid though, but for the reasons above, I'm not too fussed
about trying to support URL's we're extremely unlikely to see in real life.
The last else if() really does catch a lot.

>  Perhaps like...
> 
> char *transport_anonymize_url(const char *url)
> {
> 	char *anon_url, *scheme_prefix, *anon_part;
> 	size_t len, prefix_len = 0;
> 
> 	anon_part = strchr(url, '@');
> 	if (is_local(url) || !anon_part)
> 		goto literal_copy;
> 
> 	anon_part++;
> 	scheme_prefix = strstr(url, "://");
> 	if (scheme_prefix) {
> 		const char *cp;
> 		/* make sure scheme is reasonable */
> 		for (cp = url; cp < scheme_prefix; cp++) {
> 			switch (*cp) { /* RFC 1738 2.1 */
> 			case '+':
> 			case '.':
> 			case '-':
> 				break; /* ok */

Isn't %xx also a valid escape sequence for unknown chars in url's, according
to the aforementioned RFC?


> 			default:
> 				if (isalnum(*cp))
> 					break;
> 				/* it isn't */
> 				goto literal_copy;
> 			}
> 		}
> 		/* @ past the first slash does not count */
> 		cp = strchr(scheme_prefix + 3, '/');
> 		if (cp < anon_part)
> 			goto literal_copy;
> 		prefix_len = scheme_prefix - url + 3;
> 	}
> 	else if (!strchr(anon_part, ':'))
> 		/* cannot be "me@there:/path/name" */

Nice, but the comment is misleading to the simple (or drunk) mind.
It can't contain an @-sign at all due to the check above, which I'd
be happier if it mentions (me being both atm, I'm inclined to think
in rather straight lines).

Otherwise I really like it.

> 		goto literal_copy;
> 	len = prefix_len + strlen(anon_part);
> 	anon_url = xmalloc(len + 1);
> 	memcpy(anon_url, url, prefix_len);
> 	memcpy(anon_url + prefix_len, anon_part, strlen(anon_part));
> 	return anon_url;
>  literal_copy:
> 	return xstrdup(url);
> }


This looks sensible and fairly generic, and I'll happily defer to a
more capable and less drunk programmer any time of the day. I'll copy
it into anon-url.c tomorrow and see how it pans out with some of the
weirder URL's you gave today.

If anyone's got some tricky url's they want me to try, email me
before 08:00 GMT tomorrow and I'll give 'em a whirl with multiple
algo's.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
