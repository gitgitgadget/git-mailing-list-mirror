From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/9] longest_ancestor_length(): resolve symlinks
 before comparing paths
Date: Sun, 30 Sep 2012 22:30:41 -0700
Message-ID: <7vipauep32.fsf@alter.siamese.dyndns.org>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
 <1348899362-4057-9-git-send-email-mhagger@alum.mit.edu>
 <7vd314gcti.fsf@alter.siamese.dyndns.org> <50692150.8080504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 01 07:31:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIYbO-0006br-La
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 07:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab2JAFap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 01:30:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab2JAFap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 01:30:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32C0A926C;
	Mon,  1 Oct 2012 01:30:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RytjQVcr8EA66qtXVGkCTSioPLc=; b=t11xQ0
	KgYf+ldmNsem2MgVRabvzNYJ7ZAfDKz99HFLn2daGBPL9IdfnN/Rx2z90ddQckr1
	g6+vAIQ3Ju6/Ze5AurF+Tg7k6ZHNNDgZv6Tbyv6PG2WQH8rBgcNFcfCtKIdD1w1J
	tO0Qke+uAyP29ciwAUOMWG5z1qGsJL5J6jx0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QwP19hk9wwRIC1nhMCCytyL706jh1wYD
	duEyhUV7h9PUcFY+7HQWXbroyucz4WoNyLxb+xYZ91ueiyKD5KuC4+ZO0JNn9nNr
	POZ+j68ipGRhJNjKWjXrmZOeV4mRRL8adlkwneLUlNfNDA5kM+75Iv7ZRg+TaI3I
	Eeq1rxoT+oA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18C21926B;
	Mon,  1 Oct 2012 01:30:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 693FB9269; Mon,  1 Oct 2012
 01:30:43 -0400 (EDT)
In-Reply-To: <50692150.8080504@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 01 Oct 2012 06:51:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 250A56FC-0B89-11E2-ADAA-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206715>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think I would advocate that the prefix has to match the front of
> the path exactly (including any trailing slashes) and either
>
>     strlen(prefix) == 0
>     or the prefix ended with a '/'
>     or the prefix and path are identical
>     or the character in path following the matching part is a '/'
>
> This would allow the "is path its own prefix" policy to be decided by
> the caller by either including or omitting a trailing slash on the
> prefix argument.

I think that is sensible thing to do.

The primary thing I found questionable was that the function, given
"/net/wink/project/frotz" to check against "/pub:/s" (or "/pub/:/s/"
if you like), will report that "/net/wink/project" directory is the
longest ancestor, when "/s" is a symlink that happens to point at
"/net/wink/project".  It is very counter-intuitive when you view its
two input strings as strings.  By making its sole caller expand the
symbolic links, it would be a lot clearer what is going on to
anybody who follow the codepath.  We have one path obtained from
getcwd() and a set of paths all of which are real paths without
symbolic aliasing, and we check if one among the latter cover
an earlier part of the former.
