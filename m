From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/15] submodule groups (once again)
Date: Tue, 26 Apr 2016 15:26:14 -0700
Message-ID: <xmqqoa8wc8hl.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:26:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avBQz-0000U4-Mj
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 00:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbcDZW0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 18:26:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751890AbcDZW0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 18:26:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CAA0166D6;
	Tue, 26 Apr 2016 18:26:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BQO6cXjXmfzuqDXdFyeAFrpuLBQ=; b=NWmPBt
	/Nu1J0MNVX7A/Od8J+yvcFtShAfYOLRRjaHdGx0zH3AB2+5vhYj3U+HgG7VHEcVK
	bJ9P7wq3SRS4zZLOlP7szmgcEXSu5z6QXol5bImPL+JEu33wo7lFekVfmc+I94vM
	4XM/epjvazL+RMX+t2LT+6ojkEmYOsQyBJFT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b7tDXv1soxF4AZbqVHjAEZ5OkueUF7b2
	me+U9uemgv6zxdJlw8yPp/OIxOX4qqAToyne94f4J/M7T23mnNPnCjCacXRzai6l
	IUVQfktfa6IFzMq7193tMN8WqxuZx6DZWAZyL5OhF0XoZaWfsVX+l3CqJTt83Dde
	6bJH6UYjLNE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 13FAE166D5;
	Tue, 26 Apr 2016 18:26:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 677FF166D4;
	Tue, 26 Apr 2016 18:26:15 -0400 (EDT)
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3A0FB84-0BFD-11E6-B625-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292690>

Stefan Beller <sbeller@google.com> writes:

> What is this series about?
> ==========================
>
> If you have lots of submodules, you probably don't need all of them at once, 
> but you have functional units. Some submodules are absolutely required, 
> some are optional and only for very specific purposes. 
>
> This patch series adds labels to submodules in the .gitmodules file. 
>
> So you could have a .gitmodules file such as: 
>
> [submodule "gcc"] 
>         path = gcc 
>         url = git://... 
>         label = default
>         label = devel 
> [submodule "linux"] 
>         path = linux 
>         url = git://... 
>         label = default 
> [submodule "nethack"] 
>         path = nethack 
>         url = git://... 
>         label = optional
>         label = games 
>
> and by this series you can work on an arbitrary group of these submodules
> composed by the labels, names or paths of the submodules.
>
>     git clone --recurse-submodules --init-submodule=label --init-submodule=label2   git://... 
>     # will clone the superproject and recursively 
>     # checkout any submodule being labeled label or label2
>     
>     git submodule add --label <name> git://... ..
>     # record a label while adding a submodule
>     
>     git config submodule.defaultGroups default
>     git config --add submodule.defaultGroups devel
>     # configure which submodules you are interested in.
>     
>     git submodule update
>     # update only the submodules in the default group if that is configured.
>     
>     git status
>     git diff
>     git submodule summary
>     # show only changes to submodules which are in the default group.

Nicely designed.
