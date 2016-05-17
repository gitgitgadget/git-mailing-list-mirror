From: Stefan Beller <sbeller@google.com>
Subject: [RFC-PATCHv6 0/4] pathspec attrs [WAS pathspec labels [WAS submodule groups]]
Date: Mon, 16 May 2016 20:13:49 -0700
Message-ID: <20160517031353.23707-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 05:14:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2VSq-00077N-9m
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbcEQDOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:14:11 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36753 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbcEQDOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:14:09 -0400
Received: by mail-pa0-f43.google.com with SMTP id bt5so1578353pac.3
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SQPEV/6MjpY7QbEPtZoDbasXr5MMYeO7Mpx0FeU12R4=;
        b=EiM/RnQ1M/HcZCQBVJxm7cDGgcMRT73xo3+QlNPKtXukWEGC9sJOF7s0PiI0s/lmNu
         KAtfdJ7AVpHM80Xc+TsUAiNUTlEa2+LyVCVgbXy0tCZl5YhHXwfKM1mQD95BO3b/Lyjz
         /6g7KMRBbH74v3Km1XZBsxHs0Ozl0u56Gy86XiXywP7n3gfP9NOXlkLl0URAcvTSKco6
         Iqisxn9hyZ8nX1mdx+4iOcheRWyv0qrYzmr97wvbYWwyQIIGehsr+aIEiH5f9ilnpD8X
         OYExpMWsc2H8zx4AAqSviMRdcCKOKQqzeXbFAD7c+82AOH96q3mzUe8lyXiLnShxoOIo
         BBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SQPEV/6MjpY7QbEPtZoDbasXr5MMYeO7Mpx0FeU12R4=;
        b=RtV8pOOtTj2KITQojgwPkybKInBtu+sLsjLcHsp6/XKkKmGYhhLMbqE5gdTO7OoUNO
         kOH/c+PE5yH1oCDDaSK+AzMO2na4m7UJ8/TQqFQs7nU6nGHE062TD3/LgxEi594evVB4
         4TKt8GBgIyugIh5ZBepSdJ9wvJgulVQ0MI4c8oBeM9Jl+P2vJKJJq0N2IfDAmqjRC0c1
         nlkQwaiq62z90QY3ibc2zz/MxKbyZvwxEuaDbF9YQvesg++/NrYmkpa8b9vTB3k0lQha
         Do9A+k8LG4mADf4ZqPfyjaw8RGYoaiBjmWT+ppmgwGpOqDGy1CrcXOadGzQgXofxOqlW
         0v8Q==
X-Gm-Message-State: AOPr4FXndMUkNSv+XEmlwAFWBE25rh9Tr6UrwSkQgkCirMazY0mp/3p20IfByiogq9QBEbTu
X-Received: by 10.66.160.133 with SMTP id xk5mr50431295pab.71.1463454837473;
        Mon, 16 May 2016 20:13:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id ve11sm499952pab.21.2016.05.16.20.13.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 20:13:56 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g9c0faef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294836>

  This goes on top of origin/jc/attr and is RFC as
  I did not write tests nor documentation, yet.
  I wanted to understand Junios series, so I built on top.
  
The meat is in the last patch, which allows for

    git ls-files :(attr:-text)path/pattern       # (ATTR_FALSE)
    git ls-files :(attr:+text)path/pattern       # (ATTR_TRUE)
    git ls-files :(attr:eol=input)path/pattern   # values must match
    
    git ls-files :(attr:!text)path/pattern       # find patterns with no "text" attribute, i.e. neither FALSE, TRUE or value
    git ls-files :(attr:text)path/pattern        # opposite of !;  find files which are TRUE, FALSE or value
  
Of course you can chain them:

    git ls-files :(attr:text,attr:eol=lf)path/pattern # must match both attr specs.
    
Feedback on the parsing and design welcome,

Thanks,
Stefan
   

Stefan Beller (4):
  Documentation: fix a typo
  pathspec: move long magic parsing out of prefix_pathspec
  pathspec: move prefix check out of the inner loop
  pathspec: allow querying for attributes

 Documentation/gitattributes.txt |   2 +-
 attr.c                          |   2 +-
 attr.h                          |   2 +
 dir.c                           |  49 ++++++++++++
 pathspec.c                      | 172 +++++++++++++++++++++++++++++++---------
 pathspec.h                      |  16 ++++
 6 files changed, 203 insertions(+), 40 deletions(-)

-- 
2.8.2.401.g9c0faef
