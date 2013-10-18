From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Sat, 19 Oct 2013 01:45:03 +0200
Message-ID: <CALKQrgdAhLZStLUquizkW_t6wVQsWs0hpGauEm8NjB6tZ67JFw@mail.gmail.com>
References: <1382102267-18151-1-git-send-email-johan@herland.net>
	<CACsJy8C=kaa2OgdxOrefP+Ck_sSA00tHs9UqMXwkh9v4K3Mdvg@mail.gmail.com>
	<CACsJy8ChkKQJJfV1G6DUQgq1Pwy7Hki1qkD8V4FsLC0bN362PA@mail.gmail.com>
	<CALKQrgcc6gXcthgZgrGS6YA0b8KmnaG=WO=Eu_YQc9pgjRRj6Q@mail.gmail.com>
	<20131018190537.GB11040@sigill.intra.peff.net>
	<xmqq7gdawfeg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 01:45:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXJjJ-00088n-Lc
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 01:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757728Ab3JRXpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 19:45:11 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:51697 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433Ab3JRXpK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 19:45:10 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VXJjA-0006qA-2N
	for git@vger.kernel.org; Sat, 19 Oct 2013 01:45:08 +0200
Received: from mail-pa0-f52.google.com ([209.85.220.52])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VXJj9-000IUz-MC
	for git@vger.kernel.org; Sat, 19 Oct 2013 01:45:07 +0200
Received: by mail-pa0-f52.google.com with SMTP id kl14so5268901pab.39
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 16:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lvS7f/rRzb1AC9lWXqgB4mAltlcLMhgMOmFCpDDkOGQ=;
        b=UM18YvbBlfr1MXM0BhX5kGzeSFVhjiVkz5p8+IKJU8d4Fx18R/9hmiN91HSx8+Djer
         nJ8FrPc4JgPBqC0tvZ1MsaWs12lr0IZka5YNzIMXFw4cFVd+9Y/7BF555LXo5EIPb4bk
         gzAWYGMqlA5ec/F7JcbynMzBZF3eYLor8SMbb+Eqb7POp2PEfC12vCevakoyEjuSmetw
         mrzyh350DOaGLSxQqmc7OwJtBlbYx4irmWWg0Oivq+C3WcQTxyw4+kKhyaE7occC7SB4
         WoCzRmPa8w49P0jpC0iwKPTwurSNfo03OrXIFLa1XeJ0Rbq4FT+ttLnm+lBw8DCjrGVY
         hncA==
X-Received: by 10.68.234.165 with SMTP id uf5mr5446038pbc.41.1382139903535;
 Fri, 18 Oct 2013 16:45:03 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Fri, 18 Oct 2013 16:45:03 -0700 (PDT)
In-Reply-To: <xmqq7gdawfeg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236380>

On Fri, Oct 18, 2013 at 9:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> Agreed. We already leave a wrong-permission directory in place if it
>> existed before we started create_tmpfile. The code before your patch,
>> when racing with such a wrong-directory creator, would abort the
>> tmpfile. Now it will correct the permissions. Either behavior seems fine
>> to me (yours actually seems better, but the point is that it does not
>> matter because they are dwarfed by the non-race cases where the
>> directory is already sitting there).
>
> Agreed.  We may notice the failure to correct the permissions in the
> new code, where the old code left existing directories incorrect
> permissions as they were.

I'm trying to mentally construct a scenario where two writers with
different configuration contexts - one with shared_repository and one
without - compete in this race, and we somehow end up with one of them
not being able to write its object. But the best/worst case I manage
to construct is this:

1. core.sharedRepository = 0640 (group-read-only)
2. Fetch A starts running
3. core.sharedRepository = 0660 (group-writable)
4. Fetch B starts running as a non-owner (i.e. depends on group-writability)
5. One of them (doesn't matter which) wins the mkdir() race
6. A and B next enter the adjust_shared_perm() race
7. B first sets dir mode to 0660
8. A then sets dir mode to 0640
9. B now tries to write its object into the dir, but fails because
it's not group-writable

This case is unfortunate, but no different than if steps 3 and 4 are
swapped, i.e. the case where fetch B fails because the repo is not yet
group-writable. Also, remember that as part of changing
core.sharedRepository like this (step 3), we also require the admin to
manually alter the permission bits of existing object dirs, to make
sure they are group-writable (call this step 3.5). All of this has to
happen _while_ fetch A is running.

Trying to code around this (frankly insane) case in the
create_tmpfile()/adjust_shared_perm() code is IMHO silly. Instead, a
better solution is for the admin to ensure that no fetch (or
receive-pack, or other object-creating process) is running while the
modification of core.sharedRepository and associated resetting of
permission bits on object dirs takes place (in any case, the admin
must ensure this, to resolve the possible race between an
object-creating process started before the core.sharedRepository
change, and the manual permission update of object dirs).

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
