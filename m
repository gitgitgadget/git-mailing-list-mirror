From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Sat, 31 Jan 2015 21:41:32 +0100
Organization: gmx
Message-ID: <81a3242fec22358d9c2c16b632cbbf9d@www.dscho.org>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
 <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
 <xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
 <xmqq38878gao.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
 <xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
 <xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
 <xmqqmw6e499u.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
 <xmqqa92e47ap.fsf@gitster.dls.corp.google.com>
 <54C11C0B.6080200@alum.mit.edu>
 <595afdd37f7774361bc18de8003c2d16@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tanay Abhra <tanayabh@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jan 31 21:41:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHerQ-0002rX-Jo
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 21:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbbAaUlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 15:41:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:54060 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444AbbAaUlj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 15:41:39 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M2ojS-1XQVyK0KQg-00sc14; Sat, 31 Jan 2015 21:41:34
 +0100
In-Reply-To: <595afdd37f7774361bc18de8003c2d16@www.dscho.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:qAn/1yskKKb7lDmcVAs2ZVEk1zhuH8l8Cl1NVqtrf6Fkixs6zg2
 rOtd49+b80eIPdEjAasG3w1G+Oz1c0D8/jJ2WJzB/q5Pu65IJvm+cltIYucdF3w4rtNoaWR
 qatgUJouU/zBO0xqJKP0hh+OZ4cqr2Mvvq52+huDdj4hlHD1reXG5URlOHdyJf6S1sVSYhK
 OzNnq8k3NG75GWiYw8e1Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263209>

Hi Michael & Junio,

On 2015-01-22 18:17, Johannes Schindelin wrote:

> [...] we need to avoid confusing settings such as
> 
> ```
> [receive.fsck]
>     warn = missing-tagger-entry
>     error = missing-tagger-entry
> ```

I *think* I found a solution.

Please let me recapitulate quickly the problem Michael brought up: if we support `receive.fsck.warn` to override `receive.fsck.error` and vice versa, with comma-separated lists, then it can be quite confusing to the user, and actually quite difficult to figure out on the command-line which setting is in effect (because it really depends on the *order* of the receive.fsck.* lines, *plus* the fact that the values are comma-separated lists).

On the other hand, Junio pointed out two shortcomings with my original implementation (i.e. to support `receive.fsck.<id> = (error|warn|ignore)`), however: it is tedious to set multiple severity levels, and it violates the config file convention that the config variable names are CamelCased (the message IDs are dashed-lowercase instead).

The solution I just implemented (and will send out shortly in v4 of the patch series) is the following: the config variable is called receive.fsck.severity and it accepts comma-separated settings. Example:

```
[receive "fsck"]
        severity = multiple-authors=ignore,missing-tagger=error
```

Now, it is *still* not the easiest to figure out the setting from the command-line:

```sh
$ git config --get-all receive.fsck.severity |
        tr "," "\n" |
        grep ^multiple-authors= |
        tail -n 1
```

But I hope this is good enough, Michael?

Ciao,
Dscho
