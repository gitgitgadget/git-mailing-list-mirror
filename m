From: Paul Smith <paul@mad-scientist.net>
Subject: profile-fast is failing in my Git 2.2.1 build from tar in a Git repo
Date: Sun, 04 Jan 2015 16:58:43 -0500
Organization: GNU's Not UNIX!
Message-ID: <1420408723.7095.207.camel@homebase>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 04 22:58:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7tBU-0006qG-N8
	for gcvg-git-2@plane.gmane.org; Sun, 04 Jan 2015 22:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbbADV57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 16:57:59 -0500
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:56164 "HELO
	gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752788AbbADV56 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2015 16:57:58 -0500
Received: (qmail 31174 invoked by uid 0); 4 Jan 2015 21:57:57 -0000
Received: from unknown (HELO cmgw4) (10.0.90.85)
  by gproxy8.mail.unifiedlayer.com with SMTP; 4 Jan 2015 21:57:57 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw4 with 
	id bxxt1p00M2qhmhE01xxwkq; Sun, 04 Jan 2015 14:57:57 -0700
X-Authority-Analysis: v=2.1 cv=BvIOn+n5 c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=qenwzdlAJUAA:10 a=YNv0rlydsVwA:10 a=oh1m6hy-WApeJ8obKkIA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:To:Reply-To:From:Subject:Message-ID; bh=644xEoa/4dlxJpI33U4OHotxdz2Kcz5ezs6CX2cmhXE=;
	b=aebGliE9fenxvyA8oSi9Lo/j4xcm11dKNRiLhWRFtuaxGTTqvcu9Nzn4GfT8x3UrbYLLDDD7lArcSe1chNrvqeWlbhZ/PzHnsyYPdvtfA49ZaIVkDiyjND0DILOwl9z/;
Received: from [72.74.248.26] (port=49283 helo=homebase.home)
	by box531.bluehost.com with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1Y7tBJ-0006Vp-MI
	for git@vger.kernel.org; Sun, 04 Jan 2015 14:57:53 -0700
X-Mailer: Evolution 3.11.3-fta1~13.10 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 72.74.248.26 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262009>

Is anyone aware of this?  It seems that profile-fast fails when invoked
from a downloaded tarball, if you are in a Git repository when you
unpack it.

So, for example, I have:

  $ cd $HOME/src
  $ git status
  On branch master
  Your branch is up-to-date with 'origin/master'.

(this is NOT the Git source repo, this is my personal repo containing
scripts used to build various source packages)

Then I download git-2.2.1.tar.xz, unpack it, configure, and run "make
profile-fast".

After it builds everything it starts trying to run the tests, and the
t/perf/run script fails (I added some -x flags in the scripts):

  === Running 9 tests in this tree ===
  cp: cannot stat '/home/psmith/src/git-2.2.1/t/..//home/psmith/src/.git/objects': No such file or directory
  error: failed to copy repository '/home/psmith/src/git-2.2.1/t/..' to '/home/psmith/src/git-2.2.1/t/perf/trash directory.p0000-perf-lib-sanity'

The problem is in the t/perf/perf-lib.sh:test_perf_create_repo_from()
function, where we see this:

  repo="$1"
  source="$2"
  source_git=$source/$(cd "$source" && git rev-parse --git-dir)

The function is invoked as:

  test_perf_create_repo_from '/home/psmith/src/git-2.2.1/t/perf/trash directory.p5302-pack-index' /home/psmith/src/git-2.2.1/t/..

but this doesn't work, because "$source" is not a Git repository; it's
the root of the unpacked tarball.  But when we run "git rev-parse" in
it, it finds the parent Git directory ($HOME/git) and uses that, so the
value of source_git becomes:

  /home/psmith/src/git-2.2.1/t/..//home/psmith/src/.git/objects

which is obviously invalid.  I think you want source_git to be set
something like this:

  source_git=$(cd "$source" && git rev-parse --git-dir || echo "$source")

instead.  There are other ways to do this of course, but this worked for
me... basically we want to use either git rev-parse OR $source but not
both.  I think...?
