From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] robustifying t5504
Date: Wed, 24 Feb 2016 02:36:03 -0500
Message-ID: <20160224073603.GA9163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:36:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYTzY-0002iR-JC
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757122AbcBXHgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 02:36:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:48065 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756743AbcBXHgH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:36:07 -0500
Received: (qmail 20225 invoked by uid 102); 24 Feb 2016 07:36:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:36:06 -0500
Received: (qmail 5123 invoked by uid 107); 24 Feb 2016 07:36:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:36:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 02:36:03 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287176>

I got a spurious test failure on t5504 while running the test suite
today. This is the result of my quest through the SIGPIPE rabbit hole.

Since this is not the first time I've investigated tests failing under
load, I finally broke down and wrote a helper script. It probably needs
some adapting for other people's environments, but I'll share it here in
case anyone is interested:

-- >8 --
#!/bin/sh

test=$1; shift
test=$(cd t && echo $test*.sh)
: ${GIT_STRESS_LOAD:=$(( 2 * $(grep -c ^processor /proc/cpuinfo)))}
: ${GIT_STRESS_ROOT:=/var/ram/git-stress}

mkdir -p "$GIT_STRESS_ROOT" || exit 1
rm -f "$GIT_STRESS_ROOT/fail"
trap 'echo aborted >"$GIT_STRESS_ROOT/fail"' TERM INT HUP
for i in $(seq $GIT_STRESS_LOAD); do
	(
		cd t &&
		while ! test -e "$GIT_STRESS_ROOT/fail"
		do
			if ./$test \
			   --root="$GIT_STRESS_ROOT/trash-$i" \
			   -v -i >"$GIT_STRESS_ROOT/output-$i" 2>&1
			then
				echo >&2 "OK $i"
			else
				echo >&2 "FAIL $i"
				cp "$GIT_STRESS_ROOT/output-$i" "$GIT_STRESS_ROOT/fail"
			fi
		done
	) &
done
wait
cat "$GIT_STRESS_ROOT/fail"
-- 8< --

You can run it like "./stress t5504", and it will run t5504 over and
over in parallel until one instance fails. Without this patch series,
t5504 generally fails for me within 30 seconds or so. With it, I can run
for several minutes without problems.

  [1/4]: write_or_die: handle EPIPE in async threads
  [2/4]: fetch-pack: ignore SIGPIPE in sideband demuxer
  [3/4]: test_must_fail: report number of unexpected signal
  [4/4]: t5504: handle expected output from SIGPIPE death

-Peff
