From: Jeff King <peff@peff.net>
Subject: Re: Promoting Git developers
Date: Wed, 11 Mar 2015 03:54:29 -0400
Message-ID: <20150311075429.GA10300@peff.net>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
 <54FDA6B5.8050505@drmicha.warpmail.net>
 <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
 <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
 <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
 <xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
 <20150311073129.GA5947@peff.net>
 <CAPc5daUVVk+SYgwCj9JftzXgV7=9kPprdBPCWHS5XQOa5uF69Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 08:54:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVbTR-0005iz-TS
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 08:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbbCKHyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 03:54:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:60095 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751300AbbCKHyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 03:54:32 -0400
Received: (qmail 3207 invoked by uid 102); 11 Mar 2015 07:54:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Mar 2015 02:54:33 -0500
Received: (qmail 25312 invoked by uid 107); 11 Mar 2015 07:54:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Mar 2015 03:54:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Mar 2015 03:54:29 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daUVVk+SYgwCj9JftzXgV7=9kPprdBPCWHS5XQOa5uF69Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265313>

On Wed, Mar 11, 2015 at 12:38:21AM -0700, Junio C Hamano wrote:

> >> I can add "shortlog --no-merges -s -n v2.3.0..v2.4.0" at the end of
> >> the e-mail when the release notes is sent out. That might be a good
> >> enough balance between the usefulness of the release notes to its
> >> customers and giving credits to individuals in a way a bit more
> >> visible than "if you are interested, run shortlog yourself" [*4*].
> >
> > I somehow thought you already did this, but it looks like you just do
> > shortlog (without the "-ns") for the "maint" release announcement.
> 
> That is because (a) it is scripted in Meta/Announce, and (b) I strip it
> out for feature releases, as the plain shortlog output with full feature
> list is usually ends up being just too long for the announce message.

Yeah, I figured the length was the reason.

> Perhaps I'll add "shortlog -s | pr -3" or something at the end for both
> maintenance track and feature releases. Names only, unordered and
> hopefully not overly long.

Yes, I was thinking something along those lines. Maybe:

  # example
  old=v2.2.0
  new=v2.3.0

  # like "shortlog -s", but we do not even care about the numbers
  shortlog () {
	git log --format=%aN "$@" | sort -u
  }

  compact () {
	perl -lne 'push @x, $_; END { print join(", ", @x) }' |
	fold -s
  }

  count () {
	shortlog $old..$new | wc -l
  }

  newbies () {
	comm -23 <(shortlog $old..$new) <(shortlog $old) | compact
  }

  oldtimers () {
	comm -12 <(shortlog $old..$new) <(shortlog $old) | compact
  }

  cat <<EOF
  Git $new was developed with commits from $(count) people. Thanks very
  much to our returning developers:

  $(oldtimers)

  and welcome to new contributors in this release:

  $(newbies)
  EOF

Or something along those lines. The wording and indentation of the
message could probably use tweaking. And there is a bash-ism in the
script. :)

-Peff
