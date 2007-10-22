From: "Andy C" <andychup@gmail.com>
Subject: Linear time/space rename logic for *inexact* case
Date: Mon, 22 Oct 2007 02:40:08 -0700
Message-ID: <596909b30710220240g665054d8hc40bc5d2234ba9e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14029_12972704.1193046008995"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 11:40:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijtlq-0007YW-82
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 11:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbXJVJkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 05:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbXJVJkN
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 05:40:13 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:36580 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbXJVJkK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 05:40:10 -0400
Received: by py-out-1112.google.com with SMTP id u77so2327384pyb
        for <git@vger.kernel.org>; Mon, 22 Oct 2007 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=uFkJh64IrAGgpY3TVjiKPLVo4rlKW0DtXYFk+qijxXw=;
        b=ng6gXLhJVKNxhE3oR+Ns7vIzng8APdWNkLWVw9gh1mPqz3jyMNZsvp5LFIqtBcO/ctO8hYAfsbOhTP/DSAxmN0TxYYcie49cblZdFD7knP//ixS6YLsqloqR8AeyF3F98eFxxWCpJw1iEJrSP7Hi09/hwi0ACXGWhhA1iMv6XBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=PORPJl6D9LwGN1YxLOAb/RYhXGXXCfs1ick3+44YMUYXStaWA+lx9CykYK9oRfcnFGw6SLqmMRdy4j7EP4V6s5sgHyXvJPV7du42I/wd7vlV0wR0Ac1Gi0ZnZAnfgM7zHa8lCfjH8JUn4EVqHQWuU9dCpt7RvrIumi4cyereOxo=
Received: by 10.35.131.13 with SMTP id i13mr5900506pyn.1193046009018;
        Mon, 22 Oct 2007 02:40:09 -0700 (PDT)
Received: by 10.35.91.3 with HTTP; Mon, 22 Oct 2007 02:40:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61975>

------=_Part_14029_12972704.1193046008995
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I just subscribed to this list, so sorry I can't respond to the
threads already started here.  I'm the guy that was mailing Linus
about this algorithm to do similarity detection in linear time,
mentioned here:

Subject:    [PATCH] Split out "exact content match" phase of rename detection
http://marc.info/?l=git&m=119299209323278&w=2

Subject:    [PATCH, take 1] Linear-time/space rename logic (exact renames
http://marc.info/?l=git&m=119301122908852&w=2


Jeff, in this message http://marc.info/?l=git&m=119303566130201&w=2 I
think you basically hit on the first half of what I was getting at.

The step 1 you describe is the first step of the algorithm -- make an
inverted index of lines (and you can use a hash code of the line to
stand in for the line).

To avoid the m*n memory usage of step 2, I use a hash table which maps
2-tuples to counts to represent the sparse similarity matrix, instead
of representing it directly.  The 2-tuple is a pair of filenames,
corresponding to the row/column of the matrix, and the counts/values
are the entries in the matrix.

You can also prune entries which have a long "postings list" (using
the term in the IR sense here:
http://www.xapian.org/docs/intro_ir.html).  This has the nice side
effect of getting rid of quadratic behavior, *and* making the
algorithm more accurate because it stops considering common lines like
"#endif" as contributing to similarity.

This pruning of common lines from the index makes step 3 linear.  In
fact, I prune the index to only include lines which occur just *once*.
 Nearly every line of code in real data sets is unique, so this works
well in practice.


I already sent this demo to Linus, but I think it's worth sending to
the list as well.  I am just going to copy parts of my earlier e-mails
below, and attach the same demos (hopefully it is kosher to send
attachments to this list).

Before I do that, Jeff, can you still reproduce this problem:

http://marc.info/?l=git&m=118975452330644&w=2
"Of course, 2 minutes for a git-status is still way too slow, so there we
might still need a limiter. It also looks like 57% of my time is spent
in spanhash_find, and another 29% in diffcore_count_changes."

I know there have been a couple fixes since you posted that, but if it
was the O(m*n) behavior that was causing your problem, it should still
be reproducible.  Linus suggested that this is a good data set to try
things out with.  Is there there a repository I can clone with git
commands to run to repro this?


OK, so attached is a little demo of the algorithm, which is (very
little) Python code, but with comments so non-Python people can
hopefully follow it.  Because of this the timings are not very
meaningful, but it proves that the algorithm doesn't blow up.

I ran it on the entire Linux 2.4 vs. Linux 2.6 codebases.  It is
*only* considering file content.  You can rename every file in both
source trees to completely random strings and it will still match
files up.  There is nothing about filenames, or identical files, and
you can consider the whole 2.4 side "all deletes" and the whole 2.6
side "all adds".  The size of the matrix would be around 286 million
cells, but here I only represent the non-zero entries in the matrix,
which is only 15,406 cells.

$ wc -l similarity_demo.py
233 similarity_demo.py

$ ./similarity_demo.py in-all-*
12697 * 22530 = 286063410 total possible pairs of files
Indexing the first set of 12697 files (threshold=1)
Indexing the second set of 22530 files (threshold=1)
Sum of file sizes in first set: 2134249 lines
Sum of file sizes in second set: 3424338 lines
Size of index over first set: 2134249
Size of index over second set: 3424338
Computing union of lines in the indices
Total unique lines in both indices: 4384375
Making sparse common line matrix
Calculating similarity for 15406 pairs of files
Sorting 15406 similar pairs
Writing similarity report
Wrote out-in-all-24-vs-in-all-26.1.txt
End
------
Report
------
Indexing the first set of 12697 files (threshold=1)          29.540s
Indexing the second set of 22530 files (threshold=1)         111.041s
Computing union of lines in the indices                      7.450s
Making sparse common line matrix                             13.468s
Calculating similarity for 15406 pairs of files              0.055s
Sorting 15406 similar pairs                                  0.030s
Writing similarity report                                    0.249s
Total time                                                   161.834s

The script outputs a text file with 15,406 similar pairs, in order of
similarity (1.0's are at the top):

andychu demo$ wc -l out-in-all-24-vs-in-all-26.1.txt
15406 out-in-all-24-vs-in-all-26.1.txt

andychu demo$ head -n3 out-in-all-24-vs-in-all-26.1.txt
(  51) linux-2.4.35.3/include/asm-m68k/apollodma.h
(  51) linux-2.6.23.1/include/asm-m68k/apollodma.h   51 1.000

(  94) linux-2.4.35.3/fs/jfs/jfs_btree.h
(  94) linux-2.6.23.1/fs/jfs/jfs_btree.h   94 1.000

(  21) linux-2.4.35.3/Documentation/fb/00-INDEX
(  21) linux-2.6.23.1/Documentation/fb/00-INDEX   21 1.000
...


And here is my explanation from an earlier mail, with some slight edits:

So the algorithm is:

1) Make an inverted index of the left set and right set.  That is {
line => ["postings list", i.e. the list of files the line appears in]
}.  To get rid of common lines like "} else {" or "#endif", there is
an arbitrary "line threshold".

2) Combine the 2 indices into a (sparse) rectangular matrix.  For each
line, iterate over all pairs in the postings list, and increment the
cell in the matrix for that pair by 1.  The index is extremely
shallow, since nearly all lines of code are unique.  The common case
is that the postings list is of length 1.  And the line threshold caps
the length of the postings list.

In the code the matrix represented by a hash of filename pairs to
integer counts.  So then the count is the number of lines that the 2
files have in common.

3) Compute the similarity metric, which I've defined here as
max(c/|left file|, c/|right file|), where c the entry in the matrix
for the file pair.  Note that the files are treated as *sets* of lines
(unordered, unique).  The similarity score is a number between 0.0 and
1.0.  Other similarity metrics are certainly possible.

A few things to notice about this algorithm:

* It takes advantage of the fact that code edits are typically
line-oriented, and nearly every line of code is unique.  (This same
technique can be used for arbitrary documents like English text, but
it's a bit harder since you basically have to find a way to make a
"deep" index of words shallow, to speed it up.  For code, the index of
lines is already shallow.)

* Some people might be concerned that it treats files as unordered
sets of lines.  The first thought might be to do this as a
preprocessing step to cull the list of candidates, and then do a real
delta.  But in my experience, I haven't encountered a case where
there's all that much to gain by doing that.

* The line_threshold might appear to be a hack, but it actually
*improves* accuracy.  If you think about it, lines like "#endif"
should not contribute to the similarity between 2 files.  It also
makes it impossible to construct pathological blow-up cases.  If you
have 1000 files on the left and 1000 files on the right that are all
identical to each other, then every line will get pruned, and thus the
entire similarity matrix will be 0, which is arguably what you want.
There is a -l flag to the script to experiment with this threshold.

* This can be run on all files, not just adds/deletes.  If I have a
change of only edits, it could be the case that I moved 500 lines from
one file 1000 line file to another 1000 line file, and changed 75
lines within the 500.  It would be meaningful to see a diff in this
case, so that I can see those 75 edits (and a great feature!)

* The similarity is defined that way so that if one file is completely
contained in another, the similarity is 1.0.  So if I move a 1000 line
file and add 9,000 lines to it, the similarity for the file pair will
still be 1.0.  I believe this is a feature, like the point above.

* I don't have a C implementation but I believe the constant factors
should be very low.  You could use the same CRC you were talking about
to reduce memory in storing the lines.  It seems like this algorithm
is amenable to trading memory for speed, as you mention.  Since it is
raw string manipulation, C should be at least 10x faster than Python,
and I wouldn't be surprised if an optimized implementation is 50 or
100x faster.

...

If anything about the explanation is unclear, let me know and I will
try to clarify it.  Playing around with the demo should illuminate
what it does.  You can run it on data sets of your own.  All you need
is 2 source trees and the "find" command to produce input to the
script (see setup_demo.sh).

As mentioned, I will try to do some tests on this, perhaps with Jeff's
hard data set, and show that the results are good and that the
algorithm is faster because the quadratic behavior is gone (if Linus
doesn't beat me to it!).

thanks,
Andy

------=_Part_14029_12972704.1193046008995
Content-Type: application/x-sh; name=setup_demo.sh
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f82sbl6e
Content-Disposition: attachment; filename=setup_demo.sh

IyEvYmluL2Jhc2gKIwojIFNldCB1cCBkYXRhIGZpbGVzIGZvciBzaW1pbGFyaXR5X2RlbW8ucHkK
CndnZXQgaHR0cDovL2tlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92Mi40L2xpbnV4LTIuNC4z
NS4zLnRhci5iejIKd2dldCBodHRwOi8va2VybmVsLm9yZy9wdWIvbGludXgva2VybmVsL3YyLjYv
bGludXgtMi42LjIzLjEudGFyLmJ6MgoKdGFyIHh2ZmogbGludXgtMi40LjM1LjMudGFyLmJ6Mgp0
YXIgeHZmaiBsaW51eC0yLjYuMjMuMS50YXIuYnoyCgpmaW5kIGxpbnV4LTIuNC4zNS4zL2tlcm5l
bC8gLXR5cGUgZiA+IGluLWtlcm5lbC0yNC50eHQKZmluZCBsaW51eC0yLjYuMjMuMS9rZXJuZWwv
IC10eXBlIGYgPiBpbi1rZXJuZWwtMjYudHh0CgpmaW5kIGxpbnV4LTIuNC4zNS4zL2ZzLyAtdHlw
ZSBmID4gaW4tZnMtMjQudHh0CmZpbmQgbGludXgtMi42LjIzLjEvZnMvIC10eXBlIGYgPiBpbi1m
cy0yNi50eHQKCmZpbmQgbGludXgtMi40LjM1LjMvIC10eXBlIGYgPiBpbi1hbGwtMjQudHh0CmZp
bmQgbGludXgtMi42LjIzLjEvIC10eXBlIGYgPiBpbi1hbGwtMjYudHh0CgouL3NpbWlsYXJpdHlf
ZGVtby5weSBpbi1rZXJuZWwtKgouL3NpbWlsYXJpdHlfZGVtby5weSBpbi1mcy0qCgojIFRyeSBh
IGhpZ2ggbGluZSB0aHJlc2hvbGQuICBQZXJoYXBzIHRoaXMgY291bGQgdXNlIHNvbWUgZXhwZXJp
bWVudGF0aW9uLiAgVGhlCiMgZGVmYXVsdCBvZiAxIHNlZW1zIHRvIHdvcmsgd2VsbCwgYW5kIGl0
IGlzIHRoZSBmYXN0ZXN0LiAgWW91IGdldCBtb3JlIGp1bmsgYXQKIyB0aGUgZW5kICh0cnkgd2Mg
LWwgb3V0LSopCi4vc2ltaWxhcml0eV9kZW1vLnB5IC1sMTAgaW4ta2VybmVsLSoKLi9zaW1pbGFy
aXR5X2RlbW8ucHkgLWwxMCBpbi1mcy0qCgojIFRoZXNlIHRha2UgfjMgbWludXRlcyBmb3IgbWUK
Iy4vc2ltaWxhcml0eV9kZW1vLnB5IGluLWFsbC0qCiMuL3NpbWlsYXJpdHlfZGVtby5weSAtbDEw
IGluLWFsbC0qCgoKCgo=
------=_Part_14029_12972704.1193046008995
Content-Type: text/x-python; name=similarity_demo.py
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f82sbxei
Content-Disposition: attachment; filename=similarity_demo.py

IyEvdXNyL2Jpbi9weXRob24yLjQKCiIiIgpEZW1vIG9mIGxpbmVhci10aW1lIGNvZGUgc2ltaWxh
cml0eSBjYWxjdWxhdGlvbi4KCkF1dGhvcjogQW5keSBDaHUgKGFuZHljaHUgYXQgZ29vZ2xlIGRv
dCBjb20pCiIiIgoKaW1wb3J0IG9wdHBhcnNlCmltcG9ydCBvcwppbXBvcnQgbWQ1CmltcG9ydCBy
ZQppbXBvcnQgc3lzCmltcG9ydCB0aW1lCmZyb20gcHByaW50IGltcG9ydCBwcHJpbnQKCgpjbGFz
cyBNdWx0aVRpbWVyOgogICIiIlRvIGdpdmUgYSBnZW5lcmFsIGlkZWEgb2YgaG93IGxvbmcgZWFj
aCBzdGVwIHRha2VzLiIiIgoKICBkZWYgX19pbml0X18oc2VsZiwgbG91ZD1GYWxzZSk6CiAgICBz
ZWxmLnRpbWVzdGFtcHMgPSBbXQogICAgc2VsZi5kZXNjcmlwdGlvbnMgPSBbXQoKICBkZWYgY2hl
Y2twb2ludChzZWxmLCBkZXNjcmlwdGlvbj0nJyk6CiAgICBwcmludCBkZXNjcmlwdGlvbgogICAg
c2VsZi50aW1lc3RhbXBzLmFwcGVuZCh0aW1lLnRpbWUoKSkKICAgIHNlbGYuZGVzY3JpcHRpb25z
LmFwcGVuZChkZXNjcmlwdGlvbikKCiAgZGVmIHJlcG9ydChzZWxmKToKICAgIHByaW50ICItLS0t
LS0iCiAgICBwcmludCAiUmVwb3J0IgogICAgcHJpbnQgIi0tLS0tLSIKCiAgICAjIENvbXB1dGUg
dGltZSBkaWZmZXJlbmNlcwogICAgZm9ybWF0ID0gIiUtNjBzICUuM2ZzIgogICAgZm9yIGkgaW4g
eHJhbmdlKGxlbihzZWxmLnRpbWVzdGFtcHMpLTEpOgogICAgICBpbnRlcnZhbCA9IHNlbGYudGlt
ZXN0YW1wc1tpKzFdIC0gc2VsZi50aW1lc3RhbXBzW2ldCiAgICAgIHByaW50IGZvcm1hdCAlIChz
ZWxmLmRlc2NyaXB0aW9uc1tpXSwgaW50ZXJ2YWwpCiAgICBwcmludCBmb3JtYXQgJSAoJ1RvdGFs
IHRpbWUnLCBzZWxmLnRpbWVzdGFtcHNbLTFdIC0gc2VsZi50aW1lc3RhbXBzWzBdKQoKCmRlZiBJ
bmRleEZpbGVzKGZpbGVzLCBsaW5lX3RocmVzaG9sZCk6CiAgIiIiCiAgR2l2ZW4gYSBsaXN0IG9m
IGZpbGVuYW1lcywgcHJvZHVjZSBhbiBpbnZlcnRlZCBpbmRleC4KICAKICBBbnkgbGluZXMgd2hp
Y2ggb2NjdXIgaW4gImxpbmVfdGhyZXNob2xkIiBmaWxlcyBhcmUgdGhyb3duIG91dC4KCiAgQWxz
bywgZm9yIHNpbWlsYXJpdHkgc2NvcmluZywga2VlcCB0cmFjayBvZiB0aGUgbnVtYmVyIG9mIGlt
cG9ydGFudCBsaW5lcyBpbgogIGVhY2ggZmlsZS4gIEZpbGVzIGFyZSB0cmVhdGVkIGFzICh1bm9y
ZGVyZWQpICpzZXRzKiBvZiAodW5pcXVlKSBsaW5lcy4KICBVbmltcG9ydGFudCBsaW5lcyBhcmUg
ZHVwbGljYXRlcyBhbmQgbGluZXMgd2hpY2ggZXhjZWVkIGxpbmVfdGhyZXNob2xkLgogICIiIgog
ICMgeyBsaW5lIC0+IGxpc3Qgb2YgZmlsZW5hbWVzIHRoZSBsaW5lIGFwcGVhcnMgaW4gfQogIGlu
ZGV4ID0ge30gIAogICMgeyBmaWxlbmFtZSAtPiBudW1iZXIgb2YgdW5pcXVlIGxpbmVzIGluIHRo
ZSBmaWxlIH0KICBzaXplcyA9IHt9CgogIGZvciBmaWxlbmFtZSBpbiBmaWxlczoKICAgIHRyeToK
ICAgICAgZiA9IGZpbGUoZmlsZW5hbWUpCiAgICBleGNlcHQgSU9FcnJvciwgZToKICAgICAgcHJp
bnQgZSwgZmlsZW5hbWUKICAgICAgc3lzLmV4aXQoMSkKCiAgICBmb3IgbGluZSBpbiBmOgogICAg
ICBsaW5lID0gbGluZS5zdHJpcCgpICAjIENvdWxkIHJlbW92ZSAqYWxsKiB3aGl0ZXNwYWNlIGhl
cmUKICAgICAgaWYgbGluZTogICMgU2tpcCBibGFuayBsaW5lcwogICAgICAgIGlmIGxpbmUgaW4g
aW5kZXg6CiAgICAgICAgICBmaWxlbGlzdCA9IGluZGV4W2xpbmVdCiAgICAgICAgICAjIFN0b3Ag
a2VlcGluZyB0cmFjayBvbmNlIHdlIHJlYWNoIHRoZSB0aHJlc2hvbGQKICAgICAgICAgIGlmIGxl
bihmaWxlbGlzdCkgPT0gbGluZV90aHJlc2hvbGQgKyAxOgogICAgICAgICAgICBjb250aW51ZQog
ICAgICAgICAgIyBPbmx5IGNvdW50IHRoZSBmaXJzdCBvY2N1cnJlbmNlIG9mIHRoZSBsaW5lIGlu
IHRoZSBmaWxlCiAgICAgICAgICBpZiBmaWxlbGlzdFstMV0gIT0gZmlsZW5hbWU6CiAgICAgICAg
ICAgIGZpbGVsaXN0LmFwcGVuZChmaWxlbmFtZSkKICAgICAgICAgICAgc2l6ZXNbZmlsZW5hbWVd
ID0gc2l6ZXMuZ2V0KGZpbGVuYW1lLCAwKSArIDEKICAgICAgICBlbHNlOgogICAgICAgICAgaW5k
ZXhbbGluZV0gPSBbZmlsZW5hbWVdCiAgICAgICAgICBzaXplc1tmaWxlbmFtZV0gPSBzaXplcy5n
ZXQoZmlsZW5hbWUsIDApICsgMQogICAgZi5jbG9zZSgpCgogICMgTm93IHJlbW92ZSBhbnkgbGlu
ZXMgdGhhdCBoaXQgdGhlIHRocmVzaG9sZCBmcm9tIHRoZSBpbmRleCwgYW5kIGFkanVzdCB0aGUK
ICAjIGZpbGUgc2l6ZXMuCiAgdG9fcmVtb3ZlID0gW10KICBmb3IgbGluZSwgZmlsZWxpc3QgaW4g
aW5kZXguaXRlcml0ZW1zKCk6CiAgICBpZiBsZW4oZmlsZWxpc3QpID09IGxpbmVfdGhyZXNob2xk
ICsgMToKICAgICAgdG9fcmVtb3ZlLmFwcGVuZChsaW5lKQogICAgICBmb3IgZiBpbiBmaWxlbGlz
dDoKICAgICAgICBzaXplc1tmXSAtPSAxCiAgZm9yIGxpbmUgaW4gdG9fcmVtb3ZlOgogICAgZGVs
IGluZGV4W2xpbmVdCgogIHJldHVybiBpbmRleCwgc2l6ZXMKCgpkZWYgRmluZFNpbWlsYXJQYWly
cyhzZXQxLCBzZXQyLCByZXBvcnRmaWxlLCBsaW5lX3RocmVzaG9sZCk6CiAgIiIiQ2FsY3VsYXRl
cyBwYWlyd2lzZSBzaW1pbGFyaXR5IGJldHdlZW4gdHdvIHNldHMgb2YgZmlsZXMsIHVzaW5nIG5v
IG90aGVyCiAgaW5mb3JtYXRpb24gYnV0IHRoZSBjb250ZW50cyBvZiB0aGUgZmlsZXMgKGkuZS4g
bm8gZmlsZW5hbWUgaW5mb3JtYXRpb24pLgoKICBBcmdzOgogICAgc2V0MSwgc2V0MjogVGhlIDIg
bGlzdHMgb2YgZmlsZSBzeXN0ZW0gcGF0aHMgdG8gY29tcGFyZS4KICAgIHJlcG9ydGZpbGU6IG5h
bWUgb2YgdGhlIG91dHB1dCB0ZXh0IGZpbGUKICAgIGxpbmVfdGhyZXNob2xkOgogICAgICBXZSBw
cnVuZSB0aGUgaW5kZXggb2YgZW50cmllcyB0aGF0IG9jY3VyIG1vcmUgdGhhbiB0aGlzIG51bWJl
ciBvZiB0aW1lcy4KICAgICAgRm9yIGV4YW1wbGUsIHRoZSBsaW5lICJ9IGVsc2UgeyIgbWF5IG9j
Y3VyIHZlcnkgZnJlcXVlbnRseSBpbiB0aGUgY29kZSwKICAgICAgYnV0IHdlIGp1c3QgdGhyb3cg
aXQgb3V0LCBzaW5jZSB0aGUgZmFjdCB0aGF0IDIgZmlsZXMgaGF2ZSB0aGlzIGxpbmUgaW4KICAg
ICAgY29tbW9uIGlzIG5vdCB2ZXJ5IG1lYW5pbmdmdWwuCiAgICAgIAogICAgICBNYWtpbmcgbGlu
ZV90aHJlc2hvbGQgYSBjb25zdGFudCBhbHNvIG1ha2VzIHRoZSBhbGdvcml0aG0gbGluZWFyLiAg
SW4KICAgICAgcHJhY3RpY2UsIHdpdGggcmVhbCBkYXRhIHNldHMsIHRoZSByZXN1bHRzIHNob3Vs
ZCBiZSBxdWl0ZSBzdGFibGUgd2l0aAogICAgICByZXNwZWN0IHRvIHRoaXMgcGFyYW1ldGVyLiAg
VGhhdCBpcywgdGhleSBzaG91bGQgbm90IHZhcnkgdmVyeSBtdWNoIGF0CiAgICAgIGFsbCBpZiBs
aW5lX3RocmVzaG9sZCA9IDEgb3IgMTAwIG9yIDEwMDAuCiAgIiIiCiAgbXQgPSBNdWx0aVRpbWVy
KCkKCiAgcHJpbnQgJyVzICogJXMgPSAlcyB0b3RhbCBwb3NzaWJsZSBwYWlycyBvZiBmaWxlcycg
JSAoCiAgICAgIGxlbihzZXQxKSwgbGVuKHNldDIpLCBsZW4oc2V0MSkgKiBsZW4oc2V0MikpCgog
ICMKICAjIDEuIEdlbmVyYXRlIGludmVydGVkIGluZGljZXMgYW5kIHNpemUgaW5mb3JtYXRpb24g
Zm9yIGVhY2ggc2V0LgogICMKICBtdC5jaGVja3BvaW50KCJJbmRleGluZyB0aGUgZmlyc3Qgc2V0
IG9mICVkIGZpbGVzICh0aHJlc2hvbGQ9JWQpIiAlICgKICAgIGxlbihzZXQxKSwgbGluZV90aHJl
c2hvbGQpKQogIGluZGV4MSwgc2l6ZXMxID0gSW5kZXhGaWxlcyhzZXQxLCBsaW5lX3RocmVzaG9s
ZCkKCiAgbXQuY2hlY2twb2ludCgiSW5kZXhpbmcgdGhlIHNlY29uZCBzZXQgb2YgJWQgZmlsZXMg
KHRocmVzaG9sZD0lZCkiICUgKAogICAgbGVuKHNldDIpLCBsaW5lX3RocmVzaG9sZCkpCiAgaW5k
ZXgyLCBzaXplczIgPSBJbmRleEZpbGVzKHNldDIsIGxpbmVfdGhyZXNob2xkKQoKICBwcmludCAi
U3VtIG9mIGZpbGUgc2l6ZXMgaW4gZmlyc3Qgc2V0OiAlcyBsaW5lcyIgJSBzdW0oc2l6ZXMxLnZh
bHVlcygpKQogIHByaW50ICJTdW0gb2YgZmlsZSBzaXplcyBpbiBzZWNvbmQgc2V0OiAlcyBsaW5l
cyIgJSBzdW0oc2l6ZXMyLnZhbHVlcygpKQogIHByaW50ICJTaXplIG9mIGluZGV4IG92ZXIgZmly
c3Qgc2V0OiIsIGxlbihpbmRleDEpCiAgcHJpbnQgIlNpemUgb2YgaW5kZXggb3ZlciBzZWNvbmQg
c2V0OiIsIGxlbihpbmRleDIpCgogICMKICAjIDIuIENvbWJpbmUgdGhlIDIgaW5kaWNlcyB0byBm
b3JtIHNwYXJzZSBtYXRyaXggdGhhdCBjb3VudHMgY29tbW9uIGxpbmVzLgogICMKICAjIFBhaXJz
IHdoaWNoIGRvIG5vdCBhcHBlYXIgaGF2ZSBhbiBpbXBsaWNpdCBjb3VudCBvZiAwLgogICMKICAj
IFRoaXMgaXMgYSBzcGFyc2UgbWF0cml4IHJlcHJlc2VudGVkIGFzIGEgZGljdGlvbmFyeSBvZiAy
LXR1cGxlczoKICAjIChmaWxlbmFtZSAjIGluIHNldDEsIGZpbGVuYW1lIGluIHNldDIpIC0+IG51
bWJlciBvZiAodW5pcXVlKSBsaW5lcyB0aGF0CiAgIyB0aGV5IGhhdmUgaW4gY29tbW9uCgogIG10
LmNoZWNrcG9pbnQoIkNvbXB1dGluZyB1bmlvbiBvZiBsaW5lcyBpbiB0aGUgaW5kaWNlcyIpCiAg
YWxsX2xpbmVzID0gc2V0KGluZGV4MSkgfCBzZXQoaW5kZXgyKQogIHByaW50ICdUb3RhbCB1bmlx
dWUgbGluZXMgaW4gYm90aCBpbmRpY2VzOiAlcycgJSBsZW4oYWxsX2xpbmVzKQoKICBtdC5jaGVj
a3BvaW50KCJNYWtpbmcgc3BhcnNlIGNvbW1vbiBsaW5lIG1hdHJpeCIpCgogIG1hdHJpeCA9IHt9
CiAgZm9yIGxpbmUgaW4gYWxsX2xpbmVzOgogICAgZmlsZXMxID0gaW5kZXgxLmdldChsaW5lKQog
ICAgZmlsZXMyID0gaW5kZXgyLmdldChsaW5lKQogICAgaWYgZmlsZXMxIGFuZCBmaWxlczI6CiAg
ICAgICMgRm9yIGV2ZXJ5IHBhaXIgb2YgZmlsZXMgdGhhdCBjb250YWluIHRoaXMgbGluZSwgaW5j
cmVtZW50IHRoZQogICAgICAjIGNvcnJlc3BvbmRpbmcgY2VsbCBpbiB0aGUgY29tbW9uIGxpbmUg
bWF0cml4LiAgCiAgICAgICMKICAgICAgIyBTaW5jZSB3ZSBwcnVuZWQgdGhlIGluZGV4LCB0aGlz
IHdob2xlIGRvdWJsZSBsb29wIGlzIGNvbnN0YW50IHRpbWUuICBJZgogICAgICAjIHRoZSBsaW5l
X3RocmVzaG9sZCBpcyAxIChkZWZhdWx0KSwgdGhlbiB0aGUgd2hvbGUgdGhpbmcgaXMganVzdCBh
CiAgICAgICMgc2luZ2xlIGl0ZXJhdGlvbi4gIAogICAgICBmb3IgZjEgaW4gZmlsZXMxOgogICAg
ICAgIGZvciBmMiBpbiBmaWxlczI6CiAgICAgICAgICBtYXRyaXhbKGYxLCBmMildID0gbWF0cml4
LmdldCgoZjEsIGYyKSwgMCkgKyAxCgogIG10LmNoZWNrcG9pbnQoIkNhbGN1bGF0aW5nIHNpbWls
YXJpdHkgZm9yICVzIHBhaXJzIG9mIGZpbGVzIiAlIGxlbihtYXRyaXgpKQoKICAjCiAgIyAzLiBD
YWxjdWxhdGUgdGhlIHNpbWlsYXJpdHkgb2YgZWFjaCBjZWxsIGluIHRoZSBtYXRyaXguCiAgIwog
ICMgVGhlIHNpbWlsYXJpdHkgbWV0cmljIGlzIG51bWJlciBvZiBjb21tb24gbGluZXMgZGl2aWRl
ZCBieSB0aGUgZmlsZSBzaXplCiAgIyAoYW5kIHRha2UgdGhlIGdyZWF0ZXIgb2YgdGhlIDIpLiAg
Tm90ZSB0aGF0IHRoaXMgbWVhbnMgdGhhdCBpZiBmaWxlMSBpcwogICMgZW50aXJlbHkgKmNvbnRh
aW5lZCogaW4gZmlsZTIsIHRoZW4gdGhlIHNpbWlsYXJpdHkgb2YgdGhlIHBhaXIgd2lsbCBiZSAx
LjAuCiAgIyBUaGlzIGlzIGRlc2lyYWJsZSBzaW5jZSB5b3UgY2FuIGRldGVjdCBpZiA5OSwwMDAg
bGluZXMgd2VyZSBhZGRlZCB0byBhIDEsMDAwCiAgIyBsaW5lIGZpbGUsIGV0Yy4gIE90aGVyIHNp
bWlsYXJpdHkgbWV0cmljcyBhcmUgcG9zc2libGUuCiAgIwogIHNpbWlsYXJfcGFpcnMgPSBbXQog
IGZvciAoZmlsZTEsIGZpbGUyKSwgbnVtX2NvbW1vbiBpbiBtYXRyaXguaXRlcml0ZW1zKCk6CiAg
ICBjID0gZmxvYXQobnVtX2NvbW1vbikKICAgICMgVE9ETzogV3JpdGUgbm90ZXMgb24gc2ltaWxh
cml0eSBtZXRyaWMKICAgIHNpbWlsYXJpdHkgPSBtYXgoYyAvIHNpemVzMVtmaWxlMV0sIGMgLyBz
aXplczJbZmlsZTJdKQogICAgc2ltaWxhcl9wYWlycy5hcHBlbmQoKGZpbGUxLCBmaWxlMiwgbnVt
X2NvbW1vbiwgc2ltaWxhcml0eSkpCgogIG10LmNoZWNrcG9pbnQoIlNvcnRpbmcgJWQgc2ltaWxh
ciBwYWlycyIgJSBsZW4oc2ltaWxhcl9wYWlycykpCiAgc2ltaWxhcl9wYWlycy5zb3J0KGtleT1s
YW1iZGEgeDogeFszXSwgcmV2ZXJzZT1UcnVlKQoKICBtdC5jaGVja3BvaW50KCJXcml0aW5nIHNp
bWlsYXJpdHkgcmVwb3J0IikKICBmID0gb3BlbihyZXBvcnRmaWxlLCAndycpCiAgZm9yIGZpbGUx
LCBmaWxlMiwgbnVtX2NvbW1vbiwgc2ltaWxhcml0eSBpbiBzaW1pbGFyX3BhaXJzOgogICAgIyBQ
dXQgYSAqIGFmdGVyIGVudHJpZXMgd2hlcmUgdGhlIHJlbGF0aXZlIHBhdGhzIGFyZSAqbm90KiB0
aGUgc2FtZSwganVzdAogICAgIyBmb3IgY29udmVuaWVuY2Ugd2hlbiBsb29raW5nIGF0IHRoZSBy
ZXBvcnQuCiAgICBpZiBmaWxlMS5zcGxpdCgnLycpWzE6XSAhPSBmaWxlMi5zcGxpdCgnLycpWzE6
XToKICAgICAgbWFyayA9ICcqJwogICAgZWxzZToKICAgICAgbWFyayA9ICcnCgogICAgcHJpbnQg
Pj4gZiwgJyglNGQpICUtNDBzICglNGQpICUtNDBzICU0ZCAlLjNmICVzJyAlICgKICAgICAgICBz
aXplczFbZmlsZTFdLCBmaWxlMSwgc2l6ZXMyW2ZpbGUyXSwgZmlsZTIsIG51bV9jb21tb24sIHNp
bWlsYXJpdHksCiAgICAgICAgbWFyaykKICBmLmNsb3NlKCkKICBwcmludCAnV3JvdGUgJXMnICUg
cmVwb3J0ZmlsZQoKICBtdC5jaGVja3BvaW50KCJFbmQiKQogIG10LnJlcG9ydCgpCgoKaWYgX19u
YW1lX18gPT0gJ19fbWFpbl9fJzoKICBwYXJzZXIgPSBvcHRwYXJzZS5PcHRpb25QYXJzZXIoKQoK
ICBwYXJzZXIuYWRkX29wdGlvbigKICAgICAgJy1sJywgJy0tbGluZS10aHJlc2hvbGQnLCBkZXN0
PSdsaW5lX3RocmVzaG9sZCcsIHR5cGU9J2ludCcsIGRlZmF1bHQ9MSwKICAgICAgaGVscD0naWdu
b3JlIGxpbmVzIHRoYXQgb2NjdXIgbW9yZSB0aGFuIHRoaXMgbnVtYmVyIG9mIHRpbWVzIGluIGVp
dGhlciAnCiAgICAgICdzZXQnKQogIHBhcnNlci5hZGRfb3B0aW9uKAogICAgICAnLW8nLCAnLS1v
dXQnLCBkZXN0PSdyZXBvcnRmaWxlJywgZGVmYXVsdD1Ob25lLAogICAgICBoZWxwPSdXcml0ZSBv
dXRwdXQgdG8gdGhpcyBmaWxlIGluc3RlYWQgb2YgdGhlIGRlZmF1bHQuJykKCiAgKG9wdGlvbnMs
IGFyZ3YpID0gcGFyc2VyLnBhcnNlX2FyZ3MoKQoKICB0cnk6CiAgICBsZWZ0LCByaWdodCA9IGFy
Z3ZbOjJdCiAgZXhjZXB0IFZhbHVlRXJyb3I6CiAgICBwcmludCAnUGFzcyAyIGZpbGVzIGNvbnRh
aW5pbmcgcGF0aHMgYXMgYXJndW1lbnRzIChsZWZ0IHRyZWUsIHJpZ2h0IHRyZWUpLicKICAgIHN5
cy5leGl0KDEpCgogIGlmIG5vdCBvcHRpb25zLnJlcG9ydGZpbGU6CiAgICBvcHRpb25zLnJlcG9y
dGZpbGUgPSAnb3V0LSVzLXZzLSVzLiVzLnR4dCcgJSAoCiAgICAgICAgb3MucGF0aC5zcGxpdGV4
dChvcy5wYXRoLmJhc2VuYW1lKGxlZnQpKVswXSwKICAgICAgICBvcy5wYXRoLnNwbGl0ZXh0KG9z
LnBhdGguYmFzZW5hbWUocmlnaHQpKVswXSwKICAgICAgICBvcHRpb25zLmxpbmVfdGhyZXNob2xk
KQoKICBzZXQxID0gW2Yuc3RyaXAoKSBmb3IgZiBpbiBvcGVuKGxlZnQpLnJlYWRsaW5lcygpXQog
IHNldDIgPSBbZi5zdHJpcCgpIGZvciBmIGluIG9wZW4ocmlnaHQpLnJlYWRsaW5lcygpXQogIEZp
bmRTaW1pbGFyUGFpcnMoc2V0MSwgc2V0Miwgb3B0aW9ucy5yZXBvcnRmaWxlLCBvcHRpb25zLmxp
bmVfdGhyZXNob2xkKQo=
------=_Part_14029_12972704.1193046008995--
