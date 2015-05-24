From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/3] git-p4: tests: use test-chmtime in place of touch
Date: Sun, 24 May 2015 11:56:03 -0700
Message-ID: <xmqqy4kdby9o.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com>
	<1432074198-13806-1-git-send-email-luke@diamand.org>
	<1432074198-13806-4-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun May 24 20:56:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ywb4H-0004Ao-VV
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 20:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbbEXS4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2015 14:56:09 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36900 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbbEXS4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2015 14:56:07 -0400
Received: by igbsb11 with SMTP id sb11so21339543igb.0
        for <git@vger.kernel.org>; Sun, 24 May 2015 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0sylFWYKsRUdGqH30ZbEc2XkNx7Xpg1ydLtI2lLOm2Y=;
        b=C/FX4WHkkFcH2aqFfgxDXqjnD3UxLRQgHkPgjxSzlEOc+/siZnc1FQAWeAgQhe3d2G
         5cS5kEHj48CTAjrewUqtKCESul9lD8j3/i7Mgk9sNiY7a1j0/Bb8+x9LqsBloodc2QTF
         Csjl5dfXZ97hIhuc93ov84ZTiRFm0IO/rsMeXHbgPY1GPSLcisQzmF5y/nT+2Qm129rh
         T5pLdYg844PYKNEJDzN1FKCk0dMFD1+9vLuFjkpZ34MFhgzYVWDAfocef+o0aVCQiQzx
         /R7nvI97JNZkdD1mbuSAI5Be4JXWejIngRQ6YJajYzh01ShfpWandhU+lkH/W72ZNfp9
         UqYw==
X-Received: by 10.50.33.51 with SMTP id o19mr19222313igi.45.1432493766833;
        Sun, 24 May 2015 11:56:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:45f7:b54f:6e94:918d])
        by mx.google.com with ESMTPSA id z195sm6945341iod.33.2015.05.24.11.56.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 24 May 2015 11:56:05 -0700 (PDT)
In-Reply-To: <1432074198-13806-4-git-send-email-luke@diamand.org> (Luke
	Diamand's message of "Tue, 19 May 2015 23:23:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269830>

Luke Diamand <luke@diamand.org> writes:

> diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
> index 166b840..fe65788 100755
> --- a/t/t9813-git-p4-preserve-users.sh
> +++ b/t/t9813-git-p4-preserve-users.sh
> @@ -53,7 +53,8 @@ test_expect_success 'preserve users' '
>  		git commit --author "Alice <alice@example.com>" -m "a change by alice" file1 &&
>  		git commit --author "Bob <bob@example.com>" -m "a change by bob" file2 &&
>  		git config git-p4.skipSubmitEditCheck true &&
> -		P4EDITOR=touch P4USER=alice P4PASSWD=secret git p4 commit --preserve-user &&
> +		P4EDITOR="test-chmtime +5" P4USER=alice P4PASSWD=secret &&
> +		git p4 commit --preserve-user &&

I think this hunk is wrong; we need to either change && to \ to make
it a single logical line that exports three environment variables
only to "git p4 commit --preserve-user", or insert "export P4EDITOR
P4USER P4PASSWD &&" between these two lines.

The latter seems to be what the remainder of the test is doing, so
I'd fix this up to mimick them.

Sorry for not catching it in the earlier review.

Thanks.

> @@ -69,7 +70,7 @@ test_expect_success 'refuse to preserve users without perms' '
>  		git config git-p4.skipSubmitEditCheck true &&
>  		echo "username-noperms: a change by alice" >>file1 &&
>  		git commit --author "Alice <alice@example.com>" -m "perms: a change by alice" file1 &&
> -		P4EDITOR=touch P4USER=bob P4PASSWD=secret &&
> +		P4EDITOR="test-chmtime +5" P4USER=bob P4PASSWD=secret &&
>  		export P4EDITOR P4USER P4PASSWD &&
>  		test_must_fail git p4 commit --preserve-user &&
>  		! git diff --exit-code HEAD..p4/master
