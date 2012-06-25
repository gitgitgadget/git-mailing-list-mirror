From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: Handle new repository case.
Date: Mon, 25 Jun 2012 16:13:22 -0700
Message-ID: <7vobo7dlyl.fsf@alter.siamese.dyndns.org>
References: <1340664813-96891-1-git-send-email-muhtasib@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leila Muhtasib <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 01:13:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjITJ-0005BY-8V
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 01:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185Ab2FYXNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 19:13:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757166Ab2FYXNY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 19:13:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85B7580D9;
	Mon, 25 Jun 2012 19:13:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2+PViiNRD+EtpxhTj+F1XUM0aic=; b=eZHLq8
	JleaDnz+LZ48MAEa+3TpK4ZIbtKcPCoCAAgxSbt8NpBOjlSyZD+Ol+8MwC4/3etb
	0sCo+ILMVPUt+fdwb9sCLFJZPVPlZkjoARwG5wuuSmaoX/VR8aPDdupbtMYbzNH4
	2qEWM9tH/2AZdCQa1iQ2WIPZi7ao/my/BuLjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hzjtrx6iPwk1i7YHKoejGNPwezAOt7JM
	oBwlwtLKTdcmbyAqmVAJepr88Bv2v42i0//q8tQT8m/UyICK1wQxxAMf/TZXizTZ
	i64BzEZjBheb3fdmoYc3kTTwHaIe3UeAhqm5Wod3wNKUzkLjm+i/nDyuhF2t9Ckf
	cXZWTqWDm5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DBA780D8;
	Mon, 25 Jun 2012 19:13:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1216080D7; Mon, 25 Jun 2012
 19:13:23 -0400 (EDT)
In-Reply-To: <1340664813-96891-1-git-send-email-muhtasib@gmail.com> (Leila
 Muhtasib's message of "Mon, 25 Jun 2012 18:53:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CDCF338-BF1B-11E1-B10A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200606>

Leila Muhtasib <muhtasib@gmail.com> writes:

> @@ -553,8 +562,13 @@ int cmd_log(int argc, const char **argv, const char *prefix)
>  	init_revisions(&rev, prefix);
>  	rev.always_show_header = 1;
>  	memset(&opt, 0, sizeof(opt));
> -	opt.def = "HEAD";
> +	opt.def = default_to_head_if_exists();
> +
>  	cmd_log_init(argc, argv, prefix, &rev, &opt);
> +
> +	if (!opt.def && !rev.cmdline.nr)
> +		return 0;
> +
>  	return cmd_log_walk(&rev);

Do you even need these four new lines if you do not error out?
Doesn't log_walk() return successfully if there is nothing in the
queue anyway?

> @@ -1128,7 +1142,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
>  	rev.subject_prefix = fmt_patch_subject_prefix;
>  	memset(&s_r_opt, 0, sizeof(s_r_opt));
> -	s_r_opt.def = "HEAD";
> +	s_r_opt.def = default_to_head_if_exists();

I didn't think about other commands, but I do not think format-patch
wants to silently succeed without doing anything---it is definitely
a user error, no?
