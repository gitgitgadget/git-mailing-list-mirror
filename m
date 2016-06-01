From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segfault in the attr stack
Date: Wed, 01 Jun 2016 15:11:30 -0700
Message-ID: <xmqqpos0wodp.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:11:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8EMW-0006A6-4P
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 00:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbcFAWLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 18:11:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750863AbcFAWLe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 18:11:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7743D20103;
	Wed,  1 Jun 2016 18:11:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kGfKc1vs19F6/yO9Avz4ntJS19E=; b=kcc8aq
	Yty1qGmF11kVf9sBTwu8ZaLym6RG0tWXPL1mXEzpM9YjxVGqbKCpLfWznUzEwSlO
	41H7FJfDgd2z+ZOFNtr3+UUH9WzJOGs8SSVdQDIaocQ8R7e2kOv310C+aMsXMoYM
	ZwY492hGptihZRCJOYAu2CqiZA0Z4SbO+Rp9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MPI1VHCOpmJUOdv6GAgqEkKkxAlfcgRE
	Zgzq1poQfZmgWRZ0F1Kodq74g63A77Te4P74IKBI5X7VstdSsCd6wW1JgXQmTyMJ
	MjjuYmixUZPfPx/7PFs1QxzRSQ+QR1qZS7JScX+JA//MTnuOoXpKFIhwcrSNytWC
	F7OcNiCwQ90=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 709C220102;
	Wed,  1 Jun 2016 18:11:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E58CC200FF;
	Wed,  1 Jun 2016 18:11:32 -0400 (EDT)
In-Reply-To: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 1 Jun 2016 15:00:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC75D5F6-2845-11E6-B321-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296170>

Stefan Beller <sbeller@google.com> writes:

> In the Gerrit repo I did
>     $ echo "/plugins/commit-message-length-validator sub-default"
>>>.gitattributes
>     $ git status ":(attr:sub-default)"
> Segmentation fault (core dumped)

Thanks.  I can reproduce this easily with git.git, e.g.

	$ cat >>.git/info/attributes <<-\EOF
	Documentation/git-merge.txt conflict-marker-size=32
        Documentation/user-manual.txt conflict-marker-size=32
	EOF
	$ git status ':(attr:conflict-marker-size=32)'

would die (presumably) the same way.

By the way, I just noticed that the <specification> part of the
':(attr:<specification>)' syntax would need to be rethought.  In the
.gitattributes file everybody has, we see these lines:

        *.[ch] whitespace=indent,trail,space
        *.sh whitespace=indent,trail,space

but because comma is a special separator in the pathspec magic
system, we cannot do

	$ git status ':(attr:whitespace=indent,trail,space)'

I think we should introduce a quoting mechanism to hide these commas
from the pathspec magic splitter, e.g.

where attr_value_unquote() would copy string while unquoting some
special characters (i.e. at least ' ' and ',' because they are used
as syntactic elements in the higher level; there might be others).

diff --git a/pathspec.c b/pathspec.c
index 0a02255..fb22f28 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -132,7 +132,7 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
 				am->match_mode = MATCH_SET;
 			else {
 				am->match_mode = MATCH_VALUE;
-				am->value = xstrdup(&attr[attr_len + 1]);
+				am->value = attr_value_unquote(&attr[attr_len + 1]);
 				if (strchr(am->value, '\\'))
 					die(_("attr spec values must not contain backslashes"));
 			}
