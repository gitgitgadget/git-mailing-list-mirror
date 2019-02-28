Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF4F20248
	for <e@80x24.org>; Thu, 28 Feb 2019 22:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfB1Wbc (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 17:31:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53146 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfB1Wbc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 17:31:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2173645B6;
        Thu, 28 Feb 2019 17:31:29 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=GLe
        xdR32AL4S8ogDUhTDDZapMR0=; b=pLuK0c4gCCanhCsk7rg16sYI56XKWMzkDWh
        vQmJthwfp1Xrk0bYKdzpDceYosX31Bi1Ao0vgjaPfpGebprDrmBCqUkTAVaqNEGs
        6fDmm0YInYwyRQr7ze0cCyQwImBGlaRos/0nhwg5MB2rRX0wWachy/ZMG8bkXDEc
        62B2yitI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:mime-version:content-type; q=dns; s=sasl; b=
        T/eFjRKlS0DorkhQ1K/zbmXrcmtRZXAPY/EeL6sq0jKF8SmJMUVJShLrXq6Iz8Vs
        uySuQKVDIQP9iqlr66HcVpouJ8RXFcp8wa3WSKlGt2emfEVXXutjJsEVqhP3VMDF
        /lvdHgrQSVO/UOHmp7JwMScT64PIOPPfF1iXptN6sCA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8B9E645B5;
        Thu, 28 Feb 2019 17:31:29 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 90E80645B4;
        Thu, 28 Feb 2019 17:31:26 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 28 Feb 2019 17:31:23 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [BUG] completion.commands does not remove multiple commands
Message-ID: <20190228223123.GZ16125@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 95EF4F2A-3BA8-11E9-94AD-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was playing with the completion.commands config added in
6532f3740b ("completion: allow to customize the completable
command list", 2018-05-20) and noticed an issue removing
multiple commands.

I wanted to remove completion for cherry and mergetool, so I
added them both to the config:

    git config completion.commands "-cherry -mergetool"

But git still completes cherry in this case, only removing
mergetool.  Swapping the items in the config yields the
opposite result (cherry is removed and mergetool is not).

With luck this will be a clear and easily resolved issue in
list_cmds_by_config() (in help.c).

Here's an example in test form:

-- 8< --
diff --git c/t/t9902-completion.sh w/t/t9902-completion.sh
index 3a2c6326d8..06cee36ae5 100755
--- c/t/t9902-completion.sh
+++ w/t/t9902-completion.sh
@@ -1483,6 +1483,14 @@ test_expect_success 'git --help completion' '
 	test_completion "git --help core" "core-tutorial "
 '
 
+test_expect_failure 'completion.commands removes multiple commands' '
+	test_config completion.commands "-cherry -mergetool" &&
+	git --list-cmds=list-mainporcelain,list-complete,config |
+		grep ^cherry >actual &&
+	echo cherry-pick >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'setup for integration tests' '
 	echo content >file1 &&
 	echo more >file2 &&
-- 8< --

That's not quite normal form for t9902, but I was undable to
create a working test using the test_completion functions.
The tests set GIT_TESTING_PORCELAIN_COMMAND_LIST and
GIT_TESTING_ALL_COMMAND_LIST which override the settings in
the completion script.  I played a bit with adjusting those
to add cherry{,-pick} to the command lists, unsetting those
vars for the test, and such, to no avail.

In the end, I'm not really sure that calling --list-cmds
directly is such a bad way to go for testing this issue.

-- 
Todd
