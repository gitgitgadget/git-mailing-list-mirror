From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Solve git-submodule issues with detached work trees
Date: Mon, 23 Jul 2012 16:42:01 -0700
Message-ID: <7veho2hwom.fsf@alter.siamese.dyndns.org>
References: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com>
 <7vsjcjnjvj.fsf@alter.siamese.dyndns.org> <500D8C30.9010807@web.de>
 <7v7gtumj88.fsf@alter.siamese.dyndns.org> <500DADEE.9060700@web.de>
 <7vd33mkyhj.fsf@alter.siamese.dyndns.org> <500DDB99.80103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
	git@vger.kernel.org,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 01:42:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StSGR-0006wC-W5
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 01:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab2GWXmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 19:42:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755001Ab2GWXmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 19:42:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 318E47464;
	Mon, 23 Jul 2012 19:42:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nU6O+0i7y9YsZH7p26boLOJrJvU=; b=MERvzZ
	vNLUyzmBdAB7RKhrP7gN1FphNf1t/6bjL4xX4xZgLj5N4ETbEHHLzQB6xwz4tc1I
	2qOp9pMbxDNA25Bf/mTO5HdJcIMPk/fiXVCP3L/QY8zKMNMDKdnz3ToMXnHmbDVz
	WcUGua855mbF1uUSIhdavxuemur4iuVsyD6Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eRvyh/CH3YEaNEwbCrFHpBHwPdE3/FfI
	9EdLF+srjQ64vEb0oh8vH+t1u7YIg9mTcW80wqQew2+QAheVLGuj1o7jPW1K18hA
	qoeoXub/WB6CfSLPEpKGq3UkJJ/qLEl4kZ0Qd8ae7gg1y7B/Anq8267phv/XBT+t
	ELjnXr8RpLs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B7C77463;
	Mon, 23 Jul 2012 19:42:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88B787462; Mon, 23 Jul 2012
 19:42:03 -0400 (EDT)
In-Reply-To: <500DDB99.80103@web.de> (Jens Lehmann's message of "Tue, 24 Jul
 2012 01:17:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01529B9C-D520-11E1-B3ED-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202005>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Not inside the submodule, me thinks they only make sense in the
> superproject (that's why we clean the environment before working
> inside the submodule).

Yes, that is fundamental and the only sane behaviour that comes from
what submodules are.  They are free-standing projects.  Not clearing
these environments when Git recurses into submodule was simply a bug
(the original bug was that we added recursion without thinking these
things through).

Hence...

> But setting the superproject's GIT_WORK_TREE
> to something else won't work for an already initialized submodule,

... if you point the _root_ of the toplevel superproject with
GIT_WORK_TREE (and the repository of the superproject with GIT_DIR),
and chdir into one of its submodule's working tree, we shouldn't say
$GIT_WORK_TREE/$smpath is the submodule world.  That will make it
impossible to work only on submodules by setting GIT_WORK_TREE to
point at its root level (and the submodule repository with GIT_DIR).
