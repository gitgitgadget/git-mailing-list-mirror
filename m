Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A048320A17
	for <e@80x24.org>; Wed, 18 Jan 2017 06:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdARG6K (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 01:58:10 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:36075 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbdARG6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 01:58:09 -0500
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id v0I6h6IO023815;
        Wed, 18 Jan 2017 09:43:07 +0300
Date:   Wed, 18 Jan 2017 09:43:06 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [RFH - Tcl/Tk] use of procedure before declaration?
Message-Id: <20170118094306.a17083eecd94c0f39b760081@domain007.com>
In-Reply-To: <alpine.DEB.2.20.1701171218260.3469@virtualbox>
References: <F9099DB3F0374D898776BD2621BF36FA@PhilipOakley>
        <alpine.DEB.2.20.1701171218260.3469@virtualbox>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Jan 2017 12:29:23 +0100 (CET)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> > In
> > https://github.com/git/git/blob/master/git-gui/lib/choose_repository.tcl#L242
> > the procedure `_unset_recentrepo` is called, however the procedure
> > isn't declared until line 248. My reading of the various Tcl
> > tutorials suggest (but not explictly) that this isn't the right way.
> 
> Indeed, calling a procedure before it is declared sounds incorrect.
[...]
> And it is perfectly legitimate to use not-yet-declared procedures in
> other procedures, otherwise recursion would not work.
[...]

Sorry for chiming in too late, but I'd throw a bit of theory in.

Since Tcl is an interpreter (though it automatically compiles certain
stuff to bytecode as it goes through the script, and caches this
representation), everything is interpreted in the normal script order --
top to bottom as we usually see it in a text editor.

That is, there are simply no declaration vs definition: the main script
passed to tclsh / wish is read and interpreted from top to bottom;
as soon as it calls the [source] command, the specified script is read
and interpreted from top to bottom etc; after that the control is back
to the original script and its interpretation continues.

Hence when Tcl sees a command (everything it executes is a command; this
includes stuff like [proc], [foreach] and others, which are syntax in
other languages) it looks up this command in the current list of
commands it knows and this either succeeds or fails.  The built-in
command [proc] defines a new Tcl procedure with the given name, and
registers it in that list of known commands.

So the general rule for user-defined procedures is relatively
straightforward: to call a procedure, the interpreter should have read
and executed its definition before the attempted call.
