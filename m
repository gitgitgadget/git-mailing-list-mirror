From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Thu, 14 May 2015 10:37:39 -0700
Message-ID: <xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
References: <55534D95.60609@alum.mit.edu>
	<xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
	<xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
	<xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
	<20150514063317.GA22509@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 19:37:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysx4y-0006kA-Io
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933579AbbENRhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:37:46 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35020 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221AbbENRhm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:37:42 -0400
Received: by iebpz10 with SMTP id pz10so67007272ieb.2
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xDiSJBksRbecMksiUkxf0C+8am4KcCMkLcvi2MdEUC4=;
        b=sMRtUzjqAPrVj9QxI6ecfoXoFHCjnZEIXaz1AJYPwAGZp/XUATmwIVpFnKfWhk5DYS
         ANFFS8uxJkjf+FtvCCnlPxn3Y+t2ZI7g0NZSXPIhhm1owVd1TfhWcjGkiUnxSyVgjVv+
         h4teTBWrB1DpHiiraa1tjFFcPrpJyX/N5BuP+t0jvrP216oo6+J9++yDNK7lLT+J5dAe
         A/Z6wqDar3bMwytYMzA1Z4q9ms5HSlkSQwnfptsvkK24r381G8Q8fReWNL0j5crXFpWl
         06JKlG/hjSasY94bvVwd7zSinWhOlMb70DaqSSQDOrDbbXN5O1cf9PewKttR8Ke2btBE
         2nxw==
X-Received: by 10.50.115.4 with SMTP id jk4mr32290773igb.21.1431625061619;
        Thu, 14 May 2015 10:37:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id v14sm6292696igd.12.2015.05.14.10.37.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 10:37:40 -0700 (PDT)
In-Reply-To: <20150514063317.GA22509@peff.net> (Jeff King's message of "Thu,
	14 May 2015 02:33:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269054>

Jeff King <peff@peff.net> writes:

> While we are on the subject of the name_decoration code, I had
> considered at one point replacing the use of the decorate.[ch] hash
> table with a commit_slab (you can't do it in the general case, because
> decorate.[ch] handles arbitrary objects, but the name_decoration code
> only does commits). It would in theory be faster, though I don't know if
> the time we spend on the hash table is actually measurable (we make a
> lot of queries on it, but it doesn't actually get that big in the first
> place).

Hmmm, but I do not know if commit_slab is a good fit for the usage
pattern.  I expect commit objects to be fairly sparsely decorated
(e.g. a tag or ref pointing at say 1-2% of commits or fewer).
Wouldn't the hashtable used by decorate.[ch] with the max load
factor capped to 66% a better economy?

I notice that there is no API into commit_slab to ask "Does this
commit have data in the slab?"  *slabname##_at() may be the closest
thing, but that would allocate the space and then says "This is the
slot for that commit; go check if there is data there already."

In the context of using commit_slab in log-tree.c for decoration, it
would mean that we assign low slab indices to commits at the tips by
first calling "for_each_ref(add_ref_decoration)" and populate the
slab fairly densely at the beginning.  But when we check if a commit
that we encountered during a traversal is decorated or not, we would
ask *slabname##_at() and that ends up enlarging the slab, even at
that point the only thing we are interested in is if the commit is
decorated and we are not adding a new decoration for it.

For example, we have this in commit.c:

    const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
    {
            struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
            if (sizep)
                    *sizep = v->size;
            return v->buffer;
    }

But if we do not have the "buffer" data cached for that commit (via
an earlier call to set_commit_buffer()), we don't have to enlarge
the slab, as we are not adding anything to the slab system with this
call.

Perhaps we want a new function *slabname##_peek() with the same
signature as *slabname##_at() that returns NULL when commit->index
is larger than the last existing element in the slab?  Then the
above would become more like:

    const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
    {
            struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
            if (!v)
                    return NULL;
            if (sizep)
                    *sizep = v->size;
            return v->buffer;
    }
