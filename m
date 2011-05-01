From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Pass empty file to p4merge where no base is
 suitable.
Date: Sun, 01 May 2011 14:54:46 -0700
Message-ID: <7v7haarsrd.fsf@alter.siamese.dyndns.org>
References: <BANLkTimXBayYAScPfk2j9spxcYrmtMJKxg@mail.gmail.com>
 <7vwriq3p0t.fsf@alter.siamese.dyndns.org>
 <BANLkTimf1q8JM46J-X1BCwQ+GaeWAgv75Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Ciaran <ciaranj@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 23:55:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGebY-0006sV-2n
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 23:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab1EAVy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 17:54:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1EAVy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 17:54:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 798365DDD;
	Sun,  1 May 2011 17:57:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8m35iKTkht3df21PnEwJlSc7uWk=; b=AnMCs6
	RpdUc3gFIlx3t47qHEsl0B0BmisGdJv2/98C4o3ccv8E4Ru8L8y4Yr6cjU6rGiN6
	/PiLbMevjJL+4B9EZHw8VwC1p1MtL+9j0dlNNCnENuLwgQovSXf6m51Hu9uNO6t8
	uKkKWY54dgCtjIN1jMVTtyzXOBos1v5lx+3FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wRe3LwFnF/UIdoEuhaz4DYmkXUYqrEMg
	JvE22l1oisfbro5w/eD6Qg61kRLy7ynLitTTRRzLYWjOE3VhEl3nu3xfpzeVBN9P
	jmn9ZWUsY5iE2ul+lOFBG8sPgyz1ucsaCIiJo9Ilizui6dsm7BzmWCEDU6fcbQd/
	UKTddDXh4lg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45F915DD8;
	Sun,  1 May 2011 17:56:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1CDE25DD6; Sun,  1 May 2011
 17:56:51 -0400 (EDT)
In-Reply-To: <BANLkTimf1q8JM46J-X1BCwQ+GaeWAgv75Q@mail.gmail.com> (Ciaran's
 message of "Sun, 1 May 2011 21:47:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE5CAF1C-743D-11E0-832D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172547>

Ciaran <ciaranj@gmail.com> writes:

>> I suspect that you may be able to simply use "$BASE" for that, no?  It
>> will be cleaned up when cleanup_temp_files() is run anyway (warning: I do
>> not use mergetool, and I am writing this only from my cursory looking of
>> the script, so take this with a large grain of salt).
> I don't think so, the BASE file isn't created at-all in this scenario afaict.

Hmm, just like $BASE, your .no-base is not created at all in this scenario
either, but you create it yourself in your patch, and because you picked a
new filename for that temporary file, you also need to worry about
cleaning it up.

Why can't that temporary file be "$BASE"?  That is what I was asking.
Then you would still create an empty file (but see *1*), and can rely on
existing codepaths to clean it up.

IOW, wouldn't it be far simpler to turn the part you are patching into
these three lines?

	$base_present || >"$BASE"
        "$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
        check_unchanged

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index fb3f52b..7b2008f 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -262,7 +262,9 @@ run_merge_tool () {
>  			if $base_present; then
>  				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
>  			else
> -				"$merge_tool_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
> +				: > "$GIT_DIR/.no_base"
> +				"$merge_tool_path" "$GIT_DIR/.no_base" "$LOCAL" "$REMOTE" "$MERGED"
> +				rm "$GIT_DIR/.no_base"
>  			fi
>  			check_unchanged
>  		else


[Footnote]

*1* It also may be worth considering to employ the "use either an empty
    file or use the common parts of merged files, whichever makes the
    merge simpler, as a phony base" technique found in git-merge-one-file.
