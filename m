Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667A21F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbcHIS7X (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:59:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:52255 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932347AbcHIS7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:59:22 -0400
Received: (qmail 21649 invoked by uid 109); 9 Aug 2016 18:58:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 18:58:12 +0000
Received: (qmail 23782 invoked by uid 111); 9 Aug 2016 18:58:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 14:58:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 14:58:09 -0400
Date:	Tue, 9 Aug 2016 14:58:09 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160809185809.qyh2gwabxgotvvgk@sigill.intra.peff.net>
References: <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
 <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
 <20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net>
 <CACsJy8ARtg5KUceogNaeB+Fgh-u-TxfkAWdOk68_sEA-c0y6vg@mail.gmail.com>
 <CAGZ79kZ=kNCq3uM5WGdmZRfPGaT1ZUqa2WkQdq5C2inF154sew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ=kNCq3uM5WGdmZRfPGaT1ZUqa2WkQdq5C2inF154sew@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 11:50:51AM -0700, Stefan Beller wrote:

> > Could you share your mutt set up pleaaase? I've been wanting this for
> > a long time, but never used mutt long enough to bother with a proper
> > setup like this (I blame gmail).
> 
> 
> That is my complaint^H^H^H^H position, too.
> I always wanted to switch to a more powerful
> setup than git-send-email for sending /gmail for reading,
> but I could not convince myself the steep learning/setup curve
> is worth it eventually as it is "not broken enough" to do the change
> right now.

I think I may have shared it before, but here is the script I use to
send emails. It dumps you in mutt, and then I have:

  macro index,pager b ":set edit_headers=yes<enter><resend-message>:set edit_headers=no<enter>"

to send the message ("b" is for "bounce", which I think may be another
Pine-ism).

-- >8 --
#!/bin/sh

upstream_branch() {
  current=`git symbolic-ref HEAD`
  upstream=`git for-each-ref --format='%(upstream)' "$current"`
  if test -n "$upstream"; then
    echo $upstream
  else
    echo origin
  fi
}

get_reply_headers() {
  perl -ne '
    if (defined $opt) {
      if (/^\s+(.*)/) {
        $val .= " $1";
        next;
      }
      print "--$opt=", quotemeta($val), " ";
      $opt = $val = undef;
    }
    if (/^(cc|to):\s*(.*)/i) {
      $opt = lc($1);
      $val = $2;
    }
    elsif (/^message-id:\s*(.*)/i) {
      $opt = "in-reply-to";
      $val = $1;
    }
    elsif (/^subject:\s*\[PATCH v(\d+)/i) {
      print "-v$1 ";
    }
    elsif (/^$/) {
      last;
    }
  '
}

has_nonoption=
for i in "$@"; do
  case "$i" in
    -[0-9]) has_nonoption=yes ;;
    -*) ;;
     *) has_nonoption=yes
  esac
done

git rev-parse || exit 1

: ${REPLY:=$HOME/patch}
test -e "$REPLY" && eval "set -- `get_reply_headers <\"$REPLY\"` \"\$@\""
test "$has_nonoption" = "yes" || set -- "$@" `upstream_branch`

git format-patch -s --stdout --from "$@" >.mbox
if test -t 1; then
  mutt -e 'set sort=mailbox-order' -f .mbox
else
  perl -lne '
    if (/^Subject: (.*)/) {
      $subject = $1;
    }
    elsif ($subject && /^\s+(.*)/) {
      $subject .= " $1";
    }
    elsif ($subject) {
      print $subject;
      $subject = undef;
    }
  ' .mbox |
  sed -e 's/\[PATCH /[/' \
      -e 's/]/]:/' \
      -e 's/^/  /'
fi
rm -f .mbox
