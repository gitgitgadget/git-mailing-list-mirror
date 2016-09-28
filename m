Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5411F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 12:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbcI1Mn4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 08:43:56 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:39226 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932452AbcI1Mnt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 08:43:49 -0400
Received: (qmail 29012 invoked from network); 28 Sep 2016 12:43:46 -0000
Received: (qmail 19832 invoked from network); 28 Sep 2016 12:43:45 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 28 Sep 2016 12:43:40 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1475066620.3257.12.camel@sapo.pt>
Subject: Re: [PATCH v2 01/11] i18n: add--interactive: mark strings for
 translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Wed, 28 Sep 2016 12:43:40 +0000
In-Reply-To: <xmqqr387y4le.fsf@gitster.mtv.corp.google.com>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
         <1472646690-9699-2-git-send-email-vascomalmeida@sapo.pt>
         <xmqqr387y4le.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Dom, 25-09-2016 às 15:52 -0700, Junio C Hamano escreveu:
> > @@ -252,7 +253,7 @@ sub list_untracked {
> >  }
> >  
> >  my $status_fmt = '%12s %12s %s';
> > -my $status_head = sprintf($status_fmt, 'staged', 'unstaged', 'path');
> > +my $status_head = sprintf($status_fmt, __('staged'), __('unstaged'), __('path'));
> 
> Wouldn't it make sense to allow translators to tweak $status_fmt if
> you are allowing the earlier elements that are formatted with %12s,
> as their translation may not fit within that width, in which case
> they may want to make these columns wider?

As far as I understand, %12s means that the argument printed will have
a minimum length of 12 columns. So if the translation of 'stage' is
longer than 12 it will be printed fully no matter what. Though in that
case, the header will not be align correctly anymore:

my $status_fmt = '%12s %12s %s';

     123456789abcdefghijkl     unstaged caminho
  1:    unchanged        +1/-0 git-add--interactive.perl
  2:    unchanged  +4226/-3152 po/git.pot
  3:    unchanged +11542/-10426 po/pt_PT.po


my $status_fmt = '%12s %8s %s';

     123456789abcdefghijkl unstaged caminho
  1:    unchanged    +2/-1 git-add--interactive.perl
  2:    unchanged +4226/-3152 po/git.pot
  3:    unchanged +11542/-10426 po/pt_PT.po


For reference in C locale (my $status_fmt = '%12s %12s %s';)

           staged     unstaged path
  1:        +4/-4      nothing git-add--interactive.perl
  2:    unchanged  +4232/-3150 po/git.pot
  3:    unchanged +11572/-10448 po/pt_PT.po

I did not contemplate this issue before, but I think allowing a
translator to tweak $status_fmt would not be enough to properly align
the header if the translation is longer than 12 columns.

Maybe a lazy solution would be to add a TRANSLATOR: comment asking to
fit the translation of those words in 12 columns, but that would be
unpractical because 'stage' and 'unstage' can occur alone, like they do
here, in other place in the future, without having that length
restriction.

I think the real fix would be to find the longer column and use that
length for the remaining rows. I will try to do that if I can.


I also forgot to mark strings 'unchanged' and 'nothing' that are
displayed on that status. I will mark then in the next re-roll.

> >                       prompt_yesno(
> > -                             'Your edited hunk does not apply. Edit again '
> > -                             . '(saying "no" discards!) [y/n]? '
> > +                             # TRANSLATORS: do not translate [y/n]
> > +                             # The program will only accept that input
> > +                             # at this point.
> > +                             __('Your edited hunk does not apply. Edit again '
> > +                                . '(saying "no" discards!) [y/n]? ')
> 
> Not just [y/n], but "no" in "saying no discards!" also needs to
> stay, no?  I wonder if it is a good idea to lose the TRANSLATORS
> comment by ejecting "[y/n]" outside the "__()" construct here.

I fear that ejecting "[y/n]" would not be good for right-to-left
languages since "[y/n]" would be the first thing a user of those
languages would read followed by the actual question. I feel the same
for other instances of this in the present patch series.
