Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF711FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 17:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbdJ0RW1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 13:22:27 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:42080 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932190AbdJ0RW0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2017 13:22:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 93C651822408A;
        Fri, 27 Oct 2017 17:22:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spade10_89775501ffd14
X-Filterd-Recvd-Size: 3074
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Oct 2017 17:22:24 +0000 (UTC)
Message-ID: <1509124942.1914.9.camel@perches.com>
Subject: Re: grep vs git grep performance?
From:   Joe Perches <joe@perches.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Date:   Fri, 27 Oct 2017 10:22:22 -0700
In-Reply-To: <CAGZ79kYWPunzZ2u=MtCoCadxXu_4etEK5DYnhYXo+CgeHrXQwQ@mail.gmail.com>
References: <1509030170.10651.59.camel@perches.com>
         <CAGZ79ka41NdzNxGAvtVW802088KydKkp3yHx=Z5q3Mc9GGa_+g@mail.gmail.com>
         <1509039696.11245.9.camel@perches.com>
         <CAGZ79kYWPunzZ2u=MtCoCadxXu_4etEK5DYnhYXo+CgeHrXQwQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-10-26 at 10:45 -0700, Stefan Beller wrote:
> On Thu, Oct 26, 2017 at 10:41 AM, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2017-10-26 at 09:58 -0700, Stefan Beller wrote:
> > > + Avar who knows a thing about pcre (I assume the regex compilation
> > > has impact on grep speed)
> > > 
> > > On Thu, Oct 26, 2017 at 8:02 AM, Joe Perches <joe@perches.com> wrote:
> > > > Comparing a cache warm git grep vs command line grep
> > > > shows significant differences in cpu & wall clock.
> > > > 
> > > > Any ideas how to improve this?
> > > > 
> > > > $ time git grep "\bseq_.*%p\W" | wc -l
> > > > 112
> > > > 
> > > > real    0m4.271s
> > > > user    0m15.520s
> > > > sys     0m0.395s
> > > > 
> > > > $ time grep -r --include=*.[ch] "\bseq_.*%p\W" * | wc -l
> > > > 112
> > > > 
> > > > real    0m1.164s
> > > > user    0m0.847s
> > > > sys     0m0.314s
> > > > 
> > > 
> > > I wonder how much is algorithmic advantage vs coding/micro
> > > optimization that we can do.
> > 
> > As do I.  I presume this is libpcre related.
> > 
> > For instance, git grep performance is better than grep for:
> > 
> > $ time git grep -w "seq_printf" -- "*.[ch]" | wc -l
> > 8609
> > 
> > real    0m0.301s
> > user    0m0.548s
> > sys     0m0.372s
> > 
> > $ time grep -w -r --include=*.[ch] "seq_printf" * | wc -l
> > 8609
> > 
> > real    0m0.706s
> > user    0m0.396s
> > sys     0m0.309s
> > 
> 
> One important piece of information is what version of Git you are running,
> 
> 
> $ git tag --contains origin/ab/pcre-v2
> v2.14.0

v2.10

> ...
> 
> (and the version of pcre, see the numbers)
> https://git.kernel.org/pub/scm/git/git.git/commit/?id=94da9193a6eb8f1085d611c04ff8bbb4f5ae1e0a

I definitely didn't have that one.

I recompiled git latest (with USE_LIBPCRE2) and reran.

Here are the results

$ git --version
git version 2.15.0.rc2.48.g4e40fb3

$ time git grep -P "\bseq_.*%p\W" -- "*.[ch]" | wc -l
112

real	0m0.437s
user	0m1.008s
sys	0m0.381s

So, git grep performance has already been
quite successfully improved.

Thanks.

