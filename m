From: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [RFC] solving a bug with hunks starting at line 1 in git apply
Date: Mon, 01 Jun 2015 19:07:55 +0200
Message-ID: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 19:08:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTC6-0001TQ-SO
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbbFARIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 13:08:07 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:60479 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752259AbbFARIF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 13:08:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 233573624
	for <git@vger.kernel.org>; Mon,  1 Jun 2015 19:08:02 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 166uZpy9Eb0J for <git@vger.kernel.org>;
	Mon,  1 Jun 2015 19:08:02 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 03EDB35EC
	for <git@vger.kernel.org>; Mon,  1 Jun 2015 19:08:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id F046E20D8
	for <git@vger.kernel.org>; Mon,  1 Jun 2015 19:08:01 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uVfv6ahia21d for <git@vger.kernel.org>;
	Mon,  1 Jun 2015 19:08:01 +0200 (CEST)
Received: from Groseille (AGrenoble-652-1-368-161.w82-122.abo.wanadoo.fr [82.122.243.161])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 80C0C20A2
	for <git@vger.kernel.org>; Mon,  1 Jun 2015 19:08:01 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270439>


======================================================================
= 1. The bug
======================================================================

hunks of the form:

@@ -1,k +n,m @@

have a special behavior because of the variable match_begining.  For
these hunks, offset is not allowed which means that the fragment has to
match at the first line of the image. This is done for the sake of
safety (This behavior does not exist in the basic patch command). Here's
an example

first original file:

10
20
30
40

for the following diff file:

@@ -1,2 +1,2 @@
 20
-30
+35
 40

The patch will not be applied with a git apply command, but it will
with a basic patch command. However, there's no problem with the
following diff for both:

@@ -2,2 +2,2 @@
 10
-20
+25
 30

The problem comes when we have a diff file like that (which can be
obtained by splitting a hunk with git add -p for example (unsolved bug
reported in 1bf01040f0c1101f410f9caa5e715460cdd0cbe0))

@@ -1,1 +1,2 @@
+5
 10
@@ -1,3 +2,3 @@
 10
+15
-20
 30

In this case the first hunk will be treated, the image will then become

5
10
20
30

The second will try to match the lines

10
20
30

with the first lines of the image, will not succeed and will return that
it is not possible without trying to match the image with offsets,
because the hunk begin with 1.

Moreover, there are cases where both the git apply and the
patch command will work, giving different outputs.

second original file:

10
10
20

diff file associated:

@@ -1,1 +1,2 @@
+10
 10
@@ -1,2 +2,3 @@
 10
+cc
 10

With git apply, the problem will silently appear, and the command will
give the following output:

10
cc
10
10
20

whereas the output given by the simple patch command will be:

10
10
cc
10
20

======================================================================
= 2. Correction
======================================================================

I see mainly two ways to fix the bug:

********************************************************************
* 2.1 first method (the most basic)
********************************************************************

The most basic is to change the code so that the special behavior
only affects the hunks of the form

@@ -1,k +1,m @@

Which makes the previous diff file possible to use. And fixes the
bug reported in 1bf01040f0c1101f410f9caa5e715460cdd0cbe0

Note that this modification, which changes positively behavior of hunks

@@ -1,k +l,m @@

where l is not 1, when there's a hunk

@@ -1,a +1,b @@

above, also changes the behavior when there's no such bloc above:

For example: the diff file

@@ -1,2 +2,2 @@
 20
-30
+35
 40

would have given an error before this patch (with the first original file)
whereas it works with the modification introduced by the patch.

**********************************************************************
* 2.2 second method
**********************************************************************

The other method, is to pass a base_line and an offset to the match_fragment
function instead of passing directly the line to test.

This does not involve any change in the behavior of apply, and therefore
has not the problem of the most basic method.

======================================================================
= 3. Question
======================================================================

I personnaly think that the second method is better, but this implies more
modifications, and it will be useful only to keep the failing behavior of 
some hand-modified patches... Do you think that the second method is
worth implementing ?
