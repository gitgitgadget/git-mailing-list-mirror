From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's the difference between `git show branch:file | diff -u -
 file` vs `git diff branch file`?
Date: Tue, 23 Aug 2011 10:15:36 -0700
Message-ID: <7vk4a4rqvb.fsf@alter.siamese.dyndns.org>
References: <loom.20110823T091132-107@post.gmane.org>
 <4E537AF0.9070604@drmicha.warpmail.net>
 <1314096731.15017.2.camel@n900.home.ru>
 <4E53C89A.9000604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 19:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvuZk-0007AB-FL
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 19:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab1HWRPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 13:15:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755460Ab1HWRPj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 13:15:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC203358B;
	Tue, 23 Aug 2011 13:15:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M3ezbWzREfvfxTD1ipr1hA/c84c=; b=W7gIbM
	4hiqu4PnOMxuCMnY/D5JViDq0tGdEC6b6ohszVx2vg7uvvpWlomSRV7oO+AARZIX
	qp0KtrG3G2NB1RI3WIz9zNss+eX3bCLZhGNJn3lbmD9aaPDtuN8SgJlkO+7AqgpF
	iJ4Us8KOzUjz6P8J+L1aEC6DSvy148it09nfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HqdU6eK9IK7pR+5tVHwwaxTm79EIqxSD
	5uiHyIAlPWkhSvpq0DhUzIKk1LFfTsTMqGRaBEwog5An6aMiAcO3cq+UuhFJmt3O
	RlVfO7HvjTjBY0IukyIXvAQMj7E2krOMa+PBPU6A19z4nKTiQSS9P2jZ9/vrBkh9
	z8mA7dsutZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1681358A;
	Tue, 23 Aug 2011 13:15:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 199703588; Tue, 23 Aug 2011
 13:15:38 -0400 (EDT)
In-Reply-To: <4E53C89A.9000604@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 23 Aug 2011 17:34:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8554F5D4-CDAB-11E0-846E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179951>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Marat Radchenko venit, vidit, dixit 23.08.2011 12:52:
>>> Is that a very large tree or a very slow file system?
>> Tree is large (500k files), file system is irrelevant since all time is spend on CPU.
>> 
>>> Do we enumerate all
>>> differing files and only then limit diff output by path??
>> 
>> Dunno, that's why I am asking why it is so slow.
>
> Well, we have to read the full tree before diffing.

Not necessarily, especially when pathspec is given like the original post,
i.e. "git diff $tree_ish -- $path". We would need to open tree objects
that lead to the leaf of the $path and a blob, but other objects won't be
needed.

The default diff backend tries to come up with minimal changes by spending
extra cycles, so it is not so surprising if the file compared is large-ish
and/or has very many similar lines in itself (in which case there are many
potential matching line pairs between the preimage and the postimage to be
examined to produce a minimal diff).
