From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Project idea: strbuf allocation modes
Date: Fri, 18 Apr 2014 15:50:46 +0200
Message-ID: <53512DB6.1070600@alum.mit.edu>
References: <vpqr457omgs.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 18 15:50:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wb9Bw-0007aK-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 15:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbaDRNuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 09:50:51 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58442 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139AbaDRNut (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2014 09:50:49 -0400
X-AuditID: 1207440e-f79c76d000003e2c-c2-53512db824f2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BD.E5.15916.8BD21535; Fri, 18 Apr 2014 09:50:49 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9714E.dip0.t-ipconnect.de [79.201.113.78])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3IDok9l009763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 18 Apr 2014 09:50:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <vpqr457omgs.fsf@anie.imag.fr>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqLtTNzDYYPlqRouuK91MFpc+r2d1
	YPKY+OU4q8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bkd66czFczQrTi0dDl7A+N3+S5GTg4JAROJ
	y+/ns0DYYhIX7q1n62Lk4hASuMwose3MS1YI5zyTRPe7vWwgVbwC2hJnDj1jArFZBFQl/hzs
	Zgax2QR0JRb1NAPFOThEBYIk/pxVhCgXlDg58wnYAhEBL4nD316DlQsL6Ek8WP4PLC4koCXx
	6f5usFZOoPErl0mDmBIC4hI9jUEgFcwCOhLv+h4wQ9jyEtvfzmGewCgwC8mCWUjKZiEpW8DI
	vIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJEj5djC2r5c5xCjAwajEw6vx
	wz9YiDWxrLgy9xCjJAeTkijvL63AYCG+pPyUyozE4oz4otKc1OJDjBIczEoivLv/BgQL8aYk
	VlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeEN0gIYKFqWmp1akZeaUIKSZ
	ODhBhnNJiRSn5qWkFiWWlmTEg6I0vhgYpyApHqC9a0HaeYsLEnOBohCtpxh1OS40rGhhEmLJ
	y89LlRLnFQYpEgApyijNg1sBS0mvGMWBPhbmXQpSxQNMZ3CTXgEtYQJa8vcMyHPFJYkIKakG
	xujg27M4ZK3idBo1NH8p16+XZWs6XZ39tiWoxvjD0bd7d2+aYBlw+7S6aeBHZv8LR+tEdVq1
	Je8fchO5f7hPQ++hRGX0QbHH7a6H2i941+68Ulc2abWt8qUpoVYs/strwl4KmxoU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246470>

I like that strbuf is getting used more than it used to, and I think
that is a good general trend to help git rid of and/or avoid buffer
overflows and arbitrary limits on strings.

It is unfortunate that it is currently impossible to use a strbuf
without doing a memory allocation.  So code like

    void f()
    {
        char path[PATH_MAX];

        ...
    }

typically gets turned into either

    void f()
    {
        struct strbuf path;

        strbuf_add(&path, ...);   <-- does a malloc
        ...
        strbuf_release(&path);    <-- does a free
    }

which costs extra memory allocations, or

    void f()
    {
        static struct strbuf path;

        strbuf_add(&path, ...);
        ...
        strbuf_setlen(&path, 0);
    }

which, by using a static variable, avoids most of the malloc/free
overhead, but makes the function unsafe to use recursively or from
multiple threads.


The Idea
========

I would like to see strbuf enhanced to allow it to use memory that it
doesn't own (for example, stack-allocated memory), while (optionally)
allowing it to switch over to using allocated memory if the string grows
past the size of the pre-allocated buffer.

The way I envision this, strbuf would gain a flags field with two bits:

    STRBUF_OWNS_MEMORY

        The memory pointed to by buf is owned by this strbuf.  If this
        bit is not set, then the memory should never be freed, and
        (among other things) strbuf_detach() must always call xstrcpy().

    STRBUF_FIXED_MEMORY

        This strbuf can use the memory of length alloc at buf however
        it likes.  But it must never free() or realloc() the memory or
        move the string.  Essentially, buf should be treated as a
        constant pointer.  If the string overgrows the buffer, die().

The different bit combinations would have the following effects:

    flags == ~STRBUF_OWNS_MEMORY | ~STRBUF_FIXED_MEMORY

        The strbuf doesn't own the current memory, but it is allowed to
        grow the buffer into other (allocated) memory.  When needed,
        malloc() new memory, copy the old string to the new memory,
        and clear this bit -- but *don't* free the old memory.  Note
        that STRBUF_INIT, when buf is initialized to point at
        strbuf_slopbuf, would use this flag setting.  This flag
        combination could be used to wrap a stack-allocated buffer
        without preventing the string from growing beyond the
        size of the buffer:

        void f()
        {
            char path_buf[PATH_MAX];
            struct strbuf path;

            strbuf_wrap_preallocated(&path, path_buf, 0, sizeof(path));
            ...
            strbuf_release(&path);
        }

        (Probably the boilerplate could be reduced by using macros.)

    flags == STRBUF_OWNS_MEMORY | ~STRBUF_FIXED_MEMORY

        This gives the current behavior of a non-empty strbuf.

    flags == ~STRBUF_OWNS_MEMORY | STRBUF_FIXED_MEMORY

        This would make it possible to use a strbuf to wrap a
        fixed-size buffer that belongs to somebody else and must not
        be moved.  For example,

        void f(char *path_buf, size_t path_buf_len)
        {
            struct strbuf path;

            strbuf_wrap_fixed(&path, path_buf,
                              strlen(path_buf), path_buf_len);
            ...
            /*
             * no strbuf_release() required here, but if called it
             * is a NOOP
             */
        }

        (Probably the boilerplate could be reduced by using macros.)

        It would also be possible to use this mode to dynamically
        allocate a strbuf along with space for its string (i.e., to
        make do with one allocation instead of two):

            struct strbuf sb = xmalloc(sizeof(strbuf) + len + 1);
            sb.alloc = len + 1;
            sb.len = len;
            sb.flags = STRBUF_FIXED_MEMORY;
            sb.buf = (void *)sb + sizeof(strbuf);
            *sb.buf = '\0';

        If this is considered useful, it should of course be offered
        via a function.

    flags == STRBUF_OWNS_MEMORY | STRBUF_FIXED_MEMORY

        This combination seems less useful, but I leave it here for
        completeness.  It is basically a strbuf whose length is
        constrained to its currently-allocated size.

The nice thing is that I believe this new functionality could be
implemented without slowing down the most-used strbuf functions.  For
example, none of the inline functions would have to be changed.  The
flags would only have to be checked when doing memory-related operations
like strbuf_grow(), strbuf_detach(), etc.


Anyway, I just wanted to get the idea out there.  I'd like to get
feedback about whether people think this is a good idea.  If so, maybe
I'll add it to the wiki as a suggested project.

I've wanted to work on this myself, but realistically I'm not going to
have time in the near future.  It might be a good Ensimag project or a
future GSoC project (though it might be a bit "janitorial" to excite
students).  Improving the strbuf API in this way shouldn't be too
difficult, and it can be followed up by an almost limitless number of
fixes throughout the Git codebase to use the new functionality.

Of course if somebody is looking for a relatively straightforward
project, I think this would be a nice improvement: it makes strbufs
easier and cheaper to use and thereby reduces the temptation to do
manual memory management, which is all too prone to creating security
holes via buffer overflows.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
