From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Thu, 07 May 2015 14:06:17 -0700
Message-ID: <xmqqa8xgnlme.fsf@gitster.dls.corp.google.com>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>
	<1431019501-30807-3-git-send-email-luke@diamand.org>
	<xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>
	<554BBCBE.1020408@diamand.org>
	<xmqqlhh0nny1.fsf@gitster.dls.corp.google.com>
	<554BCE25.5070308@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu May 07 23:06:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqSzy-0007S9-KU
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 23:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbbEGVGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 17:06:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751337AbbEGVGU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 17:06:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56EA550577;
	Thu,  7 May 2015 17:06:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YSP38DIyVoUPNQP5hy6bcrSamJ8=; b=FLHRQb
	/Q+18idixVAvE3qEvbC6GZK29YBxGvtXkn/GQc5cV7P13f0sMUVko5KOTwQNjBbm
	8BsVK74BWBB/Ea3KCmY9libBd/D3h8JcQRmKHO5hagdIgrRNaZhUC1TiYjnIfW7+
	9YpMLKIFFvJc8ScpkTkGtDXv80TPfhCIPa5QA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zk5OQSci7ph5m30EPJEtO8Ugwp9adJqV
	tBC49B9HZdYanHp62MvHuTgxrKlns8rSXHAZeZsV0fugVfcfSA4gGuA0oPzM6a3u
	1L9ypM76n2HzxOXLV8GAWvGvlDm4/0OBc+efiW4Zt0NPYARckDXIOh6VpfN/ErX7
	wAISzlOzElw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E28650576;
	Thu,  7 May 2015 17:06:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C299350574;
	Thu,  7 May 2015 17:06:18 -0400 (EDT)
In-Reply-To: <554BCE25.5070308@diamand.org> (Luke Diamand's message of "Thu,
	07 May 2015 21:42:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E7EF80AC-F4FC-11E4-854A-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268588>

Luke Diamand <luke@diamand.org> writes:

> On 07/05/15 21:16, Junio C Hamano wrote:
>> Luke Diamand <luke@diamand.org> writes:
>>
>>> On Linux:
>>>
>>> $ export P4EDITOR="gvim -f"
>>> $ p4 submit
>>> -- works as you would hope --
>>>
>>> $ export P4EDITOR="/home/lgd/My Programs/editor.sh"
>>> $ p4 submit
>>> sh: 1: /home/lgd/My: not found
>>>
>>> $ export P4EDITOR="/home/lgd/My\ Programs/editor.sh"
>>> -- works fine --
>>
>> Good.  That is exactly I wanted to see.
>
> Test case t9805-git-p4-skip-submit-edit.sh fails with that change. It
> sets P4EDITOR to "$TRASH_DIRECTORY/ed.sh".

;-)

Perhaps something like this would work (totally untested)?

diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index 8931188..a47b44b 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -90,8 +90,9 @@ test_expect_success 'no config, edited' '
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 5" &&
-		P4EDITOR="$TRASH_DIRECTORY/ed.sh" &&
-		export P4EDITOR &&
+		customEditor="$TRASH_DIRECTORY/ed.sh" &&
+		P4EDITOR="\$customEditor" &&
+		export customEditor P4EDITOR &&
 		git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 5 wc
