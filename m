From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] git-p4: add config git-p4.pathEncoding
Date: Thu, 03 Sep 2015 10:03:05 -0700
Message-ID: <xmqqa8t3l9km.fsf@gitster.mtv.corp.google.com>
References: <1441271647-67824-1-git-send-email-larsxschneider@gmail.com>
	<1441271647-67824-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de,
	sunshine@sunshineco.com, remi.galan-alfonso@ensimag.grenoble-inp.fr
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 03 19:03:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXus-0006ic-2J
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 19:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbbICRDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 13:03:09 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34223 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932409AbbICRDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 13:03:07 -0400
Received: by padfa1 with SMTP id fa1so9752204pad.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QJFKegAHuFIrB+EOlOONgrJDNQAbgk9wkXaaGerTsqk=;
        b=VENFa+K+Wdg8zGrqLOLj+4ZMsNMqE/oZabh17hDgs4wl87z80PRlAP5rFZF23YrJ8W
         MMRsVtQ9CdFhz1Cws78Hi6DgVCxD5yjKy1GIai/QDZse0FZ7PYvs2Za8gw6lebxyaPON
         bvsm5++p6XVWqng7gg+9QaPjhcQY55lIdb5IWNQQZmhB7ZAxb6cxI9rmZTQ4XWfuEXHp
         mSrp+B/KviiAjPQFx3o1QqgniIrdgGvv60oOIc7fggbK1lNtj20Bmli07c6JmP1eeszM
         F6uFu7wN4ObtrUK8p30JQle10lVyZ0vh4ZT0o04QboEam68Sbfa+D94k9L3nT1Bmnz0E
         WzDw==
X-Received: by 10.68.131.138 with SMTP id om10mr69822467pbb.3.1441299787158;
        Thu, 03 Sep 2015 10:03:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id wj8sm25945389pab.3.2015.09.03.10.03.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 10:03:06 -0700 (PDT)
In-Reply-To: <1441271647-67824-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Thu, 3 Sep 2015 11:14:07
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277232>

larsxschneider@gmail.com writes:

> +test_expect_success 'Clone repo containing iso8859-1 encoded paths without git-p4.pathEncoding' '
> +	git p4 clone --destination="$git" //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		UTF8="$(printf "$UTF8_ESCAPED")" &&
> +		echo $UTF8 >expect &&
> +		git -c core.quotepath=false ls-files >actual &&
> +		test_must_fail test_cmp expect actual

I am not sure what this test wants to do.  It is not inconceivable
that future versions of "git p4 clone" becomes more intelligent to
detect the need for git-p4.pathEncoding and set it, so the only
effect to insist the comparison fails is to block future advance in
that direction.

Besides, "test_must_fail test_cmp" looks like a strange thing to
say.  "! test_cmp expect actual" perhaps.

Even better, expect that "expect" and "actual" becomes the same, but
mark the test itself to expect failure, to say "it ought to work
this way in the ideal world, but we know the system currently does
not pass this test".

I'm tempted to suggest squashing the following in.  Thoughts?


 t/t9822-git-p4-path-encoding.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index e507ad7..2d652d89 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -21,15 +21,15 @@ test_expect_success 'Create a repo containing iso8859-1 encoded paths' '
 	)
 '
 
-test_expect_success 'Clone repo containing iso8859-1 encoded paths without git-p4.pathEncoding' '
+test_expect_failure 'Clone auto-detects depot with iso8859-1 paths' '
 	git p4 clone --destination="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
 		UTF8="$(printf "$UTF8_ESCAPED")" &&
-		echo $UTF8 >expect &&
+		echo "$UTF8" >expect &&
 		git -c core.quotepath=false ls-files >actual &&
-		test_must_fail test_cmp expect actual
+		test_cmp expect actual
 	)
 '
 
@@ -39,16 +39,15 @@ test_expect_success 'Clone repo containing iso8859-1 encoded paths with git-p4.p
 	(
 		cd "$git" &&
 		git init . &&
-		test_config git-p4.pathEncoding iso8859-1 &&
+		git config git-p4.pathEncoding iso8859-1 &&
 		git p4 clone --use-client-spec --destination="$git" //depot &&
 		UTF8="$(printf "$UTF8_ESCAPED")" &&
-		echo $UTF8 >expect &&
+		echo "$UTF8" >expect &&
 		git -c core.quotepath=false ls-files >actual &&
 		test_cmp expect actual &&
-		cat >expect <<-\EOF &&
-		content123
-		EOF
-		cat $UTF8 >actual &&
+
+		echo content123 >expect &&
+		cat "$UTF8" >actual &&
 		test_cmp expect actual
 	)
 '
