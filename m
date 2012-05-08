From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-tree does not use alternate objects for submodules
Date: Tue, 08 May 2012 08:36:36 -0700
Message-ID: <7v1umuznuj.fsf@alter.siamese.dyndns.org>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Orgad and Raizel Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 17:36:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRmSy-0007lv-C2
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 17:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793Ab2EHPgk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 11:36:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755572Ab2EHPgj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 11:36:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 825C27752;
	Tue,  8 May 2012 11:36:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hPqszXX51/5n
	3N9BPkDvYHarz9Y=; b=ILfKto6mcZuF/VmzGPCRG/rS+4NNAnburLzz7PIbsXta
	d87UEJSUkS0TC8jYgrZbAOzIyk5d9EX8Yi+tRcLP2spKtYO/zSXYJOAZZuMQuuvr
	hGFoW5N2Dw1uRVMeJjcz8RHrSB+2djJ5mCF7B2oIhbP2S9IliutSoKhZqyuykTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eX0gx1
	x1G5fKRMqzEsXg4jYZgC7JrVnW9UEzU4qjKmzhIZ/FGoDzyvORG0bqV8z3f2dahB
	TOT8xhuAlArn0uE/Ut5Q8RmHhJOr8UFu5PUyq1LYcrO3JVxsC73ZQKUldTyDxTX2
	7E2wNcAU69896JI6QNF5D6FTIJcKCqWU/v2uE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72D6D7751;
	Tue,  8 May 2012 11:36:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6AF7774D; Tue,  8 May 2012
 11:36:37 -0400 (EDT)
In-Reply-To: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com> (Orgad
 and Raizel Shaneh's message of "Tue, 8 May 2012 16:42:08 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99B5C816-9923-11E1-85DB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197375>

Orgad and Raizel Shaneh <orgads@gmail.com> writes:

> I have a project with a submodule. Both have objects/info/alternate
> (different ones).
>
> After running 'git gc', running gitk on the superproject results in:
> =C2=A0 Submodule sub 227e2b5...d8597e2 (commits not present)

When "--submodule" option was implemented in 752c0c, it was done with a=
n
premature and incomplete optimization, and I think you are seeing an
unfortunate side effect of it. The code attempts to link the object sto=
re
of the submodule repository into the in-core representation of the obje=
ct
store of the superproject (in submodule.c::add_submodule_odb()), but do=
es
not do a good job of it.  It does not take alternates into account, and
who knows what else is missing.  Sigh...

The right approach to implement this feature would have been to fork a
child process and perform the submodule operation inside the child, whi=
ch
will chdir into the submodule and treat as if it is a freestanding git
repository, without contaminating the superproject process.

=46or now, an easiest workaround would be to rephrase the error message=
 to
"commits not present" to "commit not present or missing", or something.
