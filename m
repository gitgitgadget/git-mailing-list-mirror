From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 1/2] document irregular config --add behaviour for empty
 and NULL values
Date: Fri, 12 Sep 2014 12:53:18 +0530
Message-ID: <54129F66.9080905@gmail.com>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>	<xmqqvbppwtir.fsf@gitster.dls.corp.google.com>	<20140819051732.GA13765@peff.net>	<xmqqmwb1vwvs.fsf@gitster.dls.corp.google.com>	<20140819062000.GA7805@peff.net> <xmqqy4tpbuii.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 09:23:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSLCa-0000Xj-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 09:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbaILHXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 03:23:24 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:43845 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaILHXY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 03:23:24 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so604639pdj.8
        for <git@vger.kernel.org>; Fri, 12 Sep 2014 00:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=iP5mgl2ERnCucNnirHhBhY2nO6B92Nufi2kwTR3DSHk=;
        b=YWRU+gKVgmEUJGcl7aPSbjKNiHAOTHK8FZGRFMrcutRK0IXeIjemFMNOC5A/9omfQ2
         rXSLrorh5pZhur+UwRaJAn3rFpeqXpCGR2bczV/3YQIdwDowbdZFwUvGJBodyp8ajIO0
         UNZC7f7WFuh070tke9WQI4qCkbbUICE1tZXkVh2whnG+gcZsOPMRZLiYsm05jFliy/KI
         /asa3TOytnQ/+so9HLL01HXvaFjyI2MEqC0ka2dQoIaE+IuL21M3w56Z9/bHPznYDeim
         Q/0VK0UE7MiKkOMUspFXBqjDIgDcpg4ZPVkEsnqsI0L9FTdxlhUrHy39nOVgp6vBV0yU
         +JgA==
X-Received: by 10.68.225.133 with SMTP id rk5mr8795467pbc.101.1410506603607;
        Fri, 12 Sep 2014 00:23:23 -0700 (PDT)
Received: from [127.0.0.1] ([223.188.87.40])
        by mx.google.com with ESMTPSA id nm6sm2953824pdb.60.2014.09.12.00.23.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Sep 2014 00:23:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqy4tpbuii.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256903>

If we have a config file like,
[foo]
        baz
        bar =

and we try something like, "git config --add foo.baz roll", Git will
segfault. Moreover, for "git config --add foo.bar roll", it will
overwrite the original value instead of appending after the existing
empty value. Document these deficiencies in form of a test.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---

Sorry for this very late reply. I was stuck in a flood affected region
with no internet connectivity for the past week. I am safe now. :)

FWIW, here is the reroll with a set bit in the store struct and an exported
global. I could have done the reroll as you have done, but Jeff had mentioned
that he liked the version with a bit flag more. But you can choose the version
that seems better to you.

 t/t1303-wacky-config.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 3a2c819..e5c0f07 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -111,4 +111,24 @@ test_expect_success 'unset many entries' '
 	test_must_fail git config section.key
 '

+test_expect_failure '--add appends new value after existing empty value' '
+	cat >expect <<-\EOF &&
+
+
+	fool
+	roll
+	EOF
+	cp .git/config .git/config.old &&
+	test_when_finished "mv .git/config.old .git/config" &&
+	cat >.git/config <<-\EOF &&
+	[foo]
+		baz
+		baz =
+		baz = fool
+	EOF
+	git config --add foo.baz roll &&
+	git config --get-all foo.baz >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
1.9.0.GIT
