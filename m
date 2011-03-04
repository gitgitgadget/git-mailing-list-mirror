From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [RFC] git blame-tree
Date: Fri, 04 Mar 2011 14:40:14 +0000
Message-ID: <1299249614.2133.19.camel@wpalmer.simply-domain>
References: <20110302164031.GA18233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 15:40:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvWBD-00058B-O3
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 15:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759432Ab1CDOk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 09:40:26 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47053 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759294Ab1CDOkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 09:40:25 -0500
Received: by wyg36 with SMTP id 36so2138891wyg.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=byw3qoY80AhmnBOKb1rHHHcT+FisttRZp8yyza4D7Jg=;
        b=M60vdmOf7+flDXZl0xmd2sDC+m6WN7k/LeWVpMZKncInrxyvWg18iC8IHl8qUljYFu
         rel0fjduMguk1LhoE7jW6NEcsFFstLtiKb/7YgRo6cVkkMGeTfPWfgZ4HNdWMscVw6oz
         2YWxA9gSfUlwptbpfv5UIO2uuNPvGDlw32lTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=smLo5GYyccxy5vZAhdlmhLbFjJn6+9qHCs73I9u6Ts4RZ6vFY2sM3lYGMlN+QOFCbO
         8dZEmuB+AvgCoKB5/ZmeNIBM6UtheC6Bn1VEWOLBbaT1XekM9sLSyys+bgAlfD2DhqRP
         y5u1kDNLQ11HLlrMUDVG2gPmQXzMn1GmY60fA=
Received: by 10.227.29.27 with SMTP id o27mr653268wbc.16.1299249624446;
        Fri, 04 Mar 2011 06:40:24 -0800 (PST)
Received: from [192.168.2.128] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id u2sm1202011weh.12.2011.03.04.06.40.16
        (version=SSLv3 cipher=OTHER);
        Fri, 04 Mar 2011 06:40:19 -0800 (PST)
In-Reply-To: <20110302164031.GA18233@sigill.intra.peff.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168440>

On Wed, 2011-03-02 at 11:40 -0500, Jeff King wrote:
> [I know, I know, another RFC. I'll get to actually cleaning up and
> submitting some of these patches soon.]
> 
> It's sometimes useful to get a list of files in a tree along with the
> last commit that touched them. This is the default tree view shown on
> github.com, but it can also be handy from the command line (there has
> been talk lately of having a "git ls"), or as plumbing for a local
> fancier tree view. E.g., something like:
> 
>      add.c 6e7293e git-add: make -A description clearer vs. -u
>    apply.c fd03881 add description parameter to OPT__VERBOSE
>    blame.c 9ca1169 parse-options: Don't call parse_options_check() so much
>   branch.c 62270f6 branch_merged: fix grammar in warning
>   bundle.c 62b4698 Use angles for placeholders consistently
> 
> The obvious naive way to do this is something like:
> 
>   for i in `git ls-tree --name-only HEAD`; do
>     echo "`git rev-list -1 --no-merges HEAD -- $i` $i";
>   done
> 
> which is really slow, because we end up traversing the same commits many
> times (plus the startup overhead for each rev-list).  It takes about 35
> seconds to run on git.git.
> 
> So the next obvious thing is to do one traversal, output the changed
> files for each commit, and then mark each file as you see it. The perl
> script below does this (though the careful reader will note it is
> actually buggy with sub-trees; I didn't bother fixing it since it was
> just a stage in the evolution):
> 
[code snipped]
> 
> This runs in about 3 seconds. And besides the above-mentioned bug,
> also doesn't properly handle things like filenames that need quoting.
> 
> So I wrote it in C, which drops the time down to about 1.5 seconds, and
> of course doesn't have any parsing issues.  The patch is below.
> 
> I wasn't sure at first what to call it or what the calling conventions
> should be. The initial thought was to make it part of "ls-tree". But
> that feels wrong, as ls-tree otherwise never cares about traversal. The
> combination of traversal and diff made me think of blame, and indeed, I
> think this is really just about blaming a whole tree at the file-level,
> rather than at the content-level. Thus I called it blame-tree, and I
> used the same calling conventions as blame: "git blame-tree <path>
> <rev opts>". See the test script for examples.
> 
> I have many thoughts on the patch already, but rather than put them
> here, I'll include the patch without further ado, and put them inline in
> a reply.
> 
[patch snipped]

Coincidentally, I'm doing a similar thing in a shell script at the
moment. Unfortunately, no tree-object is involved: I'm instead using the
output from "git diff" on two different branches to generate a list of
files I care about. How hard would it be to accept a nul-delimited list
of filenames via stdin, rather than from a tree? If I'm reading this
right, it looks like a pretty trivial change. (I couldn't get the
existing patch to apply, myself.. I assume I'm just doing something
wrong as I don't need to use "git am" very often.)
