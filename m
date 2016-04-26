From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/3] git-p4 tests: work with python3 as well as python2
Date: Tue, 26 Apr 2016 10:48:02 -0700
Message-ID: <xmqqpotcgt2l.fsf@gitster.mtv.corp.google.com>
References: <1461657061-7984-1-git-send-email-luke@diamand.org>
	<1461657061-7984-3-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:48:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av75p-0004sx-27
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbcDZRsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:48:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750843AbcDZRsG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:48:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A153E1487C;
	Tue, 26 Apr 2016 13:48:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F/vp7pEmxtVuwTear3SS9bY2PH8=; b=VEjXaJ
	FzLBSqTU6tF63tMf2wGpgDM3d7ncQqdsMSFT63cZKury7xduqodeVTnjHcrn9I+o
	UasNWXCtk53rtQtrWuBueasz8Kj2frOUHzT/FELgRW23DaQIKNwrXUynxf09lUs/
	ZRvnerAtjTlWNCDw1dl4jcoS6v41LL86MEzk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aLEl82b3YupOAVoigDkXsov1g9jG0A8k
	/xVGxRaK9GVj5B2SS/+3Y8SDpYaC9snNgZ2hPMuJX58J9nrtZEICzA9Fg/S7bH7f
	8T84tiGorT4T5yUgiidA8WhLe1Qu0RxCnR38zS+Ejvj9SYL4LY0Tee2pI/K0jett
	/UN3vYyH/go=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9979D1487A;
	Tue, 26 Apr 2016 13:48:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A78114879;
	Tue, 26 Apr 2016 13:48:03 -0400 (EDT)
In-Reply-To: <1461657061-7984-3-git-send-email-luke@diamand.org> (Luke
	Diamand's message of "Tue, 26 Apr 2016 08:51:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 06793472-0BD7-11E6-914A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292628>

Luke Diamand <luke@diamand.org> writes:

> Update the git-p4 tests so that they work with both
> Python2 and Python3.
>
> We have to be explicit about the difference between
> Unicode text strings (Python3 default) and raw binary
> strings which will be exchanged with Perforce.
>
> Additionally, print always takes braces in Python3.

s/braces/parentheses/, I think (can locally tweak if you say so--in
which case no need to resend).

>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  t/lib-git-p4.sh            | 5 +++--
>  t/t9802-git-p4-filetype.sh | 6 +++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 724bc43..7393ee2 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -198,9 +198,10 @@ marshal_dump() {
>  	cat >"$TRASH_DIRECTORY/marshal-dump.py" <<-EOF &&
>  	import marshal
>  	import sys
> +	instream = getattr(sys.stdin, 'buffer', sys.stdin)
>  	for i in range($line):
> -	    d = marshal.load(sys.stdin)
> -	print d['$what']
> +	    d = marshal.load(instream)
> +	print(d[b'$what'].decode('utf-8'))
>  	EOF
>  	"$PYTHON_PATH" "$TRASH_DIRECTORY/marshal-dump.py"
>  }
> diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> index 66d3fc9..eb9a8ed 100755
> --- a/t/t9802-git-p4-filetype.sh
> +++ b/t/t9802-git-p4-filetype.sh
> @@ -223,12 +223,12 @@ build_gendouble() {
>  	import sys
>  	import struct
>  
> -	s = struct.pack(">LL18s",
> +	s = struct.pack(b">LL18s",
>  			0x00051607,  # AppleDouble
>  			0x00020000,  # version 2
> -			""           # pad to 26 bytes
> +			b""          # pad to 26 bytes
>  	)
> -	sys.stdout.write(s)
> +	getattr(sys.stdout, 'buffer', sys.stdout).write(s)
>  	EOF
>  }
