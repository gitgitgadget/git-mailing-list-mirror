From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <mtzguido@gmail.com>
Subject: [RFC/PATCH] Ordering of remotes for fetch --all
Date: Mon, 25 Apr 2016 23:15:05 +0200
Message-ID: <20160425211506.8421-1-mtzguido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <mtzguido@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 23:15:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aunqm-0006Ds-LO
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbcDYVPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 17:15:18 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38541 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933361AbcDYVPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:15:16 -0400
Received: by mail-wm0-f43.google.com with SMTP id u206so147879190wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rLX5MSlARh/xu8Vxfs7765U7supsTeFHXOhBtCT86yY=;
        b=x/bM4qNTS0jOojppzyrbmHwyFSTxvyjZFYs/ON33qb0m/RrwaIPDSgeoCibVliuPBS
         uk1ZJUSTDPTQ/oFW+O0dmJobU3eKBBxXiWsjHAmNctioE44u1YmZtAmnure4QjybA5H/
         NKU372rj3O/qFqm5h08NH9PILkAI3cUh3azf1LQC8n4fIr97oIqQhL51Y6E/Xhmn8F3l
         eDP44Yuss4ZIrgIK7AdON/GwB01wH30/lIztHifj9qZUGbjOM2lY1gTMc46lTmC6bi5k
         SCTAM/8sJlFBFlO2cAqiWyS5dfW+6zgPqKDTbZruSDeEoKDo4uhOO2AeAZTYCT4r/B7I
         VL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rLX5MSlARh/xu8Vxfs7765U7supsTeFHXOhBtCT86yY=;
        b=mMeZPmyBeeeT4hUFC/Z5xv3kLya5KmO1PwbQ3y6ZlWnH7wn7FXJojw3HOGDLqP3vj4
         NaJAq1UjHsxz6201A5PXnUnJ6gvR+mDnEjiyYOJHZWUzm1B9+bz8cQaNghFTGHMSwoEM
         RJ+EfiAYw2s0+4cKYBZKkmtr4x+5JS2aeQ/txhllJx5vMIFGRq4hjFE7/+rX7yR/egeq
         hG9IE7SKZK84zTXo/EnGWF00ZKLOzviR+lJCtX2o7xhsGWuLnQNo3StXfYCo+WvtV9w+
         C3qgntThIXw51sDF+2Y1GeTftBh4C+LRQV9DL3cqKy+oDqmR9uZjfIhmUS4PP0SMZqzY
         vrmA==
X-Gm-Message-State: AOPr4FVQuRXtOZBrudAOEfglNe86LDyAJa+vYXyfGexoQ7Fieio9sCfY5rPjz6Mz0wMjDg==
X-Received: by 10.194.163.229 with SMTP id yl5mr33570185wjb.6.1461618915034;
        Mon, 25 Apr 2016 14:15:15 -0700 (PDT)
Received: from localhost ([78.250.243.110])
        by smtp.gmail.com with ESMTPSA id w79sm20580611wme.19.2016.04.25.14.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Apr 2016 14:15:14 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.281.g0994585
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292560>

Hi all,

I run a server with several git mirrors, that are updated every hour. O=
n
that same server, users clone those projects and work on them. We use
the local mirrors to reduce network load: the users can fetch from the
mirror first (to get most of the objects with zero network cost) and
then fetch the real remote (to make sure they're completely up to date)=
=2E

I would like this to be configurable in each git working directory,
so users can just configure the order they want and then just do "git
remote update".

I'm aware one can get this behavior by editing .git/config and
ordering the remotes as one wishes, but I find that very hacky and not
scripting-friendly.

This patch introduces a fetch priority for each remote, at a default of
50 and modifiable via git config. This new order will only matter when
doing fetch --all.

Do you think this is a useful feature? Hopefully you don't consider thi=
s
as just noise :)

(As a side note: for ordering the remotes a stable sort would be best,
to have the least impact possible on current behavior. I believe
git_qsort is stable but a confirmation would be nice.)

Thanks!
Guido

Guido Mart=C3=ADnez (1):
  remote: add a fetching priority to each remote

 Documentation/config.txt |  5 +++++
 builtin/fetch.c          |  2 +-
 remote.c                 | 43 +++++++++++++++++++++++++++++++++++++++-=
---
 remote.h                 |  2 ++
 4 files changed, 47 insertions(+), 5 deletions(-)

--=20
2.8.1.281.g0994585
