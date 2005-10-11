From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Tue, 11 Oct 2005 21:48:08 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.11.19.48.04.675482@smurf.noris.de>
References: <20051010105008.GB30202@gentoo.org> <7vzmph42j2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Oct 11 21:55:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPQBW-0000Mk-CP
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 21:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVJKTxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 15:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbVJKTxJ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 15:53:09 -0400
Received: from main.gmane.org ([80.91.229.2]:25230 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750962AbVJKTxH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 15:53:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EPQ8m-0007tu-Ne
	for git@vger.kernel.org; Tue, 11 Oct 2005 21:50:24 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Oct 2005 21:50:24 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Oct 2005 21:50:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9981>

Hi, Junio C Hamano wrote:

> One thing to keep in mind is how badly this C part might
> interact with the libification effort going on underwater.

Not too badly.

> Since current code Smurf is working on is based on 0.99.6 and

I've merged it up once already; will do that again soon.

> many small pieces need to be reviewed anyway, I am not so much
> worried about forward porting the changes.  

I've also mostly succeeded in keeping the individual patches clean so that
everything still builds (and verifies), so it might be easiest to just
merge with it. ;-)

But we'll cross that bridge when we get to it.

>                             But some die()s that
> are in the parts that will be moved to the common library code
> would also want to use this prog global somehow.

IMHO, common library code should not be allowed to die.
(Yes, that does imply replacing all the xmalloc() calls.)

My library effort has a buffer for the (first) error message. The
caller can elect to suppress printing it, so that it can be formatted
appropriately. Python, for instance, will wrap errors in an exception.

The way I structured it so far, a C program would do 

	git_env = git_env_new();
	die_if_null(git_env());
	git_env->print_error = 0;
[...]
	git_whatever(git_env, ...);
	if (git_env->error) {
		fprintf(stderr, "%s: doing whatever: %s\n",
			my_program_name, git_env->error);
		git_env_clear_error(git_env);
		goto whatever_bad_so_go_clean_up;
	}

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
A hundred mouths, a hundred tongues, And throats of brass, inspired with
iron lungs.
					-- Virgil
