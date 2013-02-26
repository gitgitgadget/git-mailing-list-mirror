From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Tue, 26 Feb 2013 12:13:05 -0800
Message-ID: <20130226201305.GA3502@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:13:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQu9-0001Gr-5T
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015Ab3BZUNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:13:09 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:43043 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab3BZUNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 15:13:08 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1UAQtd-0000wi-Kw; Tue, 26 Feb 2013 12:13:05 -0800
Mail-Followup-To: Matt Kraai <kraai@ftbfs.org>,
	Mike Gorchak <mike.gorchak.qnx@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217174>

Hi,

Please include me in the Cc field, since I'm not subscribed to the
list.

Mike Gorchak wrote:
> Do you have a testcase for this (without using git codebase)? I wrote
> numerous resource managers since QNX 6.0 using threads and fork()s for
> daemonization in different order and never experienced a problems.
> There can be issues with pipes in case of external command run.

I just created the following one:


#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <process.h>

static void *
start_routine (void *arg)
{
  return NULL;
}

int
main (int argc, char **argv)
{
  int err;

  if ((err = pthread_create (NULL, NULL, start_routine, NULL)))
    {
      fprintf (stderr, "foo: pthread_create failed: %s\n", strerror (errno));
      return 1;
    }

  if (fork () == -1)
    {
      fprintf (stderr, "foo: fork failed: %s\n", strerror (errno));
      return 1;
    }

  return 0;
}


When I compile and run it on either QNX 6.3.2 or QNX 6.5.0, it
produces the following output:

 foo: fork failed: Function not implemented

If I remove the call to pthread_create, it doesn't output anything and
exits successfully.
