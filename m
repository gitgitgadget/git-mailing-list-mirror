Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85CC320986
	for <e@80x24.org>; Thu,  6 Oct 2016 06:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbcJFGrd (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 02:47:33 -0400
Received: from mx6-phx2.redhat.com ([209.132.183.39]:40327 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbcJFGrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 02:47:32 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u966lTdw047413;
        Thu, 6 Oct 2016 02:47:29 -0400
Date:   Thu, 6 Oct 2016 02:47:28 -0400 (EDT)
From:   Josef Ridky <jridky@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <174484314.1957110.1475736448828.JavaMail.zimbra@redhat.com>
In-Reply-To: <xmqqponerdaw.fsf@gitster.mtv.corp.google.com>
References: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com> <1499287628.1324571.1475653631366.JavaMail.zimbra@redhat.com> <xmqqponerdaw.fsf@gitster.mtv.corp.google.com>
Subject: Re: Feature Request: user defined suffix for temp files created by
 git-mergetool
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.4.141]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF48 (Linux)/8.0.6_GA_5922)
Thread-Topic: Feature Request: user defined suffix for temp files created by git-mergetool
Thread-Index: tzHNzfxnuoN4yn2CmOfHc1WZG24uHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

thank you very much for the tips. I'll make new patch with a simpler code.

Josef

| Sent: Wednesday, October 5, 2016 6:05:59 PM
| Josef Ridky <jridky@redhat.com> writes:
| 
| > Hi,
| >
| > I have just realize, that my attachment has been cut off from my previous
| > message.
| > Below you can find patch with requested change.
| >
| > Add support for user defined suffix part of name of temporary files
| > created by git mergetool
| > ---
| 
| The first two paragraphs above do not look like they are meant for
| the commit log for this change.
| 
| Please sign-off your patch.
| 
| > -USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to
| > merge] ...'
| > +USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt]
| > [--local=name] [--remote=name] [--backup=name] [--base=name] [file to
| > merge] ...'
| >  SUBDIRECTORY_OK=Yes
| >  NONGIT_OK=Yes
| >  OPTIONS_SPEC=
| >  TOOL_MODE=merge
| > +
| > +#optional name space convention
| > +local_name=""
| > +remote_name=""
| > +base_name=""
| > +backup_name=""
| 
| If you initialize these to LOCAL, REMOTE, etc. instead of empty,
| wouldn't it make the remainder of the code a lot simpler?  For
| example,
| 
| > +	if [ "$local_name" != "" ]  && [ "$local_name" != "$remote_name" ] && [
| > "$local_name" != "$backup_name" ] && [ "$local_name" != "$base_name" ]
| > +	then
| > +		LOCAL="$MERGETOOL_TMPDIR/${BASE}_${local_name}_$$$ext"
| > +	else
| > +		LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
| > +	fi
| 
| This can just be made an unconditional
| 
| 	LOCAL="$MERGETOOL_TMPDIR/${BASE}_${local_name}_$$$ext"
| 
| without any "if" check in front.  The same for all others.
| 
| The conditional you added is doing two unrelated things.  It is
| trying to switch between an unset $local_name and default LOCAL,
| while it tries to make sure the user did not give the same string
| for two different things (which is a nonsense).  It is probably
| better to check for nonsense just once just before all these
| assuments of LOCAL, REMOTE, etc. begins, not at each point where
| they are set like this patch does.
| 
