From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Fri, 25 May 2012 09:58:45 -0700
Message-ID: <7vy5ogtcxm.fsf@alter.siamese.dyndns.org>
References: <4FBAA33D.1080703@kdbg.org>
 <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com>
 <7vzk8yzq35.fsf@alter.siamese.dyndns.org>
 <CAOeW2eGvEaQYk9KODmLzZuEBu-KhKcQeL4PE-4YHwSgtP0dJfA@mail.gmail.com>
 <7vehq9xz7a.fsf@alter.siamese.dyndns.org>
 <CAOeW2eH85+qa2PXS55_xGwH+tpMDMEK76HywfpLTYrv_Dtg49Q@mail.gmail.com>
 <4FBE9AC7.3010506@kdbg.org> <7vaa0xw9dy.fsf@alter.siamese.dyndns.org>
 <4FBFAC19.8030108@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri May 25 18:58:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXxqn-0006Na-JG
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 18:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab2EYQ6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 12:58:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265Ab2EYQ6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 12:58:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9610E818B;
	Fri, 25 May 2012 12:58:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kdPAbGELv5bKvZu4ntoOlm1q084=; b=DdtkCk
	wb8KJVh467Ng//skFhay6vZy3dS14huueXABULSXyqH/k5PE+ZhZ3T0KG2MNUn/3
	KBQh8rYmUT3uBCrfX0GcQTUWivHV8qMhgRAkDirRMYLnNCJkyZK+VKeTFFYBWeAt
	TqNPZvOqZhq5VBPGsmju+eZC39gnIPVVgYo1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KDXSfMxU5ZX7Z2zqGkYcNCdoJkOOUkjE
	+UkAKpcfXoSsUGlK7gceTaayP85p2LFJ17yOQ0XJI/kkkV+/Ck5y8wAZ2y0B37Ys
	7mxiVzEew570vlFpZ2aCk+diyOGc7ZqsIVHBsVEGjW+Ql7Q74lo0P3XHrD8JP8j4
	MlnCxz2gvZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B617818A;
	Fri, 25 May 2012 12:58:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B6518187; Fri, 25 May 2012
 12:58:47 -0400 (EDT)
In-Reply-To: <4FBFAC19.8030108@kdbg.org> (Johannes Sixt's message of "Fri, 25
 May 2012 17:58:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4BEF5F2-A68A-11E1-83A5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198483>

Johannes Sixt <j6t@kdbg.org> writes:

> First-parentship. When a topic or an integration branch is rebased (with
> --preserve-merges), only the first-parent chain should be rewritten.

While I think the "start from commit T and down to where it branches off
of 'master', rebuild first-parent chain on top of elsewhere" mode has
uses, there is no way it can co-exist under the same option name with the
current "transplant the DAG as a whole on top of elsewhere, preserving the
topology inside the DAG" mode.  The name "preserve merges" clicks with the
latter mode better than the former mode, at least to me.  Perhaps the
other mode can be called "rebase --first-parent" or something?
