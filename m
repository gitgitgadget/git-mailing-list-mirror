From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 4/4] pack-revindex: radix-sort the revindex
Date: Mon, 8 Jul 2013 14:35:10 -0700
Message-ID: <CA+sFfMfHYkLc1rAnMKWGiGtH9kOC11D9CqpAsFXpeE_VBY0otA@mail.gmail.com>
References: <20130707100133.GA18717@sigill.intra.peff.net>
	<20130707101438.GD19143@sigill.intra.peff.net>
	<CA+sFfMfQcnx+OGNd+v7NJC5zSXg2OR1QiLyRSqDjXD0zb4mvtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 08 23:35:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwJ5Z-00010e-6z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 23:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab3GHVfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 17:35:12 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64262 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab3GHVfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 17:35:11 -0400
Received: by mail-wi0-f178.google.com with SMTP id k10so4417190wiv.11
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3fwNl+OVLEOFiHCsM9loBwe/nRreDF42s0wVN0A6Ikc=;
        b=rbf8avw0DcFmcvFd3EX5u7JE5FQfbZsNPULiQ1ZodRIwcDTMlMVXTmT1lssBK/SwpF
         oFBzclx/oC/oaENIl9+KvgVUsnS5PwPpALacUl461LhOfBq0rVh0buW3uvWdoGFPziSa
         6V6/3k9V8XhyPChkQZ9h6H1iy7JFkwYfL2XzwyhJqxx3yo6Z+dHA15llaLMFcUhan6qo
         LQQxSJdbGcTjdUr45YkUrgllCRjRBcYC3gtqH4GL8z+AsvPNttYfsFIOFOggoZnqBn5m
         IkeBly80uUTvJ74rpZ8a5iyiPOe4AMRcgC46FtgGczy+bwWqQ6GGzJ/f711AsPvHl0gg
         S+uQ==
X-Received: by 10.194.78.110 with SMTP id a14mr13372342wjx.84.1373319310162;
 Mon, 08 Jul 2013 14:35:10 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Mon, 8 Jul 2013 14:35:10 -0700 (PDT)
In-Reply-To: <CA+sFfMfQcnx+OGNd+v7NJC5zSXg2OR1QiLyRSqDjXD0zb4mvtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229894>

On Mon, Jul 8, 2013 at 1:50 PM, Brandon Casey <drafnel@gmail.com> wrote:
> On Sun, Jul 7, 2013 at 3:14 AM, Jeff King <peff@peff.net> wrote:

>> diff --git a/pack-revindex.c b/pack-revindex.c
>> index 77a0465..d2adf36 100644
>> --- a/pack-revindex.c
>> +++ b/pack-revindex.c
>> @@ -59,11 +59,78 @@ static int cmp_offset(const void *a_, const void *b_)
>>         /* revindex elements are lazily initialized */
>>  }
>>
>> -static int cmp_offset(const void *a_, const void *b_)
>> +/*
>> + * This is a least-significant-digit radix sort using a 16-bit "digit".
>> + */
>> +static void sort_revindex(struct revindex_entry *entries, int n, off_t max)
>
> If 'n' is the number of objects in the pack, shouldn't it be unsigned?
>
> The data type for struct packed_git.num_objects is uint32_t.  Looks
> like create_pack_revindex uses the wrong datatype when it captures
> num_objects in the int num_ent and passes it to sort_revindex.  So, it
> looks like that function needs to be updated too.

Hmm.  It seems more than just create_pack_revindex holds num_objects
in a signed int.  Don't we support 4G objects in packs?

find_pack_revindex uses a signed int for the index variables in its
binary search which means it will fail when num_objects >= 2^31.

-Brandon
