From: Paul Sokolovsky <paul.sokolovsky@linaro.org>
Subject: git 2.2.x: Unexpected, overstrict file permissions after "git
 update-server-info"
Date: Mon, 5 Jan 2015 21:07:24 +0200
Organization: Linaro
Message-ID: <20150105210724.032e9718@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 05 20:08:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8D06-0000LE-ND
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 20:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbbAETHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 14:07:34 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34906 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbbAETHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 14:07:33 -0500
Received: by mail-lb0-f170.google.com with SMTP id 10so18488556lbg.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 11:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:subject:message-id:organization
         :mime-version:content-type:content-transfer-encoding;
        bh=CmdVWILPTrPgyJ3hPoan/teCYYGu1Rv2IHL7qwCv/68=;
        b=aqKe50aS/3odSTMfOs2UgBd68GgQXzdgbQpRF1x5z1ny9AwD7na6Fsm79syAUNoUl4
         MxNPURw17x4vdRVy1RSzs0B0RLmzpJ/TIsZvkfvBFmZUCh3KDnZ/VGNerfJrH51zCpZk
         KyzayN9r+nPe01J9VgWQJ6Zks8qYcR+09DfnvxdDljz10qRr4JdLjNcwm7aY+wGQtvPI
         2YzoY62wLOtQ11h1lVmSZC92f8wPHoOQUheWMFN7CjkhzWlLzuL+m+U3sHpaPSHWNxnk
         ZE1Z9fL83vLNofxb1gqKgi+R58TIzkecrhHZs6Q1wODa2UM4dDnD+BSIhVlHpg87Pg6B
         X9+A==
X-Gm-Message-State: ALoCoQknHC42ofCMLTSDGChALtFvynD+VHMp4u5hsdWzI2YQHZYyB8E9w3T8idw3K02AnnrzDXuo
X-Received: by 10.112.135.99 with SMTP id pr3mr41061489lbb.61.1420484851251;
        Mon, 05 Jan 2015 11:07:31 -0800 (PST)
Received: from x230 ([91.225.122.14])
        by mx.google.com with ESMTPSA id i7sm13546520lai.22.2015.01.05.11.07.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 11:07:30 -0800 (PST)
X-Google-Original-From: Paul Sokolovsky <Paul.Sokolovsky@linaro.org>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262026>

Hello,

We recently upgraded to git 2.2.1 from 2.1.x and faced issue with
accessing repositories over dump HTTP protocol. In our setting,
repositories are managed by Gerrit, so owned by Gerrit daemon user,
but we also offer anon access via smart and dumb HTTP protocols. For the
latter, we of course rely on "git update-server-info" being run.

So, after the upgrade, users started to report that accessing
info/refs file of a repo, as required for HTTP dump protocol, leads to
403 Forbidden HTTP error. We traced that to 0600 filesystem permissions
for such files (for objects/info/packs too) (owner is gerrit user, to
remind). After resetting permissions to 0644, they get back to 0600
after some time (we have a cronjob in addition to a hook to run "git
update-server-info"). umask is permissive when running cronjob (0002).


I traced the issue to:
https://github.com/git/git/commit/d38379ece9216735ecc0ffd76c4c4e3da217daec

It says: "Let's instead switch to using a unique tempfile via mkstemp."
Reading man mkstemp: "The  file  is  created  with permissions 0600".
So, that's it. The patch above contains call to adjust_shared_perm(),
but apparently it doesn't promote restrictive msktemp permissions to
something more accessible.

Hope this issue can be addressed.


Thanks,
Paul

Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
