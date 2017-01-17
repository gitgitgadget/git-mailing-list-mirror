Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785F320756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbdAQXdB (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:33:01 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:28502 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbdAQXdA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:33:00 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id TdFEck0ex0KuvTdFFcP78G; Tue, 17 Jan 2017 23:32:53 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8
 a=-ipq2ZteA2u6wfjHzJUA:9 a=wPNLvfGTeEIA:10 a=Bn2pgwyD2vrAyMmN8A2t:22
Message-ID: <826895153F394EB29B0D27F3EB9A67C9@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Git List" <git@vger.kernel.org>,
        "Pat Thoyts" <patthoyts@users.sourceforge.net>
References: <F9099DB3F0374D898776BD2621BF36FA@PhilipOakley> <alpine.DEB.2.20.1701171218260.3469@virtualbox>
Subject: Re: [RFH - Tcl/Tk] use of procedure before declaration?
Date:   Tue, 17 Jan 2017 23:32:54 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfIKvGGFlXh5nSXS6yO+hXwQ0F24COJa1eN5795McBrOwBCP+bNP/SPYfkkjXSqyT6qTqqBcfUaB6qw8Z5ykdytvTBJv9pDJxie3PnpOdYJL9RU9ZfOUF
 E9mLVvPO6uqLcr+PFahqLBG2PL/tpYQUxFy1LIfTu5r56LO46jAhhgrfp1xWLJXRUqhq06HZLeTGlzMzJPFRyOmpuTncskKksBgcEoIZOcashPBJAO1wI2iJ
 8LDiwAIRpQqlEseB8dHH1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Philip,
>
> On Mon, 16 Jan 2017, Philip Oakley wrote:
>
>> In
>> https://github.com/git/git/blob/master/git-gui/lib/choose_repository.tcl#L242
>> the procedure `_unset_recentrepo` is called, however the procedure isn't
>> declared until line 248. My reading of the various Tcl tutorials suggest
>> (but not explictly) that this isn't the right way.
>
> Indeed, calling a procedure before it is declared sounds incorrect.
>
> Since documentation can be treacherous, let's just test it. With a `tclsh`
> whose `$tcl_version` variable claims that this is version 8.6, this
> script:
>
> ```tcl
> hello Philip
>
> proc hello {arg} {
>        puts "Hi, $arg"
> }
> ```
>
> ... yields the error message:
>
> invalid command name "hello"
>     while executing
> "hello Philip"
>
> ... while this script:
>
> ```tcl
> proc hello {arg} {
>        puts "Hi, $arg"
> }
>
> hello Philip
> ```
>
> ... prints the expected "Hi, Philip".
>
> Having said that, in the code to which you linked, the procedure is not
> actually called before it is declared, as the call is inside another
> procedure.
>
> Indeed, the entire file declares one object-oriented class, so no code
> gets executed in that file:
>
> https://github.com/git/git/blob/d7dffce1c/git-gui/lib/choose_repository.tcl#L4
>
> (I guess proper indentation would make it easier to understand that this
> file is defining a class, not executing anything yet).
>
> And it is perfectly legitimate to use not-yet-declared procedures in other
> procedures, otherwise recursion would not work.
>
>> Should 3c6a287 ("git-gui: Keep repo_config(gui.recentrepos) and 
>> .gitconfig
>> in sync", 2010-01-23) have declared `proc _unset_recentrepo {p}` before
>> `proc _get_recentrepos {}` ?
>
> Given the findings above, I believe that the patch is actually correct.
>
> Ciao,
> Dscho
>
Thanks for the clarification. I'll update the old patch series and see if we 
can get this fixed.

Philip 

