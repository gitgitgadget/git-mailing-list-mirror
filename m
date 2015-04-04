From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: git clean performance issues
Date: Sat, 4 Apr 2015 20:32:45 +0200
Message-ID: <CAMpP7NY++BwV+UygRj1C6Zsf=jE-z1AQuN3On0HeEqQpKGQtqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 20:32:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeSsI-00042L-Py
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 20:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbbDDScq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 14:32:46 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34867 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbbDDScp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 14:32:45 -0400
Received: by obbfy7 with SMTP id fy7so121008270obb.2
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tTSD0NQ0PwaKoLOLq/RmIJBCQKtnbBsAvg4J5iy4GWk=;
        b=YX9LXbsOKWG5MqU9PwBZN+zht3JPXdyA9TFkdyZjqOsghaX877nKqd3neyFO/07nct
         i7z4/OVv71oNHdlAXQXdV6TOPt/aet8fEozknwgK9k0ZfunVFcvm2ISG81BP48+PQQrQ
         bcdvH/5FHq9fzRGjKTnuc3wvUh8sl0rTfR5PAb9UYj9MIhnN6IQi8wNZRtJBESWq/vdW
         lpISMI/pywwEbHzL1DYXADoy9fTBKN9XM+AXWtITcXG8ngQC63fHqWVffBdNRyDCwFII
         6wB41w+6P1I2ZXiott7lQb9OdqcsEd4qtT0aHx4RWwzVLLE3vDmTef+oIzOp44ETuXE6
         p4xg==
X-Received: by 10.182.105.66 with SMTP id gk2mr9556619obb.76.1428172365075;
 Sat, 04 Apr 2015 11:32:45 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Sat, 4 Apr 2015 11:32:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266777>

Hi,

I'm having a performance issue with "git clean -qxfd" (note, not using
"-ff").

The performance issue shows up when trying to clean untracked
directories that themselves contain many sub directories. The
performance is highly non linear with the number of sub
directories. Some test numbers:

Dirs    Time
10000   0m0.754s
50000   0m16.606s
100000  1m31.418s

When running "git clean -qxffd" (note, using "-ff") the performance is
fast and linear:

Dirs    Time
10000   0m0.158s
50000   0m0.918s
100000  0m1.639s

After checking the source of git-clean my understanding of the problem
is as follows:

When clean.c:cmd_clean finds a directory and the "-d" flag is given it
will call clean.c:remove_dirs to potentially remove the directory and
all sub directories.

Unless "-ff" is given remove_dirs tries to be nice and not remove
directories containing other git repositories. To do this it does the
following check:

    ...
    if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
            !resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
    ...

The problem is that refs.c:resolve_gitlink_ref will call
refs.c:get_ref_cache that will linearly search a linked list of cache
entries and create and insert a new ref_cache entry in the list for
each path it is given if it fails to find an existing entry:

    for (refs = submodule_ref_caches; refs; refs = refs->next)
        if (!strcmp(submodule, refs->name))
            return refs;

    refs = create_ref_cache(submodule);
    refs->next = submodule_ref_caches;
    submodule_ref_caches = refs;
    return refs;

In my scenario get_ref_cache will be called 10000+ times, each time
with a new path. The final few calls will need to search through and
compare 10000+ entries before realizing that there is no existing
entry. This quickly ads up to 100 million+ calls to strcmp().

>From what I can understand, the calls to get_ref_cache in this
scenario will never do any useful work. Is this correct? If so, would
it be possible to bypass it, maybe by calling
resolve_gitlink_ref_recursive directly or by using some other way of
checking for the presence of a git repo in clean.c:remove_dirs?

/Erik
