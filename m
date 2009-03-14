From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for
 doing  custom path transformations
Date: Sat, 14 Mar 2009 11:23:30 -0700
Message-ID: <7vprgkarq5.fsf@gitster.siamese.dyndns.org>
References: <49B7DFA1.4030409@viscovery.net>
 <1236852820-12980-1-git-send-email-johan@johansorensen.com>
 <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de>
 <9e0f31700903121206m3adbabacra655c5d340365f43@mail.gmail.com>
 <7vvdqcd1zh.fsf@gitster.siamese.dyndns.org>
 <9e0f31700903140739g26be7981lb0fa411cdd8029e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johan =?utf-8?Q?S=C3=B8rensen?= <johan@johansorensen.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 19:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiYXm-0005qh-EV
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 19:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbZCNSXl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 14:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbZCNSXl
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 14:23:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbZCNSXk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2009 14:23:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CC90359CC;
	Sat, 14 Mar 2009 14:23:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F207C59CB; Sat,
 14 Mar 2009 14:23:32 -0400 (EDT)
In-Reply-To: <9e0f31700903140739g26be7981lb0fa411cdd8029e6@mail.gmail.com>
 (Johan =?utf-8?Q?S=C3=B8rensen's?= message of "Sat, 14 Mar 2009 15:39:24
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C8EB772-10C5-11DE-9380-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113255>

Johan S=C3=B8rensen <johan@johansorensen.com> writes:

>> Do you run git-daemon from inetd, or standalone, by the way?
>
> Standalone.
>
>>=C2=A0I am wondering how well it would scale if you spawn an external=
 "filter path"
>> script every time you get a request.
>
> A quick test of 250 consecutive requests with ls-remote to localhost
> (all without the --verbose flag), slowest run:
> - Baseline (no --filter-path agument): 3.39s
>
> $ cat filter.c
> #import "stdio.h"
> int main (int argc, char const *argv[]) {
> 	printf("%s", "/existing.git\0");
> 	return 0;
> }
> - 3.84s
>
> $ cat filter.rb
> #!/usr/bin/ruby
> print "/existing.git\0"
> - 4.76s
>
> So, obviously highly dependent on how long it takes the script to
> launch and how much work it does. And yes, neither of the above reall=
y
> does anything :) nor takes any increased cpu load into account
>
> Another approach is to keep the external script running and feed it o=
n
> stdin, but that would involve a bit more micro-management of the
> external process. I will revisit that idea if I find out that's
> needed.

I actually was hoping (especially we have Dscho on Cc: list) that someb=
ody
like you would start suggesting a "plug in" approach to load .so files,
which would lead to a easy-to-port dso support with the help from msysg=
it
folks we can use later in other parts of the system (e.g. customizable
filters used for diff textconv, clean/smudge, etc.)

>> (by the way, "filter path" sounds as if it checks and conditionally
>> denies access to, or something like that, which is not what you are =
using
>> it for.  It is more about rewriting paths, a la mod_rewrite, and I t=
hink
>> the option is misnamed)
>
> Maybe --rewrite-script or --rewrite-command  instead?

Perhaps.
