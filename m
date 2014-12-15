From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] win32: syslog: prevent potential realloc memory leak
Date: Mon, 15 Dec 2014 10:11:33 -0800
Message-ID: <xmqqbnn4eqay.fsf@gitster.dls.corp.google.com>
References: <1418463676-1753-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Arjun Sreedharan <arjun024@gmail.com>,
	Mike Pape <dotzenlabs@gmail.com>
To: git mailing list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 19:11:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0a7T-000110-3p
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 19:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbaLOSLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 13:11:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750770AbaLOSLi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 13:11:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55D062728E;
	Mon, 15 Dec 2014 13:11:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t2rMSyb8FJGbEtVOl4OoppYlz5M=; b=uYWfKm
	/k+eYxKXuRMHNDHJWZpfozkwUCTrmWXY5HDoqVCk/fWqxmOvmPOZVNW4UYLK1oqr
	5YeAnVLOcHZFkcM21kwVKfVyoqmPHxYZ+tCTRPcvuHa7igWXdrdL5/y4Pge4Fv1i
	w8VWPOZXZFF8+DMyvNfCJ28daBStAIgP4dcbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bV7jZeoqQ8bc4EX2O5b16K/v6/clOWxu
	nzVI5cKxGxM69haqMRmGsjF805izt2OhixVh3NdC/SUK7PYDQLTUQfTm9vCC5Svs
	IAuZbUAN1und1yTyX/4fulYBihPqRgEVDUTA3EXscZ+YrP5D7XcgU1HOQpcmcRP/
	e4Ol/obIp4k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CCAA2728D;
	Mon, 15 Dec 2014 13:11:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C413A2728C;
	Mon, 15 Dec 2014 13:11:35 -0500 (EST)
In-Reply-To: <1418463676-1753-1-git-send-email-arjun024@gmail.com> (Arjun
	Sreedharan's message of "Sat, 13 Dec 2014 15:11:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CE82B7B6-8485-11E4-98E4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261411>

Arjun Sreedharan <arjun024@gmail.com> writes:

> use a temporary variable to free the memory in case
> realloc() fails.
>
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
> ---
>  compat/win32/syslog.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> index d015e43..3409e43 100644
> --- a/compat/win32/syslog.c
> +++ b/compat/win32/syslog.c
> @@ -16,7 +16,7 @@ void openlog(const char *ident, int logopt, int facility)
>  void syslog(int priority, const char *fmt, ...)
>  {
>  	WORD logtype;
> -	char *str, *pos;
> +	char *str, *str_temp, *pos;
>  	int str_len;
>  	va_list ap;
>  
> @@ -43,9 +43,11 @@ void syslog(int priority, const char *fmt, ...)
>  	va_end(ap);
>  
>  	while ((pos = strstr(str, "%1")) != NULL) {
> +		str_temp = str;
>  		str = realloc(str, ++str_len + 1);
>  		if (!str) {
>  			warning("realloc failed: '%s'", strerror(errno));
> +			free(str_temp);
>  			return;
>  		}

Hmm, the original, 088d8802 (mingw: implement syslog, 2010-11-04),
that introduced the special casing for %1, says:

    Syslog does not usually exist on Windows, so implement our own
    using Window's ReportEvent mechanism.

    Strings containing "%1" gets expanded into them selves by
    ReportEvent, resulting in an unreadable string. "%2" and above
    is not a problem.  Unfortunately, on Windows an IPv6 address can
    contain "%1", so expand "%1" to "% 1" before reporting. "%%1" is
    also a problem for ReportEvent, but that string cannot occur in
    an IPv6 address.

It is unclear why it says '"%2" and above is not a problem' to me.
Is that because they expand to something not "an unreadable string",
or is that because in the original developer's testing only "%1" was
observed?  It also says "%%1" is a problem, and it does not occur in
an IPv6 address, but that would suggest that every time a new caller
is added to syslog(), this imitation of syslog() can break, as there
is nothing that says the new caller must be reporting something
about an IP address.  Perhaps this loop should cleanse what it
passes to ReportEvent() a bit more aggressively by expanding all "%"
to "%-sp" or something)?

Regardless of that funny %1 business, I notice in

    http://msdn.microsoft.com/en-us/library/windows/desktop/aa363679%28v=vs.85%29.aspx

that each element of lpStrings array that is passed to ReportEvent()
is limited to 32k or so.  Wouldn't it make it a lot simpler if we
removed the dynamic allocation and use a fixed sized 32k buffer here
(and truncate the result as necessary)?  That would make the "leak"
disappear automatically.

Having said all that, if we were to still go with the current code
structure, "str_temp" should be scoped inside the loop, as there is
no need to make it available to the remainder of the function, I
think.  Also writing this way may make the intention more clear.

	while (...) {
		char *new_str = realloc(str, ...);
                if (!new_str) {
                	free(str);
                        return;
		}
		memmove(... to shuffle ...);

And after starting to write the above, I notice that the current
code around realloc may be completely bogus.  It goes like this:

	while ((pos = strstr(str, "..."))) {
        	str = realloc(str, ...);
                if (!str) { warn and bail; }
                memmove(pos + 1, pos + 1, ...);
		pos[1] = ' ';
	}

If realloc() really allocated a new string, then pos that points
into the original str has no relation to the reallocated str, so
memmove() is not shuffling the string to make room for the SP in the
string that will be given to ReportEvent() at all, no?  This seems
to be a bug introduced by 2a6b149c (mingw: avoid using strbuf in
syslog, 2011-10-06).

It makes me wonder if this codepath ever triggers in the first
place.
