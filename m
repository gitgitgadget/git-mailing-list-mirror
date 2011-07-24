From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Sun, 24 Jul 2011 12:23:30 -0700
Message-ID: <7vy5znscst.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 21:23:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql4H3-0004X8-Ow
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 21:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab1GXTXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 15:23:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab1GXTXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 15:23:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03E2F4018;
	Sun, 24 Jul 2011 15:23:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KoY9DtJ1kbwT4YkeEY5M3Pk3m/0=; b=riyPA3
	82xZUciD4nxfgFvxPDLI/ulasO0bHFtCFrJW2/9P7BwP2h7W7I9L7bPNdNYte9D+
	+mlGWgGcq/L9rRFIVyH22q1RalMN4L4tdr6OIQbg1rw2nfapQ28hKNSvneC9OyvS
	iqiGbwEjBnk6eK7XvTN2wKArLhjqhc1AKsJPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SrsgnjKam9Bt8jgTZ2SUavuvWXDLTv8p
	f8b7mkzyRlcrzqZipk/7bJ6OkLUPcaR+CjqAbQCN8L3dHZhV2jQvyTtzCsEjWmEK
	cmdwDvx3rHzlPfHEGSkPHP5BIfqG7zIIzKHxUNpcjuTulShojUZES9YFcJujZJbm
	1m0TtrMfPvI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF3AD4017;
	Sun, 24 Jul 2011 15:23:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81D234016; Sun, 24 Jul 2011
 15:23:31 -0400 (EDT)
In-Reply-To: <1311517282-24831-4-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Sun, 24 Jul 2011 16:21:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AA8B984-B62A-11E0-A13A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177774>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>  void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
>  {
> -	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
> +	add_pending_object_with_mode(revs, obj, name, S_IFINVALID, 0);
>  }

This seems utterly broken.  For example, fmt-merge-msg.c adds "^HEAD" and
of course the flags on the object is UNINTERESTING. Has all the callers of
add_pending_object() been verified? Why is it passing an unconditional 0
and not !!(obj->flags & UNINTERESTING) or something?

If the excuse is "this is only to help fast-export and other callers of
add_pending_object() does not care", that is a sloppy attitude that breaks
maintainability of the code (because it forgets to add "in the current
code nobody looks at the new 'flags' field" to that excuse, and also does
not have any comments around this code that says so); it is questionable
if such a hack belongs to a patch that touches object.h.

> @@ -1073,7 +1074,8 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
>  			} else
>  				a->object.flags |= flags_exclude;
>  			b->object.flags |= flags;
> -			add_pending_object(revs, &a->object, this);
> +			add_pending_object_with_mode(revs, &a->object, this,
> +						     S_IFINVALID, flags_exclude);
> ...
> @@ -1103,7 +1105,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
>  	if (!cant_be_filename)
>  		verify_non_filename(revs->prefix, arg);
>  	object = get_reference(revs, arg, sha1, flags ^ local_flags);
> -	add_pending_object_with_mode(revs, object, arg, mode);
> +	add_pending_object_with_mode(revs, object, arg, mode, local_flags);
>  	return 0;
>  }

Questionable.  Did the user mean to say Z is positive when he said

	$ git rev-list A B ^C ... --not G H ... ^Z
