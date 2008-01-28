From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: How to split a patch
Date: Mon, 28 Jan 2008 12:37:59 +0200
Message-ID: <479DB087.30405@panasas.com>
References: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com>	 <7vhcgyuwsx.fsf@gitster.siamese.dyndns.org> <4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000008000607080002000107"
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 11:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJRO9-0003JU-UT
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 11:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbYA1KiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 05:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbYA1KiW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 05:38:22 -0500
Received: from bzq-219-195-70.pop.bezeqint.net ([62.219.195.70]:47966 "EHLO
	bh-buildlin2.bhalevy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbYA1KiV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 05:38:21 -0500
Received: from bh-buildlin2.bhalevy.com (localhost.localdomain [127.0.0.1])
	by bh-buildlin2.bhalevy.com (8.14.1/8.14.1) with ESMTP id m0SAbxtE005554;
	Mon, 28 Jan 2008 12:38:00 +0200
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71874>

This is a multi-part message in MIME format.
--------------000008000607080002000107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Jan 28 2008 at 11:32 +0200, "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> wrote:
> On Jan 28, 2008 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>>
>>> I know ho to do the opposite process, rebase -i and squash is something
>>> I'm really used to do but this time that trick is not going to help me.
>>>
>>> What is the preferred way to split a big patch in a series of
>>> smaller patches?
>>
>> I personally found the procedure described there a bit on the
>> sketchy side, but does "SPLITTING COMMITS" section of git-rebase
>> manual help?
> 
> Yes it helps but I still wonder whether thereis a "simpler" way to achive that.
> Is it possible to split a patch selecting the hunk in git gui or any
> other graphical
> tool?
> 
> That would be a good starting point for a newbie (like me).
> 
> Thanks!
> 
> Ciao,
What I do is edit the patch, let me explain.
- I create a new branch based at the base of the big patch. Now
  I have the original branch for reference. Lets say the original
  branch is called ALL, and this new branch SPLIT. and BASE is the base.
- # git-checkout -b SPLIT BASE
- # git-diff -R ALL >edit-the-patch-001.patch
- now I open the patch file with an editor. I use kwrite because of
  the good color highlighting.
- I remove all the hunks that I don't need, and am left with only the
  parts that I want to be in the first patch.
- I save the patch.
- If at the edit stage I have changed a big hunk and only used part
  of it I need to run fixpatch script attached below. If I only removed
  complete hunks then I'm good to go.
- I now use:
  # patch -p 1 < edit-the-patch-001.patch
- # git-commit -a
- and git-commit --amend until the first patch is good
- now do the 
  # git-diff -R ALL >edit-the-patch-002.patch
  and so on until there is nothing left. It is nice how
  every time it gets smaller and smaller.

[fixpatch command line]
usage: fixpatch inputfile outputfile
what I do is just
# fixpatch edit-the-patch-001.patch{,}

Boaz


--------------000008000607080002000107
Content-Type: text/plain;
 name="fixpatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fixpatch"

#!/bin/sh

src="$1"
dest="$2"
tmp=/tmp/`basename $0`.tmp.$$

if [ -z "$dest" ]; then
	dest="/dev/fd/1"
elif [ "$src" == "$dest" ]; then
	cp "$src" "$src.orig" || exit 1
fi

awk '
function dump_hunk()
{
	if (!hunk) {
		return;
	}

	if (!hsrc_line)
		foffset = 1;

#	if (hsuffix !~ /\n$/) {
#		hsuffix = hsuffix "\n";
#	}
	printf("@@ -%d,%d +%d,%d %s\n", -hsrc_line, hsrc_count,
		-hsrc_line + foffset, hdest_count, hsuffix);

	if (hunchanged + hdel + hadd != hlines) {
		fflush();
		printf("%s %d: Warning: Unchanged %d deleted %d added %d != lines %d\n",
			FILENAME, FNR, hunchanged, hdel, hadd, hlines) > "/dev/stderr";
	}

	if (hunchanged + hdel != hsrc_count) {
		fflush();
		printf("%s %d: Warning: Unchanged %d deleted %d != hsrc_count %d\n",
			FILENAME, FNR, hunchanged, hdel, hsrc_count) > "/dev/stderr";
	}

	if (hunchanged + hadd != hdest_count) {
		fflush();
		printf("%s %d: Warning: Unchanged %d added %d != hdest_count %d\n",
			FILENAME, FNR, hunchanged, hadd, hdest_count) > "/dev/stderr";
	}

	for (i = 0; i < hlines; i++) {
		print hline[i];
		delete hline[i];
	}

	foffset += hdest_count - hsrc_count;
	hsrc_line = 0;
	hsrc_count = 0;
	hdest_line = 0;
	hdest_count = 0;
	hsuffix = "";

	hunchanged = hadd = hdel = 0;
	hlines = 0;
	hunk = 0;
}

/^(diff|====)/ {
	dump_hunk();
	print;
	foffset = 0;
	next;
}

/^@@/ {
	dump_hunk();
	n = split($2, a, /,/);
	hsrc_line = a[1]+0;
	hsrc_oldcount = a[2]+0;
	hsrc_count = 0;
	if (n != 2 || hsrc_line > 0 || hsrc_oldcount < 0) {
		fflush();
		printf("%s %d: Error: Corrupt hunk header (n %d hsrc_line %d hsrc_oldcount %d)\n",
			FILENAME, FNR, n, hsrc_line, hsrc_count) > "/dev/stderr";
	}

	n = split($3, a, /,/);
	hdest_line = a[1]+0;
	hdest_oldcount = a[2]+0;
	hdest_count = 0;
	if (n != 2 || hdest_line < 0 || hdest_oldcount < 0) {
		fflush();
		printf("%s %d: Error: Corrupt hunk header (hdest_line %d hdest_oldcount %d)\n",
			FILENAME, FNR, hdest_line, hdest_oldcount) > "/dev/stderr";
	}

	hsuffix = $0;
	sub(/^@@.*@@/, "@@", hsuffix);

	hlines = 0;
	hunk = 1;
	next;
}

(!hunk) || /^#/ {
	print;
	next;
}

/^-/ {
	hdel++;
	hsrc_count++;
}

/^+/ {
	hadd++;
	hdest_count++;
}

/^ / {
	hunchanged++;
	hsrc_count++;
	hdest_count++;
}

/^$/ || /^[^-+ ]/ {
	fflush();
	printf("%s %d: Warning: badly formatted line\n",
		FILENAME, FNR) > "/dev/stderr";
	exit(255);
##	hadd++;
##	hdest_count++;
#	next;
}

{
	hline[hlines++] = $0;
}

END {
	dump_hunk()
}
' "$src" > "$tmp" && mv "$tmp" "$dest"

--------------000008000607080002000107--
