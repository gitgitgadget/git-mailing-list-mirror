From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git: problematic git status output with some translations (such as fr_FR)
Date: Wed, 12 Mar 2014 11:53:38 -0700
Message-ID: <xmqqa9cvmeod.fsf@gitster.dls.corp.google.com>
References: <20131008085036.11434.25160.reportbug@x230-buxy.home.ouaza.com>
	<20131219104613.GA18379@x230-buxy.home.ouaza.com>
	<20131219194319.GB20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Raphael Hertzog <hertzog@debian.org>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 19:53:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNoHi-0000ZO-9c
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbaCLSxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:53:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbaCLSxl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:53:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0060736CD;
	Wed, 12 Mar 2014 14:53:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ujzi5YFyH2V0AwqNKXuatSYn6bM=; b=mxPpGX
	O33/ZSFZNS0pHN+1GMowCGZ/0epqVcbMPJBiGgM88mA/m0D0SOZt91EybJ/O5Ig/
	iI6zHZeZz0yk6aG3xyNMPCAk1+fdicTZYFkjduSXbKaXjLT79LWVDKAQ8KGQq4pf
	3nkLqX1uqoDWeVSEMEOAeLdBdW/NIQkHIl07s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GjRhvKuZtnyrjP+FpNIonV2weRNbSfH8
	3JqU85/AOkSm4gZ7q9Fwyku9UFbgnvxzG1razVIh1bYpT7yFPlEIoZTwwSeWs/Fg
	5vAo0dwmmZp7Lndv25tJ4cY+Za6JJsrsP2EGfdU71SpFyhcykc79rCdWWWzA8psA
	uAH1oPArCqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CA31736CC;
	Wed, 12 Mar 2014 14:53:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6862736CB;
	Wed, 12 Mar 2014 14:53:39 -0400 (EDT)
In-Reply-To: <20131219194319.GB20443@google.com> (Jonathan Nieder's message of
	"Thu, 19 Dec 2013 11:43:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A0232F52-AA17-11E3-B0A7-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243963>

Jonathan Nieder <jrnieder@gmail.com> writes:

> @@ -292,6 +291,48 @@ static const char *wt_status_diff_status_string(int status)
>  	}
>  }
>  
> +static int maxwidth(const char *(*label)(int), int minval, int maxval)
> +{
> +	const char *s;
> +	int result = 0, i;
> +
> +	for (i = minval; i <= maxval; i++) {
> +		const char *s = label(i);
> +		int len = s ? strlen(s) : 0;

Shouldn't this be a utf8_strwidth(), as the value is to count number
of display columns to be used by the leading label part?

> +		if (len > result)
> +			result = len;
> +	}
> +	return result;
> +}
> +
> +static void wt_status_print_unmerged_data(struct wt_status *s,
> +					  struct string_list_item *it)
> +{
> +	const char *c = color(WT_STATUS_UNMERGED, s);
> +	struct wt_status_change_data *d = it->util;
> +	struct strbuf onebuf = STRBUF_INIT;
> +	static char *padding;
> +	const char *one, *how;
> +	int len;
> +
> +	if (!padding) {
> +		int width = maxwidth(wt_status_unmerged_status_string, 1, 7);
> +		width += strlen(" ");
> +		padding = xmallocz(width);
> +		memset(padding, ' ', width);
> +	}
> +
> +	one = quote_path(it->string, s->prefix, &onebuf);
> +	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
> +
> +	how = wt_status_unmerged_status_string(d->stagemask);
> +	if (!how)
> +		how = _("bug");

I'd rather see the callee do this _("bug") thing, not this
particular caller.

> +	len = strlen(padding) - utf8_strwidth(how);
> +	status_printf_more(s, c, "%s%.*s%s\n", how, len, padding, one);
> +	strbuf_release(&onebuf);
> +}
