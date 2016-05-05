From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Thu, 05 May 2016 16:33:03 -0700
Message-ID: <xmqqtwic6pxs.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<20160504062618.GA9849@sigill.intra.peff.net>
	<20160504074559.GA3077@sigill.intra.peff.net>
	<20160504080047.GA2436@sigill.intra.peff.net>
	<CAGZ79kaUiVLuXvpLPKuZZ55zbQXA3Wt7WP3a_65gBW2Cj-gMoQ@mail.gmail.com>
	<20160505012219.GA15090@sigill.intra.peff.net>
	<xmqq60uscufw.fsf@gitster.mtv.corp.google.com>
	<20160505201416.GD9162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 06 01:33:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aySli-0008MM-O2
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 01:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782AbcEEXdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 19:33:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756630AbcEEXdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 19:33:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D3F5119565;
	Thu,  5 May 2016 19:33:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AbapV5Qih2I5+A6sm6G28NK+Erk=; b=k4gFC6
	liF4BGQ8OD4qa+4mp7y5eIXkDjUPXIhyJTjjEGZ4Dnk7lPJfJdwMAoBv0TO4K1nQ
	9tHugqtktdALVR5mVCxbxjPzZJmVdVqY5ss7HeFeZj1QuBLYrTgu6n/Y5NCw0via
	9rF0z9mErGNhLffH20nVyei2x8pgYmafXCCec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fMlb2qiJ9Y0XhoWhYPLyljfRaUaHQPN/
	wDTIzpdKV2D9eWTRJUwVRNgFUEt429SXjBZ/gwVL8RQiD0X9hlzvSadBX2Lq3Zhz
	+qwYF13dRo8RYcRKn6FalyP8pxwmcXT19QvhEopukgy7jWDSXueZl0EYwWl4VV7R
	p7Lb1MyoMhI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CBE5519564;
	Thu,  5 May 2016 19:33:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5725E19563;
	Thu,  5 May 2016 19:33:05 -0400 (EDT)
In-Reply-To: <20160505201416.GD9162@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 5 May 2016 16:14:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B76A4E8A-1319-11E6-9F29-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293727>

Jeff King <peff@peff.net> writes:

> I had originally thought after the final one that we could further clean
> up by turning prepare_submodule_repo_env() into a static function. But
> we can't; it gets called in one spot from submodule--helper. However,
> while looking at it, I did notice that we probably want to squash this
> into the final patch (since sanitize_submodule_config went away
> completely):
>
> diff --git a/submodule.h b/submodule.h
> index 48690b1..869d259 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -43,19 +43,10 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>  int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
>  void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
>  
> -/*
> - * This function is intended as a callback for use with
> - * git_config_from_parameters(). It ignores any config options which
> - * are not suitable for passing along to a submodule, and accumulates the rest
> - * in "data", which must be a pointer to a strbuf. The end result can
> - * be put into $GIT_CONFIG_PARAMETERS for passing to a sub-process.
> - */
> -int sanitize_submodule_config(const char *var, const char *value, void *data);
> -
>  /*
>   * Prepare the "env_array" parameter of a "struct child_process" for executing
>   * a submodule by clearing any repo-specific envirionment variables, but
> - * retaining any config approved by sanitize_submodule_config().
> + * retaining any config in the environment.
>   */
>  void prepare_submodule_repo_env(struct argv_array *out);
>  
>
> -Peff

Hmph, Stefan, do you want to keep this (if you want to resurrect the
function in some future, for example)?
