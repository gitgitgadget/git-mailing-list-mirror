Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020C6C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA67B610F8
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhDHWnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:43:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53781 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhDHWnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:43:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 86A0412FFDF;
        Thu,  8 Apr 2021 18:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Ky/fbglFHjajY57F2Z3t0AYgjcc=; b=dP/Wdf2Fm8hwYgTKbjuG
        PYd7hdpswB0+KMJYFK0dP5Or3NbBn89mriHNamOWa00bshqrQ71aO4/jgbLdGbEn
        1rxrkIpOrrdfo31K4Qcqmpbx4I4pjKleMJuIdZhEKmVIXPdHjlmCWASbe70is3mu
        biM0DrxmqrIg5T5lcUi7G0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=izunybXdlHBZKJtgRcyl1dz3E8Bc2lAKLZhZxou1VYFYyQ
        1VkLqvu08C3NwT7ROKulWszx9lRpRTbwuzF9lQlSyJkiSY9cUdWjLwo6dclVVyTD
        ydW/wI3WscnwtWX15lXtFniCzxaXvcfX0AK3eFIEkx+44ZX7Y5eqDwVJpmxfM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 801D012FFDE;
        Thu,  8 Apr 2021 18:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA95B12FFDC;
        Thu,  8 Apr 2021 18:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] git-send-email: refactor duplicate $? checks
 into a function
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
        <patch-2.5-f236f083e36-20210404T091649Z-avarab@gmail.com>
        <xmqqft0447lu.fsf@gitster.g>
Date:   Thu, 08 Apr 2021 15:43:05 -0700
Message-ID: <xmqqpmz4qtxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C94C31A4-98BB-11EB-9ADD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> One big thing that is different between this version and the one in
> Emily's "config hook" topic is that this is still limited to the
> case where $repo exists.  In the new world order, it will not matter
> in what directory the command runs, as long as "git hook" finds the
> hook, and details of the invocation is hidden behind the command.
>
> I presume that Emily's series is expected to be updated soonish?
> Please figure out who to go first and other details to work well
> together between you two.

Since I didn't hear from either of you, I'll queue with this
possibly bogus conflict resolution for now.

Thanks.


diff --cc git-send-email.perl
index 175da07d94,73e1e0b51a..0000000000
--- i/git-send-email.perl
+++ w/git-send-email.perl
@@@ -1947,27 -1940,11 +1947,13 @@@ sub unique_email_list 
  
  sub validate_patch {
  	my ($fn, $xfer_encoding) = @_;
--
- 	if ($repo) {
- 		my $validate_hook = catfile($repo->hooks_path(),
- 					    'sendemail-validate');
- 		my $hook_error;
- 		if (-x $validate_hook) {
- 			my $target = abs_path($fn);
- 			# The hook needs a correct cwd and GIT_DIR.
- 			my $cwd_save = cwd();
- 			chdir($repo->wc_path() or $repo->repo_path())
- 				or die("chdir: $!");
- 			local $ENV{"GIT_DIR"} = $repo->repo_path();
- 			$hook_error = system_or_msg([$validate_hook, $target]);
- 			chdir($cwd_save) or die("chdir: $!");
- 		}
- 		if ($hook_error) {
- 			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
- 				       "%s\n" .
- 				       "warning: no patches were sent\n"), $fn, $hook_error);
- 		}
+ 	my $target = abs_path($fn);
 -	return "rejected by sendemail-validate hook"
 -		if system(("git", "hook", "run", "sendemail-validate", "-a",
 -				$target));
++	$hook_error = system_or_msg([qw(git hook run sendemail-validate -a), $target]);
++	if ($hook_error) {
++		die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
++			       "%s\n" .
++			       "warning: no patches were sent\n"), $fn, $hook_error);
 +	}
  
  	# Any long lines will be automatically fixed if we use a suitable transfer
  	# encoding.
