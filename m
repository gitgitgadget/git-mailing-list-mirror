From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Better value for chunk_size when threaded
Date: Thu, 6 Dec 2007 18:58:34 -0500
Message-ID: <9e4733910712061558k19fbc864ia1fb7a3431fd2603@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 00:59:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0QcM-0004TC-Vt
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 00:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbXLFX6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 18:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbXLFX6h
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 18:58:37 -0500
Received: from qb-out-0506.google.com ([72.14.204.227]:34111 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXLFX6g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 18:58:36 -0500
Received: by qb-out-0506.google.com with SMTP id e11so4473423qbe
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 15:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=LlVRcdMVCponHAxQC8zeZlGOTUxDAiH678MmHdrDLIM=;
        b=cS/kRNpkiehkqj8bH+Oezh5sN60Uy5WmmKQ8/aM9HYOiGhB9Bw1eueYh6WxnfgllJHGIWE2UFwLiKHRb6O5qsmP8YziDgqSDPL9/OLfSG6uLFTYpCLQpNJ8RIWGSTcAo/+bNBSRp+qimqpLVRejK8k780N6A9exoY3pDSHD//B8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dYHSIW4E6HiwBSjF3SvqQVltfozEQWxujoiXuwLpzsBj5ScgUROAoY5rVyOdUPyXvCe22gJaXbFA9av1Az/9pOFhaC2juk7PPiTlq/PVSclEausqR7UxVNxDe+ukIBmHaXMF/DrYrFQmpRn4M1vLt5Cj+d0ABZHObFy8vaxDTcU=
Received: by 10.114.88.1 with SMTP id l1mr1970213wab.1196985514059;
        Thu, 06 Dec 2007 15:58:34 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Thu, 6 Dec 2007 15:58:34 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67356>

I tried some various ideas out for chunk_size and the best strategy I
found was to simply set it to a constant. How does 20,000 work on
other CPUs?

I'd turn on default threaded support with this change. With threads=1
versus non-threaded there is no appreciable difference in the time.

Is there an API to ask how many CPUs are in the system? It would be
nice to default the number of threads equal to the number of CPUs and
only use pack.threads=X to override.

Making all of this work by default should help when outside people
decide to do a massive import.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4f44658..4d73be8 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1645,7 +1645,7 @@ static void ll_find_deltas(struct object_entry
**list, unsigned list_size,
        }

        /* this should be auto-tuned somehow */
-       chunk_size = window * 1000;
+       chunk_size = 20000;

        do {
                unsigned sublist_size = chunk_size;


with chunk_size = 20000, everything is on a q6600 4GB

threads = 5
time git repack -a -d -f --depth=250 --window=250
real    6m20.123s
user    20m25.841s
sys     0m5.520s


threads = 4
time git repack -a -d -f --depth=250 --window=250
real    6m15.525s
user    20m20.852s
sys     0m5.356s

threads = 4
time git repack -a -d -f
real    1m31.537s
user    3m2.063s
sys     0m3.064s

threads = 1
time git repack -a -d -f --depth=250 --window=250
real    18m46.005s
user    18m43.122s
sys     0m1.228s

threads = 1
time git repack -a -d -f
real    2m57.774s
user    2m54.211s
sys     0m1.228s

Non-threaded
time git repack -a -d -f --depth=250 --window=250
real    18m51.183s
user    18m46.538s
sys     0m1.604s

Non-threaded
time git repack -a -d -f
real    2m54.849s
user    2m51.267s
sys     0m1.412s

-- 
Jon Smirl
jonsmirl@gmail.com
