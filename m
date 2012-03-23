From: Alex Plotnick <shrike@netaxs.com>
Subject: Re: [PATCH v0 0/2] git-less: a specialized pager for git-log
Date: Fri, 23 Mar 2012 16:44:10 -0400
Message-ID: <87obrn6o9x.fsf@sol.localdomain>
References: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
	<7v1uokxxzh.fsf@alter.siamese.dyndns.org> <4F6C4B59.8060102@op5.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 21:55:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBBW2-00061T-MR
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 21:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481Ab2CWUzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 16:55:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:37322 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab2CWUzH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 16:55:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SBBVn-0005n0-P9
	for git@vger.kernel.org; Fri, 23 Mar 2012 21:55:03 +0100
Received: from pool-108-7-186-97.bstnma.fios.verizon.net ([108.7.186.97])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 21:55:03 +0100
Received: from shrike by pool-108-7-186-97.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 21:55:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pool-108-7-186-97.bstnma.fios.verizon.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (berkeley-unix)
Cancel-Lock: sha1:MtMAeH74/6WK5dtpu/L7J2TOwHI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193801>

--=-=-=
Content-Type: text/plain

I have on occasion also wished to view log messages (especially with
patches) one at a time. And although I agree that a dedicated pager is
overkill, perhaps a small script wouldn't be.

The attached script will eventually run afoul of argument length limits,
but seems to work well otherwise. If you're using less(1), you can step
through the files using :n, :p, and :x.

Cheers,

    -- Alex

--=-=-=
Content-Type: text/x-shellscript
Content-Disposition: attachment; filename=git-split-log
Content-Description: View git log as one file per commit

#!/bin/sh

# Use csplit(1) to split a git log into one commit per file, then run the
# pager on the split files.

. $(git --exec-path)/git-sh-setup

SPLIT_DIR="$GIT_DIR/split-$$"
CSPLIT="csplit -s -k"
if csplit --help 2>/dev/null | sane_grep -- "-z" >/dev/null;
then
	CSPLIT="$CSPLIT -z"
fi

_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
_infty=1000000

mkdir "$SPLIT_DIR" && cd "$SPLIT_DIR" || exit 1
trap 'rm -rf "$SPLIT_DIR"' 0 1 2 3 15
git log "$@" | $CSPLIT - "/^commit $_x40/" "{$_infty}" 2>/dev/null
git_pager "$SPLIT_DIR"/xx*

--=-=-=--
