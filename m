From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Improve handling of "." and ".." in git-diff-*
Date: Tue, 23 Aug 2005 21:49:07 +0200
Message-ID: <81b0412b050823124938d735bf@mail.gmail.com>
References: <Pine.LNX.4.58.0508162037080.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 21:51:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7elo-0001C0-Is
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 21:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVHWTtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 15:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVHWTtO
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 15:49:14 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:10216 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932340AbVHWTtN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 15:49:13 -0400
Received: by nproxy.gmail.com with SMTP id x37so381325nfc
        for <git@vger.kernel.org>; Tue, 23 Aug 2005 12:49:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DA0o1NMRvhkyNvQUeajEYcEK6P4jsnuuxWUG6mRErXRhJPzDtRw1cotRo4vxqxMjFzIXzKvS+9ZJaJ5Hl4hUxmbqEC2l6pgE4JYMuJYydLVijuoiq1Usnuz/cq+RJS3KbQbMSPCCF53aTcM2HPzAQ7ZY5nHokjf/QMc10qtoq3U=
Received: by 10.48.239.19 with SMTP id m19mr43599nfh;
        Tue, 23 Aug 2005 12:49:07 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Tue, 23 Aug 2005 12:49:07 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508162037080.3553@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7664>

On 8/17/05, Linus Torvalds <torvalds@osdl.org> wrote:
> NOTE! This does _not_ handle ".." or "." in the _middle_ of a pathspec. If
> you have people who do

BTW, could this (below) be useful for something?

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

// an analog of "cd path" from a directory "cwd".
char* pathexpand(const char* cwd, const char* path)
{
    static const char SEP[] = "/";
    if ( !*path ) // empty path -> "." (don't move)
	path = ".";
    if ( !*cwd || *SEP == *path ) // no cwd, or path begins with "/"
	cwd = SEP;

    int len = strlen(cwd);
    char* out = (char*)malloc(len + 1 + strlen(path) + 1);
    char* p = strcpy(out, cwd) + len;

    if ( *SEP != p[-1] )
	*p++ = *SEP;

    for ( ; *path; ++path )
    {
	char * pl = p;
	while ( *path && *SEP != *path )
	    *p++ = *path++;
	*p = '\0';

	if ( p == pl ) /* ..."//"... */
	    ; // just ignore

	/* ..."/./"...  */
	else if ( p - pl == 1 && '.' == *pl )
	    --p; // just ignore

	/* ..."/../"...  */
	else if ( p - pl == 2 && '.' == pl[0] && '.' == pl[1] )
	{
	    // drop last element of the resulting path
	    if ( --pl > out )
		for ( --pl; pl > out && *SEP != *pl; --pl );
	    p = ++pl;
	}
	/* ..."/path/"...  */
	else if ( *path )
	    *p++ = *path; // just add the separator
	if ( !*path )
	    break;
    }
    if ( p > out+1 && *SEP == p[-1] )
	--p;
    *p = '\0';
    return out;
}

#ifdef CHECK_PATHEXPAND
static void check(const char * cwd, const char * path, const char * good)
{
    static int n = 0;
    printf("%-2d: %s$ cd %s", ++n, cwd, path);
    char* t = pathexpand(cwd, path);
    if ( strcmp(t, good) )
	printf(" failed(%s)\n", t);
    else
	printf(" \t\t%s\n", t);
    free(t);
}

int main(int argc, char** argv)
{
    /* 1 */ check("/onelevel", "aa", "/onelevel/aa");
    /* 2 */ check("/", "..", "/");
    /* 3 */ check("/", "../..", "/");
    /* 4 */ check("/one", "aa/../bb", "/one/bb");
    /* 5 */ check("/one/two", "aa//bb", "/one/two/aa/bb");
    /* 6 */ check("", "/aa//bb", "/aa/bb");
    /* 7 */ check("/one/two", "", "/one/two");
    /* 8 */ check("/one/two", "aa/..bb/x/../cc/", "/one/two/aa/..bb/cc");
    /* 9 */ check("/one/two", "aa/x/././cc////", "/one/two/aa/x/cc");
    /* 10 */ check("/one/two", "../../../../aa", "/aa");

    return 0;
}
#endif
