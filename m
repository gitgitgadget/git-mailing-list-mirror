From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH jn/pager-lv-default-env] pager test: make fake pager consume
 all its input
Date: Thu, 30 Jan 2014 08:42:32 -0800
Message-ID: <20140130164232.GF27577@google.com>
References: <874n6zbqlh.fsf@helix.nebula.avasys.jp>
 <20140106193339.GH3881@google.com>
 <874n5ghenr.fsf@helix.nebula.avasys.jp>
 <20140107021404.GK3881@google.com>
 <52E9FC23.2030200@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Olaf Meeuwissen <olaf.meeuwissen@avasys.jp>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Jan 30 17:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8uhM-00043H-O5
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 17:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbaA3Qmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jan 2014 11:42:37 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57992 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbaA3Qmg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 11:42:36 -0500
Received: by mail-pd0-f178.google.com with SMTP id y13so3225518pdi.9
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=obnzEAMImXJEiIRtjZxAsD7tv4ilYhjG6iCbzkArB9s=;
        b=EKVRSnej7eZiF2WseWXPOb1KBBfCT2vPGXuh2Dd4LNTVKCvaJl8g9wl4zptzAb2162
         P13t+csZcoPjIuNIKHxMSFz2YD4YYmgTbDrJRCOGV2lEd7bkFpibnSX5Ti/HqLVTKZVl
         6eojxl9f8hy8VmZX6OAw+HdP9Gj3b7oFkneYEuGq5x4SlMAbWh+ZQ+dE34FSj2FNotWg
         mRyW1zXzmE0cyPphziNuPVhn+9jx2hg6OOfYjWztnhRrQm8Vc6yL+yd8Fu7IZjE7Rj0I
         1lfECtAz16d7+M5q8JRGxKafuUv1fOeYM1IKKc7Hl9rE4fL+Trs28cEkcYIgG6EHmldY
         UIOQ==
X-Received: by 10.66.141.144 with SMTP id ro16mr15143577pab.131.1391100155534;
        Thu, 30 Jan 2014 08:42:35 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pq1sm19034627pbc.8.2014.01.30.08.42.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jan 2014 08:42:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52E9FC23.2030200@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241272>

Otherwise there is a race: if 'git log' finishes writing before the
pager terminates and closes the pipe, all is well, and if the pager
finishes quickly enough then 'git log' terminates with SIGPIPE.

 died of signal 13 at /build/buildd/git-1.9~rc1/t/test-terminal.perl li=
ne 33.
 not ok 6 - LESS and LV envvars are set for pagination

Noticed on Ubuntu PPA builders, where the race was lost about half the
time.  Compare v1.7.0.2~6^2 (tests: Fix race condition in t7006-pager,
2010-02-22).

Reported-by: Anders Kaseorg <andersk@MIT.EDU>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Anders Kaseorg wrote:
> On 01/06/2014 09:14 PM, Jonathan Nieder wrote:

>> +		PAGER=3D"env >pager-env.out" &&
>> +		export PAGER &&
>> +
>> +		test_terminal git log
[...]
> On the Ubuntu PPA builders, I=E2=80=99m seeing this new test fail wit=
h
> SIGPIPE about half the time:
>
> died of signal 13 at /build/buildd/git-1.9~rc1/t/test-terminal.perl l=
ine 33.
> not ok 6 - LESS and LV envvars are set for pagination

Good catch.  Sorry for the trouble.

 t/t7006-pager.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 7fe3367..b9365b4 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -40,7 +40,7 @@ test_expect_failure TTY 'pager runs from subdir' '
 test_expect_success TTY 'LESS and LV envvars are set for pagination' '
 	(
 		sane_unset LESS LV &&
-		PAGER=3D"env >pager-env.out" &&
+		PAGER=3D"env >pager-env.out; wc" &&
 		export PAGER &&
=20
 		test_terminal git log
--=20
1.9.rc1.175.g0b1dcb5
