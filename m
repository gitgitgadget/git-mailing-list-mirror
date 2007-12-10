From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Interactive editor tests for commit-msg hook
Date: Sun, 09 Dec 2007 19:42:45 -0800
Message-ID: <7vwsrnmczu.fsf@gitster.siamese.dyndns.org>
References: <1197204731-19553-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, krh@redhat.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 04:43:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ZYB-0006VG-1U
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 04:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbXLJDnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 22:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbXLJDnA
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 22:43:00 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:60054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbXLJDnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 22:43:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7255D2CFE;
	Sun,  9 Dec 2007 22:42:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 54D372CF9;
	Sun,  9 Dec 2007 22:42:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67673>

Wincent Colaiuta <win@wincent.com> writes:

> I didn't add similar tests for the pre-commit hook because I don't
> think that's an interesting code path; we don't care about the commit
> message in that case, only whether the commit is allowed to proceed or
> not.

Sensible.

> +# set up fake editor for interactive editing
> +cat > fake-editor <<'EOF'
> +#!/bin/sh
> +cp FAKE_MSG "$1"
> +exit 0
> +EOF
> +chmod +x fake-editor
> +FAKE_EDITOR="$(pwd)/fake-editor"
> +export FAKE_EDITOR

Hmm.  Why "export"?

> +test_expect_success "with no hook (editor)" \
> +	"echo 'more foo' >> file &&
> +	 git add file &&
> +	 echo 'more foo' > FAKE_MSG &&
> +	 GIT_EDITOR="$FAKE_EDITOR" git commit"
> +

I initially was going to say "this is just a style thing", but I really
want our tests to read uniformly like this:

        test_expect_success 'without hook (editor)' '

                echo more foo >>file &&
                git add file &&
                echo more foo >FAKE_MSG &&
                GIT_EDITOR="$FAKE_EDITOR" git commit

        '

 * Use single quotes around test unless there is a compelling reason not
   to;

 * The opening single quote of the test body on the same line as
   expect-success; the end quote at column 1 on a line on its own.

Notice a bug in your version?  Dq around $FAKE_EDITOR is stripped away
and it is harder to spot it because the script does not follow that
style.
