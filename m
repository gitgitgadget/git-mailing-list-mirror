From: =?ISO-8859-1?Q?Jens_Lindstr=F6m?= <jl@opera.com>
Subject: [PATCH 0/2] remote: optimize rm/prune ref deletion
Date: Tue, 20 May 2014 12:34:12 +0200
Message-ID: <537B2FA4.7020001@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 12:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmhNa-0000tb-Iw
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 12:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbaETKej convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2014 06:34:39 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:45588 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaETKeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 06:34:37 -0400
Received: by mail-la0-f42.google.com with SMTP id el20so226052lab.1
        for <git@vger.kernel.org>; Tue, 20 May 2014 03:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=BZEI5bkwJ1jZF2icmzBzd4/nVyO8DVqhlE6ExmrWkNk=;
        b=DxqdCb0t70oV0jkJr82F/UFExzRZaDLcpqI4uBa6LHJCGB1hmG65gjcrCHPK/1vsSf
         mTiRg4YX5Ww/JiEBBQm6ybj5o0beoLVktSFrBx2AZQTzen9xORduI/QQqe/BfR0WeB3a
         4l/HwN/1rUX0+jZHR2XxeyFkpczqH4MxWqCNxKvHfFx+dZs9sa4LoViYlur7mVI2bKIb
         ZvLGDHlEDf13eahOwuUfbo0pwtdXQQukQ2NN206PmvChIwwR+jHRmWaVsZreI5kVw/J8
         gW7v8ZzyMeLeo9fvp/fFeWn+X62573ORCLQpNqjQL1h4fAsgMPB7cKmKGqPrcLvPEzBA
         maew==
X-Gm-Message-State: ALoCoQnu1agluGY4n2L/I8bv+K+sQU9twFSmNtEiXie5C+lpyx0FctOb2LY10BrRZTluAjy9JBi4
X-Received: by 10.112.67.35 with SMTP id k3mr29465886lbt.17.1400582076305;
        Tue, 20 May 2014 03:34:36 -0700 (PDT)
Received: from [10.34.0.102] (77.72.99.119.c.fiberdirekt.net. [77.72.99.119])
        by mx.google.com with ESMTPSA id to10sm20426099lbb.11.2014.05.20.03.34.35
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 03:34:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249658>

At work, we have some shared repositories with far too many refs in
them, which causes various issues, performance and otherwise.  We plan
to move most of the refs out of them, but for that to help users that
have already fetched all the refs into their local repositories, those
users should want to run 'git remote prune'.

It turns out that 'git remote prune' (and also 'git remote rm') has
its own rather severe performance issues relating to removing the
obsolete refs from the local repository, which I've addressed in the
following patches.  The performance improves from many CPU minutes
(long enough that I could never be bothered to let it run to
completion) to around a few seconds, when removing ~15000 refs.

Jens Lindstr=F6m (2):
  remote: defer repacking packed-refs when deleting refs
  remote prune: optimize "dangling symref" check/warning

 builtin/remote.c | 25 +++++++++++++++++++++----
 refs.c           | 34 +++++++++++++++++++++++++++-------
 refs.h           |  4 ++++
 3 files changed, 52 insertions(+), 11 deletions(-)

--
1.9.1
