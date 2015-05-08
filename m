From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Fri, 08 May 2015 14:31:39 -0700
Message-ID: <xmqqoaluiwn8.fsf@gitster.dls.corp.google.com>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
	<1431108819-6831-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri May 08 23:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqps2-0001U1-Pv
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbbEHVbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 17:31:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751097AbbEHVbl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 17:31:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD1854E535;
	Fri,  8 May 2015 17:31:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MfHFktGVx+ebOzUh+AEFqRRqPXk=; b=VfRt72
	xtUWfP1xU+Z3/WnT8Sk3B6B28awqWBtcXfn4W/qK6jeU6kgqayRMhcSCSnhHyOZs
	8kbbtmOO+hW1002bPIZF8CEJgEH/RuTyVdngqjoTl3HMtES6OakuIjZOAEtWNwBw
	O2Afys2JsOQhMZijnMRPvHjng7qETFYLcoeWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cVVMcQ5uE7pMp0hEivKdgir1gYuUfADi
	uqiiMqAHKzD3nI1RpM1pfm6n9gkcupqGiDtUty/euvbVn3CAKa1fzqa5yNmRcaMV
	kN5og7sbvHDTcf0MkIc9QoLrUGMoBSAi+q+G8Bz5LXqo/pTCpdN4Sp4zxGBaLA1I
	0YizyquFC0w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5EC94E534;
	Fri,  8 May 2015 17:31:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 396F74E533;
	Fri,  8 May 2015 17:31:40 -0400 (EDT)
In-Reply-To: <1431108819-6831-2-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Fri, 8 May 2015 14:13:38
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D321098-F5C9-11E4-AE66-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268676>

dturner@twopensource.com writes:

> diff --git a/sha1_name.c b/sha1_name.c
> index 6d10f05..23863f7 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1434,6 +1434,12 @@ static int get_sha1_with_context_1(const char *name,
>  			new_filename = resolve_relative_path(filename);
>  			if (new_filename)
>  				filename = new_filename;
> +			if (flags & GET_SHA1_FOLLOW_SYMLINKS) {
> +				ret = get_tree_enty_follow_symlinks(tree_sha1,
> +					filename, sha1, oc->path, &oc->mode);
> +				free(new_filename);
> +				return ret;
> +			}
>  			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
>  			if (ret && only_to_die) {
>  				diagnose_invalid_sha1_path(prefix, filename,

In general, I'd prefer to avoid this kind of "I only need this part
of the existing codeflow and I'll ignore rest by returning early".
You cannot anticipate any future needs of callers (e.g. only-to-die
flag might want to be passed when doing follow-symlinks in the
future) and clean-ups that may be added to the later part of the
function that you are skipping with this early return.

In other words,

	if (new_filename)
        	filename = new_filename;
-	ret = get_tree_entry(...);
+	if (flags & GET_SHA1_FOLLOW_SYMLINKS) {
+		ret = ... whatever new thing you want to do ...
+	} else {
+		ret = get_tree_entry(... just reindented ... );
+	}
	if (ret && ...)

is what we would prefer to see here.

> @@ -1469,5 +1475,7 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
>  
>  int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc)
>  {
> +	if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
> +		die(_("internal error: bad flags for get_sha1_with_context"));
>  	return get_sha1_with_context_1(str, flags, NULL, sha1, orc);
>  }
