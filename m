From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/18] fsck: Allow demoting errors to warnings via  receive.fsck.warn = <key>
Date: Wed, 21 Jan 2015 00:54:29 -0800
Message-ID: <xmqqlhkwy0my.fsf@gitster.dls.corp.google.com>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
	<cover.1421682369.git.johannes.schindelin@gmx.de>
	<3fd56573b263f2a4551c9a363d1a44728573a1c6.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:54:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDr3c-0004wu-PH
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 09:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbbAUIyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 03:54:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55835 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750832AbbAUIyb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 03:54:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24ADC26973;
	Wed, 21 Jan 2015 03:54:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=enIoYNQCrTt8BMT/rxbKaKZ2h2M=; b=Wv0oXB
	NBAoz9ojWjXAAuwr7Kf3NjJf2CI+watgXvf4pP7nRIGL0hf6MBYh4uX580cwO6L3
	Y4z34KnC1cT3gY8GGjkLugaUczCPLigcJ3XjN0mLH7FZDt9114PrkUR1c+iELQT2
	VQM4ywFDz+qQUGuunN5xBJF6DqG0AXaLv4ITA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TYelBjnOBVwtdNAEk6jBc0XsLuSTBK+d
	KG545e/YyQzaTmtfoUSwAPP5d6/7ZAc/q1u1aHxbKsY3i50o/UrlaXDrsvlQ0R7x
	VxHc+Q35gBBTG4QN7qpmohjqmQWaK0D21WAhCJurdGRCNlUVLL+cMEGqaL5kDdg6
	1qZA2DdZkBg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BAF926972;
	Wed, 21 Jan 2015 03:54:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9455E26971;
	Wed, 21 Jan 2015 03:54:30 -0500 (EST)
In-Reply-To: <3fd56573b263f2a4551c9a363d1a44728573a1c6.1421682369.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 19 Jan 2015 16:50:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CD2FBD8-A14B-11E4-924A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262717>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  
> +	if (starts_with(var, "receive.fsck.")) {
> +		if (fsck_severity.len)
> +			strbuf_addch(&fsck_severity, ',');
> +		strbuf_addf(&fsck_severity, "%s=%s", var + 13, value);

Wouldn't it be safer to use skip_prefix() that lets you avoid the
hardcoded "var + 13" here?

> @@ -1470,8 +1478,13 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>  		argv_array_pushl(&child.args, "unpack-objects", hdr_arg, NULL);
>  		if (quiet)
>  			argv_array_push(&child.args, "-q");
> -		if (fsck_objects)
> -			argv_array_push(&child.args, "--strict");
> +		if (fsck_objects) {
> +			if (fsck_severity.len)
> +				argv_array_pushf(&child.args, "--strict=%s",
> +					fsck_severity.buf);
> +			else
> +				argv_array_push(&child.args, "--strict");
> +		}
>  		child.no_stdout = 1;
>  		child.err = err_fd;
>  		child.git_cmd = 1;
> @@ -1488,8 +1501,13 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>  
>  		argv_array_pushl(&child.args, "index-pack",
>  				 "--stdin", hdr_arg, keep_arg, NULL);
> -		if (fsck_objects)
> -			argv_array_push(&child.args, "--strict");
> +		if (fsck_objects) {
> +			if (fsck_severity.len)
> +				argv_array_pushf(&child.args, "--strict=%s",
> +					fsck_severity.buf);
> +			else
> +				argv_array_push(&child.args, "--strict");
> +		}

Hmm.  The above two hunks look suspiciously similar.  Would it be
worth to give them a single helper function?

> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 6d17040..82f2d62 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -530,6 +530,11 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
>  				strict = 1;
>  				continue;
>  			}
> +			if (starts_with(arg, "--strict=")) {
> +				strict = 1;
> +				fsck_set_severity(&fsck_options, arg + 9);
> +				continue;
> +			}
>  			if (starts_with(arg, "--pack_header=")) {
>  				struct pack_header *hdr;
>  				char *c;
