From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Re: [PATCH] config: warn on inaccessible files
Date: Sat, 13 Oct 2012 21:55:22 -0700
Message-ID: <7vhapx1wlh.fsf@alter.siamese.dyndns.org>
References: <20121014000210.GA19094@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 06:55:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNGEm-00046G-1Y
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 06:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab2JNEzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 00:55:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab2JNEzY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 00:55:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 613666248;
	Sun, 14 Oct 2012 00:55:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+6BPLqG6ZstR2PUqcGQIM/CAvmo=; b=V5BFqS
	STI6rYOd1QykDtjooUxY1YO2Pht8DMhEX32eUjKMegOX8+/Xhc4gfyV8JhfKWCUt
	OFfMz7r3vPx9BCfwuZE7x4hPS5SF+WM9S2iZAuSZTvvH9ZIQ/LHgyhoTiJCxPMH8
	b2TLdyWcEU5GTpUJufkL1mCzkPvZMRr42HgAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wKH+xyM2MgOS/djxEuFWn1Yjo/Vsmp4N
	j5TdVFEiZYEI3FqkYkiAhE9uVBYc/rtFCto/huBivZudCvWUNG4pSLlXUrF8Vwt6
	LcQqCNsGNo1i+rq4+Vwj8pi6eawtbacqXOuO3cYJYm3/xHsOrBx1aMeIT4/SMPpP
	hv1gj0sUlaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F7E46247;
	Sun, 14 Oct 2012 00:55:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DD506245; Sun, 14 Oct 2012
 00:55:23 -0400 (EDT)
In-Reply-To: <20121014000210.GA19094@elie.Belkin> (Jonathan Nieder's message
 of "Sat, 13 Oct 2012 17:02:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CEB8B90-15BB-11E2-8A8C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207610>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Jeff,
>
> In August, Jeff King wrote:
>
>> Before reading a config file, we check "!access(path, R_OK)"
>> to make sure that the file exists and is readable. If it's
>> not, then we silently ignore it.
>
> git became noisy:
>
>  $ git fetch --all
>  warning: unable to access '/home/jrn/.config/git/config': Not a directory
>  ...
>  warning: unable to access '/home/jrn/.config/git/config': Not a directory
>  Fetching charon
>  warning: unable to access '/home/jrn/.config/git/config': Not a directory
>  [...]
>
> On this machine, ~/.config/git has been a regular file for a while,
> with ~/.gitconfig a symlink to it.  Probably ENOTDIR should be ignored
> just like ENOENT is.  Except for the noise, the behavior is fine, but
> something still feels wrong.  
>
> When ~/.gitconfig is unreadable (EPERM), the messages are a symptom of
> an older issue: the config file is being ignored.  Shouldn't git error
> out instead so the permissions can be fixed?  E.g., if the sysadmin
> has set "[branch] autoSetupRebase" to true in /etc/gitconfig and I
> have set it to false in my own ~/.gitconfig, I'd rather see git error
> out because ~/.gitconfig has become unreadable in a chmod gone wrong
> than have a branch set up with the wrong settings and have to learn to
> fix it up myself.
>
> In other words, how about something like this?

I think that is a reasonable issue to address, but I wonder if we
should be sharing more code between these.  If the config side can
be switched to unconditionally attempt to fopen and then deal with
an error when it happens, we can get rid of access_or_{warn,die}
and replace them with fopen_or_{warn,die} and use them from the two
places (attr.c:read_attr_from_file() and the configuration stuff).

I haven't looked to see if that a too intrusive refactoring to be
worth it, though.
