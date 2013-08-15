From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash takes excessively long when many untracked files present
Date: Thu, 15 Aug 2013 12:47:03 -0700
Message-ID: <7v8v02rb2g.fsf@alter.siamese.dyndns.org>
References: <20130810214453.GA5719@jtriplet-mobl1>
	<loom.20130813T120243-481@post.gmane.org>
	<7v7gfpy0wy.fsf@alter.siamese.dyndns.org>
	<1fc732a7-6b63-4d75-960f-0b1c6cf9c70e@email.android.com>
	<7vmwolwk94.fsf@alter.siamese.dyndns.org>
	<7v61v9w9dy.fsf@alter.siamese.dyndns.org>
	<7vr4durgd4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Darander <anders.darander@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 21:47:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA3Vp-0004fi-KC
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 21:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758804Ab3HOTrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 15:47:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45831 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785Ab3HOTrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 15:47:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE0AC399C6;
	Thu, 15 Aug 2013 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dnm8KZV6xHrcJeAAcif6Ref93/o=; b=rVVniT
	kOk8PtpL27hR9mhw/ChSfyTMy5ilxGJymeQHbUxpPDnEU4zgGUL2PJn5SxQ4ZYoH
	acFX6+9zTNZvfP54x/n2ejA5/q55xj2AOzGG5scsnERUU48+w6g434LslJDMvMvZ
	b/N9DBCUJD/KRdQVUd/qJn8/jWQ3Fm+N8zGC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HyXYTdszc/rdP67Q7i46A3+bn9/rKhoT
	tuWxoCx22UFdPyHR1bId98u4RquPCcQhNC7hIT83y6RjbcDXkxpCh87y2AoN7bLk
	BdpNHuQ6EmRo3PHZcvNbnV80NWD1m5xkxAqZ5pqpibEx1NXy6SQC+nAOb17EABRf
	a9OO1+WNz/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D21AC399C5;
	Thu, 15 Aug 2013 19:47:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25002399C2;
	Thu, 15 Aug 2013 19:47:05 +0000 (UTC)
In-Reply-To: <7vr4durgd4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 15 Aug 2013 10:52:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 764B72DA-05E3-11E3-833F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232366>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/dir.c b/dir.c
> index 910bfcd..02939e2 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1183,6 +1183,15 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
>  	    cache_name_exists(path->buf, path->len, ignore_case))
>  		return path_none;
>  
> +	/*
> +	 * A directory can only contain killed files if the index
> +	 * has a path that wants it to be a non-directory.
> +	 */
> +	if ((dir->flags & DIR_COLLECT_KILLED_ONLY) &&
> +	    (dtype == DT_DIR) &&
> +	    !cache_name_exists(path->buf, path->len, ignore_case))
> +		return path_none;
> +

I think this is wrong.

When we are looking at a directory P in the working tree, there are
three cases:

 (1) P exists in the index.  Everything inside the directory P in
     the working tree needs to go when P is checked out from the
     index.

 (2) P does not exist in the index, but there is P/Q in the index.
     We know P will stay a directory when we check out the contents
     of the index, but we do not know yet if there is a directory
     P/Q in the working tree to be killed, so we need to recurse.

 (3) P does not exist in the index, and there is no P/Q in the index
     to require P to be a directory, either.  Only in this case, we
     know that everything inside P will not be killed without
     recursing.

The patch will break with the second case, I think.
