From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [offtopic?] xdelta patch format wrapper
Date: Wed, 13 Feb 2008 14:53:14 +1300
Message-ID: <47B24D8A.5090703@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jmacd@cs.berkeley.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 04:03:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP7uJ-0002wx-4v
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 04:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbYBMDDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 22:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbYBMDDA
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 22:03:00 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:60331 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbYBMDC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 22:02:59 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[127.0.0.1])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JP7td-0003X5-HQ; Wed, 13 Feb 2008 16:02:53 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73738>

This is somewhat offtopic but this list is the best-informed crowd on
diff/xdelta matters so here I am, abusing your attention...

I am working on an "incremental content" feature for Moodle - and my
plan is to serve pre-computed "patchfiles" based on the xdelta utility
to the client systems.

Now, I need to provide a wrapper that concats the deltas from the xdelta
utility with a more verbose header - akin to the header in git's unified
diff output. This is because the xdelta utility only handles one file
delta at a time - the file is a pure delta (prefaced with a SHA1 of the
file it applies to, IIRC).

(From xdelta I like that it's one-way-only, and compressed internally --
thus saving a lot of space on large changes. There are small statically
linked binaries for windows, osx and linux. I did consider using git's
own diffs, but it involves significantly more work, and portability to
Win32 is still green for the wide distribution this project is expecting.)

So my question is what is a good format for the header? My thinking sofar:

 - have a prefix to scan for, such as "xdelta" at the beginning of
   the file, or after a newline/whitespace

 - keep the <fromsha1> <tosha1> line

 - \0 delimited filenames

 - filenames as ambiguous bag'o'bytes or utf-8?
   (should we have another flamewar on this? ;-) )

 - keep file modes and perhaps support copy/move headers

 - keep a/ b/ prefixes?

 - last line in the header is length: <length-in-bytes>, followed by
   a newline and the xdelta itself

 - one or more newlines follow the end of the xdelta if there is another
   header coming

Something along the lines of

xdelta d065883..74cd8e5 100644
a/foo.zip\0
b/foo.zip\0
length 1024
<1024 bytes of xdelta data>

xdelta d065883..74cd8e5 100644
a/bar.zip\0
b/bar.zip\0
length 92312

<92312 bytes xdelta data>EOF

  ---

Would the above work as a reasonably solid patch header format? Is there
something else I should be using instead of rolling my own? If there
isn't a more suitable tool,  and I'm hoping to come up with something
unambiguous and reliable that is generally useful.

[ I have to confess, it came as a bit of a surprise that xdelta didn't
support this out of the box. Haven't seen any existing wrapper for it
that covers this either. ]

As a kludge I could tar both sides and xdelta across the tars, but it is
wasteful, and an xdelta-based diff/patch that can handle multiple files
does seem useful. And I don't know how stable the output of tar is (wrt
file ordering for example).

TIA for any feedback :-)


m
-- 
