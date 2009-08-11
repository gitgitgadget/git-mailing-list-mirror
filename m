From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Wed, 12 Aug 2009 01:45:52 +0200
Message-ID: <4A8202B0.9080608@gmail.com>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain> <alpine.LFD.2.00.0908102246210.10633@xanadu.home> <alpine.LFD.2.01.0908110810410.3417@localhost.localdomain> <alpine.LFD.2.00.0908111437160.10633@xanadu.home> <alpine.LFD.2.01.0908111550470.28882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 01:46:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb12b-00082J-VF
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbZHKXp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 19:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754216AbZHKXp4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:45:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:12700 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbZHKXpz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 19:45:55 -0400
Received: by fg-out-1718.google.com with SMTP id e12so710934fga.17
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 16:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=yNU6b3Af0QkaM2Wc3++6anWtFMCMICnxQ5N9Y9FnemU=;
        b=CwOjme+nXe13i2imMQhJm9QIJ52idSIGquFmEbxDtxGlTg4TMR+34tG23pI+S1sUzZ
         FztnVSUoPExJe/j922P2oEMMtSe2ZBDfn3biN4SqKwHWR4a+2WJisB9C+8rpHR/mWAtK
         Q1Rnk/NBJh8E1I0KS31FunD9oXAeaaF6hbQi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=ea2eOdVXOutD0FpAjp8PoXi2F9ymy+tRy+UM+MbynySFFRo0lDyWMqhxNzFt+YD2V1
         jEm59a8nLAAY0EhUcCHHMV7NXS7vNdEfSrI1p83wyElZVsU4s20ck4zxRWZxqgmkxakk
         Q7VlfNQXnyjIqa8Qn9P0hJ2zpwQL4JmnCmz4M=
Received: by 10.86.58.9 with SMTP id g9mr4345997fga.18.1250034355261;
        Tue, 11 Aug 2009 16:45:55 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-83-132.multimo.pl [89.174.83.132])
        by mx.google.com with ESMTPS id l19sm16095794fgb.12.2009.08.11.16.45.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 16:45:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908111550470.28882@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125623>

Linus Torvalds wrote:
> 
> One thing that strikes me is that I've been just testing with gcc-4.4, and 
> BenH (who did some tests on PPC where SHA1 is just _trivial_ because it 
> all fits in the normal register space) noticed that older versions of gcc 
> that he tested did much worse on this.
> 
> I think Artur also posted (x86) numbers with older gcc versions doing 
> worse. Maybe you're seeing some of that?

FWIW, this is how it looks here. On 32-bit x86 gcc4.4 makes a large
difference[1], but your code does fairly well w/ most gccs, relatively
to all the other C implementations.

artur

P4: [linusv is the recent one w/ the volatile stores]

### sha1bench-gcc295: GCCVER 2.95.4 20030502 (prerelease)
rfc3174        0.9438       64.67
linus          0.9081       67.21
linusv         0.4155       146.9
linusp4        0.8761       69.66
linusas        0.9619       63.45
linusas2        1.025       59.52
mozilla         1.314       46.46
mozillaas       1.132       53.92

### sha1bench-gcc31: GCCVER 3.2 2002-07-26 (prerelease)
rfc3174        0.8582       71.12
linus          0.7943       76.84
linusv         0.5667       107.7
linusp4        0.7224       84.48
linusas        0.7127       85.64
linusas2       0.5109       119.5
mozilla         1.251       48.79
mozillaas       1.239       49.27

### sha1bench-gcc32: GCCVER 3.2.3
rfc3174        0.9062       67.35
linus          0.5555       109.9
linusv         0.3647       167.4
linusp4        0.5337       114.4
linusas        0.7126       85.66
linusas2       0.5089       119.9
mozilla         1.138       53.64
mozillaas       1.075       56.78

### sha1bench-gcc33: GCCVER 3.3.6
rfc3174        0.9029        67.6
linus          0.6059       100.7
linusv         0.3734       163.4
linusp4        0.6695       91.16
linusas        0.7832       77.93
linusas2        0.571       106.9
mozilla         1.083       56.36
mozillaas       1.078       56.62

### sha1bench-gcc34: GCCVER 3.4.6 20060121 (prerelease)
rfc3174        0.9277       65.79
linus          0.6583       92.71
linusv         0.6096       100.1
linusp4        0.7326       83.31
linusas        0.7383       82.67
linusas2       0.6264       97.44
mozilla         1.398       43.67
mozillaas       1.392       43.84

### sha1bench-gcc40: GCCVER 4.0.4 20061113 (prerelease)
rfc3174        0.9889       61.72
linus          0.7508       81.29
linusv         0.7752       78.73
linusp4        0.6548       93.21
linusas        0.4904       124.5
linusas2       0.6378        95.7
mozilla         1.528       39.93
mozillaas       1.596       38.24

### sha1bench-gcc41: GCCVER 4.1.3 20080704 (prerelease)
rfc3174        0.9798       62.29
linus          0.6993       87.28
linusv          0.767       79.57
linusp4        0.6785       89.95
linusas        0.6555       93.11
linusas2        0.691       88.32
mozilla         1.594        38.3
mozillaas       1.566       38.98

### sha1bench-gcc42: GCCVER 4.2.5 20090330 (prerelease)
rfc3174         1.138       53.63
linus          0.7772       78.53
linusv         0.6138       99.43
linusp4        0.7018       86.97
linusas        0.8164       74.76
linusas2       0.7038       86.73
mozilla         1.697       35.97
mozillaas       1.491       40.94

### sha1bench-gcc43: GCCVER 4.3.5 20090810 (prerelease)
rfc3174         1.148       53.15
linus          0.7085       86.14
linusv         0.5474       111.5
linusp4        0.5399         113
linusas        0.7522       81.14
linusas2       0.5341       114.3
mozilla         1.723       35.43
mozillaas       1.502       40.64

### sha1bench-gcc44: GCCVER 4.4.2 20090809 (prerelease)
rfc3174         1.451       42.06
linus          0.5871         104
linusv         0.3713       164.4
linusp4        0.4367       139.8
linusas        0.4083       149.5
linusas2       0.4372       139.6
mozilla         1.104       55.27
mozillaas       1.314       46.44


And on Atom:

### sha1bench-gcc295: GCCVER 2.95.4 20030502 (prerelease)
rfc3174         1.905       32.04
linus           1.089       56.06
linusv         0.8134       75.04
linusp4         1.086       56.19
linusas         1.009       60.52
linusas2        1.255       48.63
mozilla         2.663       22.92

### sha1bench-gcc31: GCCVER 3.2 2002-07-26 (prerelease)
rfc3174         2.141       28.51
linus           1.022       59.75
linusv         0.8323       73.34
linusp4         1.061       57.54
linusas        0.9889       61.72
linusas2       0.9204       66.32
mozilla         2.573       23.72

### sha1bench-gcc32: GCCVER 3.2.3
rfc3174         2.155       28.32
linus          0.9031       67.58
linusv         0.7849       77.76
linusp4         0.847       72.06
linusas        0.9888       61.73
linusas2        0.912       66.93
mozilla         2.485       24.56

### sha1bench-gcc33: GCCVER 3.3.6
rfc3174         2.178       28.02
linus          0.9489       64.32
linusv         0.8642       70.63
linusp4        0.8784       69.48
linusas         1.017       60.03
linusas2        0.906       67.37
mozilla         2.541       24.02

### sha1bench-gcc34: GCCVER 3.4.6 20060121 (prerelease)
rfc3174         2.157        28.3
linus          0.9481       64.37
linusv         0.8383        72.8
linusp4         0.965       63.25
linusas        0.9852       61.95
linusas2       0.9809       62.22
mozilla         3.143       19.42

### sha1bench-gcc40: GCCVER 4.0.4 20061113 (prerelease)
rfc3174         2.088       29.24
linus          0.9706       62.89
linusv          0.928       65.77
linusp4         1.003       60.85
linusas        0.9478        64.4
linusas2       0.9475       64.42
mozilla         2.742       22.26

### sha1bench-gcc41: GCCVER 4.1.3 20080704 (prerelease)
rfc3174         2.047       29.81
linus          0.9778       62.42
linusv          1.051       58.06
linusp4         1.062       57.46
linusas         1.052       58.01
linusas2        1.069       57.12
mozilla           2.6       23.47

### sha1bench-gcc42: GCCVER 4.2.5 20090330 (prerelease)
rfc3174         2.025       30.14
linus          0.9622       63.43
linusv         0.7984       76.44
linusp4        0.8967       68.07
linusas         1.018       59.94
linusas2       0.9048       67.46
mozilla         2.748       22.21

### sha1bench-gcc43: GCCVER 4.3.5 20090810 (prerelease)
rfc3174         2.043       29.88
linus          0.9436       64.69
linusv         0.8532       71.54
linusp4        0.8531       71.54
linusas          1.04       58.71
linusas2       0.8495       71.85
mozilla         2.678       22.79

### sha1bench-gcc44: GCCVER 4.4.2 20090809 (prerelease)
rfc3174         2.119        28.8
linus          0.9132       66.84
linusv         0.8632       70.71
linusp4        0.9842       62.02
linusas         1.027       59.45
linusas2       0.9844          62
mozilla         2.214       27.57
