Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB571F597
	for <e@80x24.org>; Fri,  3 Aug 2018 21:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeHCXot (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 19:44:49 -0400
Received: from mx.sdf.org ([205.166.94.20]:65215 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729828AbeHCXot (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 19:44:49 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2018 19:44:49 EDT
Received: from sdf.org (IDENT:aedifex@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id w73LcZ8H015907
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO)
        for <git@vger.kernel.org>; Fri, 3 Aug 2018 21:38:35 GMT
Received: (from aedifex@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id w73LcY7d021101
        for git@vger.kernel.org; Fri, 3 Aug 2018 21:38:34 GMT
Date:   Fri, 3 Aug 2018 21:38:34 +0000
From:   Tacitus Aedifex <aedifex@SDF.ORG>
To:     git@vger.kernel.org
Subject: abstracting commit signing/verify to support other signing schemes
Message-ID: <20180803213834.GB7619@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm looking at the existing commit signing and verification
integration and it is all GPG specific. I'm interested in refactoring
the code to have a generic signing/verifying interface so that "drivers"
for other signing tools can be created and other signing tools can be
used (e.g. OpenBSD signify).

The existing interface defined in gpg-interface.h is already fairly
generic. It looks like the only things that would need to be fixed
are the names of some members in the signature_check struct and the GPG
specific constants.

I propose to rename the gpg-interface.h file to signature-interface.h.
There are several different ways to do the "polymorphism" needed to have
a base signature_check struct with a tool-specific part for storing the
tool-specific data (e.g. gpg_output, gpg_status, result). I'm looking
for suggestions on the way this has been done in other places in the Git
code so I can do it the same way. My initial impulse it to have a union
of tool-specific structs inside of the signature_check struct.

The plan for changing the signing behavior is to change the code looking
for commit.gpgsign in sequencer.c to instead look for commit.signtool.
The string value will define which signing tool to use. The default will
be null which is the equivilent to gpgsign=false. To get GPG
signing the user would set it to "gpg". To maintain backwards
compatibility, the code will continue to check for commit.gpgsign and
translate that to commit.signtool=gpg and output a warning.

I also think that it makes sense to move the user.signingkey to be
gpg.signingkey since that only makes sense in the context of GPG.

The real trick here is how to handle signatures from different tools in
a given project. I think the answer is to store the value of
commit.signtool along with the signature blob associted with each signed
commit. That way the signature verification code can know which tool to
use to verify the signature. If a commit has a signture but no tool
selector, the default will be to assume GPG to preserve backwards
compatibility.

Any other thoughts and/or suggestions?

//tæ
