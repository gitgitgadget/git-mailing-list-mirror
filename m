From: David Reiss <dreiss@facebook.com>
Subject: Re: [PATCH 1/4] Implement normalize_absolute_path
Date: Wed, 21 May 2008 01:34:17 -0700
Message-ID: <4833DE89.4000106@facebook.com>
References: <48327456.1060202@facebook.com> <20080520222447.GA13123@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 10:35:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyjn1-0006G2-G8
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 10:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761755AbYEUIeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 04:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761470AbYEUIeX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 04:34:23 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:17257 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759761AbYEUIeU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 04:34:20 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4L8YIgK010550;
	Wed, 21 May 2008 01:34:18 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 May 2008 01:31:11 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080520222447.GA13123@steel.home>
X-OriginalArrivalTime: 21 May 2008 08:31:11.0846 (UTC) FILETIME=[068DC860:01C8BB1D]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-21_03:2008-05-20,2008-05-21,2008-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805210021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82537>

This is close enough to what I want that I could definitely use it if it
were in the main tree.  I read through most of that thread, but I
couldn't figure out what ever happened to your patch.  (I couldn't find
a clear rejection, but I also don't see it in master.)

--David

Alex Riesen wrote:
> David Reiss, Tue, May 20, 2008 08:48:54 +0200:
>> normalize_absolute_path removes several oddities form absolute paths,
>> giving nice clean paths like "/dir/sub1/sub2".  Also add a test case
>> for this utility, based on a new test program (in the style of test-sha1).
> 
> Heh...
> http://thread.gmane.org/gmane.comp.version-control.git/68786/focus=68812
> 
> The test of the function has these cases:
> 
> static void check(const char *cwd, const char *path, const char *good);
> 
> int main(int argc, char **argv)
> {
>         /* 1 */ check("/onelevel", "aa", "onelevel/aa");
>         /* 2 */ check("/", "..", "");
>         /* 3 */ check("/", "../..", "");
>         /* 4 */ check("/one", "aa/../bb", "one/bb");
>         /* 5 */ check("/one/two", "aa//bb", "one/two/aa/bb");
>         /* 6 */ check("", "/aa//bb", "aa/bb");
>         /* 7 */ check("/one/two", "", "one/two");
>         /* 8 */ check("/one/two", "aa/..bb/x/../cc/", "one/two/aa/..bb/cc");
>         /* 9 */ check("/one/two", "aa/x/././cc////", "one/two/aa/x/cc");
>         /* 10 */ check("/one/two", "../../../../aa", "aa");
>         /* 11 */ check("one/", "../one/two", "one/two");
>         /* 12 */ check("", "../../two", "two");
>         /* 13 */ check("a/b/c", "../../two", "a/two");
>         /* 14 */ check("a/b/", "../two", "a/two");
>         /* 15 */ check("///", "../two", "two");
>         return 0;
> }
> 
> static void check(const char *cwd, const char *path, const char *good)
> {
>         static int n = 0;
>         printf("%-2d: %10s$ cd %s", ++n, cwd, path);
>         char *t = pathexpand(cwd, path);
>         if ( strcmp(t, good) )
>                 printf(" ____________________failed(%s)\n", t);
>         else
>                 printf(" \033[32m%s\033[0m\n", t);
>         free(t);
> }
> 
> 
