Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A39120189
	for <e@80x24.org>; Wed, 22 Jun 2016 21:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbcFVVsN (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 17:48:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40730 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbcFVVsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 17:48:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4F6C20189;
	Wed, 22 Jun 2016 21:48:11 +0000 (UTC)
Date:	Wed, 22 Jun 2016 21:48:11 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	Andrea Stacchiotti <andreastacchiotti@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: git-htmldocs.googlecode.com is no more
Message-ID: <20160622214811.GA19633@dcvr.yhbt.net>
References: <146652690896.29270.13813898006180324611.reportbug@duelitri>
 <20160622024151.GA20206@google.com>
 <20160622190018.GA786@dcvr.yhbt.net>
 <CAPc5daUiUv-EEv7ouQ=K+Q8S64QVV5wn4H6+TuF0wLeo123K5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPc5daUiUv-EEv7ouQ=K+Q8S64QVV5wn4H6+TuF0wLeo123K5Q@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Jun 22, 2016 at 12:00 PM, Eric Wong <e@80x24.org> wrote:
> >
> > Just wondering, who updates
> > https://kernel.org/pub/software/scm/git/docs/
> > and why hasn't it been updated in a while?
> > (currently it says Last updated 2015-06-06 at the bottom)
> 
> Nobody. It is too cumbersome to use their upload tool to update many
> files (it is geared towards updating a handful of tarballs at a time).

Alright, I've setup https://git-htmldocs.bogomips.org/ for my own
usage, at least.  It should check for updates twice an hour(*),
and plain HTTP is also available in case Let's Encrypt goes away.

Can't hurt to have more mirrors:
----------------------8<---------------------
#!/bin/sh
set -e
DST=/path/to/server-docroot/git-htmldocs
# my mirror of git://git.kernel.org/pub/scm/git/git-htmldocs.git:
GIT_DIR=/path/to/mirrors/git-htmldocs.git
export GIT_DIR

# rsync from a temporary dir for atomicity so nobody fetches
# a partially written file
tmp="$(mktemp -t -d htmldocs.XXXXXXX)"
git archive --format=tar HEAD | tar x -C "$tmp"
chmod 755 "$tmp"
rsync -a "$tmp/" "$DST/"
rm -rf "$tmp"

# for servers which support pre-gzipped files (e.g. gzip_static in nginx)
find "$DST" -type f -name '*.html' -o -name '*.txt' | while read file
do
	gz="$file.gz"
	if ! test -e "$gz" || test "$gz" -ot "$file"
	then
		gztmp="$gz.$$.tmp"
		gzip -9 <"$file" >"$gztmp"
		touch -r "$file" "$gztmp"
		mv "$gztmp" "$gz"
	fi
done
---
(*) On a side note, It would be nice to something like IMAP IDLE
    for real-time updates of mirrors.
