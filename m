From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 10:31:11 +0100
Organization: eudaptics software gmbh
Message-ID: <45DD62DF.9324130F@eudaptics.com>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 10:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKAOf-00040l-Pe
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 10:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbXBVJhv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 04:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbXBVJhv
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 04:37:51 -0500
Received: from main.gmane.org ([80.91.229.2]:35703 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbXBVJhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 04:37:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HKAJr-0003zv-2i
	for git@vger.kernel.org; Thu, 22 Feb 2007 10:32:55 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Feb 2007 10:32:54 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Feb 2007 10:32:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40342>

Johannes Schindelin wrote:
> +/* if in && *in >= 0, take that as input file descriptor instead */
> +static int fork_with_pipe(const char **argv, int *in, int *out)
> +{
> +       int needs_in, needs_out;
> +       int fdin[2], fdout[2], pid;
> +
> +       needs_in = in && *in < 0;
> +       if (needs_in) {
> +               if (pipe(fdin) < 0)
> +                       return error("could not setup pipe");
> +               *in = fdin[1];
> +       }
> +
> +       needs_out = out && *out < 0;
> +       if (needs_out) {
> +               if (pipe(fdout) < 0)
> +                       return error("could not setup pipe");
> +               *out = fdout[0];
> +       }
> +
> +       if ((pid = fork()) < 0) {
> +               if (needs_in) {
> +                       close(fdin[0]);
> +                       close(fdin[1]);
> +               }
> +               if (needs_out) {
> +                       close(fdout[0]);
> +                       close(fdout[1]);
> +               }
> +               return error("could not fork");
> +       }
> +       if (!pid) {
> +               if (needs_in) {
> +                       dup2(fdin[0], 0);
> +                       close(fdin[0]);
> +                       close(fdin[1]);
> +               } else if (in)
> +                       dup2(*in, 0);
> +               if (needs_out) {
> +                       dup2(fdout[1], 1);
> +                       close(fdout[0]);
> +                       close(fdout[1]);
> +               } else if (out)
> +                       dup2(*out, 1);
> +               exit(execv_git_cmd(argv));
> +       }
> +       if (needs_in)
> +               close(fdin[0]);
> +       if (needs_out)
> +               close(fdout[1]);
> +       return pid;
> +}

This function looks very similar to spawnvppe, which I use in the MinGW
port for a number of fork/exec pairs. Do you see a chance to make this
into a helper that can be used in more places (so that it reduces the
differences to the MinGW code)?

> +       in = out = -1;
> +       pid = fork_with_pipe(argv, &in, &out);
> +       if (pid < 0)
> +               return error("Could not fork rev-list");
> +       if (!fork()) {
> +               for (i = 0; i < p->nr; i++) {
> +                       write(in, sha1_to_hex(p->list[i].sha1), 40);
> +                       write(in, "\n", 1);
> +               }
> +               close(in);
> +               exit(0);
> +       }
> +       close(in);

Oops, fork error check missing?

-- Hannes
