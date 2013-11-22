From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Fri, 22 Nov 2013 15:23:31 +0100
Message-ID: <CAP8UFD1z4NsmgzrnPmqHo7CkNRkgg24qT2SGnFjhjrzckdKoTQ@mail.gmail.com>
References: <20131120203350.GA31139@kitenet.net>
	<20131120213348.GA29004@sigill.intra.peff.net>
	<20131120222805.GC26468@kitenet.net>
	<20131121114157.GA7171@sigill.intra.peff.net>
	<20131121160426.GA21843@kitenet.net>
	<CAP8UFD2S1HUDYLbmEGFqLcBFExuB0h7=gqwsQ0qjpMSc+YaXog@mail.gmail.com>
	<20131122095801.GB12042@sigill.intra.peff.net>
	<CAP8UFD1fMTrJGo9Z4+jdWqc-=UmPG1jQjwTij4962WDoh_a1DA@mail.gmail.com>
	<20131122112429.GA16172@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joey Hess <joey@kitenet.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 15:23:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjrdx-0001RM-EB
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 15:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721Ab3KVOXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 09:23:33 -0500
Received: from mail-vb0-f51.google.com ([209.85.212.51]:36321 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712Ab3KVOXc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 09:23:32 -0500
Received: by mail-vb0-f51.google.com with SMTP id m10so912530vbh.10
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nTk5Ldl5DbTAZD1sZa2DrFJ59WgVNaMMza2vxduqTm4=;
        b=eOPyBZ/1G56GLYvwVrIpv9AYd2LSLLr7KVLALuVpEdzxsWr0l58fevArYEnlWb0XFZ
         LdRE7tsiK4tb7wpOC3qS7VVjnrfzoll4XVffebnTnnWtq7zubw92I87EjrxkyCV9WioT
         dieQ+oartjCjP+wQpT2+NQr+HkCwdTEvVRaY+I0FReYikjy9D071ALdEFUJKQ8+xDMOy
         Evgl7ovozoekfKjsu+ojem3rtUy0PBAZqNgOYxWlWnPfvOiSvjdljeGcmVb3AXYirQQ7
         V/0Mbd1zDqcw50ZHOaA/QPf8+cvIZQWyQvE2vnm3TNhFtSKmVIiI83s87aca/vbt0NkB
         nOVA==
X-Received: by 10.52.230.202 with SMTP id ta10mr682510vdc.41.1385130211732;
 Fri, 22 Nov 2013 06:23:31 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Fri, 22 Nov 2013 06:23:31 -0800 (PST)
In-Reply-To: <20131122112429.GA16172@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238188>

On Fri, Nov 22, 2013 at 12:24 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 22, 2013 at 12:04:01PM +0100, Christian Couder wrote:
>
>> In "sha1_file.c", there is:
>>
>> void *read_sha1_file_extended(const unsigned char *sha1,
>>                               enum object_type *type,
>>                               unsigned long *size,
>>                               unsigned flag)
>> {
>>         void *data;
>>         char *path;
>>         const struct packed_git *p;
>>         const unsigned char *repl = (flag & READ_SHA1_FILE_REPLACE)
>>                 ? lookup_replace_object(sha1) : sha1;
>>
>>         errno = 0;
>>         data = read_object(repl, type, size);
>> ...
>>
>> And in cache.h, there is:
>>
>> #define READ_SHA1_FILE_REPLACE 1
>> static inline void *read_sha1_file(const unsigned char *sha1, enum
>> object_type *type, unsigned long *size)
>> {
>>         return read_sha1_file_extended(sha1, type, size,
>> READ_SHA1_FILE_REPLACE);
>> }
>>
>> So the READ_SHA1_FILE_REPLACE is a way to disable replacement at compile time.
>
> Is it? I did not have the impression anyone would ever redefine
> READ_SHA1_FILE_REPLACE at compile time, but that it was a flag that
> individual callsites would pass to read_sha1_file_extended to tell them
> whether they were interested in replacements. And the obvious reasons to
> not be are:
>
>   1. You are doing some operation which needs real objects, like fsck or
>      generating a packfile.
>
>   2. You have already resolved any replacements, and want to make sure
>      you are getting the same object used elsewhere (e.g., because you
>      already printed its size :) ).
>
> The only site which calls read_sha1_file_extended directly and does not
> pass the REPLACE flag is in streaming.c. And that looks to be a case of
> (2), since we resolve the replacement at the start in open_istream().

Yeah, you are right. Sorry for overlooking this.

But anyway it looks redundant to me to have both this REPLACE flag and
the read_replace_refs global variable, so I think a proper solution
would involve some significant refactoring.

And if we decide to keep a REPLACE flag we might need to add one to
sha1_object_info_extended() too.

Thanks,
Christian.
