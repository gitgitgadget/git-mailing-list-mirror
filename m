From: Wincent Colaiuta <win@wincent.com>
Subject: Trouble using --word-diff results
Date: Fri, 17 Sep 2010 09:19:52 +0200
Message-ID: <A5062D09-2D2B-4F46-B813-71483325012A@wincent.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 17 09:48:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwVgK-0007px-IV
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 09:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268Ab0IQHsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 03:48:08 -0400
Received: from outmail137072.authsmtp.net ([62.13.137.72]:56677 "EHLO
	outmail137072.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750860Ab0IQHsG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 03:48:06 -0400
X-Greylist: delayed 1683 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2010 03:48:06 EDT
Received: from mail-c187.authsmtp.com (mail-c187.authsmtp.com [62.13.128.33])
	by punt4.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o8H7K1wX016685
	for <git@vger.kernel.org>; Fri, 17 Sep 2010 08:20:01 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o8H7JvTD074563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 17 Sep 2010 08:19:59 +0100 (BST)
Received: from [192.168.1.6] (7.Red-83-59-198.dynamicIP.rima-tde.net [83.59.198.7] (may be forged))
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o8H7JsVg024562
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 17 Sep 2010 03:19:56 -0400
X-Mailer: Apple Mail (2.1081)
X-Server-Quench: fb0e9a77-c22b-11df-ab46-001185d377ca
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha Dh4fBRVVLUBPVglL NEteaF1JP0tFGhZi ViYUWVRVUE1xUWl0 YgBUZEtcak5QWAZ0 UktNXFBTFBpqBAMA SEEWKh4IMWEyeHl0 YEBhEHdTVEQ0IxR9 F0cFEmobNmViOn0e URQOalIGdAVXfh9E a1h6AHAKZjZWKB4i GBI5Oz15IC5eLisd B0QSKkgeBEoKEDB0 XR0ZADEzBiVR
X-Authentic-SMTP: 61633436303433.1000:706
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156375>

Hi,

I've been working with the output of "git diff --word-diff" and am seeing some unexpected results which at first I thought might be a bug, but now I am beginning to wonder if --word-diff is actually useful at all for the purposes of scripting.

I noticed this specifically with the --word-diff=porcelain format, which I thought would be helpful to produce output colorized diff output like that which you can see here:

  http://github.com/git/git/commit/c2e0940b44ded03f0af02be95c35b231fea633c1
  http://qt.gitorious.org/+qt-developers/qt/staging/commit/45851a64ead74748d6b5045066545ee2c95d83f6

ie. normal unified diff style, but with darker background coloring within each added or removed line to draw attention to the specific parts of the line that were modified.

So, I tried to achieve this using --word-diff=porcelain format and got some unexpected results. But the problem can be demonstrated using the standard --word-diff=plain format as well, so I'll use that here seeing as it is a little easier to read.

Given a normal diff like this:

  -a, b, c, d
  +b, a, c, d

With --word-diff we get:

  [-a,-]b, {+a,+} c, d

Note how there is no whitespace between the removed "a" and the "b", and in the "pre" version of the file (where there is no "a" between the "b" and the "c") there will effectively be too much whitespace. Reconstructing the above in order to give us a colorized diff will yield:

  -a,b,  c, d
  +b, a, c, d

Using HTML-like tags to show where the color tags would be inserted:

  -<red>a,</red>b,  c, d
  +b, <green>a,</green>, c, d

So we get the desired coloring, but our whitespace is wrong in the "pre" line, and right in the "post" line. The problem is information about the whitespace is lost and can't be reconstructed from the output. This kind of whitespace damage doesn't happen in all cases, but in this particular example of moving something within a line, the damage occurs.

Like I said, at first I thought this was a bug, but on reading the "git diff" man page I see:

  "Every non-overlapping match of the <regex> is considered a word. Anything between these matches is considered whitespace and ignored(!) for the purposes of finding differences. You may want to append |[^[:space:]] to your regular expression to make sure that it matches all non-whitespace characters. A match that contains a newline is silently truncated(!) at the newline."

It seems from that that some whitespace information loss is expected. So now I'm wondering if --word-diff, and particularly --word-diff=porcelain, is actually useful for consumption by a script. 

If the output were:

  [-a, -]b, {+a, +}c, d

Then I could colorize like this with no whitespace damage:

  -<red>a, </red>b, c, d
  +b, <green>a, </green> c, d

And I could optionally add a post-processing pass in my script to massage the exact positioning of those color tags to not highlight those trailing spaces:

  -<red>a,</red> b, c, d
  +b, <green>a,</green> c, d

Is what I'm talking about here possibly using "--word-diff=porcelain"? For now I am working with normal diffs and rolling my own intra-line colorization from scratch.

Cheers,
Wincent