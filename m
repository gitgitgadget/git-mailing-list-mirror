From: =?ISO-8859-1?Q?Philip_J=E4genstedt?= <philip@foolip.org>
Subject: Working with remotes with (too) many branches
Date: Sun, 19 Feb 2012 16:29:57 +0100
Message-ID: <CAKHWUka763XRWyMz2Xq1qQ2rfKqSYdTX0xtdVFm8zWJ_+6tGqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 16:30:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rz8ix-0001yz-3Q
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 16:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361Ab2BSPaS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Feb 2012 10:30:18 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63229 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab2BSPaS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2012 10:30:18 -0500
Received: by vbjk17 with SMTP id k17so3120520vbj.19
        for <git@vger.kernel.org>; Sun, 19 Feb 2012 07:30:17 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.220.38.5 as permitted sender) client-ip=10.220.38.5;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.220.38.5 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.220.38.5])
        by 10.220.38.5 with SMTP id z5mr9539299vcd.63.1329665417239 (num_hops = 1);
        Sun, 19 Feb 2012 07:30:17 -0800 (PST)
Received: by 10.220.38.5 with SMTP id z5mr7581719vcd.63.1329665417127; Sun, 19
 Feb 2012 07:30:17 -0800 (PST)
Received: by 10.52.178.193 with HTTP; Sun, 19 Feb 2012 07:29:57 -0800 (PST)
X-Gm-Message-State: ALoCoQm2rMCI/My4urDNswMFo5imx4FLBn+jAxcqT+jh8U/QhWdn4CSkEKWBAN/gigpZqiOHfd+z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191025>

Hi,

I work on a project where topic branches are allowed in the main
repository and are not removed even if/when they are merged. This
results in an ever-growing number of branches (and tags), making e.g.
tab completion slow to the point of being useless. We know that this
is not great and it will probably change, but in the meantime I have
set up an alternative origin that only includes the master branch and
annotated tags. However, I still need to collaborate on some topic
branches in the main repository, and have arrived at this solution:

$ git remote add -t footopic -f --no-tags main example.com:/git/main.gi=
t
$ git checkout -t main/footopic
# next day
$ git remote set-branches --add main bartopic
$ git fetch main
$ git checkout -t main/bartopic

This works fairly well, but there are a few wrinkles:

1. If I make a typo with remote set-branches, fetch will fail with
"fatal: Couldn't find remote ref refs/heads/typotopic" and not fetch
anything at all.

2. If I forget that I've previously worked with footopic and
set-branches --add it again, I'll get a duplicate line in my config.

3. When I don't care about footopic anymore, there's no clear way to
stop fetching it and remove refs/remotes/main/footopic.

4. If set-branches --delete existed one could end up with no fetch
lines in the remote config, at which point fetch falls back to
fetching HEAD, instead of the expected nothing.

1 and 2 seem fairly easy to fix: add set-branches --delete and use the
same logic to make --add also remove duplicates. Would changing the
git_config_set_multivar call in add_branch (remote.c) be the right
kind of fix here?

3 is less clear to me. Is it a bug that fetch --prune only prunes refs
that it actually tried to fetch, or is it remote prune that should be
taking care of this? Alternatively, should it be the non-existent
set-branches --delete?

4 could be a deliberate fallback, or is it a bug waiting to be exposed?

I'd appreciate feedback on these issues so that I don't waste time
trying to patch the wrong problems. Suggestions for an alternative
work flow is of course also most welcome!

--
Philip J=E4genstedt
