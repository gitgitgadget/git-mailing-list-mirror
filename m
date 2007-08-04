From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 04 Aug 2007 16:45:54 -0400
Message-ID: <46B4E582.7030200@gmail.com>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site> <46B4A2B0.9080208@gmail.com> <46B4DF39.2070506@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Aug 04 22:46:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHQVt-0005xj-Vl
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 22:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761974AbXHDUp7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 16:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759946AbXHDUp7
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 16:45:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:56071 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016AbXHDUp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 16:45:58 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1125210wxd
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 13:45:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TqYAs0wajL9hiaBQYnbO9qzlIyeMd6XWYFaQraTvhWbnIZGW8L1pRarkaSZwjanVvfy0fRri0uDIgcxiQylaiLonds0pMju+GT94cSA7AO17/NBSmpu0tM1yWq2B0m8CjMRy3HfWNoUiJxyjekdz3h81T2D3Yr5yNtuAny2zc34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TxigkkIHyRg08QlWj2lrhCM0cENJ5kQwZIWrCLoxcS3xVN1UoQNt0PadhWU9w98n5fq4dQgNIFoIZiueiEF7Qqk5JI9ignVuttTMddFzjF6W+BpJ+bX02CkK4pu7ZW/5FtYmosnWo15Jr5ucYONk/NApWyCKjdl4XUCMhtjZxu0=
Received: by 10.70.61.3 with SMTP id j3mr7305814wxa.1186260357827;
        Sat, 04 Aug 2007 13:45:57 -0700 (PDT)
Received: from ?192.168.100.118? ( [72.66.124.87])
        by mx.google.com with ESMTPS id 3sm6464637wrs.2007.08.04.13.45.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Aug 2007 13:45:56 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <46B4DF39.2070506@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54906>

Ren=E9 Scharfe wrote:
> Mark Levedahl schrieb:
>  =20
>> git>git bisect good
>> 6490a3383f1d0d96c122069e510ef1af1d019fbb is first bad commit
>>    =20
>
> I've started a bisect run myself and ended up at a different commit,
> viz. e90fdc39b6903502192b2dd11e5503cea721a1ad ("Clean up work-tree
> handling").  Hmm.  I guess this candidate has a greater chance of
> actually being the culprit than yours. ;-)
>  =20

Nak - at commit e90fdc... it works fine for me here. However, one=20
problem is the following lines in setup.c/set_work_tree() that appear=20
until 6490a3

            strncpy(dir_buffer, dir, len - postfix_len);

        /* are we inside the default work tree? */
        rel =3D get_relative_cwd(buffer, sizeof(buffer), dir_buffer);

Note that dir_buffer is not null terminated in the above code, that bug=
=20
has been around for a while, and you certainly could run into a=20
different problem than I did as the results are essentially undefined=20
here because of that bug.. The key innovation for the current discussio=
n=20
in commit 6490a33 is that dir_buffer is null terminated after the copy,=
=20
causing a different but repeatable result from get_relative_cwd.

I think this ultimately exposes a bug in=20
builtin-checkout-index/checkout_all wherein the latter does not=20
explicitly honor the given --prefix option that is passed along in=20
state.  Specifically, on each pass the following test passes

        if (prefix && *prefix &&
            (ce_namelen(ce) <=3D prefix_length ||
             memcmp(prefix, ce->name, prefix_length)))
            continue;

so the code never attempts to write the file out. I cannot fathom what=20
this test is trying to discern and have to leave it to others more=20
familiar with the design to figure out the right course. For this=20
particular use, the passed in prefix is irrelevant, the correct path to=
=20
write to is in state.

Mark
