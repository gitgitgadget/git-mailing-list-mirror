From: John Keeping <john@keeping.me.uk>
Subject: Remote helpers and signed tags
Date: Sun, 7 Apr 2013 11:34:18 +0100
Message-ID: <20130407103418.GT2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 12:34:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOmvf-0005ad-Uz
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 12:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933263Ab3DGKe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 06:34:27 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:55100 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab3DGKe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 06:34:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 527A1CDA5A5;
	Sun,  7 Apr 2013 11:34:26 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UiVjKhO28xYT; Sun,  7 Apr 2013 11:34:25 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4B508CDA5A6;
	Sun,  7 Apr 2013 11:34:20 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220305>

It appears to be impossible to push signed tags using a remote helper
that supports only fast-export.  This is reported against gitifyhg[1]
but I think it is actually a Git issue.

[1] https://github.com/buchuki/gitifyhg/issues/59

I can reproduce the error using a trivial remote helper (run this in a
clone of git.git):

-- >8 --
cat >git-remote-export <<EOF &&
#!/bin/sh

alias=$1
url=${2-$1}

while read -r line
do
	case "$line" in
	capabilities)
		echo 'export'
		echo 'refspec *:*'
		echo
		;;
	list)
		echo
		;;
	export)
		while read -r line
		do
			echo "$line" >&3
			test "$line" = done && break
		done 3>"$url"
		echo
		;;
	'')
		exit
		;;
	*)
		echo >&2 "unsupported command: $line"
		exit 1
		;;
	esac
done
EOF
chmod +x git-remote-export &&
PATH="$(pwd):$PATH" git push "export::$(pwd)/v1.8.2.export" v1.8.2
-- 8< --

This produces:

    fatal: Encountered signed tag 572a535454612a046e7dd7404dcca94d6243c788;
        use --signed-tag=<mode> to handle it.
    fatal: Error while running fast-export

which is not particularly helpful for a user who doesn't know how the
remote helper is implemented, particularly because adding
--signed-tag=<mode> to the command won't work.

I think there are two problems here:

    1) The error message is misleading: "--signed-tag" isn't an option
       to git-push and as a user I don't know why Git thought I wanted
       to run fast-export.

    2) There is no way (that I have found) to change the signed-tag
       behaviour of git-fast-export when it is being invoked for a
       remote helper.

How do remote helpers using the "push" method handle this?  In that case
it seems to be completely up to the helper program to decide what to do.

I wonder if the way forward is to do some combination of:

    a) Add a --signed-tags option to git-push, which is either passed to
       fast-export or given as a new "option signed-tags" to the
       remote-helper when using the push interface (and ignored for the
       connect interface).

    b) Add a configuration variable to specify how to handle signed tags
       when pushing to a remote that uses a remote helper that cannot
       handle them; something like "remote.<name>.signedTags".

    c) Improve the "Error while running fast-export" message to
       something more like "Error pushing with fast-export (using helper
       git-remote-foo)".
