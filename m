From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 23:59:44 +0200
Message-ID: <7ism18exin.fsf@lanthane.pps.jussieu.fr>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com> <42730061.5010106@zytor.com>
 <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
 <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
 <87zmvganq9.fsf@windlord.stanford.edu>
 <1114848175.24014.35.camel@localhost.localdomain>
 <20050430124048.79119cac.froese@gmx.de>
 <87r7gs87a9.fsf@windlord.stanford.edu>
 <Pine.LNX.4.58.0504301322130.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 30 23:54:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRzuk-0003D0-3v
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 23:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVD3V75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 17:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVD3V75
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 17:59:57 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:63226 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S261440AbVD3V7v (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 17:59:51 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3ULxbP1052047
          for <git@vger.kernel.org>; Sat, 30 Apr 2005 23:59:39 +0200 (CEST)
X-Ids: 168
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j3ULxipf005819
          for <git@vger.kernel.org>; Sat, 30 Apr 2005 23:59:46 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DS000-0004vR-Pq
	for git@vger.kernel.org; Sat, 30 Apr 2005 23:59:44 +0200
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0504301322130.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 30 Apr 2005 13:32:35 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.168]); Sat, 30 Apr 2005 23:59:39 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 4273FFC9.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Here's the code I'm using in darcs-git (copied from Polipo, another
project of mine).  You're welcome to use it in any way you see fit.

sprintf_a is defined as strdup of sprintf.

                                        Juliusz
#if defined __GLIBC__
#define HAVE_TM_GMTOFF
#define HAVE_SETENV
#ifndef __UCLIBC__
#define HAVE_TIMEGM
#endif
#endif

#if defined(__linux__) && (__GNU_LIBRARY__ == 1)
/* Linux libc 5 */
#define HAVE_TIMEGM
#define HAVE_SETENV
#endif

#ifdef BSD
#define HAVE_TM_GMTOFF
#define HAVE_SETENV
#endif

#ifdef __CYGWIN__
#define HAVE_SETENV
#endif

#if _POSIX_VERSION >= 200112L
#define HAVE_SETENV
#endif

#define HAVE_TZSET

/* Like mktime(3), but UTC rather than local time */
#if defined(HAVE_TIMEGM)
time_t
mktime_gmt(struct tm *tm)
{
    return timegm(tm);
}
#elif defined(HAVE_TM_GMTOFF)
time_t
mktime_gmt(struct tm *tm)
{
    time_t t;
    struct tm *ltm;

    t = mktime(tm);
    if(t < 0)
        return -1;
    ltm = localtime(&t);
    if(ltm == NULL)
        return -1;
    return t + ltm->tm_gmtoff;
}
#elif defined(HAVE_TZSET)
#ifdef HAVE_SETENV
/* Taken from the Linux timegm(3) man page. */
time_t
mktime_gmt(struct tm *tm)
{
    time_t t;
    char *tz;

    tz = getenv("TZ");
    setenv("TZ", "", 1);
    tzset();
    t = mktime(tm);
    if(tz)
        setenv("TZ", tz, 1);
    else
        unsetenv("TZ");
    tzset();
    return t;
}
#else
time_t
mktime_gmt(struct tm *tm)
{
    time_t t;
    char *tz;
    static char *old_tz = NULL;

    tz = getenv("TZ");
    putenv("TZ=");
    tzset();
    t = mktime(tm);
    if(old_tz)
        free(old_tz);
    if(tz)
        old_tz = sprintf_a("TZ=%s", tz);
    else
        old_tz = strdup("TZ");  /* XXX - non-portable? */
    if(old_tz)
        putenv(old_tz);
    tzset();
    return t;
}
#endif
#else
#error no mktime_gmt implementation on this platform
#endif
