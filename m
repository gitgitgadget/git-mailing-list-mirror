Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9283220986
	for <e@80x24.org>; Fri, 21 Oct 2016 11:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbcJULHz (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 07:07:55 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:35539 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932247AbcJULHy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Oct 2016 07:07:54 -0400
Received: from dimstar.local.net (c110-22-56-26.eburwd6.vic.optusnet.com.au [110.22.56.26])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTP id 8C7F33C593B
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 22:07:38 +1100 (AEDT)
Received: (qmail 3564 invoked by uid 501); 21 Oct 2016 11:07:28 -0000
Date:   Fri, 21 Oct 2016 22:07:28 +1100
From:   Duncan Roe <duncan_roe@acslink.net.au>
To:     git <git@vger.kernel.org>
Subject: Re: [BUG] [PATCH]: run-command.c
Message-ID: <20161021110728.GB31554@dimstar.local.net>
Mail-Followup-To: git <git@vger.kernel.org>
References: <20161021055013.GA31554@dimstar.local.net>
 <20161021090029.glr5u6gwrxluavir@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161021090029.glr5u6gwrxluavir@sigill.intra.peff.net>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.1 cv=RIxOZNW+ c=1 sm=1 tr=0
        a=/xIuaNGu1NPzt0yKkvdCVQ==:117 a=/xIuaNGu1NPzt0yKkvdCVQ==:17
        a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
        a=CH0kA5CcgfcA:10 a=XPUPcRBtb2EO3jOn9e4A:9 a=CjuIK1q_8ugA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 05:00:29AM -0400, Jeff King wrote:
> On Fri, Oct 21, 2016 at 04:50:13PM +1100, Duncan Roe wrote:
>
> > For example, if .git/config has this alias (the sleep is to leave time to
> > examine output from ps, &c.):
> >
> > [alias]
> > 	tryme = "!echo $PWD;sleep 600"
> >
> > [...]
> > 16:42:06$ ps axf|grep -A2 trym[e]
> >  2599 pts/4    S+     0:00      \_ git tryme
> >  2601 pts/4    S+     0:00          \_ /bin/sh -c echo $PWD;sleep 600 echo $PWD;sleep 600
> >  2602 pts/4    S+     0:00              \_ sleep 600
> > 16:42:45$ cat /proc/2601/cmdline | xargs -0 -n1 echo
> > /bin/sh
> > -c
> > echo $PWD;sleep 600
> > echo $PWD;sleep 600
>
> This duplicated argument is expected and normal. The arguments after "-c
> whatever" become positional parameters $0, $1, etc. The actual script
> arguments start at "$1", and "$0" is typically the "script name".
> So you have to stick some placeholder value in the "$0" slot, so that
> the sub-script can find the actual arguments. E.g., try:
>
>   sh -c '
>     for i in "$@"; do
>       echo "got $i"
>     done
>   ' one two three
>
> it will print only:
>
>   got two
>   got three
>
> But if you stick a placeholder there, it works:
>
>   sh -c '
>     for i in "$@"; do
>       echo "got $i"
>     done
>   ' placeholder one two three
>
> The value of the placeholder does not matter to the shell. But it is
> accessible to the script inside via $0:
>
>   sh -c '
>     echo "\$0 = $0"
>     echo "\$1 = $1"
>     echo "\$2 = $2"
>     echo "\$3 = $3"
>   ' placeholder one two three
>
> Since our script does not have a filename, we just stick the script
> contents there (which is really just a convention, and one I doubt
> anybody is really relying on, but there's no point in breaking it now).
>
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -182,8 +182,8 @@ static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
> >  		else
> >  			argv_array_pushf(out, "%s \"$@\"", argv[0]);
> >  	}
> > -
> > -	argv_array_pushv(out, argv);
> > +	else
> > +		argv_array_pushv(out, argv);
> >  	return out->argv;
> >  }
>
> Try running "make test" with this. Lots of things break, because we are
> not sending the positional parameters to the shell script at all.
>
> If we just cared about the positional parmeters, we _could_ do something
> like:
>
>   if (argv[0]) {
> 	argv_array_push(out, "sh");
> 	argv_array_pushv(out, argv + 1);
>   }
>
> That would omit "$0" entirely when we have no positional parameters (and
> the shell generally fills in "sh" there itself), and provide a dummy
> "sh" value when we need to use it as a placeholder.
>
> But again, there's no real value in breaking the existing convention.
>
> -Peff
Agreed - tests 110 and 111 in t1300-repo-config.sh fail. After that, "make test"
gives up, losing about 14000 lines of output.

Sorry for the noise,

Cheers ... Duncan.
