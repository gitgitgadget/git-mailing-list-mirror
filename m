From: Christian Couder <christian.couder@gmail.com>
Subject: "./t0001-init.sh --valgrind" is broken
Date: Thu, 3 Mar 2016 01:07:40 +0100
Message-ID: <CAP8UFD0-FxoPe5-35NAKSkegFBoRPy1+BOsqN-y+QJUoXAqR3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 01:07:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abGnz-0004zg-NH
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 01:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbcCCAHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 19:07:43 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36199 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbcCCAHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 19:07:42 -0500
Received: by mail-lb0-f171.google.com with SMTP id x1so4295241lbj.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 16:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=yRiiXf9tinb0R1S52/ukzzYwO23e8nvPuJJZ2b14bsg=;
        b=j/48bZEPUyy7WLoKZCZhMOvgl5cwptFgbspDerZV+z944U7w0qz+kW/umz/CkOrvWp
         /ac1lz0sMIdj0vnISKoxGSywZ6mgUVLH/NNmFVpJi+HHJzepmAYcqTTXg74x6ih5/1V+
         yAncut1qyxfIX0vR9SyEwe6DeW415ZCeKXxxnlF4kZHkZRZOIeHSpS8iqA1m1WP6smrp
         fMD6Wodc2iZU7UCFW3srICeaYj5rgZkRrCOExqTZRF8GYbLf1ZQwbNHGmYOtC9F1DsPb
         tvefIIPIwt/XDsZrt5B281C/AYSqLTPbBkMOkLzHa9OIIwu/BZeVAxOxVmK8bQZ8ZPF1
         7vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=yRiiXf9tinb0R1S52/ukzzYwO23e8nvPuJJZ2b14bsg=;
        b=Smpuu4+FTi/icHi8Q5BhFwzscS2WQDrMOiGTkvYQTc0vqMJTI3CAe4opWWb7U7hn3j
         oB1KpH2kmSAdWlMXE4ADg+DQ+2/KZaM9AN/TrFQOklaTzhmBQSCPoFk1YXXkwJ2S5m4U
         /XvT22NcToNalYxqPa6swz6+sxJcz3lf/6wEDR65FouYYS2/wZCajxDAyjJrRAAWYCla
         8nDnteTr9uNAoODPHgkiMp001+ZN6mg2fCfovO0SoRAjkvYKAVOEgZA68JLUfLRYjcWA
         fBa8RQZkUydIvlMLQAqRFG7b6e0impmEsnI+wPtGmNE0FSLI13MONXkHLxsF6HuMwZBS
         jr/A==
X-Gm-Message-State: AD7BkJL6m/0QJS6P4SNewalFUkl2h2OzkMJMzXSacr2y03oRBBz/k7BhT+mjeDGqG/dEk1ArIrkMBzhL2mN5LQ==
X-Received: by 10.25.148.208 with SMTP id w199mr11358759lfd.124.1456963660872;
 Wed, 02 Mar 2016 16:07:40 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Wed, 2 Mar 2016 16:07:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288159>

Hi,

It looks like commit 57ea7123c86771f47f34e7d92d1822d8b429897a (git.c:
make sure we do not leak GIT_* to alias scripts, Dec 20 14:50:19 2015)
broke "./t0001-init.sh --valgrind".

I get:

expecting success:
        (
                env | sed -ne "/^GIT_/s/=.*//p" &&
                echo GIT_PREFIX &&        # setup.c
                echo GIT_TEXTDOMAINDIR    # wrapper-for-bin.sh
        ) | sort | uniq >expected &&
        cat <<-\EOF >script &&
        #!/bin/sh
        env | sed -ne "/^GIT_/s/=.*//p" | sort >actual
        exit 0
        EOF
        chmod 755 script &&
        git config alias.script \!./script &&
        ( mkdir sub && cd sub && git script ) &&
        test_cmp expected actual

--- expected    2016-03-03 00:05:17.113754381 +0000
+++ actual      2016-03-03 00:05:19.041783583 +0000
@@ -10,7 +10,6 @@
 GIT_PREFIX
 GIT_TEMPLATE_DIR
 GIT_TEST_TEE_STARTED
-GIT_TEXTDOMAINDIR
 GIT_TRACE_BARE
 GIT_VALGRIND
 GIT_VALGRIND_ENABLED
not ok 6 - No extra GIT_* on alias scripts

It's late here so I don't have time to work on this tonight.

Thanks,
Christian.
