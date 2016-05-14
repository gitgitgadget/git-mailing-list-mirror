From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git diff-index' doesn't honor the 'diff.algorithm' variable
Date: Sat, 14 May 2016 11:40:47 -0700
Message-ID: <xmqqshxk7aa8.fsf@gitster.mtv.corp.google.com>
References: <9d15b6c8-ed97-7352-3df1-efab1b4ffadb@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dmitry Gutov <dgutov@yandex.ru>
X-From: git-owner@vger.kernel.org Sat May 14 20:41:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1eUh-0003XE-Vs
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 20:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbcENSkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 14:40:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753900AbcENSkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 14:40:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A9D71A5C3;
	Sat, 14 May 2016 14:40:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fvtu+CjiMXAypH6aSKah9izRKq0=; b=YC2lQu
	klm+48/Xsgf9du0xYUqV18BqW/BeOZibLfp5Anc7SoQunfmbb7tCdR9amxTDRGMo
	HSUfqIktvxpFNkOJfsLyQjlWWRFib3hrJYrJD+Nt9EhdpCWUOzLYsWENFeko7/SM
	70Tl4jnCLuJCwaRkC0u91DvQ0U3bfboPf7q88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WcjdkZbNdEUyVV60ZxqxpZL9+MG84Rtj
	9YtVX2d1JEup5jDXvIJewAJQ2T6+ZQ3QJ4JGDCEHq6x5Qupv905xGCs6Vb0PaxfO
	BNCLCUmLd4u0O0j/3uwFc4XhSbf4anTZQ2MN2ovZH3gD9QeaalBvHBxZdohiajD5
	889hcltKcDw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 22C2A1A5C2;
	Sat, 14 May 2016 14:40:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93C721A5C0;
	Sat, 14 May 2016 14:40:49 -0400 (EDT)
In-Reply-To: <9d15b6c8-ed97-7352-3df1-efab1b4ffadb@yandex.ru> (Dmitry Gutov's
	message of "Sat, 14 May 2016 02:45:21 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 61030294-1A03-11E6-8FA7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294622>

Dmitry Gutov <dgutov@yandex.ru> writes:

> Hi all,
>
> Subj. ...even though it's explicitly mentioned in the subcommand's man
> page. Git version 2.7.4 here.
>
> To elaborate:
>
> - Call 'git config --global diff.algorithm histogram'.

The variable belongs to UI config, meant for Porcelain "git diff",
together with things like "diff.color", "diff.context", etc.

As the point of lower-level plumbing commands in the diff family,
i.e. diff-files, diff-index and diff-tree, are about giving stable
output, which are _not_ affected by random end-user configuration,
for scripted use, it is very much deliberate design decision that
they ignore the UI config variables.

A script that calls diff-index, if it wants to honor end-users'
UI config variables, is allowed to use 'git config' to read them and
turn them into appropriate command line options.  e.g.

    algo=$(git config diff.algorithm)
    case "$algo" in
    minimal|histogram|patience) algo=--$algo ;;
    *) algo= ;;
    esac

    ...
    git diff-index $algo ... other args ...

or something like that.
