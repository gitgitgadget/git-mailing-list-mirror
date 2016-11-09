Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6742021E
	for <e@80x24.org>; Wed,  9 Nov 2016 17:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754238AbcKIRCh (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 12:02:37 -0500
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:44195 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751944AbcKIRCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 12:02:36 -0500
Received: (qmail 24459 invoked from network); 9 Nov 2016 17:02:33 -0000
Received: (qmail 26850 invoked from network); 9 Nov 2016 17:02:33 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 9 Nov 2016 17:02:33 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1478710943.28771.4.camel@sapo.pt>
Subject: Re: [PATCH v5 01/16] Git.pm: add subroutines for commenting lines
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Wed, 09 Nov 2016 16:02:23 -0100
In-Reply-To: <xmqqshr19oxp.fsf@gitster.mtv.corp.google.com>
References: <20161108120823.11204-1-vascomalmeida@sapo.pt>
         <20161005172110.30801-1-vascomalmeida@sapo.pt>
         <20161108120823.11204-2-vascomalmeida@sapo.pt>
         <xmqqshr19oxp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Ter, 08-11-2016 às 17:06 -0800, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
> > 
> > Add subroutines prefix_lines and comment_lines.
> > 
> > Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> > ---
> >  perl/Git.pm | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/perl/Git.pm b/perl/Git.pm
> > index b2732822a..17be59fb7 100644
> > --- a/perl/Git.pm
> > +++ b/perl/Git.pm
> > @@ -1438,6 +1438,29 @@ sub END {
> >  
> >  } # %TEMP_* Lexical Context
> >  
> > +=item prefix_lines ( PREFIX, STRING )
> > +
> > +Prefixes lines in C<STRING> with C<PREFIX>.
> > +
> > +=cut
> > +
> > +sub prefix_lines {
> > +	my ($prefix, $string) = @_;
> > +	$string =~ s/^/$prefix/mg;
> > +	return $string;
> > +}
> > +
> > +=item comment_lines ( STRING )
> > +
> > +Comments lines following core.commentchar configuration.
> > +
> > +=cut
> > +
> > +sub comment_lines {
> > +	my $comment_line_char = config("core.commentchar") || '#';
> > +	return prefix_lines("$comment_line_char ", @_);
> > +}
> > +
> 
> This makes it appear as if comment_lines can take arbitrary number
> of strings as its arguments (because the outer caller just passes @_
> thru), but in fact because prefix_lines ignores anything other than
> $_[0] and $_[1], only the first parameter given to comment_lineS sub
> is inspected for lines in it and the prefix-char prefixed at the
> beginning of each of them.
> 
> Which is not a great interface, as it is quite misleading.
> 
> Perhaps
> 
> 	prefix_lines("#", join("\n", @_));
> 
> or something like that may make it less confusing.

I prefer to have like this instead

sub prefix_lines {
        my $prefix = shift;
        my $string = join("\n", @_);
        $string =~ s/^/$prefix/mg;
        return $string;
}

So both subroutines can take several strings as arguments.
