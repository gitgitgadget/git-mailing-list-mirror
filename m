From: Junio C Hamano <gitster@pobox.com>
Subject: Re: attr.c doesn't honor --work-tree option
Date: Thu, 06 Feb 2014 09:54:19 -0800
Message-ID: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
References: <CAB7pA0_2kLJmRZb8Z_9+xOcrbwMZLgnZwC5f7etbE4OuJ1wgmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Lasse Makholm <lasse.makholm@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 18:55:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBTA7-000361-T0
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 18:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbaBFRyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 12:54:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbaBFRyu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 12:54:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A20D168F28;
	Thu,  6 Feb 2014 12:54:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YK+DMrM02RQCTdZgWLcK9snDbX8=; b=c7P/A/
	ewzC/keBPP+gLplPekpUN3hAYi+/KxwqyibaQietLZ/0+NFTD5hGiXmYqSShxSau
	wCElG9osRAHfZ/gijE7lgYJeZ7EeG+SrjCe7LtDK0jAWkUCerErcCPoeMaOhvb9i
	9BX1XNSodC63Ob/sudv/mzVxdldE48KyzLOaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TDyzxl7iBG0LKeKYRPKuJ3KRmwSI0Z5t
	ukT3YcoVIchsxbvYsh4H7Sel0XRjNIlHPoiYz8q0ttiZxo0+gumCWKm4CMRwKjgm
	0uLXKHutRatz6h6qU4lV2rmI4hRu2NSvvolvdfS8atacb1gNWc+Y2iguIv5nUrCK
	j30XUxN3//M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FE3E68F27;
	Thu,  6 Feb 2014 12:54:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50E0A68F16;
	Thu,  6 Feb 2014 12:54:22 -0500 (EST)
In-Reply-To: <CAB7pA0_2kLJmRZb8Z_9+xOcrbwMZLgnZwC5f7etbE4OuJ1wgmA@mail.gmail.com>
	(Lasse Makholm's message of "Thu, 6 Feb 2014 13:48:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B5A0E16A-8F57-11E3-B575-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241705>

Lasse Makholm <lasse.makholm@gmail.com> writes:

> Here's a repro with -DDEBUG_ATTR=1 and a printf() in read_attr_from_file():
>
> $ cd /tmp/
> $ mkdir -p attr-test/repo
> $ cd attr-test/repo
> $ git init
> Initialized empty Git repository in /tmp/attr-test/repo/.git/
> $ echo 'dir/* filter=foo' >.gitattributes
> $
>
> Inside the working tree, it works:
>
> $ ~/src/git.git/git check-attr -a dir/file

Does check-ignore misbehave the same way?

I suspect that is this because check-attr is not a command that
requires a working tree.  The command was written primarily as a
debugging aid that can be used anywhere as long as you have a
repository to read strings from either its standard input or its
arguments, and gives them directly to check_attr(), but it does so
without first going to the top of the real working tree like
check-ignore does.

Forcing it to go to the top of the working tree (see the attached
one-liner, but note that I didn't test it) may give you want you
want.

 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 7cf2953..314ec9f 100644
--- a/git.c
+++ b/git.c
@@ -342,7 +342,7 @@ static struct cmd_struct commands[] = {
 	{ "branch", cmd_branch, RUN_SETUP },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
-	{ "check-attr", cmd_check_attr, RUN_SETUP },
+	{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 	{ "check-ref-format", cmd_check_ref_format },
