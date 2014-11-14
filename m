From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: support temporarily preserving garbage
Date: Fri, 14 Nov 2014 15:01:05 -0800
Message-ID: <xmqqlhnd1j66.fsf@gitster.dls.corp.google.com>
References: <1415927805-53644-1-git-send-email-brodie@sf.io>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Bryan Turner <bturner@atlassian.com>
To: Brodie Rao <brodie@sf.io>
X-From: git-owner@vger.kernel.org Sat Nov 15 00:01:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpPrf-0005NL-N5
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 00:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422752AbaKNXBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 18:01:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422637AbaKNXBK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 18:01:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DE631E495;
	Fri, 14 Nov 2014 18:01:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qKEdUEFYjk5f5bI0FEQ4vke4GlA=; b=AHEIUl
	ZM56VgAKb9kmvWDmmrNU4iduxp65zR9D6T3hayAYE6SYl9R7HqH+uN3L+2L+9ZOP
	1Bv8SQ7aeDcWtQd4G11DXJCExpN06f7FNhnRo2WGqBvkDRAbIMZEen6H0fdJKben
	sFh841YcGqdwzxJiWQL0UNL+X0DQkF0l0l/Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uc9654vuho9Dxkug+OSuLM16NSoCeV1/
	bdxvDMKFkbtqLIX7AjXCUDfSt/wyoimNiXXTVsw3YIwD4vFZ+ClYpMqfEwl3TXOq
	OcHrIyafebVlyKqpb4tuu3y7DG43jXrlVquB87hE31LCK8CO5gdTIQWItPkZOFsd
	m/8xCg3tOAE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 769E01E494;
	Fri, 14 Nov 2014 18:01:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85BB01E493;
	Fri, 14 Nov 2014 18:01:06 -0500 (EST)
In-Reply-To: <1415927805-53644-1-git-send-email-brodie@sf.io> (Brodie Rao's
	message of "Thu, 13 Nov 2014 17:16:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D798E54-6C52-11E4-AA62-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brodie Rao <brodie@sf.io> writes:

> This patch adds a gc.garbageexpire setting that, when not set to "now",
> makes gc (and prune, prune-packed, and repack) move garbage into a
> temporary garbage directory instead of deleting it immediately. The
> garbage directory is then cleared out based on gc.garbageexpire.
>
> The motivation for this setting is to work around various NFS servers
> not supporting delete-on-last-close semantics between NFS clients.
> Without proper support for that, gc could potentially delete objects
> and packs that are in use by git processes on other NFS clients. If
> another git process has a deleted pack file mmap()ed, it could crash
> with a SIGBUS error on Linux.
>
> Signed-off-by: Brodie Rao <brodie@sf.io>
> ---
>  .gitignore                             |  1 +
>  Documentation/config.txt               | 20 +++++++++
>  Documentation/git-gc.txt               |  7 ++++
>  Documentation/git-prune-garbage.txt    | 55 ++++++++++++++++++++++++
>  Documentation/git-prune-packed.txt     |  9 ++++
>  Documentation/git-prune.txt            |  9 ++++
>  Documentation/git-repack.txt           |  6 +++
>  Documentation/git.txt                  |  6 +++
>  Makefile                               |  2 +
>  builtin.h                              |  1 +
>  builtin/gc.c                           | 20 +++++++++
>  builtin/prune-garbage.c                | 77 ++++++++++++++++++++++++++++++++++
>  builtin/prune-packed.c                 |  3 +-
>  builtin/prune.c                        |  5 ++-
>  builtin/repack.c                       |  7 ++--
>  cache.h                                |  2 +
>  command-list.txt                       |  1 +
>  contrib/completion/git-completion.bash |  2 +
>  environment.c                          | 12 +++++-
>  gc.c                                   | 60 ++++++++++++++++++++++++++
>  gc.h                                   | 16 +++++++
>  git.c                                  |  1 +
>  t/t6502-gc-garbage-expire.sh           | 60 ++++++++++++++++++++++++++
>  23 files changed, 375 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/git-prune-garbage.txt
>  create mode 100644 builtin/prune-garbage.c
>  create mode 100644 gc.c
>  create mode 100644 gc.h
>  create mode 100755 t/t6502-gc-garbage-expire.sh

I am not sure if this much of code churn is warranted to work around
issues that only happen on repositories on NFS servers that do not
keep open-but-deleted files available.  Is it an option to instead
have a copy of repository locally off NFS?
