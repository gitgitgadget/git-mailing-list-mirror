Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BF8F1FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 11:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932633AbcLMLRE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 06:17:04 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:49412 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932464AbcLMLRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 06:17:04 -0500
Received: (qmail 25190 invoked from network); 13 Dec 2016 11:17:01 -0000
Received: (qmail 14181 invoked from network); 13 Dec 2016 11:17:01 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 13 Dec 2016 11:17:01 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1481627820.2041.21.camel@sapo.pt>
Subject: Re: [PATCH v6 01/16] Git.pm: add subroutines for commenting lines
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Tue, 13 Dec 2016 10:17:00 -0100
In-Reply-To: <xmqqy3zno2qv.fsf@gitster.mtv.corp.google.com>
References: <20161111124541.8216-1-vascomalmeida@sapo.pt>
         <20161111124541.8216-2-vascomalmeida@sapo.pt>
         <1479823833.1956.7.camel@sapo.pt>
         <xmqqoa17quls.fsf@gitster.mtv.corp.google.com>
         <1481303956.4934.8.camel@sapo.pt>
         <alpine.DEB.2.20.1612091832310.23160@virtualbox>
         <xmqqk2b8rbbb.fsf@gitster.mtv.corp.google.com>
         <1481364496.1993.14.camel@sapo.pt>
         <xmqqy3zno2qv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Sáb, 10-12-2016 às 14:09 -0800, Junio C Hamano escreveu:
> We only update comment_line_char from the default "#" when the
> configured value is a single-byte character and we ignore incorrect
> values in the configuration file.  So I think the patch you sent is
> correct after all.

I am still not sure what version do we prefer.

Check whether core.commentchar is a single character. If not, use '#'
as the $comment_line_char.

+sub get_comment_line_char {
+       my $comment_line_char = config("core.commentchar") || '#';
+       $comment_line_char = '#' if ($comment_line_char eq 'auto');
+       $comment_line_char = '#' if (length($comment_line_char) != 1);
+       return $comment_line_char;
+}

Check whether core.commentchar is a single character. If not, use the
first character of the core.commentchar value, mirroring the "rebase
-i" behavior introduced recently.

+sub get_comment_line_char {
+       my $comment_line_char = config("core.commentchar") || '#';
+       $comment_line_char = '#' if ($comment_line_char eq 'auto');
+       if (length($comment_line_char) != 1) {
+               # use first character
+               $comment_line_char = substr($comment_line_char, 0, 1);
+       }
+       return $comment_line_char;
+}

Or akin to what I had in the first patch related to handling 'auto'
value of core.commentchar configuration variable:

+sub get_comment_line_char {
+       my $comment_line_char = config("core.commentchar") || '#';
+       $comment_line_char = '#' if ($comment_line_char eq 'auto');
+       return $comment_line_char;
+}

Which assumes that the value of core.commentchar configuration variable
is either 'auto' or one single character, or the variable is not
defined.
