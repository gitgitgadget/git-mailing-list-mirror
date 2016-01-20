From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/4] Submodule Groups
Date: Tue, 19 Jan 2016 19:34:36 -0800
Message-ID: <1453260880-628-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 20 04:34:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLjXl-0004br-Do
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 04:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935032AbcATDep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 22:34:45 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34112 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933912AbcATDeo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 22:34:44 -0500
Received: by mail-pf0-f176.google.com with SMTP id q63so192074316pfb.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 19:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=e4lQbgEAbEibmWTB+c5ckoz4w1dYM4m2/0D7dQ0Oy3k=;
        b=BmOKpb3s0qEN2Sm+x9qNWNwUjH9p4UY15X9iTs3quOl9LH/Kp993HVAGU75ddD1qtH
         ygw9gfZWDm0XXDrFojTm9keAvvQFOXjj3jYWzL0GfTbOOQZidnfGnFdX64GhxcyB+DBR
         FEq0klL971fN9s8bo7Rsqg+OhJoysbiMYPzi5h2RqeaXuDThdZsYwbqTp8TwWZM+jqlk
         UgOu6SnZeqFeW8Xj6kStna7//KAD3UZgWbZrjAuW6s26VE7BbEcIQBUNoX9aMFiU6L+Z
         dLE64w4GDUtWi37RSuZ1d9WxVpjP49RK3K+Wq5v7gicoRz7EIzvi5ZYxdzLTWpl7G4T3
         776A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e4lQbgEAbEibmWTB+c5ckoz4w1dYM4m2/0D7dQ0Oy3k=;
        b=FAdQ6duw3PL6sMa/SljvEpmt2weBWLJQ3enLeUYZIay8iPaGFakkjPygdKfwkQp3Ml
         hVDl8Vox3jjlOJEoh7j2IvPc8/JCA3/PUKIUYQiW2/9gM0oyWSDjO0hMCcII9Xh09TYz
         gfPf79N+762/6gZeTJ2ey5fzXVaTT8f25OD1ZrImN+aZOG56Py2QAdb12KjmIqav34hb
         OL5aATOcjutkYIJL8x/sT5vS5D1LOX1PI6OXzUrwGLuaUQZ/xvC9L8SNaMi45p5105ZF
         14OjuCAKWOK4sNAG2w5rToYJZEFqI5U5oKD7LpvQZrZDWAwfL7jrzj0foqVa6xPjQ6Rm
         T82g==
X-Gm-Message-State: ALoCoQnZY7LMlFIIr02NZq2afdxkLhmmcFzIXs5kcl6KFSwwVuCrlS+jmu8Mff288FeIK5fWGNgXIz+lT945lJ5yDTMrJF24cw==
X-Received: by 10.98.72.200 with SMTP id q69mr48822831pfi.159.1453260883667;
        Tue, 19 Jan 2016 19:34:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:25db:c0:235a:551d])
        by smtp.gmail.com with ESMTPSA id tm4sm45062673pab.3.2016.01.19.19.34.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 19:34:43 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.g89994f2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284420>

This applies on top of the updated sb/submodule-init branch.

Why?
====
Consider having a real large software project in Git with each component
in a submodule (such as an operating system, Android, Debian, Fedora,
no toy OS such as https://github.com/gittup/gittup as that doesn't quite
demonstrate the scale of the problem).

If you have lots of submodules, you probably don't need all of them at once,
but you have functional units. Some submodules are absolutely required,
some are optional and only for very specific purposes.

This patch series adds meaning to a "groups" field in the .gitmodules file.

So you could have a .gitmodules file such as:

[submodule "gcc"]
        path = gcc
        url = git://...
        groups = default
        groups = devel
[submodule "linux"]
        path = linux
        url = git://...
        groups = default
[submodule "nethack"]
        path = nethack
        url = git://...
        groups = optional
        groups = games

and by this series you can work on an arbitrary subgroup of these submodules such
using these commands:
 
    git submodule add --group default --group devel git://... ..
    # will add a submodule, adding 2 submodule
    # groups to its entry in .gitmodule (default and devel)
    
    
    git submodule update --groups
    # All submodules as selected by groups (submodule.groups in .git/config)
    # will be initialized if they are not, before updating.
    
    git clone --group default,default2 --group devel git://...
    # will clone the superproject and recursively
    # checkout any submodule being in at least one of the groups (default, default2, devel)


Changes to v1
=============

* All entries are stored as separate lines (both in .git/config as well as in
  the .gitmodules file)

* No harm is done to `init` as it is implied by `update` now. :)

* I tried to keep it as simple as possible (update and clone being the minimal set
  of supported commands required, `add --group` being syntactic sugar for editing
  the .gitmodules file.

This is also available at https://github.com/stefanbeller/git/tree/submodule-groups-v2

Thanks,
Stefan


Stefan Beller (4):
  git submodule: Teach add to accept --group
  submodule-config: keep groups around
  submodule update: Initialize all group-selected submodules by default
  builtin/clone: support submodule groups

 Documentation/git-clone.txt     |  13 +++++
 Documentation/git-submodule.txt |   8 ++-
 builtin/clone.c                 |  46 +++++++++++++++--
 builtin/submodule--helper.c     |  30 ++++++++++-
 git-submodule.sh                |  15 ++++++
 submodule-config.c              |  13 +++++
 submodule-config.h              |   1 +
 t/t7400-submodule-basic.sh      | 112 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 233 insertions(+), 5 deletions(-)

-- 
2.7.0.rc0.41.g89994f2.dirty
