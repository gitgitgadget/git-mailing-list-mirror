From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 0/2] Let merge-file write out conflict markers with correct
 EOLs
Date: Wed, 27 Jan 2016 17:37:25 +0100 (CET)
Message-ID: <cover.1453912583.git.johannes.schindelin@gmx.de>
References: <cover.1453819314.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:37:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOT6J-000881-IE
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565AbcA0Qho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:37:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:55851 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256AbcA0Qhm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:37:42 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MI5rO-1aNvfD1rgM-003saY; Wed, 27 Jan 2016 17:37:29
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453819314.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gj1RUS34QQ/ag1l0dZH8Dhgmbxf9hDoVFnwO+cWfBu0a9f0/fwg
 hC8XGZWiN2h5a0neozHvaHH62o6l+9lAGCyaxFldVrXiL2vZSjZAxWZ+c32OuWyp0b1HGLx
 nluhncW8+6bYOvLJSe6of+DA5ahXf+W5fuV2Ht5q+YbCk3lv7ofWwqk+dYbcd5+PcHA74W1
 jH1GpynBqhewAW5fSGiXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H9q639x2tKw=:MAdTRCBgbSEfudbqNOwRwH
 SHP73x6yT2jYNcE09ygbFz4eixFMsOYN/mhuB8n8D/jvBwsmovas01PJi9CBTbPn5lXwhtyMq
 0QsEfJNzmdtpEzHPOzF9+ED18xjeV/ADBuhSRprbfLYu+9fpmTkCmV4PCEnsp4AwcGCL5iHYt
 5PV5v4VHNkv2kykaMLRcvP/M4Rl7jrs5M0Dk58WSdXJyo8pHTGzO1EiW/pjKaZGdbL1p1QOh1
 KQpqUUyRojc+uidquGtVSKHGdG4i60aKOVXCka3zIyB9zchCmVfNdbuaywMXc3r8UyXZBN3gW
 UlbtzdlJb6llOjB0pPG1PMNsAWDswv14hnoe+dX3FMIerv3iPLAHFxTDNstw46dg5HxEiyVjJ
 DBvH1yei70q0nW4imeeqF2zdobgVyMLVa4LOQEp0PvrVJP1aUZUJV2cFzDRV24PSyXqBuljnS
 YBvS+6xOXeMMu7pdehpI733Du7joZXsQwfPdk/GrCIW64V0W1dQ94HH8sCqmOoFzo4YG7c11o
 NSHam3p8rDbGnH48fYw5Zz5Cwu9m3zfb9aAHLMR+9ElTVFT7V+kSk2ECDO/eG7eY1DfkOGe3r
 U6Nd0uRvZyqvUSsOlbd3fmVfXjthx9SAD/G5d7aEY5C8ihb+LstID0M9zDOr6jtSrniN45OvP
 eHTd02YUNyHIUtuSn9l7MKe42/em2Au6xXfSnEE3Ch3E+f5oAALRZsJcMlX68rp+VTBdsOKz8
 EeJzWdgs5PQz92MZDN2pxFfpIzYIUTjoNxJaOz+eSZXwghak1j6hFINsgD8AsG6SSejQzGWr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284941>

The original patch was sent by Beat Bolli in
http://thread.gmane.org/gmane.comp.version-control.git/281600

My suggestion to extend it to respect gitattributes led to
changes that broke the original patch. And they were misguided
to begin with (see below).

Since there have been a couple of "What's cooking" mails
containing unheard calls for updates on this patch, I took it
on myself to fix things.

Junio's comment that we might look at blobs containing CR/LF
line endings made me rethink the entire approach, and I am now
convinced that we need to abandon the entire idea to make the
conflict markers depend on config settings or attributes:
after all, I introduced `git merge-file` as a replacement for
GNU merge that can be used *outside* of any repository, by design.

The crucial idea hit me yesterday when I took a step back: all
we need to do is to ensure that the end-of-line style is matched
when *all* input files are LF-only, or when they are all CR/LF.
In all other cases, we have mixed line endings anyway.

And to do that, it is sufficient to look at *one single line
ending* in the context. Technically, it does not even have to be
the context, but the first line endings of the first file would
be enough, however it is so much more pleasant if the conflict
marker's eol matches the one of the preceding line.

To prevent my future self from repeating mistakes, I added a
little bit of background to the first commit message.

Triggered by a comment by Junio, I realized that a second patch is
needed: we need to make sure that the conflicting sections are also
augmented by the appropriate line endings if they lack any.

The change relative to v4 is that I now test the correct conflict
markers: the merge-file call we add to t6023 actually produces four
conflict markers because a previous test switched the conflict style
to `diff3` mode. This is only a side effect, though, therefore I
really wanted to avoid testing for it. However, I managed to test
an *incorrect* subset of three, but this is now fixed. Thanks go
to Ramsay Jones for poking my nose onto that issue.


Johannes Schindelin (2):
  merge-file: let conflict markers match end-of-line style of the
    context
  merge-file: ensure that conflict sections match eol style

 t/t6023-merge-file.sh | 13 +++++++
 xdiff/xmerge.c        | 98 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 93 insertions(+), 18 deletions(-)

Interdiff vs v4:

 diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
 index 1390548..20aee43 100755
 --- a/t/t6023-merge-file.sh
 +++ b/t/t6023-merge-file.sh
 @@ -352,11 +352,11 @@ test_expect_success 'conflict sections match existing line endings' '
  	printf "1\\r\\n2\\r\\n5" >crlf-diff2.txt &&
  	test_must_fail git -c core.eol=crlf merge-file -p \
  		crlf-diff1.txt crlf-orig.txt crlf-diff2.txt >crlf.txt &&
 -	test $(tr "\015" Q <crlf.txt | grep "\\.txtQ$" | wc -l) = 3 &&
 +	test $(tr "\015" Q <crlf.txt | grep "^[<=>].*Q$" | wc -l) = 3 &&
  	test $(tr "\015" Q <crlf.txt | grep "[345]Q$" | wc -l) = 3 &&
  	test_must_fail git -c core.eol=crlf merge-file -p \
  		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
 -	test $(tr "\015" Q <nolf.txt | grep "\\.txtQ$" | wc -l) = 0
 +	test $(tr "\015" Q <nolf.txt | grep "^[<=>].*Q$" | wc -l) = 0
  '
  
  test_done

-- 
2.7.0.windows.1.7.g55a05c8
