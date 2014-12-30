From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/9] atomic pushes
Date: Tue, 30 Dec 2014 15:41:29 -0800
Message-ID: <1419982898-23108-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 31 00:41:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y66QB-0007kt-HN
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 00:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbaL3Xlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 18:41:46 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:64802 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaL3Xlp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 18:41:45 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so14401420ier.13
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 15:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TUcabuGQxS9GyoyH8x5rrqslxfSOuWcsL+X7Y3ShtGM=;
        b=erwDfGIO+/5nwK1J3LBqhnFrgL3pAUVK7UKHxbZieozAWSenoug8KVSUrAD7CfJyx8
         y5GrF3L74goFmnswJjnmkrDWE9hljRU2xZuFsmT7kbKSFD3uK3A5JAEo8jvaKHiG4/vJ
         eMFEQ4poW500YoCJhETgfluLdJymfyVEBCZHskQnBqK0+KxbpxeViSZLWEjyowpFKBQJ
         Xz/F5ic5r0t/G38UpwIQV4l6jOIoRNWF7touI0pW9Ce5TMd4nlWujbLEtNUi+EJ3/SFS
         sr77MmRXf3d6IgECAFO9gZtzi9/TMBvhz+ehmb4hqDVnVcrZfqdpQyN0aMGLM2oBiu/R
         r+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TUcabuGQxS9GyoyH8x5rrqslxfSOuWcsL+X7Y3ShtGM=;
        b=X0TCoLpX6tOcKJLC5Vd+8ukynL0gGpncLJMB/lzPG0UX3hkD49TDV5skCj2gwTGBiw
         AYOowjlVd5/xF5sEsdEZt9NS2qk16sIsw+RnvleJ5NYnrvPAFRfUNxMKlzWtH1DZ4JUu
         xp3UWsfMAOD9UPxpSOwYs7mnezAKRsf/gh9esuVm2Gb5VAgPJR2l+B7hti5UF5Dtiqia
         ZuYd0y3lyGquLZU9awLsqT1A7A0fKVEihSRn9VmADy4zyXq4wYI8ktxJf44cfTI9p/XI
         VFdNzA6d2YExFvLPg9HqsZ5shGzEqCKBCQTEI8RUsfhP1UBckbcU5lyN/dB0azBg+YRk
         2NAQ==
X-Gm-Message-State: ALoCoQkH/iMcc5lVFBQzgvma0g7tbH0Z+8FJ88HFjFv4YozUg5kjOG+1fc3lbussD0a/TEYAE06G
X-Received: by 10.42.201.212 with SMTP id fb20mr48235950icb.2.1419982904522;
        Tue, 30 Dec 2014 15:41:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e545:220a:6cf6:2fed])
        by mx.google.com with ESMTPSA id m127sm19662414ioe.32.2014.12.30.15.41.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Dec 2014 15:41:44 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261953>

This patch series adds a flag to git push to update the remote refs atomically.

All comments from Eric and Junio have been incorporated.

The patch to negotiate the atomic push protocol was ripped apart
and we have one commit for the receiving side and one for the sending side,
so the order of new functionality introduced should not bring any bisect
breakages. 

The remote side learned the receive.advertiseatomic config option
and a test was added, that the user cannot push any more if they ask
for --atomic but the server doesn't advertise atomic.


But as of writing this cover letter I have a question on the security 
implications here. If we ask the remote side to not advertise atomic, 
(say because of some problem with too many file descriptors open)
but the client side (being a malicious client, not possible with the code 
presented in this patch series) does ask for atomic, the server should not
obey the request to handle it atomic. I just added that as well.

How about other capabilites requested such as "report-status",
"side-band-64k" and "quiet" ? 

This series applies on top of origin/mh/reflog-expire

Any comments are welcome!

Thanks,
Stefan

Ronnie Sahlberg (3):
  receive-pack.c: negotiate atomic push support
  send-pack.c: add --atomic command line argument
  push.c: add an --atomic argument

Stefan Beller (6):
  receive-pack.c: shorten the execute_commands loop over all commands
  receive-pack.c: move iterating over all commands outside
    execute_commands
  receive-pack.c: move transaction handling in a central place
  receive-pack.c: add execute_commands_atomic function
  send-pack: rename ref_update_to_be_sent to check_to_send_update
  t5543-atomic-push.sh: add basic tests for atomic pushes

 Documentation/git-push.txt                        |   7 +-
 Documentation/git-send-pack.txt                   |   7 +-
 Documentation/technical/protocol-capabilities.txt |  13 +-
 builtin/push.c                                    |   5 +
 builtin/receive-pack.c                            | 166 ++++++++++++++----
 builtin/send-pack.c                               |   6 +-
 remote.h                                          |   3 +-
 send-pack.c                                       |  65 +++++++-
 send-pack.h                                       |   3 +-
 t/t5543-atomic-push.sh                            | 194 ++++++++++++++++++++++
 transport.c                                       |   5 +
 transport.h                                       |   1 +
 12 files changed, 425 insertions(+), 50 deletions(-)
 create mode 100755 t/t5543-atomic-push.sh

-- 
2.2.1.62.g3f15098
