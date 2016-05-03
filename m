From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] submodule deinit: lose requirement for giving '.'
Date: Tue, 03 May 2016 10:21:18 -0700
Message-ID: <xmqqoa8nnjld.fsf@gitster.mtv.corp.google.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<1462227844-10624-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens.Lehmann@web.de, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 19:21:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axe0l-0006cu-C8
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 19:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320AbcECRVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 13:21:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756039AbcECRVW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 13:21:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5468117FF9;
	Tue,  3 May 2016 13:21:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pu9zpQXESlK8rFK48BvsCL0Sy6k=; b=YI41XK
	pu6S/80NEHr874tTvk4iGQjao0LsPxQbzjJI4ytKbfS7BlKGEmI/BfsTyn4yvEAn
	vU9bm7TeK4om/kZd977b4KejWXg72G1+CB3eelRTed+Vhg2gJGKAQ8IADZbFsH9M
	mQ/otbHvDsfV2CsQcwh/tH5yJKC2VHC8sO38Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U7S/ZhSfor2+KoY+8R4tHLUcEeggx/9X
	mOJTiDc86Yo7ESGG29zdzBTQVb9r/IXjyzw4h7oInfrnAObd+cNfLbV5VsGcQQFl
	wedICa7sN4WJ4gHTMZv8OrB/HM04UMEWDiFaa3pQTyDxk5wD3iY2RoT6cOGv5rXl
	SL8b9yqR8cw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 48C1C17FF6;
	Tue,  3 May 2016 13:21:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95A6F17FF5;
	Tue,  3 May 2016 13:21:20 -0400 (EDT)
In-Reply-To: <1462227844-10624-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 2 May 2016 15:24:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73EE0AD8-1153-11E6-A825-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293419>

Stefan Beller <sbeller@google.com> writes:

> The discussion in [1] realized that '.' is a faulty suggestion as
> there is a corner case where it fails:
>
>> "submodule deinit ." may have "worked" in the sense that you would
>> have at least one path in your tree and avoided this "nothing
>> matches" most of the time.  It would have still failed with the
>> exactly same error if run in an empty repository, i.e.
>>
>>        $ E=/var/tmp/x/empty && rm -fr "$E" && mkdir -p "$E" && cd "$E"
>>        $ git init
>>        $ rungit v2.6.6 submodule deinit .
>>        error: pathspec '.' did not match any file(s) known to git.
>>        Did you forget to 'git add'?
>>        $ >file && git add file
>>        $ rungit v2.6.6 submodule deinit .
>>        $ echo $?
>>        0
>
> Allow no argument for `submodule deinit` to mean all submodules
> and add a test to check for the corner case of an empty repository.
>
> There is no need to update the documentation as it did not describe the
> special case '.' to remove all submodules.

OK, and the reason why there is no need to update the actual code,
other than the "do not allow" gate, is because "submodule--helper
list" aka module_list already knows to list everything if no
pathspec is given.  Am I reading the code (not in the patch)
correctly?

> [1] http://news.gmane.org/gmane.comp.version-control.git/289535

The old discussion thread raises a good point.  The refusal to
accept no-pathspec form for a potentially destructive "deinit" may
have been a safety measure, even though the suggested way to tell
the command "Yes, I know I want to deinit everything" was not a
good one (i.e. it resulted in an error if your project did not have
any files tracked yet).

So possible ways forward may be

 - to remove the safety altogether; or
 - keep the safety, but give a better suggestion to say "Yes, deinit
   everything".

And this patch decides to take the former approach?

I am wondering if this can be solved in a cleaner way to teach
"deinit" take a new "--all" option instead, e.g. something like...

diff --git a/git-submodule.sh b/git-submodule.sh
index 82e95a9..4b84116 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -405,6 +405,7 @@ cmd_init()
 cmd_deinit()
 {
 	# parse $args after "submodule ... deinit".
+	deinit_all=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -414,6 +415,9 @@ cmd_deinit()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		-a|--all)
+			deinit_all=t
+			;;
 		--)
 			shift
 			break
@@ -428,9 +432,9 @@ cmd_deinit()
 		shift
 	done
 
-	if test $# = 0
+	if test $# = 0 && test -z "$deinit_all"
 	then
-		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
+		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
 	fi
 
 	git submodule--helper list --prefix "$wt_prefix" "$@" |


That would work even in the pathological "empty directory that has
nothing to match even '.'" case without losing the safety, no?
