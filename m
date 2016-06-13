From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] fix parse-opt string_list leaks
Date: Mon, 13 Jun 2016 16:36:14 +0700
Message-ID: <CACsJy8CAT54pTotUFKm-piWRppNFz9mjTsnz+5p1+7ykVg60HQ@mail.gmail.com>
References: <20160610115726.4805-1-pclouds@gmail.com> <20160612220316.GB5428@sigill.intra.peff.net>
 <CACsJy8C+NtiXRo8NcU3rtgWrMSj8Zv3mYtdYfyvzwYRHifKVCQ@mail.gmail.com> <20160613053203.GB3950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 13 11:36:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCOIb-0002od-OO
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 11:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbcFMJgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 05:36:46 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35470 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964895AbcFMJgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 05:36:45 -0400
Received: by mail-it0-f52.google.com with SMTP id z189so44436343itg.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eZNb59CVPSCaBbEgj2Ef9UvdI9EHIzBMHG0qmFuvkZM=;
        b=JOFB7NFKMK/sZDZuXldEbij/b8lElprbcSN4lhX490kjXwZ1m3nwpLu4g9mClyV2zn
         ZBiYZ9VQprk9M9fyUVUfkbod6Naz9t1Butt2nEuM2OlEe6IEUrD5+QpNDKIMs/wMgWDC
         Mw1h0aMkI+khEkI04Ox8vaz22/rsPuqLtLgxgMa+rmE8AEyY636duAVm5Pwf2AuAEKe3
         zb3+QxEWsaVNO4uaH4tkVCaO9wPgg3Bg0lD9f32dNqYPmMvSuX6YKEtaPHfih1cD215j
         9eFjDJ6bn98ftoqXZuf6p7WaobguC8XQp9PDSEwXIzwUUoJvEA1DQmIvP8IG80MW+gyd
         msCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eZNb59CVPSCaBbEgj2Ef9UvdI9EHIzBMHG0qmFuvkZM=;
        b=dfX+eO4iuVAINYO6dB6ZtkipsHm647biq5X6H0aJEeGBT4utfwRGVgCK80uF//uYe+
         ZYAmhVn3qhofNo6h4enwIb+c2qZ9oKWGdIjzG0Z7Ec/OoWKr6oCQqKc7kEgCwKyDoOnu
         x1LzW/ZFaPTskIp10jqu6qGQdxOs4CWK46q+B1YGx5yLjGAEVlHODFZ2pFC3YSznwyW6
         rPJdUh8ejJ4ohC746r8KnrPFcMmnV/ff0oNwZOF+6FDDwVE0v1dgIl8vhZqT8iZCtu+8
         pAMMyfsgxTqRr3xD0X1viWmxsAPWCvcm07T87j30EcmL3Uf0u03sv84iBf+R6RbkkWeS
         3i3g==
X-Gm-Message-State: ALyK8tLMtgZjlr6YsCb+zfiFbw/2ZuvJeIT70cesrV0VwJ1cTM4K+Wzeljt/wyhyGO9eqVYC2jfHceoWhnKzeQ==
X-Received: by 10.36.43.200 with SMTP id h191mr16587870ita.57.1465810603551;
 Mon, 13 Jun 2016 02:36:43 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Mon, 13 Jun 2016 02:36:14 -0700 (PDT)
In-Reply-To: <20160613053203.GB3950@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297173>

On Mon, Jun 13, 2016 at 12:32 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 13, 2016 at 07:08:55AM +0700, Duy Nguyen wrote:
>
>> > So if we are doing the conservative thing, then I think the resulting
>> > code should either look like:
>> >
>> >   if (!v->strdup_strings)
>> >         die("BUG: OPT_STRING_LIST should always use strdup_strings");
>> >   string_list_append(v, arg);
>>
>> I agree with the analysis. But this die() would hit all callers
>> (except interpret-trailers) because they all initialize with _NODUP
>> and setting strdup_strings may require auditing all access to the
>> string list in question, e.g. to change string_list_append(v,
>> xstrdup(xxx)) to string_list_append(xxx). it may cause side effects if
>> we are not careful.
>
> Yep. It is not really fixing anything, so much as alerting us to broken
> callers. We'd still have to fix the callers. :)
>
>> So far all callers are in builtin/, I think it will not take much time
>> to verify that they all call parse_options() with global argv, then we
>> can just lose extra xstrdup() and stick to string_list_append().
>> OPTION_STRING already assumes that argument strings are stable because
>> they are passed back as-is. Can we go with an easier route, adding a
>> comment on top of parse_options() stating that argv[] pointers may be
>> passed back as-is and it's up to the caller to xstrdup() appropriately
>> before argv[] memory is freed?
>
> Yeah, the two options I laid out were the "conservative" side, where we
> didn't make any assumptions about what is in passed into parse_options.
> But I agree in practice that it's not likely to be a problem to just
> point to the existing strings, and the fact that OPTION_STRING does so
> already makes me even more confident.
>
> So I'd suggest these patches:
>
>   [1/3]: parse_opt_string_list: stop allocating new strings
>   [2/3]: interpret-trailers: don't duplicate option strings
>   [3/3]: blame,shortlog: don't make local option variables static

As usual, it's hard to find things to complain in your patches.

> The first one is what we've been discussing, and the others are just
> follow-on cleanups.  I stopped short of a fourth patch to convert more
> cases of:
>
>   static struct string_list foo;
>
> to:
>
>   static struct string_list foo = STRING_LIST_INIT_NODUP;
>
> The two are equivalent (mostly due to historical reasons). I tend to
> think explicit is better than implicit for something like this (not
> because BSS auto-initialization isn't OK, but because there is an
> explicit choice of dup/nodup that the writer made, and it is good to
> communicate that). But maybe people don't want the extra noise.

I'm on the explicit side. Unless you work a lot with string lists, I
don't think you can remember whether "all zero" initialization is dup
or no dup.
-- 
Duy
