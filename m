Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F571F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeIQVtR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 17 Sep 2018 17:49:17 -0400
Received: from elephants.elehost.com ([216.66.27.132]:35969 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbeIQVtR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:49:17 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8HGLBpW086479
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Sep 2018 12:21:11 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>
Cc:     "'John Austin'" <john@astrangergravity.com>, <git@vger.kernel.org>,
        <sandals@crustytoothpaste.net>, <larsxschneider@gmail.com>,
        <pastelmobilesuit@github.com>, "'Joey Hess'" <id@joeyh.name>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com> <20180914190025.GJ55140@syl> <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com> <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com> <20180917135525.GF71477@syl> <874leokw3p.fsf@evledraar.gmail.com> <20180917155732.GI71477@syl>
In-Reply-To: <20180917155732.GI71477@syl>
Subject: RE: Git for games working group
Date:   Mon, 17 Sep 2018 12:21:04 -0400
Message-ID: <002201d44ea2$71e839a0$55b8ace0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJCK+yvnEb5QI/ikbJlwoBcKKGxtwJ84Xf9AsGEat8CU8XVTAJ6d6v5Avvgq9ICrS113AG8YU5Qo41a7TA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 17, 2018 11:58 AM, Taylor Blau wrote:
> On Mon, Sep 17, 2018 at 05:00:10PM +0200, Ævar Arnfjörð Bjarmason
> wrote:
> > >   2. Multi-file locks, e.g., "I need to lock file(s) X, Y, and Z
> > >      together." This isn't possible in Git LFS today with the existing
"git
> > >      lfs lock" command (I had to check, but it takes only _one_
filename as
> > >      its argument).
> > >
> > >      Perhaps it would be nice to support something like this someday
in
> > >      Git LFS, but I think we would have to reimagine how this would
look
> > >      in your file.lock scheme.
> >
> > If you can do it for 1 file you can do it for N with a for-loop, no?
> > So is this just a genreal UI issue in git-annex where some commands
> > don't take lists of filenames (or git pathspecs) to operate on, or a
> > more general issue with locking?
> 
> I think that it's more general.
> 
> I envision a scenario where between iterations of the for-loop, another
> client acquires a lock later on in the list. I think that the general
problem here
> is that there is no transactional way to express "please give me all N of
these
> locks".

A composite mutex is better, constructing a long name of X+Y+Z.lock and
obtaining the lock of that, then attempting all locks X.lock,Y.lock,Z.lock
and if any fail, free up what you did. Otherwise you run into a potential
mutex conflict if someone attempts the locks in a different order. Not
perfect, but it prevents two from going after the same set of resources, if
that set is common. Another pattern is to have a very temporary dir.lock
that is active while locks are being grabbed within a subtree, then released
when all locks are acquired or fail (so very short time). This second
pattern should generally work no matter what combination of locks are
required, although single threads lock acquisition - which is probably a
good thing functionally, but slower operationally.

Cheers,
Randall

