From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv3 02/11] git-p4: test debug macro
Date: Sun, 18 Dec 2011 17:10:35 +0000
Message-ID: <4EEE1E8B.2060808@diamand.org>
References: <1324147942-21558-1-git-send-email-pw@padd.com> <1324147942-21558-3-git-send-email-pw@padd.com> <4EED1B06.80007@diamand.org> <20111218013651.GA18735@padd.com> <20111218032238.GA6368@elie.hsd1.il.comcast.net> <20111218140633.GB16487@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 18:10:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcKFu-0002yz-HY
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 18:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab1LRRKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 12:10:30 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56805 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab1LRRK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 12:10:29 -0500
Received: by wibhm6 with SMTP id hm6so662427wib.19
        for <git@vger.kernel.org>; Sun, 18 Dec 2011 09:10:28 -0800 (PST)
Received: by 10.180.102.74 with SMTP id fm10mr22442869wib.26.1324228228189;
        Sun, 18 Dec 2011 09:10:28 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id ep16sm22530100wbb.21.2011.12.18.09.10.26
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Dec 2011 09:10:27 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111218140633.GB16487@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187425>

On 18/12/11 14:06, Pete Wyckoff wrote:
> Call this from a test to have it pause and wait for you to
> investigate.  It prints out its current directory and the
> P4 environment variables.  It waits for ctrl-c before continuing
> the test.

Looks good, ack.

>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
> jrnieder@gmail.com wrote on Sat, 17 Dec 2011 21:26 -0600:
>> Pete Wyckoff wrote:
>>
>>> +	# 2 is SIGINT, ash/dash does not know symbolic names
>>> +	trap echo 2
>>
>> 'trap "$cmd" INT' works, and it's even in POSIX. ;)
>> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#trap
>
> Nicer to use the constant.  It works on both.  Unfortunately
> ash has other issues regarding handling ctrl-c from subprocesses.
> Point this out in the comments.
>
>   t/lib-git-p4.sh |   31 +++++++++++++++++++++++++++++++
>   1 files changed, 31 insertions(+), 0 deletions(-)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index a870f9a..4c30960 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -72,3 +72,34 @@ kill_p4d() {
>   cleanup_git() {
>   	rm -rf "$git"
>   }
> +
> +#
> +# This is a handy tool when developing or debugging tests.  Use
> +# it inline to pause the script, perhaps like this:
> +#
> +#	"$GITP4" clone ...&&
> +#	(
> +#		cd "$git"&&
> +#		debug&&
> +#		git log --oneline>lines&&
> +#		...
> +#
> +# Go investigate when it pauses, then hit ctrl-c to continue the
> +# test.  The other tests will run, and p4d will be cleaned up nicely.
> +#
> +# Note that the directory is deleted and created for every test run,
> +# so you have to do the "cd" again.
> +#
> +# The continuation feature only works in shells that do not propagate
> +# a child-caught ctrl-c, namely bash.  With ash, the entire test run
> +# will exit on the ctrl-c.
> +#
> +debug() {
> +	echo "*** Debug me, hit ctrl-c when done.  Useful shell commands:"
> +	echo cd \"$(pwd)\"
> +	echo export P4PORT=$P4PORT P4CLIENT=$P4CLIENT
> +	trap "echo" INT
> +	sleep $((3600 * 24 * 30))
> +	trap - INT
> +}
> +
