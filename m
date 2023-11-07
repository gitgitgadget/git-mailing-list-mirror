Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0C30CFD
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89CA12A
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 09:48:07 -0800 (PST)
Received: (qmail 6129 invoked by uid 109); 7 Nov 2023 17:48:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Nov 2023 17:48:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14976 invoked by uid 111); 7 Nov 2023 17:48:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Nov 2023 12:48:04 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Nov 2023 12:48:03 -0500
From: Jeff King <peff@peff.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <20231107174803.GA507007@coredump.intra.peff.net>
References: <ZUocFhmPHstwKCkZ@devuan>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUocFhmPHstwKCkZ@devuan>

On Tue, Nov 07, 2023 at 12:14:21PM +0100, Alejandro Colomar wrote:

> I'm trying to use mutt(1) with git-send-email(1).  Is that possible?
> I tried --sendmail-cmd=mutt, but am getting strange errors.
> The reason I want to send with mutt(1) is because it can encrypt and
> sign mail (with some tweaks), which git-send-mail(1) doesn't.

I think there's a lot of overlap between what git-send-email does and
what mutt does, to the point that you probably don't need to use
send-email at all.

I assume what you want out of send-email here is the actual generation
of patch emails. But under the hood that is all done by git-format-patch
anyway. So for example if you do:

  git format-patch --stdout origin..HEAD >patches
  mutt -f patches

And then you can use mutt's "resend-message" function to send each one.
I use config like this:

  macro index,pager b ":set edit_headers=yes<enter><resend-message>:set edit_headers=no<enter>"

If you're sending a long series, it's helpful to pre-populate various
headers in the format-patch command with "--to", etc. I usually do so by
sending the cover letter directly via mutt, and then using some perl
hackery to convert those headers into format-patch args. The script I
use is below (it will also, when run without a terminal, generate the
patch summary for the cover letter; I use it with "r!my-script" while
writing the cover letter in vim).

(This script is what I use every day, so it should be fairly robust. But
it is also over 15 years old, so I don't promise there isn't a simpler
way to do some of what it does ;) ).

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

format_patch() {
  git format-patch -s --stdout --from "$@"
}

has_nonoption=
for i in "$@"; do
  case "$i" in
    -[0-9]*) has_nonoption=yes ;;
    -*) ;;
     *) has_nonoption=yes
  esac
done

: ${REPLY:=$HOME/patch}
test -e "$REPLY" && eval "set -- `get_reply_headers <\"$REPLY\"` \"\$@\""
test "$has_nonoption" = "yes" || set -- "$@" `upstream_branch`

if test -t 1; then
  format_patch "$@" >.mbox
  mutt -e 'set sort=mailbox-order' -f .mbox
  rm -f .mbox
else
  format_patch "$@" |
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
  ' |
  sed -e 's/\[PATCH /[/' \
      -e 's/]/]:/' \
      -e 's/^/  /'
  echo
  format_patch --cover-letter "$@" |
  sed -ne '/|/,/^$/p; /^-- /q'
fi
