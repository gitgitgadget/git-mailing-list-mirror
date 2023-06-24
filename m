Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66C4EB64D7
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 01:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjFXBMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 21:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFXBMo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 21:12:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9683426BD
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 18:12:42 -0700 (PDT)
Received: (qmail 12800 invoked by uid 109); 24 Jun 2023 01:12:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 24 Jun 2023 01:12:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8525 invoked by uid 111); 24 Jun 2023 01:12:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jun 2023 21:12:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jun 2023 21:12:34 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Clean up stale .gitignore and .gitattribute patterns
Message-ID: <20230624011234.GA95358@coredump.intra.peff.net>
References: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2023 at 05:29:42PM +0200, Sebastian Schuberth wrote:

> is there a command to easily check patterns in .gitignore and
> .gitattributes to still match something? I'd like to remove / correct
> patterns that don't match anything anymore due to (re)moved files.

I don't think there's a solution that matches "easily", but you can do a
bit with some scripting. See below.

For checking .gitignore, I don't think you can ever say (at the git
level) that a certain pattern is useless, because it is inherently about
matching things that not tracked, and hence generated elsewhere. So if
you have a "*.foo" pattern, you can check if it matches anything
_currently_ in your working tree, but if it doesn't that may mean that
you simply did not trigger the build rule that makes the garbage ".foo"
file.

So with that caveat, we can ask Git which rules _do_ have a match, and
then eliminate them as "definitely useful", and print the others. The
logic is sufficiently tricky that I turned to perl:

-- >8 show-unmatched-ignore.pl 8< --
#!/usr/bin/perl

# The general idea here is to read "filename:linenr ..." output from
# "check-ignore -v". For each filename we learn about, we'll load the
# complete set of lines into an array and then "cross them off" as
# check-ignore tells us they were used.
#
# Note that we'd fail to mention an ignore file which matches nothing.
# Probably the list of filenames could be generated independently. I'll
# that as an exercise for the reader.
while (<>) {
  /^(.*?):(\d+):/
    or die "puzzling input: $_";
  if (!defined $files{$1}) {
    $files{$1} = do {
      open(my $fh, '<', $1)
        or die "unable to open $1: $!";
      [<$fh>]
    };
  }
  $files{$1}->[$2] = undef;
}

# With that done, whatever is left is unmatched. Print them.
for my $fn (sort keys(%files)) {
  my $lines = $files{$fn};
  for my $nr (1..@$lines) {
    my $line = $lines->[$nr-1];
    print "$fn:$nr $line" if defined $line;
  }
}
-- >8 --

And you'd use it something like:

  git ls-files -o |
  git check-ignore --stdin -v |
  perl show-unmatched-ignore.pl

Pretty clunky, but it works OK in git.git (and shows that there are many
"not matched but probably still useful" entries; e.g., "*.dll" will
never match for me on Linux, but is probably something we still want to
keep). So I wouldn't use it as an automated tool, but it might give a
starting point for a human looking to clean things up manually.

For attributes, I think the situation is better; we only need them to
match tracked files (though technically speaking, you may want to keep
attributes around for historical files as we use the checked-out
attributes during "git log", etc). Unfortunately we don't have an
equivalent of "-v" for check-attr. It might be possible to add that ,but
in the meantime, the best I could come up with is to munge each pattern
to add a sentinel attribute, and see if it matches anything.

Something like:

  # Maybe also pipe in .git/info/attributes and core.attributesFile
  # if you want to check those.
  git ls-files '.gitattributes' '**/.gitattributes' |
  while read fn; do
  	lines=$(wc -l <"$fn")
  	mv "$fn" "$fn.orig"
  	nr=1
  	while test $nr -le $lines; do
  		sed "${nr}s/$/ is-matched/" <"$fn.orig" >"$fn"
  		git ls-files | git check-attr --stdin is-matched |
  		grep -q "is-matched: set" ||
  		echo "$fn:$nr $(sed -n ${nr}p "$fn.orig")"
  		nr=$((nr+1))
  	done
  	mv "$fn.orig" "$fn"
  done

It produces no output in git.git (we are using all of our attributes),
but you can add a useless one like:

  echo '*.c -diff' >>Documentation/.gitattributes

and then the loop yields:

  Documentation/.gitattributes:2 *.c -diff

So I definitely wouldn't call any of that "easy", but it may help you.

-Peff
