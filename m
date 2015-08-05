From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] fix repo name when cloning a server's root
Date: Wed, 05 Aug 2015 10:34:34 -0700
Message-ID: <xmqq4mkd4p1x.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438687797-14254-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:34:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN2aP-0004MI-11
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 19:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbbHEReh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 13:34:37 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36434 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbHEReg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 13:34:36 -0400
Received: by pacrr5 with SMTP id rr5so6069060pac.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BA00HAlmGtfV6aAZvVWssgXqiO8XerDkLXLc5QYOlbI=;
        b=NCg57HPLF8WDQUKE2kP0eEpWwtuGJTn58lhhNr07vjPvKxgJuqTVz2Fq9eQ7YXT55J
         Aw/I4g2EDIJ2UsQsUbnGw126XTaVqgQSWpBn2Zo216bkQ1y0oyCXkA4az+mpVjoeoDWd
         ypkwdbK4dvAdfTtOgjOxHN41IUHiB1EjS4IwLToS3TW+1B4XJQFJnIB2ZoLCwwLKf+q4
         c9hQaJA4Cjdo3Gsoh0L8X+QA94b4Ex0WNdHLJyht5vcn8h68QKMDYunr+54GpddQN9pi
         JNxBejIP06Yzo+dzUjK1O6gdvgy+74v7RdgpXzdZ3ZLoc/2iVloI/r2udjwZE2agIOtX
         6ZRA==
X-Received: by 10.68.254.69 with SMTP id ag5mr21835297pbd.130.1438796075881;
        Wed, 05 Aug 2015 10:34:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id oq7sm3573968pbb.31.2015.08.05.10.34.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 10:34:35 -0700 (PDT)
In-Reply-To: <1438687797-14254-1-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Tue, 4 Aug 2015 13:29:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275380>

Patrick Steinhardt <ps@pks.im> writes:

>  - The naive way of just adding '@' as path separator would break
>    cloning repositories like '/foo/bar@baz.git' (which would
>    currently become 'bar@baz' but would become 'baz' only).
>
>  - Skipping the scheme initially is required because without it we
>    wouldn't be able to scan until the next dir separator in the
>    host part when stripping authentication information.
>
>  - First checking for '/' in the current stripped URI when we
>    want to remove the port is required because we do not want to
>    strip port numbers when cloning from something like
>    '/foo/bar:2222.git' (which would currently become '2222' but
>    would then be stripped of the ':2222' part and instead become
>    'bar'). Still, this breaks on cloning a bare repository in the
>    current dir (e.g. cloning 'bar:2222.git', which should become
>    '2222' because it is not a port number but would become
>    'bar').

This is a very good write-up.

Please make sure all of the above appears in the commit log message
somewhere.

> As you can see, there is a lot of complexity in there and I'm not
> convinced this is better than just exposing
> 'parse_connect_url()', which already handles everything for us.

If the function "handles everything for us", that's fine, but the
primary reason I am hesitant is because parse_connect_url() was
designed specifically not to have to worry about some protocols
(e.g. I think feeding it a "http://" would fail, and more
importantly, its current callers want such a call to fail).  Also it
is meant to handle some non-protocols (e.g. scp style host:path that
does not follow <scheme>://...).

Also does it handle the "2222" case above?  I do not think
parse_connect_url() even calls get_host_and_port() to be able to
tell what "2222" means in these examples.

> Maybe I'm just being blind for the obvious solution here, though.
>
> Patrick Steinhardt (6):
>   tests: fix broken && chains in t1509-root-worktree
>   tests: fix cleanup after tests in t1509-root-worktree
>   clone: do not include authentication data in guessed dir
>   clone: do not use port number as dir name
>   clone: abort if no dir name could be guessed
>   clone: add tests for cloning with empty path
>
>  builtin/clone.c          | 67 ++++++++++++++++++++++++++++++++++++++++--------
>  t/t1509-root-worktree.sh | 51 +++++++++++++++++++++++++++++++++---
>  2 files changed, 103 insertions(+), 15 deletions(-)
