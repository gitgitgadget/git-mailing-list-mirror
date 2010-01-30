From: Jon Nelson <jnelson@jamponi.net>
Subject: Re: unable to run gc (or git repack -Adl )
Date: Fri, 29 Jan 2010 20:45:55 -0600
Message-ID: <cccedfc61001291845n5703b606icb75bb2093ae51b2@mail.gmail.com>
References: <cccedfc61001291429q7dfa2045x18134439ad1e7c94@mail.gmail.com> 
	<alpine.LFD.2.00.1001292025260.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Jan 30 03:46:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb3Lq-0006FU-Sf
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 03:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195Ab0A3CqR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 21:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756193Ab0A3CqR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 21:46:17 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42504 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192Ab0A3CqR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 21:46:17 -0500
Received: by ewy19 with SMTP id 19so127001ewy.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 18:46:15 -0800 (PST)
Received: by 10.216.89.130 with SMTP id c2mr952674wef.44.1264819575149; Fri, 
	29 Jan 2010 18:46:15 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001292025260.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138429>

On Fri, Jan 29, 2010 at 8:14 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Fri, 29 Jan 2010, Jon Nelson wrote:
=2E..
>> 1. I see the 'git-repack' shell process scanning for .keep files. I
>> don't have any. Is there a shortcut to this?
>>
>> It's also hugely inefficient. In this case, the code to identify non
>> .keep packs takes *4 minutes, 45 seconds*, lots of disk I/O, and lot=
s
>> of CPU (it pegs one CPU at 100% for the entire duration). With a wee
>> bit of awk, I have reduced that to 2.3 seconds with VASTLY reduced I=
/O
>> and CPU requirements. Patch attached.
>
> Your patch will pick any .pack file in the repo not only from the
> .git/objects/pack directory. =A0There is no such thing as *.pack.keep
> either.

Ugh. Yep. Patch amended. Still fast. Still wrong?

>> 3. When git pack objects is running and counting up the number of
>> objects, it is stat'ing files that aren't in the working directly, a=
nd
>> should not be, according to the index. If I switch the repo to be a
>> "bare" repository, then it doesn't do that, however, why is it doing
>> that in the first place?
>
> A bare repository has no index. =A0When the index is present though, =
it is
> necessary to also pack objects it references. =A0Why working director=
y
> files would be stat()'d in that case I don't know.

Inquiring minds want to know.

>> 4. Should git-pack-objects be reading the pack.idx files for countin=
g
>> objects instead of the .pack files themselves?
>
> No. =A0The whole point when "counting objects" is to perform a walk o=
f the
> history graph and capture the set of objects that are actually
> referenced from your branches/tags and leave the unreferenced objects
> behind. =A0Also the order in which those objects are encountered duri=
ng
> that history walk is very important for efficient object placement in
> the final pack. =A0So this is much more involved than only listing th=
e
> objects contained in every packs.

Ah. For some reason I thought the .idx files contained not just a
straight listing but also the parent/child relationships as well.

> You could try:
>
> =A0 =A0 =A0 =A0git config core.packedGitLimit 256m
> =A0 =A0 =A0 =A0git config core.packedGitWindowSize 32m
> =A0 =A0 =A0 =A0git config pack.deltaCacheSize 1
>
> and try repacking again with 'git gc --prune=3Dnow'. =A0After the rep=
ack
> succeeds, you should be able to remove the above configs from your
> .git/config file.

I have since thrown out the repo and started over on this particular
experiment, issuing a 'git gc' rather more often. The config options
above are now dutifully scribbled down.  Thanks!

diff --git a/git-repack.sh b/git-repack.sh
index 1eb3bca..3cef57d 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -62,15 +62,7 @@ case ",$all_into_one," in
 ,t,)
        args=3D existing=3D
        if [ -d "$PACKDIR" ]; then
-               for e in `cd "$PACKDIR" && find . -type f -name '*.pack=
' \
-                       | sed -e 's/^\.\///' -e 's/\.pack$//'`
-               do
-                       if [ -e "$PACKDIR/$e.keep" ]; then
-                               : keep
-                       else
-                               existing=3D"$existing $e"
-                       fi
-               done
+               existing=3D$( cd "$PACKDIR" && find . -type f -name
'*.pack' -o -name '*.keep' | sed -e 's/^\.\///' | sort | awk '{ if ($0
~ /\.keep$/) { N=3Dsubstr($0, 0, length($0)-4) "pack"; K[N]=3D0; } else=
 {
if ($0 in K) { } else { K[$0]=3D1; } } } END { for (k in K) { if (K[k]
=3D=3D 1) { printf "%s ", k; } } } ' )
                if test -n "$existing" -a -n "$unpack_unreachable" -a \
                        -n "$remove_redundant"
                then


--=20
Jon
