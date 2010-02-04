From: Teemu Likonen <tlikonen@iki.fi>
Subject: Making custom git-remove-tree command
Date: Thu, 04 Feb 2010 11:03:34 +0200
Message-ID: <87iqad2x09.fsf@mithlond.arda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:03:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncxd0-0007Br-0O
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 10:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab0BDJDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 04:03:52 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:60553 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756141Ab0BDJDv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 04:03:51 -0500
Received: from mithlond.arda (84.251.132.215) by kirsi1.inet.fi (8.5.014)
        id 4B1D0B4D027B9DFA for git@vger.kernel.org; Thu, 4 Feb 2010 11:03:52 +0200
Received: from dtw by mithlond.arda with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Ncxcc-0004Zb-QU
	for git@vger.kernel.org; Thu, 04 Feb 2010 11:03:34 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138958>

I'm doing a script named git-remove-tree which removes the working tree
known to Git. It doesn't touch untracked files; it only deletes
directories if they are empty. The script seems to work, but because I'm
not very good at Git plumbing and there can be some corner cases which I
don't know about, I'd appreciate if more experienced users would have a
look. Is the following script safe?


#!/bin/sh
# git-remove-tree

is_wt=$(git rev-parse --is-inside-work-tree)
if [ "$is_wt" = false ]; then
	echo "You must run this inside a working tree."
	exit 1
elif [ -z "$is_wt" ]; then
	exit 1
fi

top=$(git rev-parse --show-toplevel)
cd "$top" || {
	echo "Can't go to top-level directory $top"
	exit 1
}

git ls-tree --name-only -r -z HEAD | xargs -0r -- sh -c '
for f in "$@"; do
	rm -f -- "$f"
	d=$(dirname -- "$f")
	[ "$d" = . ] || rmdir -p -- "$d" 2>/dev/null
done' dollar0_argument

echo 'Use "git reset --hard HEAD" to populate the working tree again.'
