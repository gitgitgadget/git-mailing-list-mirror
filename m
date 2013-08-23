From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] fix t3010 failure when core.ignorecase=true
Date: Fri, 23 Aug 2013 00:29:13 -0400
Message-ID: <1377232155-7300-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 23 06:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCj0J-0006kG-O4
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 06:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab3HWE3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 00:29:39 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37850 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab3HWE3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 00:29:38 -0400
Received: by mail-ie0-f182.google.com with SMTP id aq17so146916iec.27
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 21:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=8aIZ3/LajUwmjOZAHV/27cpU6n39Jui4+25juEhailc=;
        b=vI3TjdPP9YCWg2zHb4NcjEdTz7Sckn/ObvhWJKtdwZ0E+3aZ7+PfdHE/MQdttfTlNx
         x3BAC5n9CWeUv+cZXeVIfoimgSpGXzqIZCC+ZHIkF6mMloe2HT0U/JtLAvarw/KYykty
         Q6Mo6Yg3388X6OTFjII+H1v4d7G70NoMM5kyTIKCdKywKmsfAnUVlB3wfjARfTsd9mmO
         2doqxjRPAOD2X4jboZK6rzDwTm5eskgr+nhptb3V6G+kPfAtMWIVjw+VI2pFix5aVFM+
         Ef1Nn13cKFLGmSpfXWmoI/VNs6c193k+JQffu5TmvgKVYSWtImCUc1SkRSAHxyqX4B9X
         VVIA==
X-Received: by 10.42.65.4 with SMTP id j4mr178267ici.23.1377232178276;
        Thu, 22 Aug 2013 21:29:38 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id p5sm1090591igj.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 Aug 2013 21:29:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.529.g78818d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232796>

This series fixes a bug in dir.c which causes t3010 to fail [1] when
core.ignorecase is true. The problem is that
directory_exists_in_index(dirname,len) and
directory_exists_in_index_icase() behave differently if dirname[len] is
not a '/', even though this is beyond end-of-string.  2eac2a4cc4bdc8d7
(ls-files -k: a directory only can be killed if the index has a
non-directory; 2013-08-15) adds a caller which neglects to ensure that
the the required '/' is present, hence the failure.

I am not happy with the fix, which is too add a '/' after the last
character in dirname just at the call site introduced by
2eac2a4cc4bdc8d7.

The reason for my unhappiness is that directory_exists_in_index_icase()
makes the assumption, not only that it can access the character beyond
the end-of-string, but also that that character will unconditionally be
'/'. I presume that this was done for the sake of speed (existing
callers always had a '/' beyond end-of-string), but it feels like an
ugly wart. Since the required trailing '/' is purely an implementation
detail of directory_exists_in_index_icase(), and not of
directory_exists_in_index(), a cleaner fix would be for
directory_exists_in_index_icase() to add the '/' it needs, and not
expect the passed in dirname to have a '/' after its last character.
Unfortunately, such a fix would probably negate any optimization benefit
gained by the present implementation.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232727

Eric Sunshine (2):
  t3103: demonstrate dir.c:treat_one_path() core.ignorecase failure
  dir: test_one_path: fix inconsistent behavior due to missing '/'

 dir.c                   | 12 +++++++++---
 t/t3103-ls-tree-misc.sh | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

-- 
1.8.4.rc4.529.g78818d7
