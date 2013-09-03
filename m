From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 23/23] initial pack index v3 support on the read side
Date: Tue, 3 Sep 2013 14:34:37 +0700
Message-ID: <CACsJy8D38ZtWdv0wxP9guMw_kTQ-Sm+K83B=nOX0Zb66esKPeQ@mail.gmail.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-24-git-send-email-nico@fluxnic.net> <CACsJy8CzvQSYRkH+FNuNhzicX9CLC7bRxKgq2RDmOuxh1Q-=5Q@mail.gmail.com>
 <alpine.LFD.2.03.1309030201230.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:35:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGl94-0001HX-0z
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295Ab3ICHfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:35:14 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64257 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab3ICHfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:35:08 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so5428855obb.33
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1ohAtJqUN/fqkFE1beyE1o82aLQB0kOaa/mKeOasfVI=;
        b=Q61Da5Eb9s6DRduD6/SkyE84gfqtcPOUgqDp08qBsc7QM8fny+ksdny1SPnlyAQsST
         c2S1lO6FBcuz2JyLokJNZCesK1/rxeKAFOaXVubIC2/+6mDNCw22AIvgy0OqIJJID0oa
         yexpIqJMcmqBCnMm4uLD8jE+M8r4jvV3bPJoBEsA+8vw/FrdvrYvvx1umDTj62IouR1S
         6/hlH3NRewl1rEBpmCEwksB/tl4XEwARYoKr0bXatjAr5ic5oBGquzjw75rTBEmIicXm
         Igqu5PKbztzrqBxHx7he8LMLyN2jFL0VZKVt/u+m97mujE3QEUgajHkCHktQBfZLxNnl
         PQDA==
X-Received: by 10.60.60.105 with SMTP id g9mr19775670oer.8.1378193707803; Tue,
 03 Sep 2013 00:35:07 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 3 Sep 2013 00:34:37 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309030201230.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233700>

On Tue, Sep 3, 2013 at 1:09 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 31 Aug 2013, Duy Nguyen wrote:
>
>> On Tue, Aug 27, 2013 at 11:26 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > A bit crud but good enough for now.
>>
>> I wonder if we should keep a short SHA-1 table in .idx. An entry in
>> the original .idx v1 table is <SHA-1>+<offset> then offset moved out
>> to make the table more compact for binary search. I observe that we
>> don't always need 20 byte SHA-1 to uniquely identify an entry in a
>> pack, so the SHA-1 table could be split in two: one table contain the
>> first part of SHA-1, long enough to identify any entry in the pack;
>> the second table contains either full SHA-1 or the remaining part.
>> Binary search is done on the first table, if matched, full sha-1 from
>> the second table is compared. We already have the second sha-1 table
>> in .pack v4. We could add the first table in .idx v3.
>>
>> On linux-2.6 even in one-pack configuration, we only need the first 6
>> bytes of sha-1 to identify an object. That would cut the bsearch sha-1
>> table to 1/4 full sha-1 table size.
>
> I don't see the point though.
>
> Why having two tables when only one suffice?
>
> If the argument is about making the SHA1 binary search more efficient
> given a smaller memory footprint, that comes with extra complexity
> coming from the variable length SHA1 strings in the second table.  So
> I'm not sure there is much to gain.
>
> Furthermore, one of the design of pack v4 is to avoid the SHA1 binary
> search entirely.  You will need the binary search only once to locate
> the top commit object, but from there the entire object tree can be
> walked simply by using the sha1ref index and looking up the
> corresponding offset into the pack index file to locate the next object.
>
> Same thing for walking tree objects: the pack v4 tree deltas are meant
> to be walked inline without having to _apply_ any delta.

Hmm.. you are right. We avoid a lot of SHA-1 lookups with .pack v4. A
more compact SHA-1 table only benefits random SHA-1 lookups, which
should be much fewer compared to "rev-list --objects --all".
-- 
Duy
