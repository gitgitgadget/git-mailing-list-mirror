From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2 0/6] convert various shell functions in git-bisect to C
Date: Wed, 15 Jun 2016 19:30:20 +0530
Message-ID: <20160615140026.10519-1-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 16:01:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDBO0-0006kx-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 16:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbcFOOBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 10:01:36 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35268 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbcFOOBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 10:01:35 -0400
Received: by mail-pf0-f195.google.com with SMTP id t190so1870495pfb.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X18tKBXme2oJzaBnM+bVB26QCjJTkQVzIs84xv3Gwxc=;
        b=Xzl3hlmrMCLh5jl7DPex0IHemW0oHxYDa7suq46jzRdneeIhMyIDFOnrzMwKipp6Do
         RK5jwZBSLxbK5tYdd0tO/zAw8MyQ/15GVSs7aR617WvStAOIwdzM3mR1tJPaLQvv/vgu
         vtvKsHGN+bfBUA2UH1VtEzT9uNrI49aON1IDn/VpjqMCa8brSjU844jrwHmJkMqEJSu0
         TbgfCwC/l7i6WfVeuOhGn452VbUW9CeYTVyE3ha3vx1LZokGwZGaMR/A/3r4Ngznw8SG
         7uUhMmgbNE/kM7jI7HNHq0uX6ktECBTpjHQc0SZt8ZTm+QxOvkm33CRhzuvtXTNEltod
         RrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X18tKBXme2oJzaBnM+bVB26QCjJTkQVzIs84xv3Gwxc=;
        b=IxSvYmvha57K9ZppKyNk1/W7gC59ZrvLevOTRyPoaDkKMHD9QYKmeHmws/4C6DrAGr
         Foe85FKNF7oLvX3yjyuKv1H2zCdqK8n28DNCljOdqWjdSy9egzM3uOQ0ZykiU+sFUw1q
         b7J5uBVGqC/7LkAV74JuZLXhESRKSOn00Ypq7McfYgtErTDvoiJA7kFTH10QqxC1vPu1
         O5MGL1UBt08jtuv7YRfZ1O5KKo4B9Vg/iAGI5lnDrCxBPdgFh4JFBJZdJ8MumlKWxOxY
         ufpDkorMcJxOth2CumjLYVkoLnKvqgdL+qCmXYUSuV3+gXmQ3xEsgoB+SNk6iOf3GV00
         35DA==
X-Gm-Message-State: ALyK8tL+vl4CfQt/4s7PlOzi9xKdu23Rc+rcFJlqe0w3d9vWJBHbk2P5+tt1PPqbD0x9tg==
X-Received: by 10.98.62.220 with SMTP id y89mr4120845pfj.9.1465999294869;
        Wed, 15 Jun 2016 07:01:34 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.188])
        by smtp.gmail.com with ESMTPSA id i5sm37514156pfk.14.2016.06.15.07.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jun 2016 07:01:34 -0700 (PDT)
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160607205454.22576-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297372>

A previous version is available here[1].

Changes wrt previous version:
 * Use STRING_LIST_INIT_NODUP to avoid leaks in bisect_clean_state()
 * Use test_path_is_missing in the patch 2/6
 * drop file_size()
 * move is_empty_file() method from builtin/am.c to wrapper.c
 * use static for methods
 * remove the variable status in bisect_reset() altogether and put the whole
   thing inside the if block.
 * one more method converted namely bisect_write().

An important thing to be discussed:
In shell script while reading/writing files, no error is reported but we can
actually report it in C. In this series I have tried to output error wherever
possible. What are your views?

[1]: http://thread.gmane.org/gmane.comp.version-control.git/296717

Pranit Bauva (6):
  bisect--helper: `bisect_clean_state` shell function in C
  t6030: explicitly test for bisection cleanup
  wrapper: move is_empty_file() from builtin/am.c
  bisect--helper: `bisect_reset` shell function in C
  bisect--helper: `is_expected_rev` & `check_expected_revs` shell
    function in C
  bisect--helper: `bisect_write` shell function in C

 builtin/am.c                |  16 ----
 builtin/bisect--helper.c    | 194 +++++++++++++++++++++++++++++++++++++++++++-
 cache.h                     |   3 +
 git-bisect.sh               |  97 +++-------------------
 t/t6030-bisect-porcelain.sh |  17 ++++
 wrapper.c                   |  13 +++
 6 files changed, 236 insertions(+), 104 deletions(-)

-- 
2.9.0
