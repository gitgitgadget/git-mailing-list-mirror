From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] userdiff: funcname and word patterns for sh
Date: Fri, 13 Mar 2015 22:13:09 -0700
Message-ID: <xmqqy4n0xiu2.fsf@gitster.dls.corp.google.com>
References: <1425918999-11992-2-git-send-email-adrien+dev@schischi.me>
	<1425944432-23642-1-git-send-email-adrien+dev@schischi.me>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr
To: Adrien Schildknecht <adrien+dev@schischi.me>
X-From: git-owner@vger.kernel.org Sat Mar 14 06:13:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWeO9-000192-En
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 06:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbbCNFNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 01:13:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750739AbbCNFNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 01:13:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB4B941EAC;
	Sat, 14 Mar 2015 01:13:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qcyVsMWPJGrVJEB0lHxMQOlLiXM=; b=BRyKFS
	1+6I8nwDm9Zo/MXUFJS41QnyUuVmKyNtDAues5F6Vbm+L7GjEQlplLqHmnCmnITh
	st+A2wxTv+zzXBE6CaoHrNpgXx8RbFRgWEO1a+/eIrBOj+i4vFTgrkxhPvulE5sN
	RGXeMnRNc9DNJ/LMSPNlzjAO3C8V3HNK+EBwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dvrRKP5dQ4MWYV222WoR4PAGJUjTd0xF
	5CpZDpgAfLl1Dlf5sEJOyi0r9K4rqBdV8jnalx/sg12MRUAJ4H7TG1X3SFGh4baU
	5+4T7EQ1F0bAJrPwnOXUk0YbmbtW9H4nEjuOEhkgyYOM/7nC9+TiccfjIn6/jys4
	L9aI0GYMI7k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D516A41EAB;
	Sat, 14 Mar 2015 01:13:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FDF341EAA;
	Sat, 14 Mar 2015 01:13:10 -0400 (EDT)
In-Reply-To: <1425944432-23642-1-git-send-email-adrien+dev@schischi.me>
	(Adrien Schildknecht's message of "Tue, 10 Mar 2015 00:40:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CEAED36E-CA08-11E4-93D9-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265435>

Adrien Schildknecht <adrien+dev@schischi.me> writes:

> Add regexp based on the "Shell Command Language" specifications.
> Because of the lax syntax of sh, some corner cases may not be
> handled properly.
>
> Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
> ---

Those of you who helped in the first round of review, any comments,
"This round looks good"'s, ...?

> +PATTERNS("sh",
> +	"^([ \t]*(function[ \t]+)?[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\).*)$",
> +	/* -- */

I do not think it is wrong per-se to try to be as precise as
possible, but I wonder if it is sufficient to cheat and make these
"what is a word?" expressions a bit looser, by declaring that it is
OK if a simpler pattern allows something that are syntactically
illegal in shell, as long as it splits valid shell construct
correctly.  For example:

> +	 "[a-zA-Z0-9_]+"
> +	 "|[-+0-9]+"

The first one matches an identifier (e.g. If you have frotz="a b c"
and $frotz, two appearances of 'frotz' are matched) and the second
one I think is trying to catch possibly signed integers, but the
latter also matches 0+1+++2 which is already loose (but I do not
think it is a problem).  Perhaps it is sufficient to collapse the
above into a single "[-+a-zA-Z0-9_$]+"?

> +	 "|[-+*/<>%&^|=!]=|>>=?|<<=?|\\+\\+|--|\\*\\*|&&|\\|\\||\\[\\[|\\]\\]"
> +	 "|>\\||[<>]+&|<>|<<-|;;"),

Likewise.  I wonder if something like "[-~!@#%^&*+=|;/]+" gives too
many false matches.

>  { "default", NULL, -1, { NULL, 0 } },
>  };
>  #undef PATTERNS
