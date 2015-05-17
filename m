From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Sun, 17 May 2015 12:10:49 -0700
Message-ID: <xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
	<1431806796-28902-1-git-send-email-gjthill@gmail.com>
	<xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 21:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yu3xh-0004Nd-2J
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 21:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbbEQTKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 15:10:52 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34934 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbEQTKv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 15:10:51 -0400
Received: by iesa3 with SMTP id a3so68651494ies.2
        for <git@vger.kernel.org>; Sun, 17 May 2015 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ujriMmSyEqo5nhunrgMDxsBNDMqllx88388QaKUrApA=;
        b=PVj7ML2PV7cdqyhjMRj5gGyKjeuni1ebW0dPTbOIr0vEyMjmkKVBnCIwqWYZIcuZwh
         USLJI2YWjDBALLn6mqaOG8gi6Uzl2LWW0QNB3sB1MRXoHmWfZVaBHl89sqRqWi/J6ZBo
         eC5WeD7WIgzheakAnYzqbUHxpXwYlHb9ltA4G1V/F8YOspscuNHVp1ZKHOZnsJGtWk9v
         xSPaPnKlXP5+M44YDt9KMi8c9fbbyqG4uTtyLW+1a2kGp3YJATJulcOGDvu+iZFqeAcR
         5zoxyHWLvc3gYLWus7o3StNaR88MAdx5Y6NEdsghT2HkjnELKEqdAtGuKqFvz2/AEw5s
         QClQ==
X-Received: by 10.42.203.4 with SMTP id fg4mr30913963icb.52.1431889850964;
        Sun, 17 May 2015 12:10:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1b0:922b:6b11:b020])
        by mx.google.com with ESMTPSA id i185sm6093274ioi.24.2015.05.17.12.10.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 17 May 2015 12:10:50 -0700 (PDT)
In-Reply-To: <xmqqegmfds1n.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 17 May 2015 10:37:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269221>

Junio C Hamano <gitster@pobox.com> writes:

> If the contents to be cleaned is small enough (i.e. the one-liner
> file used in this test) to fit in the pipe buffer and we feed the
> pipe before 'true' exits, we won't see any problem.  Otherwise we
> may get SIGPIPE when we attempt to write to the 'true' (non-)filter,
> but because we explicitly ignore SIGPIPE, 'true' still is a "black
> hole" filter.
>
> "cat >/dev/null" may have been a more naive and straight-forward way
> to write this "black hole" filter, but what you did is fine.

I spoke too fast X-<.  "while sh t0021-*.sh; do :; done" dies after
a few iterations and with this squashed in it doesn't.

 t/t0021-conversion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 42e6423..b778faf 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -218,7 +218,7 @@ test_expect_success "filter: clean empty file" '
 '
 
 test_expect_success "filter: smudge empty file" '
-	git config filter.empty-in-repo.clean true &&
+	git config filter.empty-in-repo.clean "cat >/dev/null" &&
 	git config filter.empty-in-repo.smudge "echo smudged && cat" &&
 
 	echo "empty-in-repo filter=empty-in-repo" >>.gitattributes &&
-- 
2.4.1-374-g090bfc9
