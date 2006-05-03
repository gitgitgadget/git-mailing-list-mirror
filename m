From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Transitively read alternatives
Date: Tue, 02 May 2006 21:28:25 -0700
Message-ID: <7v8xpjhguu.fsf@assigned-by-dhcp.cox.net>
References: <20060501203631.GH20847@admingilde.org>
	<7v1wvdsbuj.fsf@assigned-by-dhcp.cox.net>
	<20060501225335.GI20847@admingilde.org>
	<20060502073847.GK20847@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 06:28:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb8yd-0002cN-GS
	for gcvg-git@gmane.org; Wed, 03 May 2006 06:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWECE23 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 00:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWECE23
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 00:28:29 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38846 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965085AbWECE22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 00:28:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060503042828.HKKA27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 May 2006 00:28:28 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060502073847.GK20847@admingilde.org> (Martin Waitz's message
	of "Tue, 2 May 2006 09:38:47 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19455>

Martin Waitz <tali@admingilde.org> writes:

> When adding an alternate object store then add entries from its
> info/alternates files, too.

Not quite, I'm afraid...

> +static int link_alt_odb_entry(const char * entry, int len, const char * relative_base)
> +{
> +	struct stat st;
> +	const char *objdir = get_object_directory();
> +	struct alternate_object_database *ent;
> +	struct alternate_object_database *alt;
> +	/* 43 = 40-byte + 2 '/' + terminating NUL */
> +	int pfxlen = len;
> +	int entlen = pfxlen + 43;
> +	int base_len = -1;
> +
> +	if (*entry != '/' && relative_base) {
> +		/* Relative alt-odb */
> +		if (base_len < 0)
> +			base_len = strlen(relative_base) + 1;

Wouldn't base_len be always -1 here?

> +	if (*entry != '/' && relative_base) {
> +		memcpy(ent->base, relative_base, base_len - 1);
> +		ent->base[base_len - 1] = '/';
> +		memcpy(ent->base + base_len, entry, len);
> +	}
> +	else
> +		memcpy(ent->base, entry, pfxlen);

Handling of full path sounds sensible; with relative_base case,
the referred-to object directory is relative to our object/
directory, so "A/.git/objects/info/alternates" would typically
have "../../../B/.git/objects/" if A borrows from B that lives
in the same subdirectory as A itself.

> +	/* recursively add alternates */
> +	read_info_alternates(ent->base);

But using that "../../../B/.git/objects/", we would read its
alternates.  If it points at a neighbor we already borrow from,
say C (we would refer to it as "../../../C/.git/objects/"),
prefixing with relative_base would yield

	../../../B/.git/objects/../../../C/.git/objects/

and we would end up getting the same thing twice, which sounds a
bit unfortunate.  Maybe it is easier not to do the recursive
thing unless the alternate is absolute path, and also as a
purely safety measure, limit the maximum recursion depth to
something low like 5, similar to recursive symlink resolution.

Hmm?
