From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] ident.c: add support for IPv6
Date: Fri, 30 Oct 2015 14:19:06 -0400
Message-ID: <CAPig+cQkWc+R2vEn9DBdKVcsNNEWELCNNOMksBDxF7A5dTPHkQ@mail.gmail.com>
References: <1446216487-11503-1-git-send-email-gitter.spiros@gmail.com>
	<5633A838.3070801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:19:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEGh-0006KU-RP
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760299AbbJ3STI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2015 14:19:08 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36321 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760275AbbJ3STH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2015 14:19:07 -0400
Received: by vkex70 with SMTP id x70so52336212vke.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=9RXyZVr1qPjEDaWBV5rt96VY9DsU0O8iEDF/C3luzJs=;
        b=aWiJRSzJqhaMcdxh88fTxgrMGzJo+1dtUnhBQFbh1fz12pI5BUtSNjTMPQM5gBXES4
         dvPzRFmG+XwiTjOgWvndcWyYLPubz0Gg7fnHwSPW0XftsQpzed5JMwLVDGJUdijgMmvp
         pfABHXqOpwDjs++kJwfgGIVf6sU9uSzZKUkX3at0uxNPRbnyYEQEfpeq4VXfXy0NTCiB
         8Va9W+wCEBSrsMsg1IbNyMnVj+OftPkEPlg4kx0CwJBUDppV7UYVbKzp160bozdnNUSe
         AKnycj/AOaGyQH72TuHeDqBHHohPao8ENHPtUB8uFN/LdxCfZ28nRZAAx1CapKC032Pg
         mHew==
X-Received: by 10.31.52.73 with SMTP id b70mr6306758vka.45.1446229146243; Fri,
 30 Oct 2015 11:19:06 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Fri, 30 Oct 2015 11:19:06 -0700 (PDT)
In-Reply-To: <5633A838.3070801@web.de>
X-Google-Sender-Auth: icjvCFqLvYY7nfAbypHf26DzzCs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280507>

On Fri, Oct 30, 2015 at 1:26 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2015-10-30 15.48, Elia Pinto wrote:
>> Add IPv6 support by implementing name resolution with the
>> ---
>> +#ifndef NO_IPV6
>> +
>> +static void add_domainname(struct strbuf *out)
>> +{
>> +     char buf[1024];
>> +     struct addrinfo hints, *ai;
>> +     int gai;
> The scope of these variables can be narrowed, by moving them into the=
 "{" block,
> where they are needed. (Before the memset())
>> +
>> +     if (gethostname(buf, sizeof(buf))) {
>> +             warning("cannot get host name: %s", strerror(errno));
>> +             strbuf_addstr(out, "(none)");
>> +             return;
>> +     }
>> +     if (strchr(buf, '.'))
>> +             strbuf_addstr(out, buf);
>> +     else    {
> Many ' ' between else and '{', one should be enough
>> +             memset (&hints, '\0', sizeof (hints));
>> +             hints.ai_flags =3D AI_CANONNAME;
>> +             if (!(gai =3D getaddrinfo(buf, NULL, &hints, &ai)) && =
ai && strchr(ai->ai_canonname, '.')) {

Why is 'gai' needed and assigned? It's value is never consulted thereaf=
ter.

>> +                     strbuf_addstr(out, ai->ai_canonname);
>> +                     freeaddrinfo(ai);

Also, aren't you leaking 'ai' when 'ai_canonname' doesn't contain a '.'=
?

>> +             }
>> +             else
> Colud be written in one line as "} else"
>> +                     strbuf_addf(out, "%s.(none)", buf);
>> +     }
>> +}
>> +#else /* NO_IPV6 */
