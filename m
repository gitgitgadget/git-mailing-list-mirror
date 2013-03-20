From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 3/4] t7800: modernize tests
Date: Wed, 20 Mar 2013 10:48:43 +0100
Message-ID: <514985FB.8080806@viscovery.net>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com> <1361419428-22410-2-git-send-email-davvid@gmail.com> <1361419428-22410-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 10:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIFdz-0001Gs-Fm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 10:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758179Ab3CTJss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 05:48:48 -0400
Received: from so.liwest.at ([212.33.55.24]:58422 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620Ab3CTJsr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 05:48:47 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UIFdU-0008GZ-H1; Wed, 20 Mar 2013 10:48:44 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 39AE51660F;
	Wed, 20 Mar 2013 10:48:44 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <1361419428-22410-3-git-send-email-davvid@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218583>

Am 2/21/2013 5:03, schrieb David Aguilar:
>  test_expect_success PERL 'difftool -d' '
> -	diff=$(git difftool -d --extcmd ls branch) &&
> -	echo "$diff" | stdin_contains sub &&
> -	echo "$diff" | stdin_contains file
> +	git difftool -d --extcmd ls branch >output &&
> +	stdin_contains sub <output &&
> +	stdin_contains file <output
>  '

This test is broken on Windows. There is this code in git-difftool.perl

	for my $file (@worktree) {
...
			copy("$b/$file", "$workdir/$file") or
			exit_cleanup($tmpdir, 1);
...
	}

@worktree is populated with all files in the worktree. At this point,
"output" is among them. Then follows an attempt to copy a file over
"$workdir/$file". I guess that is some link+remove magic going on behind
the scenes. At any rate, this fails on Windows with
"D:/Src/mingw-git/t/trash directory.t7800-difftool/../../git-difftool line
408: Bad file number", because files that are open cannot be written from
outside (the file is open due to the redirection in the test snippet).

What is going on here? Why can this ever succeed even on Unix?

Same for some later tests.

BTW, while debugging this, I found the use of the helper function
stdin_contains() highly unhelpful; it just resolves to a 'grep' that on
top of all hides stdout. Please don't do that. Just use unadorned grep
like we do everywhere else.

-- Hannes
