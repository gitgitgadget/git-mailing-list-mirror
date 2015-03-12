From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn: Fetch svn branches only and have git recognize them as branches?
Date: Thu, 12 Mar 2015 16:13:20 -0700
Message-ID: <xmqq385924j3.fsf@gitster.dls.corp.google.com>
References: <CAMMCKnc9AKjuwQ_RNxD_g3tn=xFQkbO1i-U=rP2VLWPi7qizGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Brian Koehmstedt <bkoehmstedt@berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Mar 13 00:13:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWCID-0001GC-AI
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 00:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbbCLXNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 19:13:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751614AbbCLXNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 19:13:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E314540016;
	Thu, 12 Mar 2015 19:13:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=enLVP/kd8/VBw3l88X5HdlY/BuY=; b=wxpXel
	bQcsRVKP35K3SK0g7g4hIlYSoptn3gB4jZ/YgWKkS18NNZ4wgVSbEojrHVKB5rAN
	SukUc2Ckf1XWElHNxpldxfqpzAuXyeA3gvyZ9+6nxMmvmYPcCUI8sEma3qrMCAsm
	I1q7/nOUDIX27ic6yoEHi7b1/uz4YRmE7jfYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wfEpd0tk3o9GaNNHVmR4ZfuE4tl3sRG8
	Xu+5yET6rEwNeZyXbBANfssPeP2uMkC1GgjRY5/ahNTRLfcj73u/jZrtj8DUUrn9
	TXHQLQPw/NZEOBF+e6rLiwzMSBltEo4ADU7rf44SL0ZLDFi3Q12BBthGPvsNNPXu
	9AYJErIKMSw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB21740015;
	Thu, 12 Mar 2015 19:13:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53BD740014;
	Thu, 12 Mar 2015 19:13:22 -0400 (EDT)
In-Reply-To: <CAMMCKnc9AKjuwQ_RNxD_g3tn=xFQkbO1i-U=rP2VLWPi7qizGA@mail.gmail.com>
	(Brian Koehmstedt's message of "Thu, 12 Mar 2015 15:30:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60CA9D98-C90D-11E4-9DDD-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265382>

Brian Koehmstedt <bkoehmstedt@berkeley.edu> writes:

> I'm trying deal with a project where the server is disallowing access to
> the root URL on the subversion server.
>
> i.e.,
> Doesn't allow access: http://abc.com/repo
> Does allow access: http://abc.com/repo/trunk, http://abc.com/repo/branches,
> http://abc.com/repo/tags

[warning: I have never used 'git svn' myself for several years]

The problem sounds like what this commit (which is v1.5.1.5~15)
fixed:

commit 4a1bb4c3f87f355dd52fcd0babcbd005d59d7ed6
Author: Eric Wong <normalperson@yhbt.net>
Date:   Sun May 13 09:58:14 2007 -0700

    git-svn: don't attempt to minimize URLs by default
    
    For tracking branches and tags, git-svn prefers to connect
    to the root of the repository or at least the level that
    houses branches and tags as well as trunk.  However, users
    that are accustomed to tracking a single directory have
    no use for this feature.
    
    As pointed out by Junio, users may not have permissions to
    connect to connect to a higher-level path in the repository.
    
    While the current minimize_url() function detects lack of
    permissions to certain paths _after_ successful logins, it
    cannot effectively determine if it is trying to access a
    login-only portion of a repo when the user expects to
    connect to a part where anonymous access is allowed.
    
    For people used to the git-svnimport switches of
    --trunk, --tags, --branches, they'll already pass the
    repository root (or root+subdirectory), so minimize URL
    isn't of too much use to them, either.
    
    For people *not* used to git-svnimport, git-svn also
    supports:
    
     git svn init --minimize-url \
      --trunk http://repository-root/foo/trunk \
      --branches http://repository-root/foo/branches \
      --tags http://repository-root/foo/tags
    
    And this is where the new --minimize-url command-line switch
    comes in to allow for this behavior to continue working.

The description of the commit makes me think that mimicking the
sample command line without minimize-url ought to work, i.e.

    git svn init \
        --trunk    http://abc.com/repo/trunk \
        --branches http://abc.com/repo/branches \
        --tags     http://abc.com/repo/tags

But I've never used 'git svn' for several years, so I may be
completely off the mark.
