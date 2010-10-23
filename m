From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: [PATCH 1/3] GIT-VERSION-GEN: make use of git describe --dirty
Date: Sat, 23 Oct 2010 14:23:16 +0200
Message-ID: <4CC2D3B4.5030607@debugon.org>
References: <cover.1287746107.git.misfire@debugon.org> <4CC1745C.70506@debugon.org> <20101022151140.GC9224@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 14:26:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9dB8-0005nl-ND
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 14:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab0JWMXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 08:23:19 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:60980 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab0JWMXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 08:23:19 -0400
Received: from [192.168.2.102] (dslb-088-071-188-252.pools.arcor-ip.net [88.71.188.252])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MJ0Dl-1PC72K2hQX-002VKO; Sat, 23 Oct 2010 14:23:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.14) Gecko/20101006 Thunderbird/3.0.9
In-Reply-To: <20101022151140.GC9224@burratino>
X-Provags-ID: V02:K0:VdZ6pPXrzagdfDW5xZT0NIZSZsjg3qtu4FeX2tqRZqF
 5zWvdEsUbc0YRYDJeDXDIVhR7cy33dTd141OA11fPXG05ZVBV0
 P+5OAWmhlOgzX9flKrwI4jTJgNMG7TH2AbT4C2CczaPhkVnWnp
 FOEZdXNAQMLjhySUFc4TzxQbUGXHxveDhMklVWy8NGsydj34bp
 USmmnDYaqkROhVxebbZCRVcIrWkqhWhx5QE2sBzP4o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159780>

On 10/22/2010 05:11 PM, Jonathan Nieder wrote:
> Mathias Lafeldt wrote:
> 
>> Currently, GIT-VERSION-GEN invokes the plumbing commands "git update-index" and
>> "git diff-index" to determine if the working tree is dirty. It then appends
>> "-dirty" to the version string returned by "git describe".
>>
>> However, as of Git v1.6.6, "git describe" can be told to do all that with the
>> "--dirty" option, saving us the plumbing.
> 
> This has a minor downside, which is avoiding the nice version numbers when
> building Git with git 1.5.6 installed.  What is the upside?

The upside is that the number of executed commands to get the version string
is reduced from three to one.

I understand your point, though it would only be a "problem" once when
doing the upgrade.

If backwards compatibility is more important here, I'd at least add a comment
to GIT-VERSION-GEN. Something like:

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index d441d88..5c226f6 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -16,6 +16,10 @@ elif test -d .git -o -f .git &&
        case "$VN" in
        *$LF*) (exit 1) ;;
        v[0-9]*)
+               # As of Git v1.6.6, we can use "git describe --dirty" to
+               # determine if the working tree is dirty. However, to still
+               # have nice version numbers when building Git with older
+               # versions of git installed, we keep using plumbing.
                git update-index -q --refresh
                test -z "$(git diff-index --name-only HEAD --)" ||
                VN="$VN-dirty" ;;

-Mathias
