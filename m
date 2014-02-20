From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/25] Convert git_snpath() to strbuf_git_path()
Date: Thu, 20 Feb 2014 10:54:50 -0800
Message-ID: <xmqq1tyx7gxx.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-3-git-send-email-pclouds@gmail.com>
	<xmqqeh2y7jff.fsf@gitster.dls.corp.google.com>
	<CACsJy8BJ=OKzGDFwWQF_k_Gp9XeNwf7pe7c6_ebduJXN=xeOxw@mail.gmail.com>
	<xmqqa9dm78n3.fsf@gitster.dls.corp.google.com>
	<CACsJy8DB+OP6_vwZKWXjq4YbtiKDg2NE2zRsAuz1ER6oTmyGag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 19:55:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGYm0-0004T9-4W
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 19:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbaBTSy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 13:54:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbaBTSy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 13:54:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 538126DEF8;
	Thu, 20 Feb 2014 13:54:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gqPsLquzkpyM3ReZVsyKI0euE84=; b=uVi9zm
	fyLXjWbi12eWTGwWMyVeIn8uGcK5SsD658N8l9/5H8f8agLm559SE22z7sh7O1/8
	/54ucXoOs8GnwvUB2XRHGtrW63p00RbwrlPoS9Vs3UoefVOjgboY200MrYAoKpRw
	dFcKSAwSvyjrY+SONmq5G2gwTn5Vl+tkBqo58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tK7+JbL3pW8FKRbYVI6GlKr5AGwwtIzO
	msFHMpXKE5QRU2C1p/IUrxyJtqf7aNhTdKDgvPcHr4MdlTEVAG/8TfJKBboKoCL3
	h2SOuv/64wJDIWmgUHcNLaF7utObpWR/dDpV4bPbijSnrWxWa79bOMZcELtrghPH
	Tkk+LPQs8dI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B19936DEF5;
	Thu, 20 Feb 2014 13:54:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1309D6DEF3;
	Thu, 20 Feb 2014 13:54:52 -0500 (EST)
In-Reply-To: <CACsJy8DB+OP6_vwZKWXjq4YbtiKDg2NE2zRsAuz1ER6oTmyGag@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 20 Feb 2014 10:55:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7B818386-9A60-11E3-9523-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242439>

Duy Nguyen <pclouds@gmail.com> writes:

> OK so your question was if there was a git_path() or mkpath() call
> earlier in update_refs_for_switch() and the result was expected to
> remain stable till the end of update_refs_for_switch(), then this
> conversion could ruin it, correct? I didn't think about that,...

Yeah, I couldn't tell if you thought about it, and that was why I
asked.

If a (recursively) caller does this:

	caller () {
		const char *path1 = git_path(...);
                const char *path2 = mkpath(...);
                const char *path3 = git_path_submodule(...);
		callee();
                use(path1, path2, path3);
	}

it was safe back when the callee() did not mess with the round-robin
pathname buffer, but it will be broken once callee() does.  While
looking at the patch I didn't check what the caller was doing hence
my question.

In general, in order to reduce that kind of hard-to-debug bugs, we
should be reducing the uses of these functions when we do not have
to (which applies equally to such a caller that expects multiple
temporary paths to persist, and to a callee as well).  Adding
multiple repeated calls to git_path(), especially two of them
formatting the same string into two separate round-robin pathname
buffer, looked strange in a patch that was supposed to be a
preparatory code-cleanup stage.
