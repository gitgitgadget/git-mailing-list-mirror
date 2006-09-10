From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 05:49:47 +0200
Message-ID: <e5bfff550609092049t5e016cacr2502ce81bbb6489e@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	 <17666.4936.894588.825011@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
	 <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	 <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	 <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
	 <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	 <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 05:49:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMGKO-00039h-HJ
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 05:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWIJDtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 23:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWIJDtt
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 23:49:49 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:40916 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965185AbWIJDtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 23:49:49 -0400
Received: by py-out-1112.google.com with SMTP id n25so1562449pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 20:49:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=idjxlKy+axY6/4wHBlV96aYZh1E9XJ6smPAVkufg2Z17Vpnz6erlE8W8soIcFRZ5dVRYECWx1jN/nbuxmNNMqQdPe5z9Z3ofUSRXCkjmWMNZp1n0+y96Ap1bB2x7f+P7iwvEKmjwINRhGc3Ct0DwKcGPbLHM3Xq58mmnSiE/ZZA=
Received: by 10.35.53.18 with SMTP id f18mr6053038pyk;
        Sat, 09 Sep 2006 20:49:47 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 9 Sep 2006 20:49:47 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26779>

On 9/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
>
> The example is
>
>                     A           <--- tip of branch
>                    / \
>                   B   E
>                   |   |
>                   |   F
>                   | /
>                   C
>                   |
>                   D
>                 ...
>

Ok now it' clear, thanks. But anyhow I think that it should be
possible to avoid the check and reordering on the receiver side.

Suppose for a moment to split the graph drawing from the sequence
reordering problem, suppose for a moment that receiver does do not
draw the graph immediately.

As you described, in our case git-rev-list sends the following sequence:
A, B, C, D, E, F

instead git-rev-list --topo-order would have sent something like
A, E, F, B, C, D

Now I ask, is it possible to have a sequence (without latency) like
A, B, C, D, (-3)E, (-3)F

where, in case of not topological correct revisions, git-rev-list
gives the hint on the correct position in sequence (3 revs before in
our case) where the revision would have been if the sequence would
have been --topo-order ?

This saves all the checking and reordering on the receiver side and
guarantees consistent results on different implementations of git
visualizers because the --topo-order algorithm logic is computed in
git rev-list only.

The visualizers  could be sequence order agnostic, i.e. receivers can
handle --topo-order or --date-order sequences or any other kind of
sequence with the same code, simply they recreate the sequence in the
way git-rev-list tells them.

Marco
