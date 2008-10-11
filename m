From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/cygwin.c - Use cygwin's stat if core.filemode ==
 true
Date: Sat, 11 Oct 2008 14:34:50 -0700
Message-ID: <7v1vymke85.fsf@gitster.siamese.dyndns.org>
References: <1223751280-2104-1-git-send-email-mlevedahl@gmail.com>
 <1223751859-3540-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, dpotapov@gmail.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 23:36:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kom8K-0007bl-NG
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 23:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245AbYJKVfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 17:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755118AbYJKVfI
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 17:35:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYJKVfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 17:35:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D03B9899D9;
	Sat, 11 Oct 2008 17:35:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 390D5899D7; Sat, 11 Oct 2008 17:34:53 -0400 (EDT)
In-Reply-To: <1223751859-3540-1-git-send-email-mlevedahl@gmail.com> (Mark
 Levedahl's message of "Sat, 11 Oct 2008 15:04:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 768B6392-97DC-11DD-9950-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97991>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Cygwin's POSIX emulation allows use of core.filemode true, unlike native
> Window's implementation of stat / lstat, and Cygwin/git users who have
> configured core.filemode true in various repositories will be very
> unpleasantly surprised to find that git is no longer honoring that option.
> So, this patch fores use of Cygwin's stat functions if core.filemode is

s/fores/forces/;

>  static int native_stat = 1;
> +static int core_filemode = 0;

Makes me wonder why "trust_executable_bit" is unavailable here.
Perhaps git_cygwin_config() does not fall back to git_default_config()
for a reason?

>  static int git_cygwin_config(const char *var, const char *value, void *cb)
>  {
> +	if (!strcmp(var, "core.filemode")) {
> +			core_filemode = git_config_bool(var, value);
> +			native_stat &= !core_filemode;
> +	}
>  	if (!strcmp(var, "core.ignorecygwinfstricks"))
> -		native_stat = git_config_bool(var, value);
> +		native_stat = git_config_bool(var, value) &&
> +			!core_filemode;
>  	return 0;
>  }

If you can safely determine if you would want to use cygwin_stat or not
only after you have read both core.filemode and core.ignorecygwinfstricks,
perhaps keeping the config reader as is (this includes not falling back to
git_default_config()) and instead doing:

	static int init_stat(void)
	{
		...
		git_config(git_sygwin_config, NULL);
		if (!core_filemode && native_stat) {
			cygwin_stat_fn = cygwin_stat;
			cygwin_lstat_fn = cygwin_lstat;
		} else {
			cygwin_stat_fn = stat;
			cygwin_lstat_fn = lstat;
		}
		...

is less yucky?
