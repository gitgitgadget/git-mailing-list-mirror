From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] gc: reject if another gc is running, unless --force is given
Date: Fri, 09 Aug 2013 10:41:34 -0700
Message-ID: <7vmwoq69td.fsf@alter.siamese.dyndns.org>
References: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
	<1375959938-6395-1-git-send-email-pclouds@gmail.com>
	<CAPrKj1bO1jBsv73beA6LoeN09S-jWq8FYOP+WQ-AFwb1dn4Wsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Andres Perera <andres.p@zoho.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 19:41:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7qh7-00031C-95
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 19:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758428Ab3HIRll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 13:41:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758390Ab3HIRlk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 13:41:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B817A37361;
	Fri,  9 Aug 2013 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IPpbYCc+DTAdX+43OPzycfEHoW0=; b=TpqikX
	XwL6N9t9fZcKgt+9CZrGoSI9iiDt8K/J+ZSEVNUPVeEQfokDVHI1kWRkdEZFeBeW
	CsXPXHaAdyyU3z+olu3hdoQemzvV3fqyL3YiI9dgeqagJJwpryovJnx1YZV+i47u
	iP8LdQo/etAh7jXFxacW1sCAAAIFz8Y+CrTkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OrYz6PUsRp+N2dacu2QzH+2hiP0DfFnJ
	7VbkqJw6/ljou2bdyDPaOMtxxstH54aVleoRvik22alxZqLU/JcCFqHWTNiOlWqE
	ElYGRFCjX+npCjPGBCJpqIwTPf5u73ov5op7NptU0+tDLfnB80psLVeMc6Y0AN75
	vRCDn4i79x4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABC2B37360;
	Fri,  9 Aug 2013 17:41:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF9FE3735C;
	Fri,  9 Aug 2013 17:41:37 +0000 (UTC)
In-Reply-To: <CAPrKj1bO1jBsv73beA6LoeN09S-jWq8FYOP+WQ-AFwb1dn4Wsw@mail.gmail.com>
	(Andres Perera's message of "Fri, 9 Aug 2013 11:59:39 -0430")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F13D2114-011A-11E3-B23F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232002>

Andres Perera <andres.p@zoho.com> writes:

>> +/* return NULL on success, else hostname running the gc */
>> +static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>> +{
>> +       static struct lock_file lock;
>> +       static char locking_host[128];
>> +       char my_host[128];
>> +       struct strbuf sb = STRBUF_INIT;
>> +       struct stat st;
>> +       uintmax_t pid;
>
> pid_t is always an signed type, therefore unintmax_t does not make
> sense as a catch all value

Good eyes.

>> +                       !strcmp(locking_host, my_host) &&
>> +                       !kill(pid, 0);
>> +               if (fp != NULL)
>> +                       fclose(fp);
>> +               if (should_exit) {
>> +                       if (fd >= 0)
>> +                               rollback_lock_file(&lock);
>> +                       *ret_pid = pid;
>> +                       return locking_host;
>
> why not exponential backoff?


If the other guy is doing a GC, and we decide that we should exit,
it is *not* because we want to wait until the other guy is done.  It
is because we know we do not have to do the work --- the other guy
is doing what we were about to do, and it will do it for us anyway.

So I do not think it makes any sense to do exponential backoff if
"gc --auto" is asking "should we exit" to this logic.

An explicit "gc", on the other hand, may benefit from backoff, but
then the user can choose to do so himself, and more importantly, the
user can see "ah, another one is running so enough cruft will be
cleaned up anyway" and choose not to run it.
