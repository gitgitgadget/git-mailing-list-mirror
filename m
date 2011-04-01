From: Sebastian Thiel <byronimo@googlemail.com>
Subject: Re: Indexing Zlib deflated streams for pseudo-random-access to reduce
 delta-resolution memory requirements
Date: Fri, 01 Apr 2011 15:59:51 +0200
Message-ID: <4D95DA57.9010304@gmail.com>
References: <4D94E385.7090903@googlemail.com> <4D959B56.7040508@peralex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Noel Grandin <noel@peralex.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 16:00:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5etR-0000K6-5j
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 16:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949Ab1DAN76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 09:59:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43438 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab1DAN75 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 09:59:57 -0400
Received: by fxm17 with SMTP id 17so2615805fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=OLmBOXrycLBG722oUWq6xaFNCCH74c+KM4bZc13MPf8=;
        b=la23CVAP9h0IfEmHj5uXBi87hP4q/8bh9lH6caAebRe9/mR/BbtDbjRhJCetvIoWM6
         Zb9LiJOHIHi8iP/pEUqRxDIXIYgxf0LF7YIC9YV6CQ1d1A+/gs5TcZUMUu5cZFEibU3z
         0CY1CrUpBEjPxar2nwlNmAgp6COd1Nidxmiz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=waAlD9jKLEmxAATFQRBPIn5T3zv+Bkb2EUCLFCtVVASUhLtq2Nf/A4JLIhNZ9MCaAc
         +Tlo4xvsRkwlfxbGtjiD25Y2v1+5Bw4r745JAOklXDNQE8wpHDU+Hy//FOQJz6BsxPg0
         65/wshyQbkKffb2Tnd0iwgqnYcb+ICx7MlK8E=
Received: by 10.223.100.86 with SMTP id x22mr4202750fan.108.1301666396087;
        Fri, 01 Apr 2011 06:59:56 -0700 (PDT)
Received: from steelbook.local (91-65-187-112-dynip.superkabel.de [91.65.187.112])
        by mx.google.com with ESMTPS id j12sm796808fax.9.2011.04.01.06.59.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 06:59:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D959B56.7040508@peralex.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170585>

Hi Noel,

Thanks for your input ! Except for (a), I understand what you mean. In
case of (a), this would also mean that the delta stream gets resized and
becomes larger, which could be a bottleneck depending on how many
resizes you need. Yet, I didn't understand what (a) would mean.

Everything else makes sense, and should work well and fast assuming that
hard disk is large enough to possibly hold the temporary destination
file. If the system runs out of memory, it will just swap the memory out
onto the temporary file.

I definitely consider this an alternative to indexing the zip stream,
which might even be impossible or not viable performance wise.

Thanks,
Sebastian

On 01.04.11 11:31, Noel Grandin wrote:
> Nice work!
>
> Suggestion:
> (a) walk the merged delta stream, creating additional delta entries to
> fill in the bits that did not change i.e. create entries that look like
> copy from position 500, len 20 to position 500
> (b) sort the merged delta stream by base buffer file position
> (c) create the destination file (with zero contents)
> (d) mmap the destination file
> (e) stream the base buffer, applying the deltas to the mmap'ed file.
>
> -- Noel Grandin.
>
> Sebastian Thiel wrote:
>> Hi,
>>
>> Why would one have big files delta compressed anyway ? From my
>> experience, this can save a lot of space, even though the process of
>> generating the deltas will definitely take up a lot of memory. In my
>> use-case the packs are generated on a server with plenty of RAM. And
>> even though the most recent version of an object tends to be a base
>> which wouldn't need delta resolution, querying older revisions will
>> require it. As this is done client side most of the time, it would be
>> great to reduce the memory footprint,  at the cost of some additional
>> preprocessing time.
>>
>> Currently, when reapplying deltas on rather big files, assumed that
>> one didn't exclude them for delta compression in the first place, the
>> current algorithm requires the base-buffer, the target buffer as well
>> as the inflated delta stream itself in memory concurrently. Then the
>> algorithm works its way up recursively from the first base object to
>> the last delta until it is done. This causes plenty of possibly large
>> memory allocations, as well as high memory demands.
>>
>> In my current python and c++ implementation of pack reading, I try to
>> stream all objects. Base objects can already be very efficiently
>> streamed as a plain (streamed) inflate will do. This is different for
>> delta objects. Even though the delta resolution machinery is hidden
>> behind a stream interface, it still produces a big buffer to hold the
>> resolved object.
>>
>> My current research went far enough to allow delta streams to be
>> merged together at first, so the last delta to be applied gets merged
>> down onto its base delta, and so forth, until all deltas were merged
>> into one big delta which just applies to the base buffer. This delta
>> will have only copy operations which refer to the base object's data,
>> as well as copy operations. Currently,  the merged delta stream is
>> kept in memory deflated, and could be streamed  more or less easily.
>> The problem I have is that the base object's data still needs to be
>> available for random access, i.e. inflated in memory.
>>
>> Although this technique safes some memory during processing, as it
>> will never allocate two possibly large base and target buffers, in
>> the end it turns out to be more expensive memory wise as it needs the
>> base buffer as well as the merged delta to be allocated as long as
>> the streaming is in progress, compared to just the possibly smaller
>> target buffer in case of the default recursive algorithm.
>>
>> Here comes the link to the subject line: If it was possible to index
>> the zip deflated stream somehow, it wouldn't be required to keep an
>> inflated version of the base buffer in memory all the time. Instead,
>> the required portions can be decompressed on demand, using the said
>> zip stream index. Then we would only need the merged delta stream in
>> memory, which should (ideally) be smaller than the target buffer itself.
>>
>> Do you think it is feasible to burn these extra cycles to reduce the
>> memory footprint ? Do you know whether or how it is possible to index
>> a zip deflated stream for pseudo-random access or can provide hints ?
>> So far, from studying the zlib manual, there seems to be some way of
>> determining zip blocks which can then possibly be linked to the
>> uncompressed data positions, but ... I am absolutely not sure.
>> Ideally, this whole indexing process works by quickly skipping
>> through the zlib stream without actually decompressing it.
>>
>> Maybe, all this is too much effort, and maybe the merged delta
>> stream's size ends up being larger than the target buffer so it was
>> all for nothing (which one would only know once the preprocessing
>> time was already spent), but maybe it could really help truly
>> 'stream' deltified objects (which has been something like my holy
>> grail for quite some time now).
>>
>> Thanks,
>> Sebastian
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> ------------------------------------------------------------------------
> Disclaimer: http://www.peralex.com/disclaimer.html
>
