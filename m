From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 4/4] git submodule: Fix handling of // and /.. in paths
 for added submodules
Date: Wed, 25 Feb 2009 15:06:14 +0100
Message-ID: <49A55056.8020504@viscovery.net>
References: <49A541D3.4030001@viscovery.net> <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-3-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-4-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-5-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 15:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcKQT-0000AK-Fy
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 15:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbZBYOGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 09:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbZBYOGY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 09:06:24 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54352 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbZBYOGX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 09:06:23 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LcKOt-00010w-Ip; Wed, 25 Feb 2009 15:06:15 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 03FDEA865; Wed, 25 Feb 2009 15:06:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1235568392-19705-5-git-send-email-git@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111459>

Michael J Gruber schrieb:
> @@ -167,6 +167,12 @@ cmd_add()
>  	;;
>  	esac
>  
> +	# simplify multiple /
> +	path=$(echo "$path" | sed -e 's|/\+|/|g')

I think we have so far avoided \+ in sed expressions for portability reasons.

> +
> +	# resolve /.. (add trailing / for matching /..$)
> +	path=$(echo "$path/" | sed -e 's|\([^/]*\)/../||g')

This does not work if there are more than two ../ in a row:

	$ echo a/b/c/../../d | sed -e 's|\([^/]*\)/\.\./||g'
	a/b/../d

(and make this /\.\./ instead of /../).

> +
>  	# strip superfluous ./ from path
>  	path=$(echo "$path" | sed -e 's|^\(\./\)*||' -e's|/\./|/|g')

The latter two transformations should be swapped; otherwise you would
transform foo/./../bar into foo/bar.

Perhaps it's now time to write this as:

	# normalize path
	path=$(printf '%s\n' "$path" |
		 sed -e '
			# simplify multiple /
			s|//*|/|g
			# strip superfluous ./
			s|^\(\./\)*||
			s|/\./|/|g
			# resolve /..
			s|\([^/]*\)/\.\./||g
			# strip trailing slashes
			s|/*$||
		')

But unless you know how to solve the ../../ case with a sed program, I
suggest that you keep things simple and take care only of the common cases.

-- Hannes
