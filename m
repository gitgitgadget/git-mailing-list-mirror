From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/4] Implement normalize_absolute_path
Date: Wed, 21 May 2008 00:24:47 +0200
Message-ID: <20080520222447.GA13123@steel.home>
References: <48327456.1060202@facebook.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Wed May 21 00:25:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyaH8-00076m-Sz
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 00:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762619AbYETWYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 18:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759768AbYETWYu
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 18:24:50 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:35096 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178AbYETWYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 18:24:50 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarKZB1HUNA==
Received: from tigra.home (Faa97.f.strato-dslnet.de [195.4.170.151])
	by post.webmailer.de (mrclete mo1) (RZmta 16.37)
	with ESMTP id e05e47k4KIlwJ3 ; Wed, 21 May 2008 00:24:48 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E5DEA277BD;
	Wed, 21 May 2008 00:24:47 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0C7B456D28; Wed, 21 May 2008 00:24:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48327456.1060202@facebook.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82512>

David Reiss, Tue, May 20, 2008 08:48:54 +0200:
> normalize_absolute_path removes several oddities form absolute paths,
> giving nice clean paths like "/dir/sub1/sub2".  Also add a test case
> for this utility, based on a new test program (in the style of test-sha1).

Heh...
http://thread.gmane.org/gmane.comp.version-control.git/68786/focus=68812

The test of the function has these cases:

static void check(const char *cwd, const char *path, const char *good);

int main(int argc, char **argv)
{
	/* 1 */ check("/onelevel", "aa", "onelevel/aa");
	/* 2 */ check("/", "..", "");
	/* 3 */ check("/", "../..", "");
	/* 4 */ check("/one", "aa/../bb", "one/bb");
	/* 5 */ check("/one/two", "aa//bb", "one/two/aa/bb");
	/* 6 */ check("", "/aa//bb", "aa/bb");
	/* 7 */ check("/one/two", "", "one/two");
	/* 8 */ check("/one/two", "aa/..bb/x/../cc/", "one/two/aa/..bb/cc");
	/* 9 */ check("/one/two", "aa/x/././cc////", "one/two/aa/x/cc");
	/* 10 */ check("/one/two", "../../../../aa", "aa");
	/* 11 */ check("one/", "../one/two", "one/two");
	/* 12 */ check("", "../../two", "two");
	/* 13 */ check("a/b/c", "../../two", "a/two");
	/* 14 */ check("a/b/", "../two", "a/two");
	/* 15 */ check("///", "../two", "two");
	return 0;
}

static void check(const char *cwd, const char *path, const char *good)
{
	static int n = 0;
	printf("%-2d: %10s$ cd %s", ++n, cwd, path);
	char *t = pathexpand(cwd, path);
	if ( strcmp(t, good) )
		printf(" ____________________failed(%s)\n", t);
	else
		printf(" \033[32m%s\033[0m\n", t);
	free(t);
}
