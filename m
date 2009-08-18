From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Tue, 18 Aug 2009 02:17:33 +0200
Message-ID: <200908180217.35963.jnareb@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <2729632a0908171602m3c05c97bx9ce31e8960df9198@mail.gmail.com> <alpine.DEB.1.00.0908180111340.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: skillzero@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:10:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdCHi-0007Qr-Ga
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 02:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758427AbZHRAKe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 20:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758338AbZHRAKe
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 20:10:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:24572 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758225AbZHRAKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 20:10:33 -0400
Received: by fg-out-1718.google.com with SMTP id e21so753828fga.17
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 17:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GqI7nQg3b5ElTSdel0om1u/eK1g0OflCo3mqKCEP8cQ=;
        b=I2zcwGfKPCXnJ17Wb0lf+0/QAvSZVAVMDTTmxg3AqUTmo2Jo3rVj4YiYccGxqCe/cM
         mWf2KZSp43XkqUjCGsX6YbYQnBCUy3WnyoBGIs8Rj6zyRJZBtfrf9vMWvTopnclHM5JK
         K1Tn2NvUDtQXpD/rZ+GYeBKgU/nQZca21UnOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Us2mU9aQ65+X6pwl9ZhxDZ9iREkamguNvI91XkrVMV7xNQ3eJpOFhhGmsEOk38Puek
         OxBR9BoYVFo8whN9q49Ub6yIoeBH+W5ktDF0wSp5Vg6lc36F7m2yZbxYReqXoztT69Y8
         u2BWzMHa+L84977U5vAfRGkoA/ct5zq5F94sI=
Received: by 10.86.187.27 with SMTP id k27mr2785780fgf.11.1250554233978;
        Mon, 17 Aug 2009 17:10:33 -0700 (PDT)
Received: from ?192.168.1.13? (abvz12.neoplus.adsl.tpnet.pl [83.8.223.12])
        by mx.google.com with ESMTPS id 4sm5216962fgg.19.2009.08.17.17.10.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 17:10:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0908180111340.8306@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126325>

Johannes Schindelin wrote:

> The thing is: we need a way to determine quickly and without any=20
> ambiguity whether a file is tracked, assumed unchanged, or sparse'd-o=
ut=20
> (which Nguy=E1=BB=85n calls no-checkout).

Let's reiterate: "assume-unchanged" is about telling git that it should
assume for performance reasons that state of file in working directory
is the same as state of file in the index.  But, from what was said in
this thread, there are situations where git for correctness reasons
ignores performance hack.

"no-checkout" bit is about telling git that the file is not present
in working directory, and it has to use version from the index.  Then
there is a question if there is file in working area (e.g. from applyin=
g
patch) which corresponds to a "no-checkout" file in index (corresponds
because of rename detection).

> And if we change .git/info/sparse, that state _must not_ change. =C2=A0=
We did=20
> not touch the file by editing .git/info/sparse, so the state must be=20
> unchanged.

I think this situation (and the issue of correctness vs "assume-unchang=
ed"
mentioned above) hints that "no-checkout" and "assume-unchanged" should
be separate bits, even if both tell git to use version from index.

There is e.g. question if "git grep" should search "no-checkout" files;
in the "assume-unchanged" case it should, I think, search index version=
=2E


P.S. I wonder if it would be worth resurrecting series adding support
for directories in index (which can help performance and 'empty=20
directories' issue)...  It would help, I think, with sparse checkout.

--=20
Jakub Narebski
Poland
