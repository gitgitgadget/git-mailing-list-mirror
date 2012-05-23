From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Wed, 23 May 2012 08:20:21 +0700
Message-ID: <CACsJy8BwHd0JVJ0H-H8-ZHSFjwUb0=E1gJZR1fMSN--B6jdBow@mail.gmail.com>
References: <4FB9F92D.8000305@alum.mit.edu> <20120521174525.GA22643@sigill.intra.peff.net>
 <CACsJy8Dw+mbP+ttTP6gAfX9o4q4NyZgPYpbhS=tket=5fvBXwg@mail.gmail.com> <20120522170101.GA11600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 23 03:21:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SX0G5-0003Wn-8k
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 03:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966Ab2EWBUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 21:20:55 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43394 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832Ab2EWBUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 21:20:54 -0400
Received: by wgbdr13 with SMTP id dr13so6606610wgb.1
        for <git@vger.kernel.org>; Tue, 22 May 2012 18:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PGFGm4BfQJJi7UKpoxJeeiXFpSsu0pV4iryOY0wTMZs=;
        b=GBOk8kCfA2649nCsiPQF7cNJlgMYpsQsDEvh/wzozYv6bGtZMjSWi9wJDFZ5Pr6DeL
         pz5tRvMa9A5SQLFdMkVdSZg8hhLyvNp1uaDZPJbq7yCZ+wnetBQw2I5iujQYedKoXLwa
         uQmBk7WFOubrauquHfJKLsPh6KEcxyi2z/qQWRIDt3JJQU8qwEMtM2Et2SZGbnrG39DT
         DEn8Cb/wofbg7t+GEOJTirD+2ZxWbarw/i7BT/YNIMVSf9rPeK7/0Pemok2p3SFaHZPg
         pDKHYf0xHC2ZtHzHP617GVMWOnzUfxziZ1yzJGhJwAXG97EIdLfYYL/SgvmcBjU33lEE
         8bbQ==
Received: by 10.180.92.5 with SMTP id ci5mr18898272wib.19.1337736053585; Tue,
 22 May 2012 18:20:53 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Tue, 22 May 2012 18:20:21 -0700 (PDT)
In-Reply-To: <20120522170101.GA11600@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198270>

On Wed, May 23, 2012 at 12:01 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 22, 2012 at 07:18:00PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Tue, May 22, 2012 at 12:45 AM, Jeff King <peff@peff.net> wrote:
>> > The rails/rails network repository at GitHub (i.e., a master repo with
>> > all of the objects and refs for all of the forks) has about 400K refs,
>> > and has been the usual impetus for me finding and fixing these sorts of
>> > quadratic problems.
>>
>> Off topic and pure speculation. With 400k refs, each one 20 byte in
>> length, the pathname part only can take 7MB. Perhaps packed-refs
>> should learn prefix compressing too, like index v4, to reduce size
>> (and hopefully improve startup speed). Compressing refs/heads/ and
>> refs/tags/ only could gain quite a bit already.
>
> In this case, the packed-refs file is 30MB. Even just gzipping it takes
> it down to 2MB. As far as I know, we don't ever do random access on the
> file, but instead just stream it into memory.

I did not think really hard when I wrote what I wrote. File size is
not really a problem here. In index case, we do expensive sha-1 on the
entire file so size matters. We don't do anything that expensive in
packed-refs (, I think. Should we protect it with some sort of
checksum btw?). gzip can add more computation cost at startup. 30MB is
probably still ok.

Though sending 2MB on the wire is way better than 30MB when we
advertise refs at cloning/fetching.
-- 
Duy
