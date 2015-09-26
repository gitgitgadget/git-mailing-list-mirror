From: Andrey Loskutov <loskutov@gmx.de>
Subject: Single brackets matching in .gitignore rules
Date: Sun, 27 Sep 2015 00:01:10 +0200
Message-ID: <2606743.RipZrg6Xoz@pinguin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 27 00:01:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfxX1-0002fO-Af
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 00:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbbIZWBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 18:01:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:54654 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbbIZWBN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 18:01:13 -0400
Received: from pinguin.localnet ([79.247.107.112]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0M1msU-1aYceL2sjS-00tmK2 for <git@vger.kernel.org>;
 Sun, 27 Sep 2015 00:01:11 +0200
User-Agent: KMail/4.14.9 (Linux/4.1.7-100.fc21.x86_64; KDE/4.14.9; x86_64; ; )
X-Provags-ID: V03:K0:Yh6uptFWfZLlH4k/ErSLcJNGH1ufoBbKbJiSz0HlXICnVAV+GGO
 KX3sattbF67EnDO40z6Ho74AealsF3j0OE37utes46OO80DuOdDs3beTzMqQBcomLgexRVz
 p8k3+gaB8t8qr4uMckm+0+Qnn5HHrsTsTsgLn5jCSgyT9ID4trxsVmza6tqpT7G9EhB5dpC
 HZ7HMyGhMSx/lEOfuOfHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cj8PUqJTTtM=:REVMq3WMXorNlehCz293+n
 N0TmO85eugo3hYED1vT+23bsMvsygEjQRuWfPF9JGl4lYvQ0Ry9JY9eFMo1YQjKL432DudKB2
 AN/1PkHprlAurNJJryjf7OEXsCdLnztRLPxbvIGznZRUw6Y5RzP0TY0lAWcHa5UO249/CBHL7
 wkbNJm0mFtTrRdQJseew7dSoyA0YHDgR6Y21av3p9OCERE2JOumw0VAcdbRw7oS8SvO9DlXBj
 LuoMpc9gJs2RVR5N5Je3PLx/iHXPyCH2q5X4U6UP52bRwYj0mpfN/juio8sauioENZKwiLp6J
 8YfQ0z6e6/mLYjkiaOv0PeILQhiV21GpIowKHNzus/qIlHx1G8CKUc/kT8O/Rohf9cQsscSSU
 RvtWal/N4iFwPlHDjbpFLam4DG3pW7eup6lPTGcos0JN5Y4l1G5sza8oUrk7qw1W90oKeG6kN
 IMBKyV22hFCC+Vif+LdRdd6A+8CS05NZTS8JK31GEiOKagNphYGSMxXIPiw1dqtjHCX5e0dTD
 bRbWkE3hZ+/moxNXD+Iomcd5mzfet4LGLoiAKGnGHi4akHe9VDkOUeGGJ4Ff14nIM5vj7br/1
 JYwgr9EDbZFZXHvGQz4yPoJR5vDIO8YejHE3fYBFXGwaH4aHPlduJlkDQaRbcoBsQYDWCQ8d1
 Yxhlt9hsgNUL7qStCqhhsxuWns9pjkBnqlkKEmd08zyOWpbdk1wJra8h9CYLDSTojL5S7NXNb
 EjvgObQNgyhbtKFoLd1Z91EZP8+ZHgXl7aUSPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278699>

Hi,

I'm trying to make JGit .gitignore parser compatible to Git behavior and need help to understand some corner cases.

Git seem to fail to match file names if the ignore rule contain a single bracket '[' and seem to have inconsistent behavior for a single ']'.
For all experiments below I was using git 2.1.0 from Fedora 21 repositories.

Example table for '[':
----------------------
rule  | file | match?
----------------------
[           [          false
[*         [          false
*[         [          false
*[         a[        false
----------------------

I would expect that in all cases above Git ignore rules must match, since there is no valid character group defined and so the pattern should be interpreted literally.
However, it looks like Git simply gives up on parsing the rule, probably because it contains unmatched '[' character starting a (broken) character group.

Next, the surprising table for ']':
----------------------
rule  | file | match?
----------------------
]           ]          true
]*         ]          true
*]         ]          true
*]         a]        true
----------------------

Here Git does not give up on parsing, treats unmatched ']' character literally, and doesn't dislike that it is an "unmatched" end of a broken character group.
Why?

If Git interprets [ character only as part of the glob rules (character groups), it should interpret unmatched ] character equally.
Also if Git interprets unmatched  ] character literally, why not same behavior for the [ character?
IMHO the first table for single '[' character is just a bug in Git, and it should be consistent to the ']' table.

Anyway, it would be nice to hear what should be the "right" way to interpret the tables above.

BTW the only official documentation I found about ignore rules:

https://www.kernel.org/pub/software/scm/git/docs/gitignore.html
http://man7.org/linux/man-pages/man3/fnmatch.3.html
http://man7.org/linux/man-pages/man7/glob.7.html

-- 
Kind regards,
google.com/+AndreyLoskutov
