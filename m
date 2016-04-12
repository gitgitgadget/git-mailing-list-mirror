From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] clone --shallow-submodules flag
Date: Tue, 12 Apr 2016 16:48:46 -0700
Message-ID: <1460504929-19208-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 01:49:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq83I-00036F-NV
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965353AbcDLXs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:48:56 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36486 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965037AbcDLXsz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:48:55 -0400
Received: by mail-pf0-f182.google.com with SMTP id e128so22677697pfe.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 16:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yVhNC03PHyJ5ZIdeq8tipf47O/Ksz1/xofUYLbc8Vgw=;
        b=gUX5b6HdEKDS7RkC3ildXN+JJGlXxRqECX6b+LHo2RTsMrRpugMkOLbw9y4bhqKwC1
         uWU0E/k0qVmhI0PfkjTiwDk5Rs1HfnzwXodo7ZmW3kCNCNmdx6PLODuMoB8OEb7FtSuD
         rotTul/+ZJsSQT6LEFCx/D8vstv2Lv9iZGV/D6MN5olI90gF3Chf6VhgGRDNcZkKjhYC
         3jXfCwxezhEA49R1q21M/esdEz8zIwGFQXCm1x3z/UYzDA1k6gFkdV8KIbjviegcRNCP
         WHRkS6CiDb83lXe5i0JDUAQ1EpAP4fazDTEGacVrKsju9wp7OzAJCiaKzzRwv/h0/iIq
         jl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yVhNC03PHyJ5ZIdeq8tipf47O/Ksz1/xofUYLbc8Vgw=;
        b=RiLwHEH9EuLkw7elKGispBXPJLe3QwVkTJ89ND2cxqoiqpr/bd04Dye599znIDcvI7
         PXBHWX0hVb7uY8nprj4SKgLkGbyiyn+l3Zn4GvK5Cs5/Na2L765LPfeEJTSQvIq57ssd
         fzvgzBf6dLQclF87+vUT04y2KXclRXbczkuMEyr8Kn0zdSf+KYJB45e8xZUxRkes1BgP
         e8j66lE/PxW8YuWS79PjFJGvJv+mnMF3je8e5BPQRRL8VEoSmKj8QZpZgwIVdal501X7
         pXP1x0o7j+6PBwoXDWto4XJoMXETy6kDu48DijaXfBL4d2w/8+jvxGlRl/yDj/MnyCUv
         28eg==
X-Gm-Message-State: AOPr4FXVJ8aKPkY/eQfgLSyvbhRi/PAILYNpJKSTPcZp+t10HOi/s0HPhGqpeEDrpUpUgKND
X-Received: by 10.98.23.201 with SMTP id 192mr1941691pfx.122.1460504932324;
        Tue, 12 Apr 2016 16:48:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:705c:1d3d:8d56:4629])
        by smtp.gmail.com with ESMTPSA id f12sm46110579pfd.87.2016.04.12.16.48.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 16:48:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291332>

(This is a resend of a series from March 15th, titled 
"Towards sane shallow clones with submodules", this series
applies on top of sb/submodule-parallel-update,
it replaces sb/clone-shallow-passthru)

When creating a shallow clone of a repository with submodules, the depth
argument does not influence the submodules, i.e. the submodules are done
as non-shallow clones. It is unclear what the best default is for the
depth of submodules of a shallow clone, so we need to have the possibility
to do all kinds of combinations:

* shallow super project with shallow submodules
  e.g. build bots starting always from scratch. They want to transmit
  the least amount of network data as well as using the least amount
  of space on their hard drive.
* shallow super project with unshallow submodules
  e.g. The superproject is just there to track a collection of repositories
  and it is not important to have the relationship between the repositories
  intact. However the history of the individual submodules matter.
* unshallow super project with shallow submodules
  e.g. The superproject is the actual project and the submodule is a
  library which is rarely touched.

The new switch to select submodules to be shallow or unshallow supports
all of these three cases.

Changes to the previous series:
 * Reordered patch 1 and 2, as it sounds like a more natural ordering.
 
Any comments welcome!
Thanks,
Stefan

Stefan Beller (3):
  clone: add `--shallow-submodules` flag
  submodule clone: pass along `local` option
  clone: Add t5614 to test cloning submodules with shallowness involved

 Documentation/git-clone.txt | 13 +++++--
 builtin/clone.c             | 21 ++++++++++++
 builtin/submodule--helper.c | 22 ++++++++++--
 git-submodule.sh            |  7 ++++
 t/t5614-clone-submodules.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 6 deletions(-)
 create mode 100755 t/t5614-clone-submodules.sh

-- 
2.5.0.264.gc776916.dirty
