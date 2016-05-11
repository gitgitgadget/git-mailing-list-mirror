From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/7] submodule groups
Date: Tue, 10 May 2016 17:59:50 -0700
Message-ID: <1462928397-1708-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed May 11 03:00:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IVd-0001oS-0J
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbcEKBAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:00:08 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32889 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbcEKBAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:00:05 -0400
Received: by mail-pf0-f170.google.com with SMTP id 206so11780012pfu.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3A0BbyKYhiSJtTKZiS15RNANsvNLzx339EJJ09M7p9A=;
        b=It7ygPbbcyNBOdimT5lV2FBlep1NU60ZUp6WkTaml7U2x7OxyqfnCAwcMJuoGCYOFz
         76BOUQLxoLfVRj1O/5jvech7HAtWQI5ASFNKrASx7vxkgqgtiWEp5E6RkKtNfiDdeJM/
         04uvqjgZkOXIUHL2VTx8MD1r9EmMPYXB4AF4bMP4fYNJ+7WH2rgxI+CcGAgNMudlflif
         RZVxzBfD9H/plbyJ53SIjkQqAb3FUPP4/BGScN7Y16lMVygPOkdzNBfyUwQ7isx12/ZO
         H9Q4xChu3EA69HOaU6jUWy7i84nTf9JPFwF97RKXI66hTYMeUqNadLAOl92EHvy1A31/
         J6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3A0BbyKYhiSJtTKZiS15RNANsvNLzx339EJJ09M7p9A=;
        b=k5IxZK2/RVepNPxM6pFyQWR2rsh5nZ+obPMRxO3Ieu+mJwWLwfKm2GwNqrBN8kRNPr
         +0iEqLzPuF536sO4WxGaRM1epJ0gnYCRvllsGuCxA1D0Hj4WsDp3SzevADIhDPG+kyTY
         uTsjsuMhD99mXrTzejtuSFMnXHpGY9mEhr1RXaaDcvUxZhUDkO/dnd3VYJZXBcOoVf8X
         KXWtxHauWRvSKb+uGiLZrinDbt+BO+GTfSsyd0LGHaVICc5O1GW+l5pSdBPNhf5iP6YE
         u+99aCufmiIcFq7jKcisiI0BcHa3g9B2uDkds3+lzcOgJ1AycuOeo/Bt7LQF9K3RmjfE
         tIQQ==
X-Gm-Message-State: AOPr4FXh1mHXJdp0ykaOKVyERTytKwFiwpy+E+Nxv6nXqS3uLAHMTX7ctxvsoAl7z/kLfJuK
X-Received: by 10.98.76.194 with SMTP id e63mr708281pfj.63.1462928404167;
        Tue, 10 May 2016 18:00:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69ac:db78:a0d1:60da])
        by smtp.gmail.com with ESMTPSA id n10sm7239429pax.18.2016.05.10.18.00.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 May 2016 18:00:03 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.35.g58985d9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294212>

I started from scratch as I think there were some sharp edges in the design.
My thinking shifted from "submodule groups" towards "actually it's just an
enhanced pathspec, called submodulespec".

The meat is found in the last 3 patches.

What is this series about?
==========================

If you have lots of submodules, you probably don't need all of them at once,
but you have functional units. Some submodules are absolutely required,
some are optional and only for very specific purposes.

This patch series adds labels to submodules in the .gitmodules file.

So you could have a .gitmodules file such as:

[submodule "gcc"]
        path = gcc
        url = git://...
        label = default
        label = devel
[submodule "linux"]
        path = linux
        url = git://...
        label = default
[submodule "nethack"]
        path = nethack
        url = git://...
        label = optional
        label = games

and by this series you can work on an arbitrary group of these submodules
composed by the labels, names or paths of the submodules.

    git clone --init-submodule=\*<label> --init-submodule=:<name> git://...
    # will clone the superproject checkout
    # any submodule being labeled <label> or named <name>

    git submodule add --label <name> git://... ..
    # record a label while adding a submodule

    git submodule update [--init] \*label2
    # update only the submodules labeled "label2"
    
    git config submodule.updateGroups default
    git config --add submodule.updateGroups devel
    # configure which submodules you are interested in....
    git submodule update [--init-default-group] 
    # ... and update them    

    git status 
    git diff
    git submodule summary
    # unlike the last series, these are not touched
    
    git submodule status \*label2
    # only show information about "label2" submodules.
    

Any feedback welcome, specially on the design level!

Thanks,
Stefan

Prior series found here: http://thread.gmane.org/gmane.comp.version-control.git/292666

Stefan Beller (7):
  submodule--helper: add valid-label-name
  submodule add: label submodules if asked to
  submodule-config: keep labels around
  submodule-config: check if a submodule is in a group
  submodule--helper module_list_compute: allow label or name arguments
  submodule update: learn partial initialization
  clone: allow specification of submodules to be cloned

 Documentation/config.txt        |   5 ++
 Documentation/git-clone.txt     |  26 ++++--
 Documentation/git-submodule.txt |  30 +++++--
 builtin/clone.c                 |  40 ++++++++-
 builtin/submodule--helper.c     | 146 +++++++++++++++++++++++++++---
 git-submodule.sh                |  38 ++++++--
 submodule-config.c              |  66 ++++++++++++++
 submodule-config.h              |   5 ++
 t/t7400-submodule-basic.sh      | 176 ++++++++++++++++++++++++++++++++++++
 t/t7412-submodule--helper.sh    | 193 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 692 insertions(+), 33 deletions(-)
 create mode 100755 t/t7412-submodule--helper.sh

-- 
2.8.0.35.g58985d9.dirty
