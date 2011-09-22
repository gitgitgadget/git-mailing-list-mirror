From: Alexander Pepper <pepper@inf.fu-berlin.de>
Subject: Re: Bug: git log --numstat counts wrong
Date: Thu, 22 Sep 2011 15:19:39 +0200
Message-ID: <FAB0B05E-6BAD-488C-8478-F4B80493FB96@inf.fu-berlin.de>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de> <7vr53a2icn.fsf@alter.siamese.dyndns.org> <3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de> <7vobyd1vmo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 15:19:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6jBt-00027S-Hz
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 15:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab1IVNTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 09:19:44 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:40264 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752099Ab1IVNTn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 09:19:43 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1R6jBj-0007y2-Kc>; Thu, 22 Sep 2011 15:19:39 +0200
Received: from 91-66-162-110-dynip.superkabel.de ([91.66.162.110] helo=[10.1.17.174])
          by inpost2.zedat.fu-berlin.de (Exim 4.69)
          with esmtpsa
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1R6jBj-00055q-GG>; Thu, 22 Sep 2011 15:19:39 +0200
In-Reply-To: <7vobyd1vmo.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
X-Originating-IP: 91.66.162.110
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181895>

Am 21.09.2011 um 22:35 schrieb Junio C Hamano:
> That's a tad old master you seem to have.
Up until now I only followed the github clone, but that seems to be dated. Since kernel.org is still down, I'll now follow the google code clone.


Am 21.09.2011 um 22:35 schrieb Junio C Hamano:
>> Am 21.09.2011 um 14:24 schrieb Junio C Hamano:
>>>> $ git log --numstat 48a07e7e533f507228e8d1c99d4d48e175e14260
>>>> [...]
>>>> 11      10      src/java/voldemort/server/storage/StorageService.java
>>> 
>>> Didn't we update it this already? I seem to get 10/9 here not 11/10.
>> 
>> Current 'maint' (cd2b8ae9), 'master' (4b5eac7f)...
> 
> Strangely, bisection points at 27af01d5523, which was supposed to be only
> about performance and never about correctness. There is something fishy
> going on....
I also did some tests, and besides --numstat also git show sometimes show different patches in comparison to older git versions. The last version with the "old" git show output is 1.7.7.rc0 and the first version with the "new" git show output is 1.7.7.rc1.

with git version 1.7.7.rc0:
$ git show 679e1d5cd007a0a9cb2813bd155622d7a1e904bd :
[...]
diff --git a/src/java/voldemort/store/stats/RequestCounter.java b/src/java/voldemort/store/stats/RequestCounter.java
index b012e98..c6be603 100644
--- a/src/java/voldemort/store/stats/RequestCounter.java
+++ b/src/java/voldemort/store/stats/RequestCounter.java
@@ -64,16 +64,21 @@ public class RequestCounter {
         Accumulator accum = values.get();
         long now = System.currentTimeMillis();
 
-        if(now - accum.startTimeMS > durationMS) {
-            Accumulator newWithTotal = accum.newWithTotal();
-            values.set(newWithTotal);
-
-            /*
-             * try to set.  if we fail, then someone else set it, so just keep going
-             */
-            if(values.compareAndSet(accum, newWithTotal)) {
-                return newWithTotal;
-            }
+        /*
+         *  if still in the window, just return it
+         */
+        if(now - accum.startTimeMS <= durationMS) {
+            return accum;
+        }
+
+        /*
+         * try to set.  if we fail, then someone else set it, so just return that new one
+         */
+
+        Accumulator newWithTotal = accum.newWithTotal();
+
+        if(values.compareAndSet(accum, newWithTotal)) {
+            return newWithTotal;
         }
 
         return values.get();


with git version 1.7.7.rc1:
$ git show 679e1d5cd007a0a9cb2813bd155622d7a1e904bd
[...]
diff --git a/src/java/voldemort/store/stats/RequestCounter.java b/src/java/voldemort/store/stats/RequestCounter.java
index b012e98..c6be603 100644
--- a/src/java/voldemort/store/stats/RequestCounter.java
+++ b/src/java/voldemort/store/stats/RequestCounter.java
@@ -64,16 +64,21 @@ public class RequestCounter {
         Accumulator accum = values.get();
         long now = System.currentTimeMillis();
 
-        if(now - accum.startTimeMS > durationMS) {
-            Accumulator newWithTotal = accum.newWithTotal();
-            values.set(newWithTotal);
+        /*
+         *  if still in the window, just return it
+         */
+        if(now - accum.startTimeMS <= durationMS) {
+            return accum;
+        }
 
-            /*
-             * try to set.  if we fail, then someone else set it, so just keep going
-             */
-            if(values.compareAndSet(accum, newWithTotal)) {
-                return newWithTotal;
-            }
+        /*
+         * try to set.  if we fail, then someone else set it, so just return that new one
+         */
+
+        Accumulator newWithTotal = accum.newWithTotal();
+
+        if(values.compareAndSet(accum, newWithTotal)) {
+            return newWithTotal;
         }
 
         return values.get();


The difference is, that now it's shown as two delete and two added hunks instead of one bigger delete and one bigger added hunk.

with git version 1.7.7.rc1:
$ git show 679e1d5cd007a0a9cb2813bd155622d7a1e904bd | diffstat
 RequestCounter.java |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

with git version 1.7.7.rc0:
$ git show 679e1d5cd007a0a9cb2813bd155622d7a1e904bd | diffstat
 RequestCounter.java |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

When used git version 1.7.7.rc1 I didn't observed any case where git show and git log --numstat mismatch. I'm only a little confused, that 'git show' yields different results, depending on the git version.

Greetings from Berlin
Alex