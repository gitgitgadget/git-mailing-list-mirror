From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: read()  MAX_IO_SIZE bytes, more than SSIZE_MAX?
Date: Sat, 07 Feb 2015 18:19:53 +0100
Message-ID: <54D64939.4080102@web.de>
References: <loom.20150207T174514-727@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Joachim Schmitz <jojo@schmitz-digital.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 18:20:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YK93D-0005Ac-IV
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 18:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbbBGRUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 12:20:05 -0500
Received: from mout.web.de ([212.227.17.12]:52319 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757595AbbBGRUE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 12:20:04 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Lw0q9-1XZEqK3Xhd-017pmr; Sat, 07 Feb 2015 18:20:02
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <loom.20150207T174514-727@post.gmane.org>
X-Provags-ID: V03:K0:5X6KZ6ztwWS+1PqPbyLCMK+oQVCt47C70ReiekfaCt+o/eOaMmO
 h/gh66AFa3Fk8i1eP9tKZvjO0UmKeB8E2Up2LOty1i226o1Q1k6c7hgc8hJ511pLDQgyAAa
 QHMCaqPf7r7fM8fKv8SW9k644Z/9sP2dKqSL3e0whuEZ13koiZmfwwnpPPOSKUKtuoIXJd+
 i0RqZEeZcoy59ygObPGTg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263446>

On 2015-02-07 17.45, Joachim Schmitz wrote:
> Hi there
> 
> While investigating the problem with hung git-upload-pack we think to have 
> found a bug in wrapper.c:
> 
> #define MAX_IO_SIZE (8*1024*1024)
> 
> This is then used in xread() to split read()s into suitable chunks.
> So far so good, but read() is only guaranteed to read as much as SSIZE_MAX 
> bytes at a time. And on our platform that is way lower than those 8MB (only 
> 52kB, POSIX allows it to be as small as 32k), and as a (rather strange) 
> consequence mmap() (from compat/mmap.c) fails with EACCESS (why EACCESS?), 
> because xpread() returns something > 0.
> 
> How large is SSIZE_MAX on other platforms? What happens there if you try to 
> read() more? Should't we rather use SSIZE_MAX on all platforms? If I'm 
> reading the header files right, on Linux it is LONG_MAX (2TB?), so I guess 
> we should really go for MIN(8*1024*1024,SSIZE_MAX)?

How about changing wrapper.c like this:

#ifndef MAX_IO_SIZE
 #define MAX_IO_SIZE (8*1024*1024)
#endif
---------------------
and to change config.mak.uname like this:

ifeq ($(uname_S),NONSTOP_KERNEL)

	BASIC_CFLAGS += -DMAX_IO_SIZE=(32*1024)
Does this work for you ?
