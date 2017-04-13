Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18D8F20960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754759AbdDMS2K (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:28:10 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:36944 "EHLO
        homiemail-a22.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752457AbdDMS2J (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Apr 2017 14:28:09 -0400
Received: from homiemail-a22.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTP id BBCAF114068;
        Thu, 13 Apr 2017 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=/Ehvx
        RntQPpKU6uolx8ZhrZI4WQ=; b=I3aUok7JnjiyUX+7kWEB23GrDyrrTpo6MnENH
        m1z+kBkVOfV01N4sve/+bGQHCMiJ1i31tijDlWoEhpnnknvo8di+W7MKmqzecbnK
        pGz43+Z1TEigLhgS8XfGOMFD4Z/uihtem695IvQefmMG6RZxKYkmICRf8qy0xZE/
        T0PjGE=
Received: from corey (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTPSA id 409A6114066;
        Thu, 13 Apr 2017 11:28:08 -0700 (PDT)
Message-ID: <1492108087.1527.82.camel@novalis.org>
Subject: Re: Simultaneous gc and repack
From:   David Turner <novalis@novalis.org>
To:     Martin Fick <mfick@codeaurora.org>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Date:   Thu, 13 Apr 2017 14:28:07 -0400
In-Reply-To: <10832632.7AIzXehjUi@mfick1-lnx>
References: <1492104698.1527.79.camel@novalis.org>
         <CA+P7+xo4mwA8DMeObq_T9=P9m7tG1d6afDS_Md56_EnhuXLVgw@mail.gmail.com>
         <10832632.7AIzXehjUi@mfick1-lnx>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-04-13 at 12:08 -0600, Martin Fick wrote:
> On Thursday, April 13, 2017 11:03:14 AM Jacob Keller wrote:
> > On Thu, Apr 13, 2017 at 10:31 AM, David Turner=C2=A0
>=20
> <novalis@novalis.org> wrote:
> > > Git gc locks the repository (using a gc.pid file) so
> > > that other gcs don't run concurrently. But git repack
> > > doesn't respect this lock, so it's possible to have a
> > > repack running at the same time as a gc.=C2=A0=C2=A0This makes
> > > the gc sad when its packs are deleted out from under it
> > > with: "fatal: ./objects/pack/pack-$sha.pack cannot be
> > > accessed".=C2=A0=C2=A0Then it dies, leaving a large temp file
> > > hanging around.
> > >=20
> > > Does the following seem reasonable?
> > >=20
> > > 1. Make git repack, by default, check for a gc.pid file
> > > (using the same logic as git gc itself does).
> > > 2. Provide a --force option to git repack to ignore said
> > > check. 3. Make git gc provide that --force option when
> > > it calls repack under its own lock.
> >=20
> > What about just making the code that calls repack today
> > just call gc instead? I guess it's more work if you don't
> > strictly need it but..?
>=20
> There are many scanerios where this does not achieve the=C2=A0
> same thing.=C2=A0=C2=A0On the obvious side, gc does more than=C2=A0
> repacking, but on the other side, repacking has many=C2=A0
> switches that are not available via gc.
>=20
> Would it make more sense to move the lock to repack instead=C2=A0
> of to gc?

Other gc operations might step on each other too (e.g. packing refs).=20
That would be less bad (and less common), but it still seems worth
avoiding.
