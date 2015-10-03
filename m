From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test-path-utils.c: remove incorrect assumption
Date: Sat, 03 Oct 2015 10:13:15 -0700
Message-ID: <xmqqlhbj3mfo.fsf@gitster.mtv.corp.google.com>
References: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Ray Donnelly <mingw.android@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 19:13:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiQN7-0007Od-W7
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 19:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbbJCRNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 13:13:17 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36505 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbJCRNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 13:13:17 -0400
Received: by pablk4 with SMTP id lk4so134153213pab.3
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0LxLq4C6O2xvK+8Lw5Gppa0v3LjU10YR0mZtANVAvto=;
        b=g/18Jj+qITshXJj6cxtdEzT21zBsQMq5qdNlW49J2VZIU9UaS8vAgnwoZSA4YApe9d
         jGlM/GiGluj3Pq+TgiV/rJMc1jinFtnjlVOU+TXT8pHNgHJdVrV+/UEviycmN5CXoCV/
         dcsYqg2vepXyerL32sZ/O45e6a9VztsRpwI3NO0RaO2mmDZFENeyMLb5VVi/zC+X0FEx
         OUguDnpHD/mG33W0Bh9dPPqmG+DzHtuH9fODGiQOczIt5xp/7fEYEiqVBqjzJ/kBsrL4
         nr0BLgv6+xOuk+bRT4VR3X7kqpQnLcAMJ9DnF6fEQfIigMu2qACD9zpf2eCn8tSiWukf
         FuVA==
X-Received: by 10.66.102.7 with SMTP id fk7mr27951136pab.119.1443892396525;
        Sat, 03 Oct 2015 10:13:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6403:45be:a5c3:ebf3])
        by smtp.gmail.com with ESMTPSA id ce3sm18408649pbb.35.2015.10.03.10.13.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Oct 2015 10:13:16 -0700 (PDT)
In-Reply-To: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
	(Ray Donnelly's message of "Sat, 3 Oct 2015 13:44:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278977>

Ray Donnelly <mingw.android@gmail.com> writes:

> In normalize_ceiling_entry(), we test that normalized paths end with
> slash, *unless* the path to be normalized was already the root
> directory.
>
> However, normalize_path_copy() does not even enforce this condition.

Perhaps the real issue to be addressed is the above, and your patch
is killing a coalmine canary?

Some callers of this function in real code (i.e. not the one you are
removing the check) do seem to depend on that condition, e.g. the
codepath in clone that leads to add_to_alternates_file() wants to
make sure it does not add an duplicate, so it may end up not noticing
/foo/bar and /foo/bar/ are the same thing, no?  There may be others.
