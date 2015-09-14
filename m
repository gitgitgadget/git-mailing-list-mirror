From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] saving and replaying multiple variants with rerere
Date: Mon, 14 Sep 2015 16:57:23 -0700
Message-ID: <1442275050-30497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 01:57:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbdcv-0006Ad-JR
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 01:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbbINX5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 19:57:33 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35890 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbbINX5c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 19:57:32 -0400
Received: by padhk3 with SMTP id hk3so157172183pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 16:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id;
        bh=LHkD/mS2G1/FC4idK124X/JjETaqq90p1C6ZmGXNMLc=;
        b=U7kiPjM8RT1XRI1dfNnB43HGkjxDl0COMzvM34Z2saafA2uy8SecKoMstJgZpe9bHA
         utA5U/npOCvzxM9yabT4z2ff/EzskTPdyVfxwADJP6q86BcGR8mQYUyp/UQ1KNfcrX5c
         +abxFa9u5hqex+Ra/MHAF6xdKRu/5hiYJUNhQ5+WN8/0ssaNdiqdCAQFvytAuqubzioZ
         b7j4O+goZEmxRARLwcx2wyPy+ueyM84Z3AaKxPgkP4wgDMWfst4+G6eiClQnDD+I9Mnp
         YU2C0Cpgw+gNwNZq2CHCz1ofJVpYjIH0ZCeTG4wWbejElH6TZz0wzJJXmfFX0Z4J5KGL
         QIpQ==
X-Received: by 10.68.211.42 with SMTP id mz10mr40961752pbc.118.1442275051787;
        Mon, 14 Sep 2015 16:57:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1935:6a7f:d949:928e])
        by smtp.gmail.com with ESMTPSA id xd10sm18380554pab.25.2015.09.14.16.57.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 16:57:31 -0700 (PDT)
X-Mailer: git-send-email 2.6.0-rc2-164-gdcd5d00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277878>

This is a continuation of jc/rerere topic that is now in 'next'.
The old topic is purely about refactoring and code cleaning and this
series builds on top of it.

We record a previously seen conflict and its resolution in a
subdirectory of $GIT_DIR/rr-cache, and the name of the subdirectory
is computed by hashing the "shape" of the conflicted hunk.  When a
similar-looking conflict is encountered later in the working tree,
"git rerere" tries to replay the recorded resolution by running a
three-way merge to apply the change to go from the previous conflict
to the previous resolution to the current conflicted state.

Depending on what appears in the context around the conflicted hunk,
however, this three-way merge itself can conflict and fail to apply
to a seemingly identical conflict.  You _could_ argue that you could
merge with reduced context lines to work around the problem, but
that is a risky proposition.

As a safer approach, these patches allow us to keep more than one
pairs of <preimage,postimage> (i.e. conflicted state and its
resolution) in the same "shape".  If two paths have identical
looking conflict and one's resolution does not cleanly replay to the
other's conflicted state, we now save the resolutions of these two
paths as different "variants" so that they can be applied when we
see these conflicts again.

I think the basic "record and replay" part is done with this round,
but I haven't really reviewed the part that deals with garbage
collection of old rerere database entries, which probably needs more
work (and could use help, hints hints...).

Junio C Hamano (7):
  rerere: split conflict ID further
  rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
  rerere: handle leftover rr-cache/$ID directory and postimage files
  rerere: delay the recording of preimage
  rerere: allow multiple variants to exist
  t4200: rerere a merge with two identical conflicts
  rerere: do use multiple variants

 rerere.c          | 270 +++++++++++++++++++++++++++++++++++++++++++++---------
 rerere.h          |   4 +-
 t/t4200-rerere.sh |  92 ++++++++++++++++++-
 3 files changed, 321 insertions(+), 45 deletions(-)

-- 
2.6.0-rc2-164-gdcd5d00
