From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] work around gcc 4.2.x compiler crash
Date: Mon, 21 Mar 2016 00:35:56 -0400
Message-ID: <1458534958-6956-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Renato Botelho <garga@freebsd.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 05:36:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahra3-0004oe-RY
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 05:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbcCUEgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 00:36:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34132 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbcCUEge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 00:36:34 -0400
Received: by mail-io0-f195.google.com with SMTP id o5so13081563iod.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 21:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=j1WjauaHEOu6g3h6311u/+epai/ryDuLA5Tv2t8b8yA=;
        b=kqLGz+vG4d+i8ZU1b7pVEoKdCaNQLmADVKwEr8CvUXW6Tdq05GC3gsPJDDa1xSFKku
         hsrtSw4yhFbu1xmbHLsDG49GtH0arXKBBsCgUfalflZDrymW1cNpBjxbhLolWVKsqsEB
         KpIRikdD3T7YyNCnV7sv5uol3RoJjas2JMnLgWQSw/G3t+Dh01vx9LLkAfTAIRuWEQCf
         IWHBLAC1T13DrfPDSldcOuP3RQ6fgtMABtDVf4Qf6agqamt3YDIUb3KswXXQk3ALwVKU
         wOmyAQI6DKE+3nRZF6dHOiEqaKxZIx1CoCHfnRZUIbk9xbukGW8p2lgu8f1avXmu1Z9c
         TV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=j1WjauaHEOu6g3h6311u/+epai/ryDuLA5Tv2t8b8yA=;
        b=BjKpFhobGn0utKDey7rEFAx4DNMEWBtkwYyaQqdGq35jSBs+hMs9nQOJHuu+YHihjf
         C0KSYjT6Hvy2O2dYDVmFCe0YpsQ2xx50glhdX6vQlG/4HN/8NMTqfl2v+qCv1eaGq6sM
         ERJAJCyguZ8XRJugZg1VtOpmq3huVHKHM+BeqaLaS7Ifc/CSgwTSVaHhSH2Nasi6r4Qa
         in/lqV6bAlRLsyyiAmpjXbjwrYFKdnv1dguATJRpWAXpUPv8oTMjxVuKyZZQAaikCmc2
         FzciUS90UhZda1jErph+ngUudNPIqNe8WKOcl42gbmWLuEACODwlcmBo/PZwm0gX4Y3r
         AZWg==
X-Gm-Message-State: AD7BkJLAiqgxiYJJqFlfUPp18UScbMXQjHnmiOKhACBPbFnGJQbpqFgFQXDIbuqYnYK8Mg==
X-Received: by 10.107.11.10 with SMTP id v10mr25876550ioi.188.1458534993722;
        Sun, 20 Mar 2016 21:36:33 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id i187sm10725620ioi.33.2016.03.20.21.36.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 21:36:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.240.g104e649
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289397>

This patch series works around a gcc 4.2.1 compiler crash reported on
Mac OS X[1] and FreeBSD[2] which is triggered by perfectly valid change
from 5b442c4 (tree-diff: catch integer overflow in combine_diff_path
allocation, 2016-02-19).

patch 1: sidestep the problem via a simple re-ordering of macro argument
    evaluation

patch 2: revert an earlier Mac OS X 10.6-specific work-around which is
    no longer needed

[1]: http://thread.gmane.org/gmane.comp.version-control.git/287486/focus=287706
[2]: http://thread.gmane.org/gmane.linux.kernel/2179363/focus=289357

Eric Sunshine (2):
  git-compat-util: st_add4: work around gcc 4.2.x compiler crash
  Revert "config.mak.uname: use clang for Mac OS X 10.6"

 config.mak.uname  | 3 ---
 git-compat-util.h | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.8.0.rc3.240.g104e649
