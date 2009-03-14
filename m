From: =?ISO-8859-1?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for doing 
	custom path transformations
Date: Sat, 14 Mar 2009 15:39:24 +0100
Message-ID: <9e0f31700903140739g26be7981lb0fa411cdd8029e6@mail.gmail.com>
References: <49B7DFA1.4030409@viscovery.net>
	 <1236852820-12980-1-git-send-email-johan@johansorensen.com>
	 <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de>
	 <9e0f31700903121206m3adbabacra655c5d340365f43@mail.gmail.com>
	 <7vvdqcd1zh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 15:41:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiV2n-0006li-Jn
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 15:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbZCNOj2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 10:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbZCNOj2
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 10:39:28 -0400
Received: from mail-ew0-f177.google.com ([209.85.219.177]:45432 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbZCNOj2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2009 10:39:28 -0400
Received: by ewy25 with SMTP id 25so2911703ewy.37
        for <git@vger.kernel.org>; Sat, 14 Mar 2009 07:39:24 -0700 (PDT)
Received: by 10.210.66.1 with SMTP id o1mr1767307eba.16.1237041564209; Sat, 14 
	Mar 2009 07:39:24 -0700 (PDT)
In-Reply-To: <7vvdqcd1zh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113253>

On Sat, Mar 14, 2009 at 7:58 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> However, being paranoid is a good thing when we talk about instructio=
ns we
> give to the end users. =A0The site owner who uses this facility needs=
 to be
> aware that the script is run as the same user that runs git-daemon, a=
nd
> that more than one instances of the script can be run at the same tim=
e.
> The script writer needs to be careful about using the same scratchpad
> location for the temporary files the script uses and not letting mult=
iple
> instances of scripts stomping on each other's toes. =A0These things n=
eed to
> be documented.

Will expand the docs further.

> Do you run git-daemon from inetd, or standalone, by the way?

Standalone.

>=A0I am wondering how well it would scale if you spawn an external "fi=
lter path"
> script every time you get a request.

A quick test of 250 consecutive requests with ls-remote to localhost
(all without the --verbose flag), slowest run:
- Baseline (no --filter-path agument): 3.39s

$ cat filter.c
#import "stdio.h"
int main (int argc, char const *argv[]) {
	printf("%s", "/existing.git\0");
	return 0;
}
- 3.84s

$ cat filter.rb
#!/usr/bin/ruby
print "/existing.git\0"
- 4.76s

So, obviously highly dependent on how long it takes the script to
launch and how much work it does. And yes, neither of the above really
does anything :) nor takes any increased cpu load into account

Another approach is to keep the external script running and feed it on
stdin, but that would involve a bit more micro-management of the
external process. I will revisit that idea if I find out that's
needed.

> (by the way, "filter path" sounds as if it checks and conditionally
> denies access to, or something like that, which is not what you are u=
sing
> it for.  It is more about rewriting paths, a la mod_rewrite, and I th=
ink
> the option is misnamed)

Maybe --rewrite-script or --rewrite-command  instead?

Cheers,
JS
