Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFF51F404
	for <e@80x24.org>; Thu, 13 Sep 2018 17:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeIMXF7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:05:59 -0400
Received: from elephants.elehost.com ([216.66.27.132]:29607 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeIMXF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:05:59 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8DHtKFR052546
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Sep 2018 13:55:21 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>
References: <003901d44acd$12c2bb90$384832b0$@nexbridge.com>     <4102803b-d5de-5812-4cef-569c9869fed1@kdbg.org> <004e01d44ada$b4a11ad0$1de35070$@nexbridge.com> <000001d44ae6$c2a20ac0$47e62040$@nexbridge.com> <xmqq1s9yjp9j.fsf@gitster-ct.c.googlers.com>    <001101d44b5b$fa337350$ee9a59f0$@nexbridge.com> <xmqqefdxign2.fsf@gitster-ct.c.googlers.com> <xmqqva79ffpv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva79ffpv.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Question] Signature calculation ignoring parts of binary files
Date:   Thu, 13 Sep 2018 13:55:13 -0400
Message-ID: <005e01d44b8a$ef1221e0$cd3665a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1dHr/8n7yCB9UeIXEGLjm31C4owFRfwXbAhcuk1ECJbKk4AITag6rAj4bbawDCIckPwIIxTSmojSi8uA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 13, 2018 1:52 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> >
> >> The scenario is slightly different.
> >> 1. Person A gives me a new binary file-1 with fingerprint A1. This
> >> goes into git unchanged.
> >> 2. Person B gives me binary file-2 with fingerprint B2. This does not
> >> go into git yet.
> >> 3. We attempt a git diff between the committed file-1 and uncommitted
> >> file-2 using a textconv implementation that strips what we don't need
to
> compare.
> >> 4. If file-1 and file-2 have no difference when textconv is used,
> >> file-2 is not added and not committed. It is discarded with impunity,
> >> never to be seen again, although we might whine a lot at the user for
> >> attempting to put
> >> file-2 in - but that's not git's issue.
> >
> > You are forgetting that Git is a distributed version control system,
> > aren't you?  Person A and B can introduce their "moral equivalent but
> > bytewise different" copies to their repository under the same object
> > name, and you can pull from them--what happens?
> >
> > It is fundamental that one object name given to Git identifies one
> > specific byte sequence contained in an object uniquely.  Once you
> > broke that, you no longer have Git.
> 
> Having said all that, if you want to keep the original with frills but
somehow
> give these bytewise different things that reduce to the same essence (e.g.
> when passed thru a filter like textconv), I suspect a better approach
might be
> to store both the "original" and the result of passing the "original"
through
> the filter in the object database.  In the above example, you'll get two
> "original"
> objects from person A and person B, plus one "canonical" object that are
> bytewise different from either of these two originals, but what they
reduce
> to when you use the filter on them.  Then you record the fact that to
derive
> the "essence" object, you can reduce either person A's or person B's
> "original" through the filter, perhaps by using "git notes" attached to
the
> "essence" object, recording the object names of these originals (the
reason
> why using notes in this direction is because you can mechanically
determine
> which "essence"
> object any given "original" object reduces to---it is just the matter of
passing
> it through the filter.  But there can be more than one "original" that
reduces
> to the same "essence").

I like that idea. It turns the reduced object into a contract. Thanks.

