From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [REROLL PATCH 3/8] Pass unknown protocols to external protocol
 handlers
Date: Wed, 9 Dec 2009 17:15:50 +0200
Message-ID: <20091209151549.GB15673@Knoppix>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-4-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vskbl59ai.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 16:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIOGm-0005sR-US
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbZLIPPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbZLIPPt
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:15:49 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:47968 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbZLIPPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:15:48 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id B82818BE14;
	Wed,  9 Dec 2009 17:15:53 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05D2A800B8; Wed, 09 Dec 2009 17:15:53 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 5A73A27D84;
	Wed,  9 Dec 2009 17:15:50 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vskbl59ai.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134975>

On Tue, Dec 08, 2009 at 03:35:17PM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> > +const char *remove_ext_force(const char *url)
> > +{
> > +	const char *url2 = url;
> > +	const char *first_colon = NULL;
> > +
> > +	if (!url)
> > +		return NULL;
> > +
> > +	while (*url2 && !first_colon)
> > +		if (*url2 == ':')
> > +			first_colon = url2;
> > +		else
> > +			url2++;
> > +
> > +	if (first_colon && first_colon[1] == ':')
> > +		return first_colon + 2;
> > +	else
> > +		return url;
> > +}
> 
> Sorry, I am slow today, but is this any different from:
> 
> 	if (url) {
> 		const char *colon = strchr(url, ':');
> 	        if (colon && colon[1] == ':')
> 	        	return url2 + 2;
> 	}
> 	return url;

Undefined variable url2 (you mean colon?). Changed.
 
> > diff --git a/transport.c b/transport.c
> > index 3eea836..e42a82b 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -780,6 +780,58 @@ static int is_file(const char *url)
> >  	return S_ISREG(buf.st_mode);
> >  }
> >  
> > +static const char *strchrc(const char *str, int c)
> > +{
> > +	while (*str)
> > +		if (*str == c)
> > +			return str;
> > +		else
> > +			str++;
> > +	return NULL;
> > +}
> 
> I cannot spot how this is different from strchr()...

Return type. Not that useful. Removed.
 
> > +static int is_url(const char *url)
> > +{
> > +	const char *url2, *first_slash;
> > +
> > +	if (!url)
> > +		return 0;
> > +	url2 = url;
> > +	first_slash = strchrc(url, '/');
> > +
> > +	/* Input with no slash at all or slash first can't be URL. */
> > +	if (!first_slash || first_slash == url)
> > +		return 0;
> > +	/* Character before must be : and next must be /. */
> > +	if (first_slash[-1] != ':' || first_slash[1] != '/')
> > +		return 0;
> > +	/* There must be something before the :// */
> > +	if (first_slash == url + 1)
> > +		return 0;
> > +	/*
> > +	 * Check all characters up to first slash. Only alpha, num and
> > +	 * colon (":") are allowed. ":" must be followed by ":" or "/".
> > +	 */

I tightened this a bit, only checking (exclusive) character before first
"/" and requiring all-alphanum. The previous rules were apparently
leftover from times the "specify remote helper by url" patch didn't
exist.

Considering context at call site, it is equivalent, since any ':' must be
followed by '/' or is_url will never be called, and first ':/' must be
exactly at last_slash - 1 (by earlier checks).
 
> Hmm, so "a::::bc:://" is ok?

is_url never gets such thing. Due to "::" it bypasses URL validation. And
yes, it is ok.

> Is the reason this does not to check the string up to (first_slash-1) for
> a valid syntax for <scheme> (as in "<scheme>://") because this potentially
> has "<helper>::" in front of it?

It doesn't have '<helper>::' in front of it.

> I cannot tell if you want to allow "<helper1>::<helper2>::<scheme>://..."
> by reading this code.

Allowing or denying that is not up to this function. And one can't chain
helpers that way. It invokes <helper1>
 
> > +static int external_specification_len(const char *url)
> > +{
> > +	return strchrc(url, ':') - url;
> > +}
> 
> Does the caller guarantee url has at least one colon in it?

Anything passing is_url() does have ':' in it.

> > +	} else if (!is_url(url)
> > +		|| !prefixcmp(url, "file://")
> > +		|| !prefixcmp(url, "git://")
> > +		|| !prefixcmp(url, "ssh://")
> > +		|| !prefixcmp(url, "git+ssh://")
> > +		|| !prefixcmp(url, "ssh+git://")) {
> > +		/* These are builtin smart transports. */
> 
> Hmm, what is !is_url(url) at the beginning for, if this lists "builtin"
> smart transports?

It catches the scp and path syntaxes as not URLs.
 
> > +	} else {
> > +		/* Unknown protocol in URL. Pass to external handler. */
> > +		int len = external_specification_len(url);
> > +		char *handler = xmalloc(len + 1);
> > +		handler[len] = 0;
> > +		strncpy(handler, url, len);
> > +		transport_helper_init(ret, handler);
> 
> Hmph, external_specification_len() may get passed a colon-less string
> after all, I think.

Nope, it can't. Else if above snarfs everything that doesn't pass
is_url, and string can't pass it without having ':' in it. 

-Ilari
