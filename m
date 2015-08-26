From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/5] submodule: helper to run foreach in parallel
Date: Wed, 26 Aug 2015 10:21:08 -0700
Message-ID: <CAGZ79kaWh5F_d9TGHFe-fAd5arFicaAVcmYnWnAS2Wn1PoGMzg@mail.gmail.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-4-git-send-email-sbeller@google.com>
	<20150826170647.GA1870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 26 19:21:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUeNv-0004s0-VO
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 19:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbbHZRVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 13:21:11 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33326 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbbHZRVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 13:21:09 -0400
Received: by qgeh99 with SMTP id h99so71049070qge.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wluMdqmlC9v1A91tp8Rus8MVktFNAykBGsHe4EJPeHY=;
        b=B2r5DWtmnsQ8dx814XbrZ2XGX+3PFlcIUNOoc7qPQCV4rPYtuYP0/igLun4XeV0NwT
         ydIi0w7WY/zpBlu7mzRgDG+l0TDb6iNXLYR/LlYrBnHiQjGFth/Z7tvO9n/LEkKj+5yE
         lUv3PE8RUTDG+Yo01tlFygTZojxhssvSuO0fBke6q6jGpz0zDP1kqbvshq1RCSVY9DiX
         i83TIMRjGGdXDv9t3KzZbz1glk0//27dArMYk8oOErqfjOX0VP1ApgjL7S0LPZmFTPVb
         OXcmH06vbntVsZkUY9Bf/zCaRpcGY4sWa48Sw3VWFpxM38ULcnej/F+YPlrdStYD9aoU
         f1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wluMdqmlC9v1A91tp8Rus8MVktFNAykBGsHe4EJPeHY=;
        b=OvYftvjbN+/0wa1RYdgS1IlFMyRoaLga7zyTK71QEzo6jVgoP1v5C8BFCHEbuDNbWV
         b/+l2Qim8/OjhcyqQa0bCkBnlNRyf80YNM8QlISeumYJJ1m5+mgTwq4N92986/PhO4ON
         +A6Qgt8jbhcHo8KkCATnMHQuPf57lVNSJxf37mj8cDx7Qh24xWuAhkflFNuT7HdReDR2
         gkkBSZzINDw5gYmGUloHhOY2rSOtGGsv1f72TS+GIObJF0Icg8glTNK2+WLGi7sZzSjI
         Pq7T8p5qGMBhMYbRufHIuD2uyidR6beQUjQE5TG85Z62mybyCCwMs247NtrnwjWMDMHI
         IrIw==
X-Gm-Message-State: ALoCoQmgXTVNj40crYIufoEraORG8a+0DArFFI4u8K4Cr3ck3idsGyMrdCQfSN7zxy341uHOB32k
X-Received: by 10.140.147.69 with SMTP id 66mr84663540qht.57.1440609668782;
 Wed, 26 Aug 2015 10:21:08 -0700 (PDT)
Received: by 10.140.90.100 with HTTP; Wed, 26 Aug 2015 10:21:08 -0700 (PDT)
In-Reply-To: <20150826170647.GA1870@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276620>

On Wed, Aug 26, 2015 at 10:06 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 25, 2015 at 10:28:24AM -0700, Stefan Beller wrote:
>
>> +int module_foreach_parallel(int argc, const char **argv, const char *prefix)
>> +{
>> [...]
>> +     for (i = 0; i < ce_used; i++) {
>> +             const struct submodule *sub;
>> +             const struct cache_entry *ce = ce_entries[i];
>> +             struct submodule_args *args = malloc(sizeof(*args));
>> +
>> +             if (ce_stage(ce))
>> +                     args->sha1 = xstrdup(sha1_to_hex(null_sha1));
>> +             else
>> +                     args->sha1 = xstrdup(sha1_to_hex(ce->sha1));
>> +
>> +             strbuf_reset(&sb);
>> +             strbuf_addf(&sb, "%s/.git", ce->name);
>> +             if (!file_exists(sb.buf))
>> +                     continue;
>
> "args" and "args->sha1" go out of scope and leak here.
>
>> +             args->name = sub->name;
>> +             args->toplevel = xstrdup(xgetcwd());
>
> Another xgetcwd leak. :) I think this one can just drop the xstrdup.
>
> (Both of these were spotted by Coverity. I know you have played with it
> a little, so if you are actually reading the emails it sends, I'll stop
> relaying them).

Fixing those memleaks was the first thing I did this morning. :)

And yeah I do pay attention to these emails. (I maintain the automatic testing
every other day, so there is that.)

>
> -Peff
