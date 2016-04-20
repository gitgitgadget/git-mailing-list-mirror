From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] git-p4: fix Git LFS pointer parsing
Date: Wed, 20 Apr 2016 14:01:00 -0700
Message-ID: <xmqq60vcuh9v.fsf@gitster.mtv.corp.google.com>
References: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com>
	<1461139809-6573-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, sschuberth@gmail.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 23:01:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aszFF-0005w3-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 23:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbcDTVBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 17:01:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751704AbcDTVBE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 17:01:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F48B142FB;
	Wed, 20 Apr 2016 17:01:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1/FXONmxzYpBT1700eMUNhibAAc=; b=vfsJUn
	RaO0jFBN9hf4v7v64TxSDH91GcvbM0BHHhTCwFa2JizfAihyqu+UAyqp22Bo2K+4
	jhQ8nz96m4x+4HFFtaJWOM5Mq9zwA7fjiKQkCAE8IQxpn+aahK3qOsdJcwj7XXNI
	YUBKPIe7T1s7UqCBWOY5wAew+sYZwaJ6Z28f8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WFj8Oq2AWy0F67Y3ATMiK1HhuswRjM7u
	NJqLnMABC5UeuQI6aVSvj/5qulTOOA+i9KsNSy2pX/YG/yVPRqpa3Pv4mueYaD9M
	6Uy4r5ToHDDcFDVJyevHinJJyVh1j7ySNvC6NtDfHL1XDuNb67xNeXQ9gyMXqWF6
	RIAj/Fl8K/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97F8F142FA;
	Wed, 20 Apr 2016 17:01:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13A96142F8;
	Wed, 20 Apr 2016 17:01:02 -0400 (EDT)
In-Reply-To: <1461139809-6573-3-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 20 Apr 2016 10:10:09
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FD52AD24-073A-11E6-9FA5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292077>

larsxschneider@gmail.com writes:

> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
> -        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
> +
> +        # Git LFS removed the preamble in the output of the 'pointer' command
> +        # starting from version 1.2.0. Check for the preamble here to support
> +        # earlier versions.
> +        # c.f. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
> +        preamble = 'Git LFS pointer for ' + contentFile + '\n\n'
> +        if pointerFile.startswith(preamble):
> +            pointerFile = pointerFile[len(preamble):]
> +
> +        oidEntry = [i for i in pointerFile.split('\n') if i.startswith('oid')]
> +        oid = oidEntry[0].split(' ')[1].split(':')[1]
>          localLargeFile = os.path.join(
>              os.getcwd(),
>              '.git', 'lfs', 'objects', oid[:2], oid[2:4],
> @@ -1073,7 +1082,7 @@ class GitLFS(LargeFileSystem):
>          )
>          # LFS Spec states that pointer files should not have the executable bit set.
>          gitMode = '100644'
> -        return (gitMode, pointerContents, localLargeFile)
> +        return (gitMode, pointerFile, localLargeFile)

It seems to me that you used to return pointerContents which is an
array of lines (each of which are LF terminated); the updated one
returns pointerFile which is a bare string with many lines.

Is that change intentional?  Does the difference matter to the
caller of this method?  Even if it doesn't, is it a good idea to
change it as part of this commit?

>      def pushFile(self, localLargeFile):
>          uploadProcess = subprocess.Popen(
> diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
> index 0b664a3..ca93ac8 100755
> --- a/t/t9824-git-p4-git-lfs.sh
> +++ b/t/t9824-git-p4-git-lfs.sh
> @@ -13,6 +13,10 @@ test_file_in_lfs () {
>  	FILE="$1" &&
>  	SIZE="$2" &&
>  	EXPECTED_CONTENT="$3" &&
> +	sed -n '1,1 p' "$FILE" | grep "^version " &&
> +	sed -n '2,2 p' "$FILE" | grep "^oid " &&
> +	sed -n '3,3 p' "$FILE" | grep "^size " &&
> +	test_line_count = 3 "$FILE" &&
>  	cat "$FILE" | grep "size $SIZE" &&
>  	HASH=$(cat "$FILE" | grep "oid sha256:" | sed -e "s/oid sha256://g") &&
>  	LFS_FILE=".git/lfs/objects/$(echo "$HASH" | cut -c1-2)/$(echo "$HASH" | cut -c3-4)/$HASH" &&
