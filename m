From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 10/13] pretty: add %C(auto) for auto-coloring
Date: Wed, 17 Apr 2013 19:55:25 +1000
Message-ID: <CACsJy8DLj90aynu376O0LZKpQqvcmyoA_8gMNoek3WK6HTRtLQ@mail.gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com> <1366100702-31745-11-git-send-email-pclouds@gmail.com>
 <7vd2tujh3o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 11:56:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USP5t-0004rd-12
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 11:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601Ab3DQJz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 05:55:56 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:38645 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab3DQJzz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 05:55:55 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so1411416oag.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 02:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JQD3UUUM/+d8SYxlEVW3XsN0HXM8cIqOHpHhd/5tc2I=;
        b=RJqPoiPgDM2hxskcf8GNvyBH+VHMHStK5IQmDevcM5x9Jrdd/HepkaWvwQvu4KshSk
         ka0aP9m+xzdLn8WL1KeQyKfs2zXDKsF+mlaLDeHU0qDfU993FigCtos690IOWHFk2/0N
         eqIR6H1Wvckl4PpYr5+WIDUQa2uI4LagAcG3NrQ138WQETaASPqyVqQaAMcI0QpqZ0QF
         LgjmVeCS2jh/3vnXwvS9f3NfHJMxEjxlvGzd4XsOTlm84eYP/ttEYUybhPuNs8+9M9k3
         9h0sJ8kj/we+hqH1rCjFoGqGjRYa+czRfzNcA0bDyl1Ted6NeL0MOtprOjxO9VD38PVU
         HbNg==
X-Received: by 10.60.117.35 with SMTP id kb3mr2337782oeb.16.1366192555415;
 Wed, 17 Apr 2013 02:55:55 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Wed, 17 Apr 2013 02:55:25 -0700 (PDT)
In-Reply-To: <7vd2tujh3o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221528>

On Wed, Apr 17, 2013 at 7:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -1005,7 +1006,15 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>>       /* these are independent of the commit */
>>       switch (placeholder[0]) {
>>       case 'C':
>> -             return parse_color(sb, placeholder, c);
>> +             if (!prefixcmp(placeholder + 1, "(auto)")) {
>> +                     c->auto_color_next = 1;
>> +                     return 7;
>> +             } else {
>> +                     int ret = parse_color(sb, placeholder, c);
>> +                     if (ret)
>> +                             c->auto_color_next = 0;
>> +                     return ret;
>> +             }
>
> This is to handle a corrupt input, e.g. "%C(auto)%Cbleu%H" where
> (perhaps deprecated) "%Cblue" is misspelled, and parse_color()
> returns 0 without consuming any byte.
>
> Does it make sense not to turn auto off in such a case?

We don't have any mechanism to report invalid %C. Instead we let them
through as literals. If they are literals, they should not have any
side effects. So I think it makes sense not to turn off things.

> Otherwise the above would become
>
>         if (!prefixcmp(placeholder + 1, "(auto)")) {
>                 c->auto_color_next = 1;
>                 return 7; /* consumed 7 bytes, "C(auto)" */
>         }
>         c->auto_color_next = 0;
>         return parse_color(sb, placeholder, c);
>
> which may be simpler.  When we see %C, previous %C(auto) is
> cancelled.

If we do this, maybe we could show invalid %C with blinking. Quite
catchy and might make the user wonder why. Of course it won't work
without coloring. But who would add %C in that case.
--
Duy
