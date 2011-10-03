From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack-object poor performance (with large number of objects?)
Date: Mon, 03 Oct 2011 12:34:31 -0700
Message-ID: <7v62k5g988.fsf@alter.siamese.dyndns.org>
References: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
 <CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
 <CAA01CsppPf_6Zp5UPYBsxa1JEwLGF-FqacRa7kBJ45Ges2ujrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:34:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAoHf-0001ov-7x
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757414Ab1JCTef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 15:34:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756250Ab1JCTed (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:34:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 608AA57EA;
	Mon,  3 Oct 2011 15:34:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=C4hEo5KdYodI5tZTXBf+hqidleg=; b=rPCVrsFeouNtOoJxNUzp
	rlfOpbzNV1VsZBg43uiNx45hYrrptNoaTk8LxHSxw3+aRW/EUP/GCfAFqPTVGhqO
	MNAADI7KOZ16BPpYpz40rZIPTB1ZzXeCUNH4pnv+OxsK9YBt3tstLek9m4L159ag
	NEjDYoqYyoAX6G60Zrbcenc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KWApCr0//ZWe+HfLDARl+9DahgSp/atsNpZJC/05Fzbf3z
	0smugL9+aon1WU1Krm0xx0Sg16LQKU0IQ1e1kLFE+PCQzpUwynvU72b5NW3grTo5
	wrxkLWi2oqJ98B3E6eYD2WoZqJTTz1AfrOT/2+nKJqmv8oce8uZ/Nlt9JEpcA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5760D57E9;
	Mon,  3 Oct 2011 15:34:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB8B957E6; Mon,  3 Oct 2011
 15:34:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B831AE64-EDF6-11E0-B098-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182703>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

>> Packing time depends on a number of factors. One of them is the number
>> of unpacked objects to process. With 1.7 million objects, yes, its
>> going to take some time.
>
> Any statistics how long it should take?

Packing time depends on the repository, your machine and how you pack, so
such statistics would be useful only in comparable contexts.

    linux-3.0/master$ time git repack -a -d 
    Counting objects: 2138578, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (327257/327257), done.
    Writing objects: 100% (2138578/2138578), done.
    Total 2138578 (delta 1791983), reused 2138009 (delta 1791434)

    real    1m40.528s
    user    1m22.805s
    sys     0m3.788s
    linux-3.0/master$ git count-objects -v
    count: 0
    size: 0
    in-pack: 2138578
    packs: 1
    size-pack: 487957
    prune-packable: 0
    garbage: 0

This is on my box [*1*] that is idle (other than running the repack). The
above is starting from an already reasonably well packed state and reuses
deltas; with "-f" to repack everything from scratch it would take
significantly longer:

    linux-3.0/master$ time git repack -a -d -f
    Counting objects: 2138578, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (2118691/2118691), done.
    Writing objects: 100% (2138578/2138578), done.
    Total 2138578 (delta 1749156), reused 344219 (delta 0)

    real    3m26.750s
    user    8m41.857s
    sys     0m6.716s

Larger "window" tends to make the process take longer (I think it grows
squared) but may reduce both the resulting packsize and runtime access
overhead. Larger "depth" does not affect time to pack and helps reducing
the resulting packsize, with increased runtime access overhead (i.e. not
really recommended).

[Footnote]

*1* http://gitster.livejournal.com/34818.html

Intel(R) Core(TM)2 Quad CPU Q9450 @ 2.66GHz with 8GB memory.
