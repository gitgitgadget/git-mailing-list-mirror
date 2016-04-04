From: santiago@nyu.edu
Subject: [PATCH v4 0/6] tag: move PGP verification code to tag.c
Date: Mon,  4 Apr 2016 18:22:09 -0400
Message-ID: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 00:22:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anCtF-0007cZ-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 00:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369AbcDDWW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 18:22:26 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36092 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293AbcDDWWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 18:22:25 -0400
Received: by mail-qg0-f53.google.com with SMTP id f52so68620319qga.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 15:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=PwJ99zGBdssUxhaatRDj7QHtJXJv4O3foYoHEXPIi7k=;
        b=S2IEGT/Nwz/Mg4lOqKvv6E3oSRRtsNC0voQbgaFoN6ClEBO2kO73jQR/gKDTySU6Nw
         cajCQMAsLMO6vATumYSyL6Kbk8NJgxM2o+kj/AZOEiwVdJ6/7kEH6tOjoJufYW14jT8P
         CKBfpR1Sq6XUM+tZnlUneICAEMX2qTOJ8Kz9+ZisW9sdKmmAQIdtmovVjHopKATIXzOs
         4TtjlgAbbqKm4Fv8VUW5/Fen/KGMWLnWq0JdheeI0zIouFiiI3iRr30XNcaFo0o2qiLc
         DmCZVUrkvvkDjaggFMJxGy0S8PZwnUacG8BsPn8JDqJY2Mgd54z78JA84DPPLoFk8E+G
         Nyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PwJ99zGBdssUxhaatRDj7QHtJXJv4O3foYoHEXPIi7k=;
        b=Krc02Fc+xZMAJDK8KTVsCImqtsXNiCgKSdG2RLhz+m5VWlqKmcR2GwfXTGdXYYmzYN
         pVWA+y9BIQgm5O7tQBcOfmYZnLL7ikd5wkKf7BL3bNCj5JPvnaEl5UuVrAm9Xok2zkjX
         k8bgr8aqb0RERLLgBynQQ81hfYS2pMaxBXUCrj5JqGvP4YDn68CkA/HeGrB4hITHLPe3
         qJtFNgozcc9CH4fH25tgW2i6sycXWvzWBXTOqoPPcxGb+zhTz6wE5JJIHB7sygNdkHl3
         1GpGcW+ga/QEQgd3lLKXU6sJmoau5dOPERCiQHPpgMOwnjmLOMXut6Ju2Vj0QtNcc3OX
         ObYQ==
X-Gm-Message-State: AD7BkJIdt1avDXuHq2EXIQX1tcGNT/SouSq7P00BNB5MrWU+dm0wlBTSuT4TO5pdS38srBp9
X-Received: by 10.140.37.113 with SMTP id q104mr17343541qgq.104.1459808544161;
        Mon, 04 Apr 2016 15:22:24 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id h9sm13180670qhh.29.2016.04.04.15.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 15:22:23 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290731>

This is a follow up of [1], [2], and [3]:

v4 (this):

Thanks Eric, Peff, and Hannes for the feedback.

 * I relocated the sigchain_push call so it comes after the error on
   gpg-interface (thanks Hannnes for catching this).
 * I updated the unit test to match the discussion on [3]. Now it generates
   the expected output of the tag on the fly for comparison. (This is just
   copy and paste from [3], but I verified that it works by breaking the
   while)
 * I split moving the code and renaming the variables into two patches so
   these are easier to review.
 * I used an adapter on builtin/tag.c instead of redefining all the fn*
   declarations everywhere. This introduces an issue with the way git tag -v
   resolves refnames though. I added a new commit to restore the previous
   behavior of git-tag. I'm not sure if I should've split this into two commits
   though.

v3:
Thanks Eric, Jeff, for the feedback.

 * I separated the patch in multiple sub-patches.
 * I compared the behavior of previous git tag -v and git verify-tag 
   invocations to make sure the behavior is the same
 * I dropped the multi-line comment, as suggested.
 * I fixed the issue with the missing brackets in the while (this is 
   now detected by the test).

v2:

 * I moved the pgp-verification code to tag.c 
 * I added extra arguments so git tag -v and git verify-tag both work
   with the same function
 * Relocated the SIGPIPE handling code in verify-tag to gpg-interface

v1:
 
The verify tag function is just a thin wrapper around the verify-tag
command. We can avoid one fork call by doing the verification inside
the tag builtin instead.


This applies on v2.8.0.

Thanks!
-Santiago

[1]
http://git.661346.n2.nabble.com/PATCH-RFC-builtin-tag-c-move-PGP-verification-inside-builtin-td7651529.html#a7651547
[2] http://git.661346.n2.nabble.com/PATCH-tag-c-move-PGP-verification-code-from-plumbing-td7651562.html 
[3] http://git.661346.n2.nabble.com/PATCH-v3-0-4-tag-move-PGP-verification-code-to-tag-c-td7652334.html
