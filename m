From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v2 0/5] New hash table implementation
Date: Tue, 24 Sep 2013 12:18:32 +0200
Message-ID: <20130924101832.GC25070@paksenarrion.iveqy.com>
References: <522FAAC4.2080601@gmail.com>
 <52416058.90008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 12:11:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOPaF-0000Ab-L6
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 12:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab3IXKLD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Sep 2013 06:11:03 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46815 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3IXKLB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 06:11:01 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so3587242lbh.21
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZCU/AbMDo9uzm0HNwubF/tlVuUnuzt2We5c5f+5+KOY=;
        b=agwWFWm2u9Kj09Oh0HjEgdA3Jw4AjX9mGXT1xZq51eSyLha3kXPHS8oBQYm9QM3jr+
         ef+cGhKeKL4QmfWKshywgJAa2oNsxWwo66wSWoj1mAsnvRkMLXEvZr3GBZ/B6y+h5E6X
         F3ElvNpQuoPUU/IaNa7BTGXSM/0E+NfuzX/UDRzJWiNOU26B5twlnC0CbJmY908yvKbS
         GiwL4wN/5w59QeyIOa6XQ403Cb4xPaLYDrDXKtAPfweJHnDiDjaAbNyjlgCao766jWB0
         WuPIK9W2BHk8aGFwDeq8ooBdCL34DccU+0/dvePfovwIvcfahn6OPyIdmsapN2c2UYvF
         Opvw==
X-Received: by 10.152.26.72 with SMTP id j8mr24469283lag.19.1380017460354;
        Tue, 24 Sep 2013 03:11:00 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id w10sm14820963lbv.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 03:10:59 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VOPhQ-000140-V7; Tue, 24 Sep 2013 12:18:33 +0200
Content-Disposition: inline
In-Reply-To: <52416058.90008@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235297>

On Tue, Sep 24, 2013 at 11:50:16AM +0200, Karsten Blees wrote:
> Regarding performance, I have to admit that the difference between th=
e two implementations is far greater than I had anticipated. The follow=
ing times (in seconds) are from Linux x64 (Debian Sarge) on a Core i7 8=
60 @2.8GHz. All tests have been run with 1,000 rounds of 100,000 entrie=
s each.
>=20
> The 'get 10% hits' test does 100,000 lookups on a table with 10,000 e=
ntries (i.e. 90% unsuccessful lookups).
>=20
> The rows denote different hash functions with different qualities:
> - FNV: FNV-1 hash on stringified loop counter (i.e. fnv1(itoa(i))), a=
s
>   an example of a high quality / low collision hash
> - i: just the loop counter (i.e. 0, 1, 2,...), guaranteed collision f=
ree
> - i/10: every 10 entries share the same hash code, lots of collisions
>=20
> The i and i/10 tests show that open addressing suffers badly from clu=
stering, i.e. with adjacent hash codes, it degrades to linear search. T=
he *2 versions provide for some space between used buckets to better co=
mpare it to the chaining version.
>=20
>=20
>         |       add        |  get 100% hits  |    get 10% hits
>         |  hash  | hashmap | hash  | hashmap |  hash   | hashmap
> --------+--------+---------+-------+---------+---------+--------
> FNV     | 14.815 |   2.345 | 3.059 |   1.642 |   4.085 |   0.976
> FNV  x2 | 14.409 |   2.706 | 2.888 |   1.959 |   3.905 |   1.393
> i       |  7.432 |   1.593 | 1.364 |   1.142 | 413.023 |   0.589
> i    x2 |  9.169 |   1.866 | 1.427 |   1.163 |   0.757 |   0.670
> i/10    |  1.800 |   1.555 | 5.365 |   6.465 |  32.918 |   1.052
> i/10 x2 |  1.892 |   1.555 | 5.386 |   6.474 |   1.123 |   1.206
>=20
> Tests can be reproduced with 'time echo "perfhash[map] <method> 1000"=
 | ./test-hashmap', see test-hashmap.c for definition of method flags.
>=20

So I did this improved hash implementation a few months back. Although =
I
could do a test like this and see an improvement, I failed to see an
improvement in actual git usage.

Hopefully it was just me doing something wrong, but I abandonned the
idea of a better hashmap since I couldn't see any major performance
boost using git and the current implementation is really simple and eas=
y
to maintain.

So my question to you is, does your hashmap speed up git? And does it
speed it up enough to justify that your implementation is the double
amount of code than the current?
--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
