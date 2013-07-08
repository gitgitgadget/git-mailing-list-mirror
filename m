From: Shawn Pearce <spearce@spearce.org>
Subject: Re: expanding pack idx fanout table
Date: Mon, 8 Jul 2013 10:58:28 -0700
Message-ID: <CAJo=hJu2WgVfWhBGozxgPf9QT=9TydP55-Hqjfis6bhMLEPQag@mail.gmail.com>
References: <CAJo=hJsto1ik=GTC8c3+2_jBuUqcAPL0UWp-1uoYYMpgbLB+qg@mail.gmail.com>
 <7vsizpymuy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 19:58:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwFi9-0004Qn-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 19:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab3GHR6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 13:58:49 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:45092 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab3GHR6t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 13:58:49 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so10798831iec.13
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w1XJIFo+UlJQ+oKfReBe3eX8sLX02SQfotl0JAchqPM=;
        b=cU/MKFIAdd+9LG5AwDnvvBwE/YfZ7C8dtbB27TIEO1mc/UJUEUKKGLog0c4nyfchGh
         BcLoLvDdyfW2NoDubt5wepJeqbpOZN/smXQ6MZyPjWdWaJV6L/bTo2EFIjvUFyCMUO/x
         2rtTE76cceS7CmjcEsz7zC24VYK0fW80unm3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=w1XJIFo+UlJQ+oKfReBe3eX8sLX02SQfotl0JAchqPM=;
        b=UvMtGv310hMf7zs6FOvVnuCe+kTkxtrLV5p/vHX0zwmb8Ohkh7a1DZRWL8EUYexreJ
         oPybjzhANFpdf3K82tzYVwLLko5ULROqT2/zfc3OBrKE4wMdZCFlJ2/hMDn46RLG5lgc
         6ZM1mZm86dQZJG4Clf5hkyy5UrMfQs4h5s/0Z+BLKfgVgDILoE4IN3mX8V1wXj85x8wW
         aTuMXkkEcDbxIHCQw5DOx9/x1DuPSsp3uMpZmSOGPmtgi0tkVUJGQq4yD4JlZPwFY8ua
         h+yn+85K9dBrZ7PfsOhuFrKtLxQmHpjL9WOkwuI59/KPUWsoPg05dAsYdZRGOZSs+nbw
         gRhQ==
X-Received: by 10.42.33.129 with SMTP id i1mr7463830icd.95.1373306328641; Mon,
 08 Jul 2013 10:58:48 -0700 (PDT)
Received: by 10.64.143.200 with HTTP; Mon, 8 Jul 2013 10:58:28 -0700 (PDT)
In-Reply-To: <7vsizpymuy.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlgXoACsLHHC/FYrYaqzxcrkuap5dogd5PX8/i2fAN2S0yPYlDjobj2Xe4SgaJV8nyXbVIP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229882>

On Mon, Jul 8, 2013 at 10:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> Has anyone studied the impact of converting the pack idx fanout table
>> from 256 entries to 65536 entries?
>>
>> Back of the envelope estimates for 3.1M objects in linux.git suggests
>> a 2^16 fanout table would decrease the number of binary search
>> iterations from ~14 to ~6. The increased table costs an extra 255 KiB
>> of disk. On a 70M idx file this is noise.
>>
>> I'm starting to wonder if increasing the fanout table once the object
>> count is above a certain threshold is a reasonable optimization for
>> larger repositories.
>
> Yeah, and I do not think we have to be worried too much about
> backward compatibility for .idx files, as they are local and can be
> regenerated if an older version cannot read it.
>
> I also wonder if we can generate a finer-grained fan-out table on
> the fly, perhaps lazily, without changing the on-disk format ;-)

Heh. Yes. The reader at runtime could expand the 256 fanout table to a
65536 fanout table without changing the on disk format. Unfortunately
doing the expansion will require O(N) time as the 2nd byte of each
SHA-1 must be examined from every bucket. If you are going to perform
O(N) lookups this expansion might save time as it lowers the "log N"
bound of the O(N log N) algorithm for N lookups. It doesn't help
enough when doing only N/20 lookups.
