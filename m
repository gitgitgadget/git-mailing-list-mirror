From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH next v2] log_ref_setup: don't return stack-allocated array
Date: Thu, 10 Jun 2010 19:29:10 +0200
Message-ID: <201006101929.11034.trast@student.ethz.ch>
References: <e888313d5a782585f4a5e7ee8914302953c187e2.1276173576.git.trast@student.ethz.ch> <47daf53b6b2cc25cc013c5f2183e309a671dc9d3.1276174233.git.trast@student.ethz.ch> <AANLkTillDOCNQrpaEiFsFdq6HpU_LlwWI2ELIrEcrWHc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 19:29:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMlZP-0005CN-73
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 19:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759057Ab0FJR3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 13:29:30 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:51393 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758889Ab0FJR33 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 13:29:29 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 19:29:28 +0200
Received: from thomas.localnet (84.74.100.241) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 19:29:13 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <AANLkTillDOCNQrpaEiFsFdq6HpU_LlwWI2ELIrEcrWHc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148896>

Erick Mattos wrote:
> 2010/6/10 Thomas Rast <trast@student.ethz.ch>
> > -int log_ref_setup(const char *ref_name, char **log_file)
> > +int log_ref_setup(const char *ref_name, char *logfile, int bufsize)
> >  {
> >        int logfd, oflags = O_APPEND | O_WRONLY;
> > -       char logfile[PATH_MAX];
> >
> > -       git_snpath(logfile, sizeof(logfile), "logs/%s", ref_name);
> > -       *log_file = logfile;
> > +       git_snpath(logfile, bufsize, "logs/%s", ref_name);
[...]
> I don't see any improvement here.  Unless you want to get rid of using
> references on calling functions which is only going to add another
> buffer to the stack, sized PATH_MAX, once that log_file is going to be
> really allocated in the heap after git_snpath().  As folks use to say
> here: "changing six by half a dozen".

What the - side of the hunk above does is returning a local (stack
allocated) variable, in the form of a pointer to logfile.  Once those
go out of scope, you have zero guarantees on what happens with them.
Try the following snippet, it should cause a similar problem:

  #include <stdio.h>

  int* f()
  {
  	int i;
  	i = 42;
  	return &i;
  }

  int main()
  {
  	int *p = f();
  	if (1) {
  		char buf[1024];
  		memset(buf, 0, sizeof(buf));
  	}
  	printf("I got: %d\n", *p);
  }

Only in this case the issue is so obvious that the compiler will warn
(at least mine does).

> I haven't ever seen this happening so I think you have found some
> particularity of valgrind which could route a patch to it.

Admittedly my experience is somewhat limited since I don't do C coding
outside of git and some teaching.  But so far I have not had a single
false alarm with valgrind (when compiled without optimizations;
otherwise the compiler may do some magic).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
