From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: add "--path-encoding" option
Date: Mon, 31 Aug 2015 14:10:39 -0700
Message-ID: <xmqqoahntb8w.fsf@gitster.mtv.corp.google.com>
References: <1441053833-63790-1-git-send-email-larsxschneider@gmail.com>
	<1441053833-63790-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 31 23:10:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWWLl-0002iq-9V
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 23:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbbHaVKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 17:10:41 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36064 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbbHaVKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 17:10:41 -0400
Received: by pacgr6 with SMTP id gr6so219705pac.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=scNk4uyFeKt8teHLEGcKpljTsaIbKDwTF5IRaWo1Gyg=;
        b=wsKltlfRfDeRJOd99gaipWbFLNB/zXy/yH0GU9Zgl6QKZaED4VePY/77bQJs5F/PFa
         PcD7TH2+nlnDbQEkEqRVrledD/qbQKJP9zOJOyeBkLpDjmUibvOjXGLKP1CY7U9AISV3
         bCJIq7Qa+dGlu4LVhxJZUnzf+3EJ6zniuJby+pTXf1FmYWjgIxWyuoisImGtJDdQVcjI
         Kcz3GrwWYi+X+iO27WvJODEoBeYXEaltHpVYB6VsFJN4feK2PEDmzY/7E+peBB8KOE+e
         8lRA/m6wdSxKl6ysb4UCtDiW6VliGlf4o6je4n8TI5Imaxfr3DHfAzSroAJ4y3fV7AJj
         xvMQ==
X-Received: by 10.68.135.161 with SMTP id pt1mr40555409pbb.47.1441055440797;
        Mon, 31 Aug 2015 14:10:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id w5sm15616662pda.80.2015.08.31.14.10.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 14:10:40 -0700 (PDT)
In-Reply-To: <1441053833-63790-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 31 Aug 2015 22:43:53
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276943>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/git-p4.txt        |  5 +++++
>  git-p4.py                       |  6 ++++++
>  t/t9821-git-p4-path-encoding.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 50 insertions(+)
>  create mode 100755 t/t9821-git-p4-path-encoding.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 82aa5d6..14bb79c 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -252,6 +252,11 @@ Git repository:
>  	Use a client spec to find the list of interesting files in p4.
>  	See the "CLIENT SPEC" section below.
>  
> +--path-encoding <encoding>::
> +	The encoding to use when reading p4 client paths. With this option
> +	non ASCII paths are properly stored in Git. For example, the encoding
> +	'cp1252' is often used on Windows systems.
> +
>  -/ <path>::
>  	Exclude selected depot paths when cloning or syncing.
>  
> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..2b3bfc4 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1981,6 +1981,8 @@ class P4Sync(Command, P4UserMap):
>                  optparse.make_option("--silent", dest="silent", action="store_true"),
>                  optparse.make_option("--detect-labels", dest="detectLabels", action="store_true"),
>                  optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
> +                optparse.make_option("--path-encoding", dest="pathEncoding", type="string",
> +                                     help="Encoding to use for paths"),
>                  optparse.make_option("--import-local", dest="importIntoRemotes", action="store_false",
>                                       help="Import into refs/heads/ , not refs/remotes"),
>                  optparse.make_option("--max-changes", dest="maxChanges",
> @@ -2025,6 +2027,7 @@ class P4Sync(Command, P4UserMap):
>          self.clientSpecDirs = None
>          self.tempBranches = []
>          self.tempBranchLocation = "git-p4-tmp"
> +        self.pathEncoding = None
>  
>          if gitConfig("git-p4.syncFromOrigin") == "false":
>              self.syncWithOrigin = False
> @@ -2213,6 +2216,9 @@ class P4Sync(Command, P4UserMap):
>              text = regexp.sub(r'$\1$', text)
>              contents = [ text ]
>  
> +        if self.pathEncoding:
> +            relPath = relPath.decode(self.pathEncoding).encode('utf8', 'replace')
> +
>          self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
>  
>          # total length...
> diff --git a/t/t9821-git-p4-path-encoding.sh b/t/t9821-git-p4-path-encoding.sh
> new file mode 100755
> index 0000000..bb85074
> --- /dev/null
> +++ b/t/t9821-git-p4-path-encoding.sh
> @@ -0,0 +1,39 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories with non ASCII paths'
> +
> +. ./lib-git-p4.sh
> +
> +UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'Create a repo containing iso8859-1 encoded paths' '
> +	cd "$cli" &&
> +
> +	ISO8859="$(printf "$UTF8_ESCAPED" | iconv -f utf-8 -t iso8859-1)" &&
> +	>"$ISO8859" &&
> +	p4 add "$ISO8859" &&
> +	p4 submit -d "test commit"
> +'
> +
> +test_expect_success 'Clone repo containing iso8859-1 encoded paths' '
> +	git p4 clone --destination="$git" --path-encoding=iso8859-1 //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		printf "\"$UTF8_ESCAPED\"" >expect &&

Did this pass your test?  I suspect 'expect' lacks the final LF.

> +		# I wonder why Git prints "ls-files" output UTF-8 escaped.
> +		# This behavior is consistent on Linux and OS X.
> +		printf $(git ls-files) >actual &&

Yuck.  Perhaps do it like so:

	test_config core.quotepath false &&
	git ls-files >actual &&
        test_cmp expect actual

> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
