From: Santiago Torres <santiago@nyu.edu>
Subject: [RFC] tag-ref and tag object binding
Date: Mon, 25 Jan 2016 16:22:09 -0500
Message-ID: <20160125212208.GB26169@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 22:22:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNoaX-0004Zk-UY
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 22:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193AbcAYVWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 16:22:13 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34980 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729AbcAYVWM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 16:22:12 -0500
Received: by mail-qg0-f54.google.com with SMTP id o11so119421622qge.2
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 13:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition;
        bh=QLiiKL/CQ4d+zLupo9gT27vIICBHnlZUwloqFZUrMUU=;
        b=GQG5jybWDKfWZ5H0Dsy9o8rHoXNo/TMulTrIUp/8xXyhxMXbuszVMZnX4HGebZicW/
         bFNiWGXqI+YfqH6lPRTyNmAICb2PVtxEfe8o2aJHsAtHSDUV0c3+zQIKZE1k2fNJTV9Y
         SKFWlhTyrHh5Iv1R723UxnF14oNADTWHA//Tucbhz/e8uKi0x/VC0aviDW79qkDYZMw0
         1QmZiKLAVVtCEFm+Eg+eowlUWtDJQrKqSc3HMuupBeR++TCi72RMczD/o96Oxts64zjL
         9INj3LX1VUtsQKl7iAPu2JP5Q1Sr6ZU6i1ZuvT4TurAkGkqZvpsgWgxME6QQVTpEsQrn
         mKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition;
        bh=QLiiKL/CQ4d+zLupo9gT27vIICBHnlZUwloqFZUrMUU=;
        b=WS7aqF0ax/DjARbI6jk2zGIjXiTqDDUA1PHH0x2R+XbpNaAzgS7Cj0lfogX8QpCsoq
         L8yx1eG1zDc6dX18/cdsd/18Z0OjiipqEZX3S4tSG04dNhGOvrBXl302YM8c6VKXfK3c
         FfUmf+7NZcuWNKTJWrPG7XQn0WvPJL6Ozoxt3Mz5r6yJwt/2tYLHbRRWUkfQd/+WoKpb
         gLb1oHbVI4IkuiimDLf+IN2QlS8zy9ffRZ092XfC0kovuKAbO2VInlmkP//3Rq7ciksy
         a+NEe6zj9Jljg684OkhRZoaBWcixaSl2yKrZvBPK1rFRoCRxyJ6ao2wKtxBFYnOnsBwk
         NQDA==
X-Gm-Message-State: AG10YOQWADomeLbxeizZeC5PWF1uXeFLtETsWnwpuLL2iTnCm7ghcLB9woeYUeLH49uV8xge
X-Received: by 10.140.195.136 with SMTP id q130mr25205109qha.45.1453756931172;
        Mon, 25 Jan 2016 13:22:11 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-18.NATPOOL.NYU.EDU. [216.165.95.7])
        by smtp.gmail.com with ESMTPSA id u78sm9464129qge.27.2016.01.25.13.22.10
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jan 2016 13:22:10 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284757>

Hello everyone.

I've done some further research on the security properties of git
metadata and I think I've identified something that might be worth
discussing. In this case, The issue is related to the refs that point to
git tag objects. Specifically, the "loose" nature of tag refs might
possibly trick people into installing the wrong revision (version?) of a
file.

To elaborate, the ref of a tag object can be moved around in the same
way a branch can be moved around (either manually or by using git
commands). If someone with write access can modify where this ref points
to, and points it to another valid tag (e.g., an older, vulnerable
version), then many tools that work under the assumption of static tags
might mistakenly install/pull the wrong reivision of source code. I've
verified that this is possible to pull off in package managers such as
PIP, rubygems, gradle(maven), as well as git submodules tracking tags.

In order to stay loyal to the way files in the .git directory are
ordered, I don't think that making the ref file (or packed refs) files
differently is an option. However, I think that it could be possible to
store the "origin ref" in the git tag object, so tools can verify that
they are looking at the appropriate tag. There might also be a simpler
solution to this, and I would appreciate any feedback.

What do you guys think?

Thanks!
Santiago.
