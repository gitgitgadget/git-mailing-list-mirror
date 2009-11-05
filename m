From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGIT PATCH/RFC]
Date: Thu, 05 Nov 2009 11:37:49 +0100
Organization: LyX
Message-ID: <4AF2AAFD.9000309@lyx.org>
References: <4AF19630.2070402@lyx.org> <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com> <4AF2A538.7040303@lyx.org> <4AF2A69F.1090802@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 11:38:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5zjC-0005P8-HK
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 11:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbZKEKhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 05:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbZKEKhy
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 05:37:54 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44570 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbZKEKhx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 05:37:53 -0500
Received: by bwz27 with SMTP id 27so9925432bwz.21
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 02:37:58 -0800 (PST)
Received: by 10.204.48.144 with SMTP id r16mr2798269bkf.170.1257417477889;
        Thu, 05 Nov 2009 02:37:57 -0800 (PST)
Received: from ?192.168.4.216? ([62.161.104.182])
        by mx.google.com with ESMTPS id 13sm646271bwz.2.2009.11.05.02.37.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 02:37:56 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4AF2A69F.1090802@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132223>

Abdelrazak Younes wrote:
>  Abdelrazak Younes wrote:
> > Marco Costalba wrote:
> >>
> >>> uint qHash(const ShaString& s) { // fast path, called 6-7 times
> >>> per revision
> >>>
> >>>
> >>
> >> Function:
> >>
> >> uint qHash(const QByteArray&);
> >>
> >> is already defined in the Qt Core libraries, so I have a link
> >> error with your patch.
> >>
> >
> > By the way, this function of yours is not used anywhere AFAICS.
>
>  Ok, now I understand that this is used by QHash, sorry.
>
>  I have gcc-4.4.1 so maybe that's the reason why linking works in my
>  case. But I don't which version of the qhash() function does take
>  precedence...

FYI I just verified that your version does take precedence over the Qt one.

Anyway, if you like the patch, we could just inherit from QByteArray 
instead of typedef it so that it links with your system.

Out of curiosity I just had a look at the two versions, yours:

********************************
// definition of an optimized sha hash function
static inline uint hexVal(const uchar* ch) {
    return (*ch < 64 ? *ch - 48 : *ch - 87);
}

uint qHash(const ShaString& s) { // fast path, called 6-7 times per revision

    const uchar* ch = reinterpret_cast<const uchar*>(s.data());

    return (hexVal(ch ) << 24)
        + (hexVal(ch + 2) << 20)
        + (hexVal(ch + 4) << 16)
        + (hexVal(ch + 6) << 12)
        + (hexVal(ch + 8) << 8)
        + (hexVal(ch + 10) << 4)
        + hexVal(ch + 12);
}
********************************

And Qt's version:

********************************
static uint hash(const uchar *p, int n)
{
    uint h = 0;
    uint g;

    while (n--) {
        h = (h << 4) + *p++;
        if ((g = (h & 0xf0000000)) != 0)
            h ^= g >> 23;
        h &= ~g;
    }
    return h;
}

uint qHash(const QBitArray &bitArray)
{
    int m = bitArray.d.size() - 1;
    uint result = hash(reinterpret_cast<const uchar 
*>(bitArray.d.constData()), qMax(0, m));

    // deal with the last 0 to 7 bits manually, because we can't trust that
    // the padding is initialized to 0 in bitArray.d
    int n = bitArray.size();
    if (n & 0x7)
        result = ((result << 4) + bitArray.d.at(m)) & ((1 << n) - 1);
    return result;
}

********************************

I recompiled qgit with the Qt version and I didn't notice any 
performance problem with a big repo (Qt).

Just tell me if this is not interesting to you and I'll shut up :-)

Abdel.
