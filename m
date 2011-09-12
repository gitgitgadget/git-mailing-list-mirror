From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFC 0/2] format-patch: produce non colorized patches when color.ui=always
Date: Mon, 12 Sep 2011 23:56:54 +0800
Message-ID: <1315843016-10959-1-git-send-email-pangyanhan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, martin.von.zweigbergk@gmail.com,
	sdaoden@googlemail.com, ib@wupperonline.de,
	Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 17:59:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R38uh-0003Zs-Hd
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 17:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758225Ab1ILP7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 11:59:08 -0400
Received: from mail-qw0-f42.google.com ([209.85.216.42]:59656 "EHLO
	mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758077Ab1ILP7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 11:59:07 -0400
Received: by qwi4 with SMTP id 4so3717594qwi.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=jDhAEixrahzAvkan+HI5s5pt1eaNankkqSpiD/k8xn8=;
        b=nm1luTUKXGtk9SDKivcHX/TIqaj7xs+mkYunwUZJzFT3mmQa76CuBj7NASZH3JYpmH
         Na/NOqwVHkZiazvwZAYPnJHYASWAGI0iVgq1CuarAp9h7qWMrz3gSQmiWui138uwwBOK
         uOSvZuTtCSTFLaR0N/NXyk9g56PpvQdg9aoGk=
Received: by 10.224.78.146 with SMTP id l18mr4071140qak.81.1315843146578;
        Mon, 12 Sep 2011 08:59:06 -0700 (PDT)
Received: from localhost (bb219-74-111-93.singnet.com.sg. [219.74.111.93])
        by mx.google.com with ESMTPS id el2sm12902421qab.2.2011.09.12.08.59.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Sep 2011 08:59:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.190.gee9b6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181218>

Hi list,

commit c9bfb953 (want_color: automatically fallback to color.ui) introduced
a regression which causes format-patch to produce colorized patches when
color.ui is set to "always".

Since patches are ultimately intended for machine consumption, having color
codes present in them is undesirable.


My understanding of the codebase is very limited. I've looked into builtin/log.c
and the call chain which causes format-patch to produce colorized output is:

git_format_config
  |_ git_log_config
       |_ git_diff_ui_config
	        |_ git_color_config
			     |_ git_config_colorbool

which causes git_use_color_default to be set to 1 when color.ui is set to
"always".

I believe that I can assume that the parsing done in git_diff_ui_config is
related to the [<common diff options>] based on git format-patch manpage?

I've introduced a color_disable function in color.c which changes
git_use_color_default to 0. This is the simplest solution I can see without
heavily touching the stuff in the call chain above since they might be
needed for format-patch.

I understand that this is very hacky but well, I'm really looking for ways
to contribute to Git and this seems like one.

Any advice on how this can be better solved is deeply appreciated.

Thanks.


Pang Yan Han (2):
  format-patch: demonstrate that color.ui=always produces colorized
    patches
  format-patch: produce non colorized patches when ui.color=always

 builtin/log.c                 |    1 +
 color.c                       |    5 +++++
 color.h                       |    1 +
 t/t4051-format-patch-color.sh |   23 +++++++++++++++++++++++
 4 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100755 t/t4051-format-patch-color.sh

-- 
1.7.7.rc0.190.g816e
