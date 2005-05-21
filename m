From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 00:08:36 -0400
Message-ID: <428EB444.7010200@pobox.com>
References: <4870.10.10.10.24.1116646732.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 06:07:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZLHC-0006t2-59
	for gcvg-git@gmane.org; Sat, 21 May 2005 06:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVEUEIu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 00:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVEUEIu
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 00:08:50 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41659 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261654AbVEUEIo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 00:08:44 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DZLI0-0000ZY-5M; Sat, 21 May 2005 04:08:42 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <4870.10.10.10.24.1116646732.squirrel@linux1>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sean wrote:
> Here is a first crack at using argp as suggested by Jeff Garzik to
> implement argument processing as requested by Junio and Linus.  Each of
> the long arguments have been given a single character equivalent as well.
> 
> This patch only converts fsck-cache to use argp in case anyone has
> objections to the basic format or style.  The patch includes a version
> number inside of fsck-cache.c; this should really be in a separate include
> file so you can run any command with --version and get the same answer.

Pretty good.  You'll probably want some additional changes:


1) eliminate
+       case ARGP_KEY_ARG:      state->next = state->argc; break;

This will cause option processing to stop at the first unknown argument.


2) Pass-by-reference a variable to argp_parse(), which will store the 
index of the argument where processing stopped.  This is the first 
hash/file/etc. non-option argument.

(example code from posixutils)

int parse_cmdline(struct cmdline_walker *cw)
{
       error_t rc_argp;
       int idx = 0;

       rc_argp = argp_parse(cw->argp, cw->argc, cw->argv, 0, &idx, NULL);
       if (rc_argp) {
               fprintf(stderr, "argp_parse: %s\n", strerror(rc_argp));
               return -rc_argp;
       }

       return idx;
}

'idx' in this case is the first non-option argument, which can be passed 
directly to argv[].  From there, you perform standard iteration over the 
arguments provided on the command line, starting at argv[idx].

If you have a fixed number of arguments following the options, then your 
parse_opt function can easily parse those args as well:

static error_t parse_opt (int key, char *arg, struct argp_state *state)
{
         switch (key) {
         case '1':
                 outmask |= OPT_FILE1;
                 break;
         case '2':
                 outmask |= OPT_FILE2;
                 break;
         case '3':
                 outmask |= OPT_DUP;
                 break;

         case ARGP_KEY_ARG:
           switch(state->arg_num) {
           case 0:         file1 = arg; break; /* 1st non-opt arg */
           case 1:         file2 = arg; break; /* 2nd non-opt arg */
           default:        argp_usage (state); break; /* too many args */
           }
           break;

         case ARGP_KEY_END:
                 if (state->arg_num < 2)         /* not enough args */
                         argp_usage (state);
                 break;

         default:
                 return ARGP_ERR_UNKNOWN;
         }

         return 0;
}

