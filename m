From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 3/6] Fix tests to work with core.autocrlf=true
Date: Mon, 11 May 2009 23:20:11 +0100
Message-ID: <20090511222011.GA7609@hashpling.org>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com> <1242070141-2936-2-git-send-email-Don.Slutz@SierraAtlantic.com> <1242070141-2936-3-git-send-email-Don.Slutz@SierraAtlantic.com> <1242070141-2936-4-git-send-email-Don.Slutz@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Slutz <Don.Slutz@SierraAtlantic.com>
X-From: git-owner@vger.kernel.org Tue May 12 00:20:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3drF-0000KW-DP
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 00:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759915AbZEKWUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 18:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759832AbZEKWUP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 18:20:15 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:20324 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759607AbZEKWUN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 18:20:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAOlBCErUnw4R/2dsb2JhbADMdIJCgUAF
Received: from pih-relay04.plus.net ([212.159.14.17])
  by relay.ptn-ipout02.plus.net with ESMTP; 11 May 2009 23:20:13 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1M3dr2-0003kU-EV; Mon, 11 May 2009 23:20:12 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n4BMKBQV008179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 May 2009 23:20:11 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n4BMKB3C008178;
	Mon, 11 May 2009 23:20:11 +0100
Content-Disposition: inline
In-Reply-To: <1242070141-2936-4-git-send-email-Don.Slutz@SierraAtlantic.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 26a660f4079351ee751e56418fe60f56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118857>

On Mon, May 11, 2009 at 03:28:58PM -0400, Don Slutz wrote:
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index e768c3e..bf39e45 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -45,9 +45,9 @@ test_expect_success 'custom mergetool' '
>      ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
>      ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
>      ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
> -    test "$(cat file1)" = "master updated" &&
> -    test "$(cat file2)" = "master new" &&
> -    test "$(cat subdir/file3)" = "master new sub" &&
> +    test_cat_eq file1 "master updated" &&
> +    test_cat_eq file2 "master new" &&
> +    test_cat_eq subdir/file3 "master new sub" &&
>      git commit -m "branch1 resolved with mergetool"
>  '

This change concerns me. At the moment, the mergetool test assumes
that globally autocrlf is true and has further tests that attempt to
verify its behaviour with autocrlf set to true. See the very next
test:

test_expect_success 'mergetool crlf' '
    git config core.autocrlf true &&
    git checkout -b test2 branch1
    test_must_fail git merge master >/dev/null 2>&1 &&
    ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
    ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
    ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
    test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
    test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
    test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
    git commit -m "branch1 resolved with mergetool - autocrlf" &&
    git config core.autocrlf false &&
    git reset --hard
'

Does the resetting of core.autocrlf to false not break the subsequent
tests?

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
