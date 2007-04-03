From: Alberto Bertogli <albertito@gmail.com>
Subject: Commit cherry-picking
Date: Tue, 3 Apr 2007 00:42:37 -0300
Message-ID: <20070403034234.GB24722@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 05:50:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYa2H-0008M3-GR
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 05:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbXDCDuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 23:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbXDCDuR
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 23:50:17 -0400
Received: from main.gmane.org ([80.91.229.2]:44782 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbXDCDuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 23:50:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HYa1x-0003D8-VS
	for git@vger.kernel.org; Tue, 03 Apr 2007 05:50:02 +0200
Received: from host136.201-252-53.telecom.net.ar ([201.252.53.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 05:50:01 +0200
Received: from albertito by host136.201-252-53.telecom.net.ar with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 05:50:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host136.201-252-53.telecom.net.ar
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43611>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi!

I often use darcs, and one feature I miss when I use git is the ability
to do cherry-picking on what I'm about to commit.

It allows me to do small changes to the code when I'm working on
something else, and don't do ugly commits.

I know the proper way to do this would be to have different branches and
all. But that means I have to switch between branches to do quick fixes,
which is an expensive operation in human terms, because I have to stop
thinking about the code and switch branches and so on.

So I wrote two small scripts to do that: git-pcp and git-commit-cp. The
former acts as a helper to the later. Both are attached.

git-pcp takes a diff file, and produces two files: one with the hunks to
apply, and another one with the ones to skip. It asks the user to
select, for each hunk, where to put it.

git-commit-cp is the command to use, which calls git-pcp to do the
cherrypicking, and then applies the corresponding patches.


The implementation of git-pcp should be better (the diff parsing is not
as strong as it should be, although it works for most cases; and the
user interaction sucks, because I don't like UI =), so it's working but
it needs some improvements.


I wanted to ask you if this was an acceptable command to add to git, and
if you had any recommendations or thoughts about the implementation.

Thanks a lot,
		Alberto


PS: Is there a way of telling git-diff how many context lines to use?


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-pcp

#!/usr/bin/env python

"""
Patch Cherry-Picking

This scripts takes a patch and asks you which chunks you want to apply. Then
it creates two output files: one with the ones to apply, and one with the ones
to skip.

Note that the output patches are NOT fixed, you might want to run them through
rediff (although git-commit-cp does not need to).
"""

import sys


#
# Classes and main data structures
#

class Diff:
	def __init__(self):
		self.parts = []

	def append(self, part):
		self.parts.append(part)

	def __str__(self):
		s = ''.join((str(i) for i in self.parts))
		return s

	def __eq__(self, other):
		if self.parts == other.parts:
			return True
		return False


class File:
	def __init__(self, fname):
		self.fname = fname
		self.parts = []

	def append(self, part):
		self.parts.append(part)

	def __str__(self):
		s = ''.join((str(i) for i in self.parts))
		return s

	def __eq__(self, other):
		if self.parts == other.parts:
			return True
		return False


class Hunk:
	def __init__(self):
		self.parts = []

	def append(self, line):
		self.parts.append(line)

	def __str__(self):
		s = ''.join(self.parts)
		return s

	def __eq__(self, other):
		if self.parts == other.parts:
			return True
		return False


#
# Diff parsing
#

def startswithany(l, *starts):
	for s in starts:
		if l.startswith(s):
			return True
	return False


def parse(fd):
	diff = Diff()
	file = None
	hunk = None
	current = diff
	trailing = []

	for line in fd:
		if line.startswith('+++ '):
			unused, fname = line.strip().split(' ', 1)
			if hunk:
				file.append(hunk)
				hunk = Hunk()
			if file:
				diff.append(file)
			file = File(fname)
			for i in trailing:
				file.append(i)
			file.append(line)
			trailing = []

		elif line.startswith('@@ '):
			if hunk:
				file.append(hunk)
			hunk = Hunk()
			hunk.append(line)

		elif startswithany(line, '+', '-', ' ') \
				and not line.startswith('---'):
			if hunk:
				hunk.append(line)
			else:
				trailing.append(line)

		else:
			if hunk:
				file.append(hunk)
				hunk = None
			trailing.append(line)

	if hunk:
		file.append(hunk)
	if file:
		if trailing:
			for i in trailing:
				file.append(i)
		trailing = []
		diff.append(file)
	if trailing:
		for i in trailing:
			diff.append(i)
	return diff


#
# Cherry-picking
#

def cherrypick(original, toapply, toskip):
	for part in original.parts:
		if isinstance(part, File):
			print '+++ ', part.fname
			happly, hskip = select_parts(part.parts)
			print

			if happly:
				f = File(part.fname)
				for i in happly:
					f.append(i)
				toapply.append(f)

			if hskip:
				f = File(part.fname)
				for i in hskip:
					f.append(i)
				toskip.append(f)
		else:
			toapply.append(part)
			toskip.append(part)


def ask(prompt, valid_options, default = None, help = ()):

	while True:
		r = raw_input(prompt)
		if not r:
			if default:
				r = default
			else:
				continue

		if r in valid_options:
			return r
		elif help and r == help[0]:
			print help[1]
		else:
			print " -- Unknown option"


def select_parts(parts):
	happly = []
	hskip = []

	for h in parts:
		if not isinstance(h, Hunk):
			# we don't care about lines
			happly.append(h)
			hskip.append(h)
			continue

		sys.stdout.write(str(h))
		print
		r = ask("* Include in commit? [y/n/Y/N/?] ", 'ynYN',
			help = ('?', 'Help not implemented') )

		if r == 'y':
			happly.append(h)
		elif r == 'n':
			hskip.append(h)
		elif r == 'Y':
			return (parts, [])
		elif r == 'N':
			return ([], parts)

	# if we don't have any chunks, skip everything
	if len( [h for h in happly if isinstance(h, Hunk)] ) == 0:
		hskip = []
	if len( [h for h in hskip if isinstance(h, Hunk)] ) == 0:
		hskip = []

	return (happly, hskip)


#
# Main
#

if __name__ == '__main__':
	if len(sys.argv) != 4:
		print "Usage: pccp diff_file to_apply to_skip"
		sys.exit(1)

	fin, fapply, fskip = sys.argv[1:4]

	original = parse(open(fin))
	toapply = Diff()
	toskip = Diff()
	cherrypick(original, toapply, toskip)

	open(fapply, 'w').write(str(toapply))
	open(fskip, 'w').write(str(toskip))



--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-commit-cp

#!/bin/bash

set -e
SUBDIRECTORY_OK=Yes
. git-sh-setup
require_work_tree
cd_to_toplevel


TMPB=`mktemp -t git-commit-cp.XXXXXX` || exit 1
ORIGINAL="$TMPB-original"
TOAPPLY="$TMPB-apply"
TOSKIP="$TMPB-skip"

function cleanup() {
	rm $TMPB $ORIGINAL $TOAPPLY $TOSKIP
}


git-diff --full-index HEAD > $ORIGINAL

git-pcp $ORIGINAL $TOAPPLY $TOSKIP

if [ ! -s $TOAPPLY ]; then
	echo "* Nothing to commit!"
	cleanup
	exit 1
fi

if [ -s $TOSKIP ]; then
	git-apply -R $TOSKIP;
fi

git-commit -a "$@"

if [ -s $TOSKIP ]; then
	git-apply --index $TOSKIP;
fi

cleanup
exit 0

--pWyiEgJYm5f9v55/--
