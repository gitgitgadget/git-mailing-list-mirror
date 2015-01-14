From: Jeff King <peff@peff.net>
Subject: my hacky mutt-specific format-patch workflow
Date: Tue, 13 Jan 2015 20:28:19 -0500
Message-ID: <20150114012819.GA7520@peff.net>
References: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
 <xmqq387eed30.fsf@gitster.dls.corp.google.com>
 <CANCZXo7UtCXF_bJe9exT1pUwwsgUuYs5mvHHGtDORoJew_UXnQ@mail.gmail.com>
 <xmqqppaicwww.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYJ+XNktc7_C81xz=BfCP4_hrE=pWW5QGJ1kdXKMf4Jjw@mail.gmail.com>
 <xmqqiogaco3m.fsf@gitster.dls.corp.google.com>
 <20150113224531.GB3144@peff.net>
 <CAGZ79kZ87ZKT5-OMTEHAMEAmZVOfku_D4vZ9jcWJ4cHrA06cSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 02:28:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBCl1-0004W6-P8
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 02:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbbANB2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 20:28:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:34189 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751335AbbANB2W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 20:28:22 -0500
Received: (qmail 27290 invoked by uid 102); 14 Jan 2015 01:28:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 19:28:22 -0600
Received: (qmail 32161 invoked by uid 107); 14 Jan 2015 01:28:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 20:28:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jan 2015 20:28:19 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ87ZKT5-OMTEHAMEAmZVOfku_D4vZ9jcWJ4cHrA06cSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262367>

[retitling in case there is a wider audience]

On Tue, Jan 13, 2015 at 02:48:15PM -0800, Stefan Beller wrote:

> Would you mind to share (parts of) the wrapper script? We could see if that
> makes sense to incorporate into format-patch as well.

Sure, but I'll warn you it's kind of gross and specific to my workflow. :)

The script (which I call mpatch) is at the end of this message. The main
thing which may be of interest to other people is the cover-letter
handling. I write my cover letters in my normal MUA (mutt), and then
generate the series as a reply to that. The two ways it supports that
are:

  1. It generates the list of patches that I include in my cover letter
     from the mbox.  This _should_ be a "git log" one-liner, but our
     --pretty placeholders do not know how to count. Ideally I could say
     "[%i/%n]: %s", but neither of those first two exist (and %n would
     require counting all of the commits first, which might require some
     surgery to git-log).

  2. Given an existing message, it will pick out the to, cc, and
     message-id headers, and generate corresponding --to, --cc, and
     --in-reply-to arguments to feed to format-patch. I do it hackily in
     perl, but probably format-patch could do it internally if it built
     on git-mailinfo.

I typically have my MUA in one terminal and a shell running git in the
other. Even though I could run mpatch directly from the MUA, it is often
missing the context of which repo I am working in. So instead, I
typically use ~/patch as a go-between for the two sessions (both for
generating patch series, but also for applying with git-am). So I have
this in my muttrc:

  macro pager,index D '<shell-escape>rm -f $HOME/patch<enter>'
  macro pager,index A '<copy-message>~/patch<enter><enter>'

Applying a patch series from the list is just 'D' to clear the state,
then 'A' to collect whatever patches. And then I "git am ~/patch" from
the terminal window.

Generating a patch series is more like:

  1. "mpatch >~/patch" from the git terminal to generate the list of
      commits. No arguments necessary, because it uses @{upstream} as
      the base (but occasionally I use "-3" or similar if I am sending
      out new patches on top of somebody else's work).

  2. Reply or start a new thread in mutt, as normal. This becomes the
     cover letter (the to/cc comes from the reply, or I have mutt
     aliases for the list and frequent contributors, and/or I may cut
     and paste from "git log" in some cases).  Mutt dumps me in vim to
     write the actual message, and I ":r ~/patch" to pull it in.

  3. Finish and send off the cover letter. This gives it a message-id.

  4. Drop the newly-sent message into ~/patch. I usually just open my
     sent folder and use 'D', 'A' to copy it there.

  5. "mpatch" from the git terminal. The headers are picked up from
     ~/patch. Sometimes I use "-v2", which is passed to format-patch
     to get "[PATCH v2 i/n]".

After that, I'm in mutt with an mbox full of the patches. I have this
hotkey in mutt:

  macro index,pager b ":set edit_headers=yes<enter><resend-message>:set edit_headers=no<enter>"

which dumps me vim, with the headers. From there I give a final
proofread, write any comments below the "---", and then send it.

I imagine for the last bit many people have a similar workflow without
mutt that is something like:

  1. format-patch into ~/patch/*

  2. $EDITOR ~/patch/*

  3. git send-email ~/patch/*

Those people would potentially benefit from the format-patch in step 1
picking up the headers from an existing message.

-Peff

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
    if (defined $opt && /^\s+(.*)/) {
      $val .= " $1";
      next;
    }
    if (defined $opt) {
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

: ${REPLY:=$HOME/patch}
test -n "$REPLY" && eval "set -- `get_reply_headers <\"$REPLY\"` \"\$@\""
test "$has_nonoption" = "yes" || set -- "$@" `upstream_branch`

git format-patch -s --stdout --from "$@" >.mbox
if test -t 1; then
  mutt -f .mbox
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
