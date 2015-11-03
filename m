From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy authentication
Date: Tue, 3 Nov 2015 13:12:31 -0500
Message-ID: <CAPig+cQ2u49oLCy6e+1G+xx0K5WjY_U5qmUqnjWZe8XjQH6xPA@mail.gmail.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446483264-15123-1-git-send-email-k.franke@science-computing.de>
	<1446483264-15123-3-git-send-email-k.franke@science-computing.de>
	<xmqqbnbcdnb8.fsf@gitster.mtv.corp.google.com>
	<20151103093103.GB6354@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Tue Nov 03 19:14:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztg5q-0005na-6I
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 19:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbbKCSMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 13:12:35 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35392 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751AbbKCSMc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 13:12:32 -0500
Received: by ykek133 with SMTP id k133so29955185yke.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 10:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ajAb9gT5R8LR2G5q5gNtvFPfh5HEyv5/e9VGVeoo/GY=;
        b=clGxAKJt8ZB+nqP/CH10KJ3MJcPqXZQZl0yprSCGOEXBPW7cRLftb8GKJEzZ+ke1G8
         B4oS2tHBWznZvZYiXpK8YS9mMhZ2oUtZwppLrTvPXRAzQSh33Cms/GG4Ywo96JVveNvM
         4T6Ri/2mtTVr3WRk+GpEzyx1ITpWqPDd+kZslYkJY/DlBBjx2Wd6m+52PeslGe9jFz7S
         S+YuKkVxp8ISRauvtMTL5VEpjt7o4T/tARCXZVoeh4VOPrqyim3I1DxZbvAh+ZOhMDpg
         vKvqjeMkF8dmPgM+W5dyEPWbrITMoM2WoPtBJciSklN6P63ozKFG3NNnyBeCCDOrhJmo
         vz6g==
X-Received: by 10.31.56.75 with SMTP id f72mr20006568vka.115.1446574351302;
 Tue, 03 Nov 2015 10:12:31 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Tue, 3 Nov 2015 10:12:31 -0800 (PST)
In-Reply-To: <20151103093103.GB6354@science-computing.de>
X-Google-Sender-Auth: OSBAh3Yfry_7g9rmJg-4q9qyhDg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280805>

On Tue, Nov 3, 2015 at 4:31 AM, Knut Franke
<k.franke@science-computing.de> wrote:
> On 2015-11-02 14:54, Junio C Hamano wrote:
>> >  static void init_curl_proxy_auth(CURL *result)
>> >  {
>> > +   if (proxy_auth.username) {
>> > +           if (!proxy_auth.password)
>> > +                   credential_fill(&proxy_auth);
>> > +#if LIBCURL_VERSION_NUM >= 0x071301
>> > +           curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
>> > +                   proxy_auth.username);
>> > +           curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
>> > +                   proxy_auth.password);
>> > +#else
>> > +           struct strbuf s = STRBUF_INIT;
>> > +           strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
>> > +           strbuf_addch(&s, ':');
>> > +           strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
>> > +           curl_proxyuserpwd = strbuf_detach(&s, NULL);
>> > +           curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
>> > +#endif
>>
>> I think #else clause of this thing would introduce decl-after-stmt
>> compilation error.
>
> I've actually tested this with CURL 7.15.5 (0x070f05), and didn't get any
> compilation error.

Junio meant that, on this project, code still follows the rule that
all declarations in a block must come before statements in order to
appease older compilers. That is (good):

    {
        int foo; /* declaration */

        if (doodad) /* statement */
            snorg();
        glop(&foo);
    }

rather than (bad):

    {
        if (doodad) /* statement */
            snorg();

        int foo; /* declaration after statement */
        glop(&foo);
    }

The gcc option -Wdeclaration-after-statement can help.
