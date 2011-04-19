From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Pass empty file to p4merge where no base is
 suitable.
Date: Tue, 19 Apr 2011 14:33:06 -0700
Message-ID: <7vwriq3p0t.fsf@alter.siamese.dyndns.org>
References: <BANLkTimXBayYAScPfk2j9spxcYrmtMJKxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Ciaran <ciaranj@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:33:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCIY0-0005zC-4p
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 23:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab1DSVdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 17:33:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab1DSVdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 17:33:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E20EC4203;
	Tue, 19 Apr 2011 17:35:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vnBMHI6KnAGn/gv8zThskXDS7PM=; b=dujrA0
	2gMvWZgr3fGT740fqtWf+6aVn04ZFi/spqLUzFz9MYu+9ODbqTLXg3BT/Uv7cObQ
	N6SeydnDIoQeW6f0MthS1od/tTCrHDPQd7oaA+2T9tEMjglcikgpwM4L1xW0J8fg
	iAMJYEQSpJiznIQX1N4XZCZQ9t+1BHTakQAt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cozU/dmKIxHAtg1VY/P072x+SfS2Q1vJ
	9tZJClOM/7EEIYVMrL+ea/wy8FByu8Hi8AfEJwTkwdejsN8UteHSn3qmRsKvN3R9
	yCTDrxTqvrviGi6rmOAKvH9Zy76rLOLJ5cKg0rHZ0JguDvG6CPrm9PudjgpI1SjG
	C1EcXMLdNfI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF8004200;
	Tue, 19 Apr 2011 17:35:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D0BF41FC; Tue, 19 Apr 2011
 17:35:08 -0400 (EDT)
In-Reply-To: <BANLkTimXBayYAScPfk2j9spxcYrmtMJKxg@mail.gmail.com> (Ciaran's
 message of "Tue, 19 Apr 2011 20:46:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E86C2418-6ACC-11E0-8D25-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171817>

Ciaran <ciaranj@gmail.com> writes:

> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -262,7 +262,9 @@ run_merge_tool () {
>  			if $base_present; then
>  				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
>  			else
> -				"$merge_tool_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
> +				touch "$GIT_DIR/.no_base"
> +				"$merge_tool_path" "$GIT_DIR/.no_base" "$LOCAL" "$REMOTE" "$MERGED"
> +				rm "$GIT_DIR/.no_base"

The calling script "git-mergetool.sh" seems to take pains to construct
these filenames to have the same .ext, presumably so that the tool can
take advantage of it to determine the type of contents and do something
intelligent about it (e.g. syntax highlighting).

Does the use of .no_base interfere with that effort?

I suspect that you may be able to simply use "$BASE" for that, no?  It
will be cleaned up when cleanup_temp_files() is run anyway (warning: I do
not use mergetool, and I am writing this only from my cursory looking of
the script, so take this with a large grain of salt).

Also, the command to use when you want to get an empty file is not "touch".
It is not likely that you would have an existing file there, but the whole
point of the updated codepath is to have an empty file, and not a file
with recent timestamp, it would be far more sensible to say

	: >"$BASE"

i.e. redirect into the path, with a no-op command.
