From: Jon Nelson <jnelson@jamponi.net>
Subject: unable to run gc (or git repack -Adl )
Date: Fri, 29 Jan 2010 16:29:01 -0600
Message-ID: <cccedfc61001291429q7dfa2045x18134439ad1e7c94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 23:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NazLV-0004GS-Ht
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab0A2W3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905Ab0A2W3Y
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:29:24 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41730 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab0A2W3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:29:22 -0500
Received: by ewy19 with SMTP id 19so124666ewy.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 14:29:21 -0800 (PST)
Received: by 10.216.89.149 with SMTP id c21mr484664wef.224.1264804161128; Fri, 
	29 Jan 2010 14:29:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138388>

Using 1.6.4.2 on openSUSE 11.2 (x86_64).

I have a beefy repo (du of 14GB) that I can't seem to run 'gc' on.

After running for over 2 hours, this is what I get:

Counting objects: 267676, done.
Compressing objects: 100% (217424/217424), done.
fatal: Unable to create temporary file: Too many open files
error: failed to run repack

Ugh!

I have 3 GB of memory (and 1GB of swap).
When I strace the various processes, I see some things I don't understand:

1. I see the 'git-repack' shell process scanning for .keep files. I
don't have any. Is there a shortcut to this?

It's also hugely inefficient. In this case, the code to identify non
.keep packs takes *4 minutes, 45 seconds*, lots of disk I/O, and lots
of CPU (it pegs one CPU at 100% for the entire duration). With a wee
bit of awk, I have reduced that to 2.3 seconds with VASTLY reduced I/O
and CPU requirements. Patch attached.

2. When git-pack-objects is being run, around the time it's 85% done
"compressing" it's very very very slow. Like, 2-5 objects every
second. The largest object in the repo is about 1MB.

3. When git pack objects is running and counting up the number of
objects, it is stat'ing files that aren't in the working directly, and
should not be, according to the index. If I switch the repo to be a
"bare" repository, then it doesn't do that, however, why is it doing
that in the first place?

4. Should git-pack-objects be reading the pack.idx files for counting
objects instead of the .pack files themselves?

5. There is no 5

6. Should git-pack-objects be closing .pack files after opening them?
I have 6559 .pack files.

7. Ultimately, how do I get "git gc" to work on this repo?


diff --git a/git-repack.sh b/git-repack.sh
index 1eb3bca..4358f96 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -62,15 +62,7 @@ case ",$all_into_one," in
 ,t,)
        args= existing=
        if [ -d "$PACKDIR" ]; then
-               for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
-                       | sed -e 's/^\.\///' -e 's/\.pack$//'`
-               do
-                       if [ -e "$PACKDIR/$e.keep" ]; then
-                               : keep
-                       else
-                               existing="$existing $e"
-                       fi
-               done
+        existing=$( find . -type f -name '*.pack' -o -name
'*.pack.keep' | sed -e 's/^\.\///' | sort | awk '{ if ($0 ~ /\.keep$/)
{ N=substr($0, 0, length($0)-5); K[N]=0; } else { K[$0]=1; } } END {
for (k in K) { if (K[k] == 1) { printf "%s ", k; } } } ' )
                if test -n "$existing" -a -n "$unpack_unreachable" -a \
                        -n "$remove_redundant"
                then



-- 
Jon
