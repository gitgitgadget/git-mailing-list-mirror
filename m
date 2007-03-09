From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Fri, 09 Mar 2007 10:36:16 -0500
Message-ID: <45F17EF0.5060008@gmail.com>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 16:36:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPh8x-0006cc-0M
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 16:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993117AbXCIPgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 10:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993113AbXCIPgQ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 10:36:16 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:47658 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993117AbXCIPgP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 10:36:15 -0500
Received: by an-out-0708.google.com with SMTP id b33so797846ana
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 07:36:14 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Q1/RMmcCZOkeiQa38vc5ih/8EotfgKDxDjku3sTwEmYR6iQV0ahAjNVjgUftXcDXQqdoZlNN3BNuex3fGHSeThIA02sROe0wPIZvdUPJxWiufIAI3hCkh3XN5SZE8naTwQjv4DC6/pACOAYBn5oGBDsAeWdT5u8HYCiKnK4/9EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Ba0/8WMaC5QI3QZsf326hTST/PcA8EIBJCaV0o8LhEH2GfKR3HaGSZn0Dn1QCT5wr9wF7EdJeWINzJMZPqDpGPfYKPO5T15fFKWtgasMflDjDtE2E2J3yFsiDbe08mqPwNFjL8bQSKty9tWDcqVIQLF/dUf5hVP55ZUX7k6d7rE=
Received: by 10.100.128.8 with SMTP id a8mr1346879and.1173454573927;
        Fri, 09 Mar 2007 07:36:13 -0800 (PST)
Received: from ?10.1.5.213? ( [206.166.206.34])
        by mx.google.com with ESMTP id c13sm5122917anc.2007.03.09.07.36.12;
        Fri, 09 Mar 2007 07:36:12 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41798>

Junio C Hamano wrote:
> If I were doing a nightly script, I would probably be doing
> something like this:
>
> 	#!/bin/sh
> 	yesterday=$(git bundle list-heads yesterday.bdl | sed -e 's/ .*//')
> 	git bundle create today.bdl --all --not $yesterday
> 	# mail it out
Thinking about this further, the above has a problem (or should, but see 
below). Consider a case where master is not updated since yesterday. 
Effectively, the above becomes

git bundle create today.bdl  master <other-refs> --not master <other-refs>

As ref master is excluded, the bundle creation should die because master 
cannot be included. Experimenting with next (299fcfbdcb5afd85) however, 
I get:

git>git bundle create t.bdl master --not master
Generating pack...
Done counting 0 objects.
Writing 0 objects.
Total 0 (delta 0), reused 0 (delta 0)
git>git ls-remote t.bdl
git>

e.g, an empty bundle is created without any error or warning. This is 
the one case I believe an error should result: there is no use to 
sending (or even creating) an empty bundle.

As a date limited bundle containing all updated refs is my basic use, I 
really want this case to not be hard, and it definitely should not 
require externally maintained history or scripting to create. Absent the 
"die if any ref wasn't updated in the given date range" logic, and 
adding always die if the resulting bundle is empty, git bundle in next 
accomplishes what I want.

Mark
