From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Wed, 13 Oct 2010 16:02:26 -0700
Message-ID: <7vhbgphf25.fsf@alter.siamese.dyndns.org>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 01:02:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6ALT-0001tF-Gz
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 01:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab0JMXCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 19:02:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab0JMXCl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 19:02:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32E2CDE381;
	Wed, 13 Oct 2010 19:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f+61OBJkv0BzQUf6QcBF3ooEjjo=; b=VETUJs
	DHdA7HjSk4CngBHgVlxLHY3anTGrpeR853piFN988Olo22YvGNugY9v0q24U4MqN
	SPv35AwlNEf1CRxKIaSsJ1cB1ppFo0G4men8MWt5+/hwKLSdp61MLVg8axz6Hbld
	S4vxhmGYmFeS1+DNiafOEWZzVyL4y9zcnculw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jEN7X4DI8gDcfpxhHydQxoZZfwnSYBvX
	UqUruMcIWd8BGSy0Nfo5VATvVf00YnVliPWo9CLqPyKd7euBOdrBTbaMSEmvJ5MI
	5JYLPf2L+sRArhxnMq+2+V56InzzvNvybpxPm0gMjVTF2uVzFewCxhEtbYtfybuZ
	UYLbTRJTDHg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7507DE380;
	Wed, 13 Oct 2010 19:02:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84DB7DE378; Wed, 13 Oct
 2010 19:02:27 -0400 (EDT)
In-Reply-To: <1286833829-5116-16-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Mon\, 11 Oct 2010 23\:50\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F749C3A2-D71D-11DF-A0E1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159003>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Windows does not supply the POSIX-functions fork(), setuuid(), setgid(),
> setsid() and initgroups(). Disable support for --user, --group and
> --detach if the NO_POSIX_GOODIES flag is set.
>
> MinGW doesn't have prototypes and headers for inet_ntop and inet_pton,
> so include our implementation instead. MSVC does have, so avoid doing
> so there.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
> diff --git a/daemon.c b/daemon.c
> index 9b97b58..aa580f6 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -965,7 +969,12 @@ static void store_pid(const char *path)
>  		die_errno("failed to write pid file '%s'", path);
>  }
>  
> -static int serve(struct string_list *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
> +#ifndef NO_POSIX_GOODIES
> +static struct passwd *pass;
> +static gid_t gid;
> +#endif
> +
> +static int serve(struct string_list *listen_addr, int listen_port)
>  {
>  	struct socketlist socklist = { NULL, 0, 0 };
>  

This is ugly.  Why did you need to make the arguments file-scope static?

> @@ -974,10 +983,12 @@ static int serve(struct string_list *listen_addr, int listen_port, struct passwd
>  		die("unable to allocate any listen sockets on port %u",
>  		    listen_port);
>  
> +#ifndef NO_POSIX_GOODIES
>  	if (pass && gid &&
>  	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
>  	     setuid(pass->pw_uid)))
>  		die("cannot drop privileges");
> +#endif

It would be cleaner to make a helper (e.g. "drop-privileges") that is a
no-op on NO_POSIX_GOODIES platform, and call that without #ifdef here.

The same aversion to too many #ifdef's apply to the rest of the patch.
