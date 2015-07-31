From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 0/2] Submodules: refactoring the `module_list` function
Date: Fri, 31 Jul 2015 16:09:05 -0700
Message-ID: <1438384147-3275-1-git-send-email-sbeller@google.com>
References: <1438301956-1658-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
	hvoigt@hvoigt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 01:09:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLJQq-0001Q6-5X
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 01:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbbGaXJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 19:09:36 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34587 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbbGaXJe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 19:09:34 -0400
Received: by pdbbh15 with SMTP id bh15so49303752pdb.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 16:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mi0yPVKzDst4HgDI6+ztI2VVHAtJYTyei3HH+0gHZws=;
        b=hSfMw5Fvzwcoo/5Y7f33yJDS3MKkKJwUh4AFtCBQmiZcK722mK94UVs8BEoZcKWGCl
         G64ZNCbMkJeDxhtEsAyhkbjAbZmt0uDSgmBBVCSXqiHhpulJmZuAF4CmjTPFZlrGOzGb
         Rwii4gzTp5pADL7yQs9yNWZuv4QMU8yJkDQejpQbUs51tIYmWsoeeWxYiyd6YN/Tv4Yl
         mhMACmFemXHs1xkvtCZ5+4yODDC4QmescW0bOe6uR2yTc9/FI3WUr83G0VP/lrkzij1R
         wCJEdX+Grm1mABoENlfiasaA32jBozcC9aP+NzFP77YRfJObkg2wwWGKaUxoaGpf+klu
         5G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mi0yPVKzDst4HgDI6+ztI2VVHAtJYTyei3HH+0gHZws=;
        b=YvuHARtraNwqOxOZZFNyyhzQO8F6wkcqEcQIGM5OEU04S0I8r742OMXgSoCnKcw/8S
         wFwh5an3v5Fv64iv6E/8qahl5zvDriKRBOx+Z0aeeouRZFAOQSGIpYyI+LmY89m8gaB0
         rOct9zScdXBokui8BAfAWKPMWFLc1FPg/m2zprDBhU17kCgF1zMYLtdYpYFv16MC6QYY
         R2g+q/gl5iBbD4z1WGP/G9EsPaAJ7+j1ITAFUL4eBw5EAkQWYzg4CYkPOK/YXEMacjqw
         aQcxEa19CsdoKWoi/FOumGmXT5AexWQ6lzqiTc9oHfb1iJ7/DvdM5xBaS8u7HNiU3KgV
         VAgQ==
X-Gm-Message-State: ALoCoQnyQ2RsHi6fmksKwStaC+Cbnj3DNoXEGYQYiDYdM9osQKxBOdyvfspniAIs2jRwnbKD3HMY
X-Received: by 10.70.41.130 with SMTP id f2mr12303511pdl.86.1438384173521;
        Fri, 31 Jul 2015 16:09:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e5af:ce62:986f:5269])
        by smtp.gmail.com with ESMTPSA id p1sm9636037pdb.3.2015.07.31.16.09.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 16:09:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.5.gf4cd9ae.dirty
In-Reply-To: <1438301956-1658-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275088>

Hi,

so eventually we want to have the whole Android project inside a git repository,
which includes > 500 submodules for the different sub systems. To make that feasable
we want to improve git-submodule for a huge set of submodules such as parallelizing
`git submodule update`. As a first step I was toying around the `module_list` function
as that is one key component for all the submodule operations. Also that part of the
code is where the operations are split up to the different submodules, so that
would be the natural place where we'd approach introducing threads later on.

This is an early RFC as it breaks the test suite. I do not remember ever interacting
with pathspecs or cache entries before, so I'd appreciate some guiding comments.
(Am I holding it wrong? Also the git code base seems large, it's easy to find new
playgrounds :)

Thanks,
Stefan

Stefan Beller (2):
  submodule: implement `module_list` as a builtin helper
  Testing the new code

 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/submodule--helper.c | 99 +++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 25 +++++++++++-
 git.c                       |  1 +
 5 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 builtin/submodule--helper.c

-- 
2.5.0.5.gf4cd9ae.dirty
