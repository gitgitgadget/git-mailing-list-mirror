From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 13:59:50 +0100
Message-ID: <4B827FC6.1090905@gnu.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix> <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix> <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com> <20100213223733.GP24809@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org> <20100218013822.GB15870@coredump.intra.peff.net> <alpine.LFD.2.00.1002172350080.1946@xanadu.home> <7vocjnqf5c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 14:35:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjXtK-00055j-CR
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 14:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab0BVM75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 07:59:57 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:39393 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0BVM7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 07:59:55 -0500
Received: by bwz1 with SMTP id 1so1576652bwz.21
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 04:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=bdmC6j584aQPDjewJMZFt3JEk/y+sNisaFyEjqqhmXo=;
        b=Jb5o70ToCF45rEgk08rQ/yoJR7F5vnlTerimpTvA8KTyRaJkoBpmMVub7M6rJJk9DK
         hs1OeczT0Fvj+9QzfFNdLZ5vaOzctKAE2mKwJmzSq4DqqfTTuxg5lRWTd2sUJ8pOmZj3
         0IFjd1dadgdoPJSaLcU5E5Tv/2suw0nMc6HUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=O7sqE4YgHcqOUnaAZ1XT3DnjCmUIFNBRiobNXaBhLWfvt3tB48XakA6K4/Y52NFADV
         lT0X7qlcIqECsH22Su/hl1kEGzqTrtL3aAD8ujUR5WfOr1vYIzUV5c9/xcZjD+imw3MR
         JaUdliCF9bOoREV1zIb9eWddTMQrYwlYBX0v0=
Received: by 10.204.10.138 with SMTP id p10mr804660bkp.71.1266843593489;
        Mon, 22 Feb 2010 04:59:53 -0800 (PST)
Received: from yakj.usersys.redhat.com (93-34-208-53.ip51.fastwebnet.it [93.34.208.53])
        by mx.google.com with ESMTPS id 16sm1108021bwz.5.2010.02.22.04.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 04:59:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vocjnqf5c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140680>

On 02/18/2010 06:36 AM, Junio C Hamano wrote:
> Nicolas Pitre<nico@fluxnic.net>  writes:
>
>> It is likely to have better performance if the buffer is small enough to
>> fit in the CPU L1 cache.  There are two sequencial passes over the
>> buffer: one for the SHA1 computation, and another for the compression,
>> and currently they're sure to trash the L1 cache on each pass.
>
> I did a very unscientific test to hash about 14k paths (arch/ and fs/ from
> the kernel source) using "git-hash-object -w --stdin-paths" into an empty
> repository with varying sizes of paranoia buffer (quarter, 1, 4, 8 and
> 256kB) and saw 8-30% overhead.  256kB did hurt and around 4kB seemed to be
> optimal for my this small sample load.
>
> In any case, with any size of paranoia, this hurts the sane use case

Because by mmaping + memcpying you are getting the worst of both cases: 
you get a page fault per page like with mmap, and touch memory twice 
like with read.

Paolo
