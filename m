From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and related stuff
Date: Thu, 14 Apr 2016 09:56:51 -0700
Message-ID: <xmqqy48ggmcs.fsf@gitster.mtv.corp.google.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	<1460507589-25525-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.co,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 18:58:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqkas-0002Jw-9A
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 18:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbcDNQ5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 12:57:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754981AbcDNQ5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 12:57:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE6F413FB9;
	Thu, 14 Apr 2016 12:57:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uf9P7iTsTrSUwgVr/GLmtknUi80=; b=dNl1y5
	EVdKorVLoPifzC3+IbDpDw55tZx49oTCa8ik3yWwdWf+LclrrxEVGbPPvLutIzrR
	rqriCHMNmcibgKw71546Up9lgkLIcomt7Zxj/oXc5CEk+lAfqoCWGrSSXttx5wdP
	fU5yGb5cG1qcpM5tBMqYMyS0H2bA6rCs4Ibg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rKstv83fH0+I09vmJQMgEF+3XZS8OQ84
	HBiZxnlWxxIJHtnakniEOBIF+ZcijryLGiwX2Zk9OYFO/RMfjEXfg4LM4Uq5IThs
	zUmZwCJbJNuOvcX0W/fbQUiYx//BufR6nNnNv8y4Co0rgemjEL8FUcOBny4WXivx
	AcqMQwmm9VI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E0D213FB8;
	Thu, 14 Apr 2016 12:57:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B05113F98;
	Thu, 14 Apr 2016 12:56:53 -0400 (EDT)
In-Reply-To: <1460507589-25525-4-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 12 Apr 2016 20:32:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E36AF94E-0261-11E6-AD0E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291533>

David Turner <dturner@twopensource.com> writes:

> $GIT_DIR/index-helper.path is a symlink to the socket for the daemon
> process. The daemon reads from the socket and executes commands.

We generally avoid using symbolic links inside $GIT_DIR (we used to
represent the current branch by a symbolic link HEAD pointing at the
underlying ref, but switched to the textual symref long time ago,
and we did the ".git pointing at the real repository location" to
support submodules also in a similar way).

I wonder if we can change this to a file that records the location
of the socket without bending over backwards too much?

> Named pipes were considered for portability reasons, but then commands
> that need replies from the daemon would have open their own pipes,
> since a named pipe should only have one reader.  Unix domain sockets
> don't have this problem.
>
> On webkit.git with index format v2, duplicating 8 times to 1.4m
> entries and 200MB in size:
>
> (vanilla)      0.986986364 s: read_index_from .git/index
> (index-helper) 0.267850279 s: read_index_from .git/index
>
> Interestingly with index v4, we get less out of index-helper. It makes
> sense as v4 requires more processing after loading the index:
>
> (vanilla)      0.722496666 s: read_index_from .git/index
> (index-helper) 0.302741500 s: read_index_from .git/index
>
> (these benchmarks are from an earlier version of this patch, but should
> still be valid).

Just something to keep in mind; we'd need to see updated numbers
when the series matures.
