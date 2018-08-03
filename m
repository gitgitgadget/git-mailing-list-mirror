Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D461F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbeHDAI5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 3 Aug 2018 20:08:57 -0400
Received: from elephants.elehost.com ([216.66.27.132]:25049 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbeHDAI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:08:57 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w73MAe4i060414
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Aug 2018 18:10:41 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Tacitus Aedifex'" <aedifex@SDF.ORG>, <git@vger.kernel.org>
References: <20180803213834.GB7619@SDF.ORG>
In-Reply-To: <20180803213834.GB7619@SDF.ORG>
Subject: RE: abstracting commit signing/verify to support other signing schemes
Date:   Fri, 3 Aug 2018 18:10:34 -0400
Message-ID: <000901d42b76$d071a0f0$7154e2d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
thread-index: AQJtitcH1BnR+hXxUjwnWPZz9ZY+06N71SVw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 3, 2018 5:39 PM, Tacitus Aedifex wrote:
> I'm looking at the existing commit signing and verification integration and it is
> all GPG specific. I'm interested in refactoring the code to have a generic
> signing/verifying interface so that "drivers"
> for other signing tools can be created and other signing tools can be used
> (e.g. OpenBSD signify).
> 
> The existing interface defined in gpg-interface.h is already fairly generic. It
> looks like the only things that would need to be fixed are the names of some
> members in the signature_check struct and the GPG specific constants.
> 
> I propose to rename the gpg-interface.h file to signature-interface.h.
> There are several different ways to do the "polymorphism" needed to have a
> base signature_check struct with a tool-specific part for storing the tool-
> specific data (e.g. gpg_output, gpg_status, result). I'm looking for
> suggestions on the way this has been done in other places in the Git code so I
> can do it the same way. My initial impulse it to have a union of tool-specific
> structs inside of the signature_check struct.
> 
> The plan for changing the signing behavior is to change the code looking for
> commit.gpgsign in sequencer.c to instead look for commit.signtool.
> The string value will define which signing tool to use. The default will be null
> which is the equivilent to gpgsign=false. To get GPG signing the user would
> set it to "gpg". To maintain backwards compatibility, the code will continue to
> check for commit.gpgsign and translate that to commit.signtool=gpg and
> output a warning.
> 
> I also think that it makes sense to move the user.signingkey to be
> gpg.signingkey since that only makes sense in the context of GPG.
> 
> The real trick here is how to handle signatures from different tools in a given
> project. I think the answer is to store the value of commit.signtool along with
> the signature blob associted with each signed commit. That way the
> signature verification code can know which tool to use to verify the
> signature. If a commit has a signture but no tool selector, the default will be
> to assume GPG to preserve backwards compatibility.

If I may suggest something a little off the wall... the abstraction needs to go beyond just the signing tool, but the whole signing infrastructure. I would like to see something along the lines of introducing a signing authority into the mix, so that not only the tool of signing is abstracted, but also the interface to who, if anyone, is responsible for signing. If I had my dream, it would be that one (or more) signing authorities would have potentially overlapping responsibilities for signing parts of the tree either on demand or by requirement.

So when a commit occurs, at least on master, or other designated branches, it may be the repository requires a signature from a particular authority, regardless of whether the committer has requested one. And there may be more than one authority or notary involved. Or, the repository could accept the signature of the committer as abstracted.

Where I'm going is that I would like to see a tighter integration with block-chain concepts in git. My customer base has very tight requirements for this type of software certification. Signatures, GPG or other, may only go so far. I am even considering whether particular parts of the tree are even visible (remember the Islands of Sparceness discussion?).

I expect to be able to contribute more to this conversation in a few months (current $NDA prohibition), if this goes anywhere.

My feature time machine window doesn't see this any time soon, if ever, but one never knows. I have my delusional hopes. 😉

Please take this as simply a suggestion for the long-term.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



