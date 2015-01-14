From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] init-db: use OPT__QUIET macro instead OPT_BIT
Date: Wed, 14 Jan 2015 11:08:47 -0800
Message-ID: <xmqqa91l9o3k.fsf@gitster.dls.corp.google.com>
References: <1421256762-26765-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 20:08:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBTJG-0008AL-VF
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 20:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbbANTIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 14:08:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751893AbbANTIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 14:08:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FF8A2B372;
	Wed, 14 Jan 2015 14:08:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FiiWh6hJTqGoY6mmM3xplCPLQzY=; b=rK4R3e
	Bxdb02nyC2DitOWF5HIAps38N6V5uZ2X3NyEmHYmCiJ9DZfB/UE8ppL0KBl1b98J
	FGsL31+u2DVoXqtWQ4G4ox4T0MXeSZqs6RkyZX4nW1FM4GKgYo5q1/IdSyPFhwDK
	UMP+YP596T1N9Td+l/F/y+nxxvy03yE6CnMOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SDmT3Zd7LIPufRNR9TBpZA2K97E1qa+P
	dE8kfZV3871XA+TIvqm3nHOghKBnjGxrDReGznBIml5mXmDHJ2khjQiwSVrQIZ9O
	WYLvagkLcNz72fqTp9GHc7zjjLPAfc4zTA9/JU0EmbFp+NQQJO7vL4nzbTj0l+x2
	KrLHE26pe38=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76BD22B370;
	Wed, 14 Jan 2015 14:08:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 127612B36F;
	Wed, 14 Jan 2015 14:08:49 -0500 (EST)
In-Reply-To: <1421256762-26765-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Wed, 14 Jan 2015 23:32:42 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C54AAE62-9C20-11E4-B27C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262414>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> There is OPT__QUIET macro for easily -q/--quiet option defenition,
> let's use it instead OPT_BIT
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  builtin/init-db.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

This is questionable for three reasons.

 - OPT__QUIET() takes an integer and counts up; a single -q and
   double -q -q will give different values to the given variable so
   that the user can express varying levels of quietness.  You can
   no longer check the value with "& INIT_DB_QUIET".

 - We did "flags" very deliberately because we wanted to make sure
   we do not have to add different parameters to init_db() every
   time we wanted a new small knob to tweak its operation like
   "quiet", "verbose", etc.

 - We have been trying to move away from OPT__VERBOSE() and
   OPT__QUIET() to OPT__VERBOSITY(), so that we can handle
   combinations of --quiet and --verbose on the command line in a
   more sensible manner.

I am OK if you switched to OPT__VERBOSITY(), in anticipation of more
verbose output from the command in the future, though.


> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 280454a..a89343b 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -368,7 +368,7 @@ static void separate_git_dir(const char *git_dir)
>  	write_file(git_link, 1, "gitdir: %s\n", git_dir);
>  }
>  
> -int init_db(const char *template_dir, unsigned int flags)
> +int init_db(const char *template_dir, unsigned int quiet)
>  {
>  	int reinit;
>  	const char *git_dir = get_git_dir();
> @@ -411,8 +411,7 @@ int init_db(const char *template_dir, unsigned int flags)
>  		git_config_set("core.sharedrepository", buf);
>  		git_config_set("receive.denyNonFastforwards", "true");
>  	}
> -	if (!(flags & INIT_DB_QUIET)) {
> +	if (!(quiet & INIT_DB_QUIET)) {
